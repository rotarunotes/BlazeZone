Data: 2026-04-23
[Transport_Layer](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Transport_Layer
___
# Index
- [[# UDP]]
	- [[# Panoramica]]
- [[# Versioni & Evoluzione]]
- [[# Come Funziona]]
- [[# Flusso Operativo]]
- [[# Casi d'Uso Reali]]
- [[# Limitazioni Tecniche]]
- [[# PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
	- [[#Header]]
	- [[#Body]]
	- [[#Flags]]
- [[# Porte e Protocolli Correlati]]
- [[# Confronto]]
- [[# Aspetti di Sicurezza]]
	- [[# Vulnerabilità Note]]
	- [[# Attacchi Comuni]]
	- [[# Contromisure]]
- [[# Comandi Cisco IOS]]
- [[# Troubleshooting]]
- [[# Note Esame]]
	- [[#Da sapere a memoria]]
	- [[#Trabocchetti frequenti]]
___
# UDP
## Panoramica

| Caratteristica              | Dettaglio |
| --------------------------- | :-------: |
| **Livello OSI**             | 4 – Trasporto |
| **Scopo**                   | Trasmissione dati senza connessione, leggera e veloce |
| **RFC / Standard**          | RFC 768 (1980) |
| **Tipo Connessione**        | Connectionless |
| **Affidabilità**            | Non affidabile (no ACK, no ritrasmissione) |
| **PDU (Unità Dati)**        | Datagramma |
| **Meccanismo di Controllo** | Nessuno (checksum opzionale, nessun controllo flusso/congestione) |

___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
|----------|------|-------------------|
| UDP originale | 1980 | RFC 768 — specifica base, ancora invariata |
| UDP-Lite | 2006 | RFC 3828 — checksum parziale per tollerare errori nei media stream |
| QUIC (su UDP) | 2021 | RFC 9000 — multiplexing, TLS 1.3 integrato, base di HTTP/3 |

___
# Come Funziona

UDP è un protocollo di trasporto **senza connessione** e **senza stato**. Non esiste handshake: il mittente costruisce un datagramma e lo spedisce direttamente al destinatario, senza alcun accordo preventivo.

Non ci sono conferme di ricezione (ACK), nessun meccanismo di ritrasmissione in caso di perdita, nessun riordinamento dei pacchetti arrivati fuori sequenza. Se un datagramma viene perso lungo il percorso, semplicemente sparisce — senza che mittente o destinatario ne vengano notificati automaticamente.

UDP si affida completamente a IP per il routing dei pacchetti. Qualsiasi logica aggiuntiva (controllo errori, ritrasmissione, ordinamento) è responsabilità esclusiva dell'applicazione che lo utilizza. In cambio, l'overhead è minimo: header fisso di **8 byte** contro i 20+ byte di TCP.

___
# Flusso Operativo

Non esiste una fase di apertura o chiusura della connessione. L'applicazione invia e basta. Il diagramma seguente mostra il caso più comune (richiesta/risposta, es. DNS):

```
Client                          Server
  |                                |
  |------ Datagramma UDP --------->|   (invio diretto, no handshake)
  |                                |
  |<----- Datagramma UDP ----------|   (risposta, se prevista dal protocollo)
  |                                |
        (nessun ACK, nessuna chiusura)
```

Per protocolli come il video streaming, il flusso è unidirezionale continuo:

```
Client                          Server
  |                                |
  |<----- Datagramma #1 -----------|
  |<----- Datagramma #2 -----------|   (perso — nessuna notifica)
  |<----- Datagramma #3 -----------|
  |<----- Datagramma #4 -----------|
  |                                |
        (il gap nel #2 viene ignorato o gestito dall'app)
```

| Fase      | # | Azione                                           | Stato Client     | Stato Server     | Note                                          |
| --------- | - | ------------------------------------------------ | ---------------- | ---------------- | --------------------------------------------- |
| **Invio** | 1 | L'app passa dati al socket UDP                   | READY            | LISTENING        | Nessuna apertura di connessione               |
|           | 2 | UDP costruisce il datagramma (header + payload)  | SENDING          | LISTENING        | Header di soli 8 byte                         |
|           | 3 | IP incapsula il datagramma e lo instrada         | SENDING          | LISTENING        | UDP non controlla il percorso                 |
| **Dati**  | 4 | Il server riceve il datagramma                   | READY            | PROCESSING       | Nessun ACK inviato al client                  |
|           | 5 | Il server elabora e risponde (se necessario)     | WAITING/READY    | SENDING          | Dipende dall'applicazione (es. DNS risponde)  |
| **Fine**  | 6 | Non esiste una chiusura formale                  | READY            | READY            | Il socket rimane aperto fino a chiusura app   |

___
# Casi d'Uso Reali

- **DNS (porta 53)**: Quando digiti un URL nel browser, il sistema operativo invia una query DNS tramite UDP. La risposta arriva in pochi ms. Se va persa, l'applicazione riprova — non UDP.
- **Video streaming / VoIP (es. RTP su UDP)**: Una videochiamata su Zoom o una live su Twitch usa UDP. Perdere qualche frame è accettabile; la latenza aggiunta da TCP sarebbe invece inaccettabile.
- **DHCP (porta 67/68)**: Al boot, un client non ha ancora indirizzo IP e non può aprire connessioni TCP. Invia un broadcast UDP `DISCOVER` per ottenere la configurazione di rete.
- **SNMP (porta 161)**: Il monitoraggio di dispositivi di rete avviene tramite polling UDP leggero, tollerando la perdita occasionale di qualche metrica.
- **Gaming online**: I giochi multiplayer inviano posizioni e azioni dei giocatori via UDP per minimizzare la latenza; la sincronizzazione è gestita dal game engine.

___
# Limitazioni Tecniche

- **Nessuna garanzia di consegna**: I datagrammi possono essere persi, duplicati o riordinati senza alcuna notifica automatica.
- **Nessun controllo della congestione**: UDP non rallenta in presenza di congestione di rete, rischiando di aggravare il problema (problema del "UDP ingordo").
- **Dimensione massima del payload**: Il campo Length è a 16 bit → max 65.535 byte totali (header incluso), quindi max **65.527 byte di payload**. In pratica, i datagrammi vengono frammentati da IP se superano la MTU del percorso (tipicamente 1.500 byte su Ethernet).
- **Problemi con NAT**: I dispositivi NAT mantengono una tabella di stato per le sessioni UDP basandosi su IP/porta. Le entry scadono rapidamente (timeout tipico: 30 secondi) causando interruzioni in flussi long-lived (es. VoIP).
- **Identificazione del flusso**: Non esiste il concetto di connessione, quindi multiplexare più flussi logici sulla stessa porta richiede logica applicativa aggiuntiva.

___
# PDU & Incapsulamento

- **Nome PDU**: Datagramma
- **Incapsulato in**: Pacchetto IP (IPv4 o IPv6) → frame Ethernet (o altro L2)
- **Incapsula**: Dati applicativi (payload dell'applicazione)

```
[ Header Ethernet (14 byte) ]
    [ Header IP (20 byte min) ]
        [ Header UDP (8 byte) ]
            [ Payload / Dati applicativi ]
```

___
# Struttura Del Pacchetto
## Header

L'header UDP è fisso, **8 byte totali**, senza opzioni.

| Campo              | Dimensione | Descrizione |
| ------------------ | ---------- | ----------- |
| **Source Port**    | 16 bit     | Porta del mittente (0–65535). Può essere 0 se non serve risposta |
| **Destination Port** | 16 bit   | Porta del destinatario — identifica l'applicazione di destinazione |
| **Length**         | 16 bit     | Lunghezza totale del datagramma UDP (header + payload), in byte. Min = 8 |
| **Checksum**       | 16 bit     | Verifica integrità dell'header e del payload. Opzionale in IPv4, obbligatorio in IPv6 |

Rappresentazione grafica dell'header (32 bit per riga):

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Source Port          |        Destination Port       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             Length            |            Checksum           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Payload (dati)                         |
|                            ...                                |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body

Il body (payload) è composto esclusivamente dai dati dell'applicazione. Non esiste struttura interna definita da UDP: il protocollo è completamente agnostico rispetto al contenuto trasportato. La dimensione massima teorica del payload è **65.527 byte** (65.535 − 8 byte di header).

## Flags

UDP **non ha flags** nel suo header. A differenza di TCP, non esistono bit di controllo (SYN, ACK, FIN, RST, ecc.). La semplicità è by design: tutta la logica di controllo è delegata all'applicazione o a protocolli superiori.

___
# Porte e Protocolli Correlati

| Porta   | Protocollo | Uso |
| ------- | ---------- | --- |
| 53      | DNS        | Risoluzione nomi di dominio |
| 67      | DHCP Server | Assegnazione indirizzi IP (server riceve) |
| 68      | DHCP Client | Assegnazione indirizzi IP (client riceve) |
| 69      | TFTP       | Trasferimento file leggero (dispositivi embedded, boot PXE) |
| 123     | NTP        | Sincronizzazione orario di rete |
| 161     | SNMP       | Monitoraggio dispositivi di rete |
| 162     | SNMP Trap  | Notifiche asincrone da dispositivi SNMP |
| 514     | Syslog     | Invio log di sistema centralizzato |
| 1900    | SSDP       | Scoperta dispositivi UPnP |
| 4500    | IPSec NAT-T | IPSec attraverso NAT |
| 5353    | mDNS       | DNS multicast (Bonjour/Avahi) |

___
# Confronto

| Caratteristica             | UDP                              | TCP                                      |
| -------------------------- | -------------------------------- | ---------------------------------------- |
| **Tipo connessione**       | Connectionless                   | Connection-oriented (3-way handshake)    |
| **Affidabilità**           | Non affidabile                   | Affidabile (ACK + ritrasmissione)        |
| **Ordinamento**            | Non garantito                    | Garantito (numeri di sequenza)           |
| **Controllo flusso**       | Assente                          | Presente (sliding window)                |
| **Controllo congestione**  | Assente                          | Presente (slow start, AIMD)              |
| **Dimensione header**      | 8 byte (fisso)                   | 20–60 byte (variabile)                   |
| **Latenza**                | Molto bassa                      | Più alta (overhead di gestione)          |
| **Overhead**               | Minimo                           | Significativo                            |
| **Broadcast/Multicast**    | Supportato                       | Non supportato                           |
| **Uso tipico**             | DNS, VoIP, streaming, gaming     | HTTP, FTP, SSH, email                    |
| **PDU**                    | Datagramma                       | Segmento                                 |

___
# Aspetti di Sicurezza

## Vulnerabilità Note

- **Assenza di autenticazione**: UDP non verifica l'identità del mittente. Il Source Port e il Source IP possono essere falsificati (IP spoofing) con relativa facilità.
- **Stateless by design**: Non esiste traccia di connessione, rendendo difficile distinguere traffico legittimo da traffico iniettato.
- **Amplificazione**: Protocolli UDP con risposte molto più grandi delle richieste (DNS, NTP, SSDP, Memcached) sono vettori naturali per attacchi DDoS di amplificazione.

## Attacchi Comuni

- **UDP Flood**: Invio massiccio di datagrammi UDP a porte casuali della vittima per saturare la banda o esaurire le risorse del sistema (risposta con ICMP Port Unreachable per ogni porta chiusa).
- **DNS Amplification**: Il mittente falsifica l'IP sorgente con quello della vittima e invia query DNS a resolver aperti. Le risposte (fino a 70x più grandi della query) vengono inviate alla vittima.
- **NTP Amplification**: Sfrutta il comando `monlist` di NTP per ottenere risposte fino a 556x più grandi della richiesta.
- **SSDP Reflection**: Abusa di dispositivi UPnP esposti su Internet per amplificare traffico verso la vittima.

## Contromisure

- Filtraggio **BCP38/uRPF** a livello ISP per bloccare il traffico con IP sorgente falsificato.
- **Rate limiting** del traffico UDP in ingresso su firewall e router di bordo.
- Disabilitare servizi UDP non necessari esposti su Internet (es. `monlist` su NTP, resolver DNS aperti).
- Uso di **DTLS (Datagram TLS)** per autenticazione e cifratura del traffico UDP sensibile.
- Implementare **firewall stateful** che traccino le sessioni UDP per IP/porta.

___
# Comandi Cisco IOS

```bash
! Visualizza statistiche UDP sul dispositivo
show ip traffic

! Verifica connessioni UDP attive e porte in ascolto (su dispositivi con IOS-XE)
show udp

! Monitora il traffico UDP in tempo reale (impatto su CPU — usare con cautela)
debug ip udp

! Visualizza le Access Control List applicate a un\'interfaccia (per regole su UDP)
show ip interface <interface>

! Verifica le traduzioni NAT attive (include sessioni UDP)
show ip nat translations

! Controlla il timeout delle sessioni UDP nelle traduzioni NAT
show ip nat translations verbose

! Configura il timeout delle sessioni UDP nel NAT (default: 300 secondi)
ip nat translation udp-timeout <secondi>

! Cattura traffico UDP su un\'interfaccia con Embedded Packet Capture
monitor capture CAP interface <interface> both
monitor capture CAP match udp any any
monitor capture CAP start
monitor capture CAP stop
show monitor capture CAP buffer brief
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore                        | Possibili Cause Tecniche                               | Descrizione del Fenomeno |
| --------------------------------------- | ------------------------------------------------------ | ------------------------ |
| Query DNS timeout intermittente         | Pacchetti UDP persi in transito o firewall che blocca  | La risposta non arriva entro il timeout dell'applicazione; il resolver riprova |
| VoIP con audio intermittente (jitter)   | Variazione del ritardo di rete, coda QoS non configurata | I datagrammi arrivano fuori tempo; il jitter buffer si svuota |
| DHCP client non ottiene indirizzo       | Firewall blocca broadcast UDP 67/68 o DHCP relay assente | Il DISCOVER non raggiunge il server; client rimane con APIPA (169.254.x.x) |
| Sessione NAT UDP scaduta                | Timeout NAT breve (default 30s su molti dispositivi)  | Flussi long-lived (es. tunnel UDP) vengono terminati dal NAT senza preavviso |
| Perdita pacchetti unidirezionale        | ACL asimmetrica o policy routing che scarta il ritorno | L'invio funziona ma le risposte vengono filtrate o indirizzate male |

**Comandi di verifica**:

```bash
! Testa raggiungibilità porta UDP specifica (es. DNS)
! (da host Linux/Mac)
nc -vzu <ip> 53

! Cattura datagrammi UDP su interfaccia specifica (Linux)
tcpdump -i eth0 udp port 53

! Verifica se il server risponde (DNS)
nslookup example.com <dns-server-ip>

! Statistiche di rete incluse perdite UDP (Linux)
netstat -su

! Traceroute UDP (default su Linux)
traceroute <destinazione>
```

**Cause frequenti**:

| Problema                      | Causa Tecnica                                                                       | Sintomo e Comportamento                                                                                           |
| ----------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **MTU Mismatch**              | Differenza nella dimensione massima tra due nodi                                    | Datagrammi UDP grandi vengono frammentati o scartati; le query piccole funzionano, quelle con payload grande no  |
| **Firewall stateful asimmetrico** | Il firewall non vede il pacchetto di ritorno come parte del flusso UDP             | Le richieste escono ma le risposte vengono scartate perché arrivano su un percorso diverso                        |
| **NAT Timeout troppo basso**  | Il binding NAT per la sessione UDP scade prima che il flusso termini               | Connessioni UDP long-lived (tunnel, streaming) si interrompono ogni N secondi                                     |
| **Port unreachable loop**     | Il client invia a una porta chiusa sul server                                       | Il server risponde con ICMP Type 3 Code 3; se il client non lo gestisce, riprova all'infinito                     |

___
# Note Esame

## Da sapere a memoria

| Argomento | Dettagli Tecnici |
| --------- | ---------------- |
| **Dimensione header** | 8 byte fissi (Source Port 16b, Dest Port 16b, Length 16b, Checksum 16b) |
| **RFC di riferimento** | RFC 768 (1980) |
| **PDU** | Datagramma |
| **Protocollo IP** | Protocol number 17 (0x11) nel campo Protocol dell'header IP |
| **Checksum** | Opzionale in IPv4, obbligatorio in IPv6 |
| **Payload massimo teorico** | 65.527 byte (65.535 − 8 byte header) |
| **Porte principali** | DNS 53, DHCP 67/68, TFTP 69, NTP 123, SNMP 161/162 |
| **Caratteristica chiave** | Connectionless, no ACK, no ritrasmissione, no ordinamento |
| **Quando si usa UDP** | Quando la latenza è prioritaria sull'affidabilità (VoIP, DNS, streaming, gaming) |

## Trabocchetti frequenti

| Concetto Errato | Realtà Tecnica |
| --------------- | -------------- |
| "UDP non ha checksum" | UDP **ha** un campo Checksum a 16 bit. È opzionale solo in IPv4; in IPv6 è **obbligatorio** |
| "UDP non può fare broadcast" | UDP **supporta** broadcast e multicast; TCP no |
| "QUIC è un protocollo completamente nuovo" | QUIC è costruito **sopra UDP** (usa UDP come trasporto) |
| "UDP è sempre meno sicuro di TCP" | La sicurezza dipende dal protocollo applicativo: DTLS su UDP può essere più sicuro di TCP senza TLS |
| "UDP non viene usato per applicazioni critiche" | DNS, NTP, DHCP — tutti fondamentali — usano UDP |
| "Il checksum UDP copre solo l'header" | Il checksum copre **header + payload + pseudo-header IP** (IP sorgente, IP destinazione, protocollo, lunghezza UDP) |
___

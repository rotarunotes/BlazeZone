Data: 2026-04-23
[Transport_Layer](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Transport_Layer
___
# Index
- [[#User Datagram Protocol]]
    - [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
- [[#Flusso Operativo]]
- [[#Casi d'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
    - [[#Header]]
    - [[#Body]]
    - [[#Flags]]
- [[#Porte e Protocolli Correlati]]
- [[#Confronto]]
- [[#Aspetti di Sicurezza]]
    - [[#Vulnerabilità Note]]
    - [[#Attacchi Comuni]]
    - [[#Contromisure]]
- [[#Comandi Cisco IOS]]
- [[#Troubleshooting]]
- [[#Note Esame]]
    - [[#Da sapere a memoria]]
    - [[#Trabocchetti frequenti]]
- [[#Quick Reference Card]]
___
# User Datagram Protocol

## Panoramica

| Caratteristica              |                                                       Dettaglio                                                        |
| --------------------------- | :--------------------------------------------------------------------------------------------------------------------: |
| **Livello OSI**             |                                                     4 — Trasporto                                                      |
| **Porta**                   |                                               Identificato dal servizio                                                |
| **Scopo**                   | Fornire una trasmissione **veloce** e **a bassa latenza** senza garanzie di consegna, ordine o controllo degli errori. |
| **RFC / Standard**          |                                                     RFC 768 (1980)                                                     |
| **Tipo Connessione**        |                                 **Connectionless** (nessuna instaurazione di sessione)                                 |
| **Affidabilità**            |                                **Non affidabile** (nessun ACK, nessuna ritrasmissione)                                 |
| **PDU (Unità Dati)**        |      **Datagramma** <br>(Solo in UDP Viene chiamato così perché è un'unità di dati indipendente e "senza stato")       |
| **Meccanismo di Controllo** |                                      Nessuno nativo (checksum opzionale su IPv4)                                       |
___
# Versioni & Evoluzione

| Versione / RFC | Anno | Novità principali                                                                          |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------- |
| RFC 768            | 1980     | Specifica originale e unica di UDP — rimasta invariata per oltre 40 anni                       |
| RFC 2460           | 1998     | IPv6 rende il checksum UDP **obbligatorio** (era opzionale in IPv4)                            |
| RFC 8085           | 2015     | Linee guida per le applicazioni che usano UDP (usage guidelines)                               |
| QUIC (RFC 9000)    | 2021     | Protocollo moderno costruito sopra UDP che reimplementa affidabilità e cifratura a livello app |

___
# Come Funziona

UDP non stabilisce nessuna connessione preliminare. 
Il mittente costruisce un datagramma con header minimale e lo invia direttamente al destinatario, senza aspettare conferme.
Il meccanismo core si basa su tre fasi principal:
1. **Fire and Forget** 
   Il mittente spedisce il datagramma e **non sa se è arrivato**. 
   Non ci sono ACK, nessun timeout, nessuna ritrasmissione. Se il pacchetto si perde, è responsabilità dell'applicazione gestirlo se necessario.
2. **Nessun ordinamento**
    I datagrammi possono arrivare in **ordine diverso** rispetto a quello di invio, oppure non arrivare affatto.
    UDP non numera i pacchetti e non li riordina. 
    L'applicazione deve gestire il riordino se ne ha bisogno.
3. **Checksum (opzionale su IPv4, obbligatorio su IPv6)**
    L'unica forma di verifica è un checksum a 16 bit sull'header e il payload (include uno pseudo-header IP). 
    Se il checksum è errato, il datagramma viene **silenziosamente scartato**:nessuna notifica al mittente.

___
# Flusso Operativo

```
Client                        Server

  |                                |
1)|------- DATAGRAM (data) ------->|  (nessuna conferma)
  |                                |
2)|------- DATAGRAM (data) ------->|  (potrebbe arrivare fuori ordine)
  |                                |
2)|------- DATAGRAM (data) ------->|  (potrebbe perdersi)
  |                                |
4)|<------ DATAGRAM (data) --------|  (potrebbe perdersi)

```

| Fase     | # | Azione                                                                    | Stato Client | Stato Server | Note                                                                                    |
| ------------ | ----- | ----------------------------------------------------------------------------- | ---------------- | ---------------- | ------------------------------------------------------------------------------------------- |
| **Invio**    | 1     | Client costruisce il datagramma.<br>Client invia il datagramma via socket UDP | —                | —                | Nessun handshake preliminare.<br>L'OS assegna una porta effimera sorgente se non impostata. |
|              | 2     | Server riceve (o non riceve) il datagramma                                    | —                | —                | Nessuna conferma inviata.                                                                   |
| **Risposta** | 3     | Se necessario, il server invia un datagramma                                  | —                | —                | Anche la risposta è inaffidabile e non ordinata.                                            |
___
# Casi d'Uso Reali

- **DNS (porta 53)**: Ogni query DNS è un singolo datagramma. La semplicità di UDP è ideale: se la risposta non arriva entro il timeout, il resolver la richiede. Usare TCP qui introdurrebbe latenza inutile per messaggi brevi.
- **VoIP e videoconferenze (es. RTP su UDP)**: In una chiamata vocale, un pacchetto perso produce un brevissimo disturbo audio — molto meno fastidioso rispetto al blocco dell'intera trasmissione che causerebbe TCP. La latenza bassa è prioritaria sulla perfezione.
- **Gaming online**: I giochi sparatutto e di guida inviano la posizione dei giocatori molte volte al secondo. Un frame di movimento perso è obsoleto nel momento in cui arriverà il successivo: meglio ignorarlo che rallentare tutto con ritrasmissioni.
- **Streaming video (es. QUIC/HTTP/3)**: Protocolli moderni come QUIC usano UDP come trasporto e reimplementano sopra di esso selettivamente le funzionalità di affidabilità, eliminando il head-of-line blocking di TCP.
- **DHCP e TFTP**: Protocolli semplici di rete che gestiscono internamente la logica di retry e non necessitano dell'overhead di una connessione TCP.
---
# Limitazioni Tecniche

- **Nessuna garanzia di consegna**: I datagrammi possono essere persi in qualsiasi punto della rete senza notifica al mittente o al ricevitore.
- **Nessun ordinamento**: I pacchetti possono arrivare in ordine diverso da quello di invio. L'applicazione deve gestire il riordino autonomamente se necessario.
- **Nessun controllo del flusso**: UDP non ha un meccanismo di window size. Un mittente veloce può saturare la rete o il buffer del ricevitore, causando perdite massive (UDP flood).
- **Nessun controllo della congestione**: A differenza di TCP, UDP non riduce la velocità di invio quando la rete è congestionata, peggiorando attivamente la situazione per tutti gli altri flussi.
- **MTU e frammentazione**: UDP non gestisce la frammentazione applicativa. Se un datagramma supera la MTU del percorso, viene frammentato da IP (o scartato se il flag DF (flag IPv4) è impostato), con rischi di perdita dell'intero datagramma se anche un solo frammento si perde.
- **Dimensione massima payload**: Il campo Length è a 16 bit, quindi il payload massimo teorico è 65.507 byte (65.535 − 8 byte header UDP − 20 byte header IP).
___
# PDU & Incapsulamento

- **Nome PDU**: Datagramma (Datagram)
- **Incapsulato in**: Pacchetto IP (Header IPv4 o IPv6)
- **Incapsula**: Dati applicativi (DNS, DHCP, RTP, SNMP, ecc.)
    

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header UDP ] PDU: Datagramma
	             L5-7 [ Payload ]
```

___
# Struttura Del Pacchetto

## Header
È **fisso** 8 byte.

| Campo                | Dimensione | Descrizione                                                                         |
| -------------------- | ---------- | ----------------------------------------------------------------------------------- |
| **Source Port**      | 16 bit     | Porta del mittente (può essere 0 se non serve risposta)                             |
| **Destination Port** | 16 bit     | Porta del destinatario                                                              |
| **Length**           | 16 bit     | Lunghezza totale del datagramma in byte (header + payload); minimo = 8              |
| **Checksum**         | 16 bit     | Verifica integrità (opzionale su IPv4, obbligatorio su IPv6); 0x0000 = disabilitato |

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Source Port          |       Destination Port        |
|             16 bit            |            16 bit             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             Length            |            Checksum           |
|    16 bit (min 8, max 65535)  |  16 bit (0x0000 = disabled)   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
|                       Payload / Dati                          |
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
## Body
I dati effettivi dell'applicazione (es. query DNS, pacchetto RTP, messaggio DHCP).

## Flags
UDP non ha un campo Flags come TCP. Le uniche informazioni nell'header sono le 4 voci sopra. Tutta la logica di controllo (se necessaria) vive nel payload applicativo.

___
# Porte e Protocolli Correlati

| Porta    | Livello OSI                | Protocollo  | Uso**                                       |
| -------- | -------------------------- | ----------- | ------------------------------------------- |
| **53**   | **7** (Applicazione)       | DNS         | Query DNS standard (< 512 byte)             |
| **67**   | **7** (Applicazione)       | DHCP Server | Assegnazione indirizzi IP (server → client) |
| **68**   | **7** (Applicazione)       | DHCP Client | Richiesta indirizzo IP (client → server)    |
| **69**   | **7** (Applicazione)       | TFTP        | Trasferimento file semplificato             |
| **123**  | **7** (Applicazione)       | NTP         | Sincronizzazione orario di rete             |
| **161**  | **7** (Applicazione)       | SNMP        | Monitoraggio dispositivi di rete            |
| **162**  | **7** (Applicazione)       | SNMP Trap   | Notifiche asincrone SNMP                    |
| **514**  | **7** (Applicazione)       | Syslog      | Logging remoto                              |
| **1194** | **7/4** (Applicazione/Vpn) | OpenVPN     | VPN (modalità UDP)                          |
| **5004** | **7** (Applicazione)       | RTP         | Trasporto flussi multimediali in real-time  |

___
# Confronto

**UDP vs TCP**

| Caratteristica              | TCP                        | UDP                                |
| --------------------------- | -------------------------- | ---------------------------------- |
| **Connection-oriented**         | Sì (3-way handshake)       | No                                 |
| **Affidabilità**                | Sì (ACK + ritrasmissione)  | No                                 |
| **Ordinamento datagrammi**      | Sì                         | No                                 |
| **Controllo del flusso**        | Sì (Window Size)           | No                                 |
| **Controllo della congestione** | Sì (cwnd)                  | No                                 |
| **Overhead header**             | 20–60 byte                 | 8 byte                             |
| **Latenza**                     | Maggiore (handshake + ACK) | Minore  (nessun handshake)         |
| **Multicast / Broadcast**       | HTTP, FTP, SSH, SMTP       | DNS, DHCP, VoIP, streaming, gaming |
| **Casi d'uso tipici**           | No                         | Sì                                 |

___
# Aspetti di Sicurezza

## Vulnerabilità Note
- **Spoofing dell'indirizzo sorgente**: Poiché UDP è connectionless e non verifica il mittente, è banale falsificare l'IP sorgente di un datagramma. Questo è alla base di molti attacchi di amplificazione.
- **Assenza di stato**: Senza handshake, non c'è modo di distinguere traffico legittimo da traffico forgiato a livello di trasporto.
- **Checksum opzionale (IPv4)**: Se il checksum è disabilitato (campo = 0x0000), datagrammi corrotti passano inosservati fino al livello applicativo.
## Attacchi Comuni
- **UDP Flood (DoS)**: Invio massiccio di datagrammi verso una vittima per saturare la sua banda o esaurire le risorse del server. Il mittente non deve aspettare risposte, quindi può inviare a velocità massima.
- **Amplification Attack (DRDoS)**: L'attaccante invia richieste con IP sorgente falsificato (IP della vittima) a server che rispondono con reply molto più grandi (es. DNS ANY, NTP monlist, SSDP). La vittima riceve un traffico amplificato di centinaia di volte rispetto a quello originale.
- **DNS Amplification**: Variante specifica di amplification che usa server DNS aperti: una query di ~40 byte genera una risposta di ~3.000 byte (fattore di amplificazione ~75×).
    
## Contromisure
- **BCP38 / Ingress Filtering**: I provider di rete filtrano i pacchetti in uscita con IP sorgente non appartenente al loro blocco, riducendo l'efficacia degli attacchi spoofed.
- **Rate limiting**: Limitare il numero di datagrammi per IP sorgente/porta riduce l'efficacia del flood.
- **Disabilitare servizi vulnerabili ad amplificazione**: Disabilitare NTP monlist, DNS ricorsivo aperto, SSDP esposto a Internet.
- **Firewall stateful per UDP**: Anche se UDP è stateless, i firewall moderni tracciano pseudo-stato (source IP/port + dest IP/port + timeout) e scartano risposte non solicitate.
- **DTLS (Datagram TLS)**: Versione di TLS progettata per UDP, fornisce cifratura e autenticazione dei peer per protocolli come DTLS-SRTP (VoIP sicuro).
___
# Comandi Cisco IOS

``` Bash
# Visualizzare le traduzioni NAT (include flussi UDP)
show ip nat translations

# Statistiche UDP (incluse nelle statistiche IP)
show ip traffic

# Verificare socket UDP aperti su un host (Linux)
ss -unp
netstat -unp

# Debug pacchetti UDP su Cisco (attenzione: verbose)
debug ip udp

# Verifica connettività UDP su porta specifica con netcat
nc -u -zv <host> <porta>

# Capture traffico UDP su Cisco IOS con SPAN o EPC (Embedded Packet Capture)
monitor capture CAP interface GigabitEthernet0/0 both
monitor capture CAP match udp
monitor capture CAP start
monitor capture CAP stop
show monitor capture CAP buffer brief
```
___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore                            | Possibili Cause Tecniche                            | Descrizione del Fenomeno                                                                                        |
| ------------------------------------------- | --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Perdita pacchetti elevata**               | Congestione, buffer overflow, MTU mismatch          | UDP non ritrasmette: i pacchetti persi sono persi. Il rate di loss è visibile solo a livello applicativo.       |
| **Pacchetti fuori ordine**                  | Multipath routing, code di rete differenti          | Datagrammi con lo stesso sorgente/destinazione percorrono strade diverse e arrivano in ordine diverso.          |
| **"ICMP Port Unreachable" ricevuto**        | Nessun processo in ascolto sulla porta destinazione | Il server riceve il datagramma ma risponde con ICMP Type 3 Code 3 perché la porta è chiusa.                     |
| **Amplification / traffico anomalo**        | Server usato come riflettore in un DRDoS            | Il server riceve query con IP sorgente falsificato e risponde alla vittima con payload amplificato.             |
| **Latenza audio/video irregolare (jitter)** | Variazione nei tempi di consegna dei datagrammi     | Il ricevitore implementa un jitter buffer per riassorbire le variazioni; se troppo elevate, l'audio si degrada. |
| **Query DNS timeout**                       | Firewall blocca UDP 53, server non raggiungibile    | Il resolver non riceve risposta entro il timeout e riprova (di solito 2–3 volte) prima di fallire.              |

**Comandi di verifica**:

``` Bash
# Linux — socket UDP attivi
ss -unp

# Cattura datagrammi UDP su porta 53
tcpdump -i eth0 udp port 53

# Test invio datagramma UDP a porta specifica
nc -u <host> <porta>

# Verifica ICMP Port Unreachable
tcpdump -i eth0 icmp

# Statistiche di rete (pacchetti persi, errori)
netstat -su      # Linux
nstat -az        # Linux, più dettagliato

# Misura jitter e perdita pacchetti UDP
iperf3 -u -c <host> -b 10M    # Test banda UDP con statistiche jitter/loss
```

**Cause frequenti**:

| Problema                        | Causa Tecnica                                                                       | Sintomo e Comportamento                                                                                   |
| ------------------------------- | ----------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| **MTU Mismatch**                | Il datagramma supera la MTU del percorso.                                           | IP frammenta il datagramma; se un frammento si perde, l'intero datagramma viene scartato dal ricevitore.  |
| **Firewall che blocca UDP**     | Il firewall è configurato per bloccare UDP o specifiche porte.                      | Nessuna risposta e nessun ICMP Port Unreachable (il firewall fa "drop silenzioso").                       |
| **NAT Timeout Aggressivo**      | Il NAT elimina la entry della sessione UDP prima che arrivi la risposta del server. | Il pacchetto di risposta non trova corrispondenza nella tabella NAT e viene scartato.                     |
| **Buffer Overflow Applicativo** | L'applicazione non legge i datagrammi abbastanza velocemente.                       | Il buffer del socket si riempie e l'OS scarta i nuovi datagrammi in arrivo (errore `ENOBUFS` o `EAGAIN`). |
___
# Note Esame
## Da sapere a memoria

| Argomento           | Dettagli Tecnici                                                                     |
| ----------------------- | ---------------------------------------------------------------------------------------- |
| **Definizione**         | Layer 4 (Trasporto), connectionless, inaffidabile, supporta unicast/multicast/broadcast. |
| **Standard RFC**        | **RFC 768** (1980) — rimasto invariato.                                                  |
| **Dimensione Header**   | **8 byte fissi** (4 campi × 16 bit). Non ci sono opzioni.                                |
| **Campi Header**        | Source Port, Destination Port, Length, Checksum.                                         |
| **PDU**                 | **Datagramma** (non segmento come TCP).                                                  |
| **Checksum**            | Opzionale su IPv4 (0x0000 = disabilitato); **obbligatorio su IPv6**.                     |
| **Multicast/Broadcast** | **Sì** — unico protocollo L4 a supportarlo nativamente.                                  |
| **Controllo flusso**    | **Nessuno**. Nessun windowing, nessun ACK.                                               |
| **Porta sorgente**      | Può essere **0** se la risposta non è necessaria (es. DHCP discover).                    |
| **Attacco tipico**      | **Amplification Attack**: sfrutta la natura connectionless per amplificare traffico DoS. |
| **Incapsulamento**      | UDP viaggia su IP. PDU UDP = **Datagramma**; PDU IP = **Pacchetto**.                     |

## Trabocchetti frequenti

| Concetto Errato                           | Realtà Tecnica                                                                                                          |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **UDP è completamente senza checksum**        | **FALSO**. Il checksum esiste ed è obbligatorio su IPv6; opzionale (non assente) su IPv4.                                   |
| **UDP non può fare comunicazioni affidabili** | **PARZIALMENTE FALSO**. L'affidabilità può essere reimplementata a livello applicativo (es. QUIC, TFTP, RUDP).              |
| **UDP è sempre più veloce di TCP**            | **DIPENDE**. UDP ha meno overhead, ma su reti con perdita elevata TCP può essere più efficiente grazie alle ritrasmissioni. |
| **La porta sorgente UDP è sempre impostata**  | **FALSO**. Il campo Source Port può valere **0** se il mittente non si aspetta risposte.                                    |
| **UDP non supporta il multicast**             | **FALSO**. UDP supporta nativamente unicast, multicast **e** broadcast. TCP no.                                             |
| **Checksum UDP = Checksum TCP**               | **FALSO**. TCP include sempre uno pseudo-header IP nel calcolo; UDP su IPv4 può disabilitarlo del tutto.                    |
| **"Connection refused" non esiste in UDP**    | **PARZIALMENTE FALSO**. Se la porta è chiusa, il destinatario risponde con **ICMP Port Unreachable** (Type 3 Code 3).       |

___
# Quick Reference Card

```
- Porta sorgente può essere 0 (se non serve risposta)
- Porta chiusa → ICMP Type 3 Code 3 (Port Unreachable)
- Checksum esiste: non è assente, è opzionale (IPv4)
- Supporta multicast e broadcast (TCP no)
- Affidabilità reimplementabile a livello app (QUIC, TFTP)
```

___
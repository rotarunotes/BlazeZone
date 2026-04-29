Data: 2026-04-23
[Transport_Layer](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Transport_Layer
___
# Index
- [[#Transmission Control Protocol]]
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
# Transmission Control Protocol

## Panoramica

| Caratteristica              |                                               Dettaglio                                               |
| --------------------------- | :---------------------------------------------------------------------------------------------------: |
| **Livello OSI**             |                                            4 — Transporto                                             |
| **Porta**                   |                                       Identificato dal servizio                                       |
| **Scopo**                   | Fornire una comunicazione **affidabile**, **ordinata** e con **controllo** degli errori tra due host. |
| **RFC / Standard**          |                                               RFC 9293                                                |
| **Tipo Connessione**        |                    **Connection-oriented** (richiede instaurazione della sessione)                    |
| **Affidabilità**            |                            **Affidabile** (conferma ricezione tramite ACK)                            |
| **PDU (Unità Dati)**        |                                             **Segmento**                                              |
| **Meccanismo di Controllo** |                             Flow Control (Windowing) e Congestion Control                             |
___
# Versioni & Evoluzione

| Versione / RFC | Anno | Novità principali                                                                              |
| -------------- | ---- | ---------------------------------------------------------------------------------------------- |
| RFC 793        | 1981 | Specifica originale TCP                                                                        |
| RFC 1122       | 1989 | Correzioni e requisiti per host Internet                                                       |
| RFC 2581       | 1999 | Controllo della congestione (Slow Start, Congestion Avoidance, Fast Retransmit, Fast Recovery) |
| RFC 2018       | 1996 | SACK — Selective Acknowledgment                                                                |
| RFC 7323       | 2014 | TCP Extensions: Window Scaling, Timestamps (PAWS)                                              |
| RFC 9293       | 2022 | Consolidamento e aggiornamento della specifica base                                            |
___
# Come Funziona

TCP stabilisce una connessione logica tra mittente e destinatario prima di trasferire dati. 
Il meccanismo core si basa su tre fasi principali:
1. **Three-Way Handshake (apertura connessione)**
	Il client invia un segmento **SYN** (*Synchronize*) con un **ISN** (*Initial Sequence Number*) randomico.
	
	![[ISO_OSI#Sequenziamento]]
	Il server risponde con **SYN-ACK** (*Synchronize-Acknowledgment*), confermando il **SYN** del client e annunciando il proprio **ISN**.
	Il client chiude l'handshake con un **ACK**. Da questo momento la connessione è stabilita e bidirezionale.
1. **Trasferimento dati affidabile**
	Ogni byte trasmesso ha un numero di sequenza. Il ricevitore invia ACK **cumulativi** (il destinatario aspetta un attimo e dice: "Ho ricevuto tutto correttamente fino al byte 3. Il prossimo che mi aspetto è il 4").
	Se un segmento non viene confermato entro il timeout **RTO** (*Retransmission Timeout*), viene ritrasmesso.
	Il meccanismo di finestra scorrevole (sliding window) permette di inviare più segmenti senza aspettare un ACK per ciascuno, aumentando il throughput.
2. **Four-Way Handshake (chiusura connessione)**
	La chiusura è half-duplex: ciascun lato chiude indipendentemente la propria direzione con **FIN** (*Finish*) + **ACK**. 
	Lo stato **TIME_WAIT** sul lato che chiude per primo garantisce che eventuali segmenti ritardati in rete vengano scartati prima di riutilizzare la stessa porta.
___
# Flusso Operativo

```
Client                                           Server
  |                                                 | 
  |            [APERTURA: 3-Way Handshake]          |
1)|------- SYN (seq=x) ---------------------------->| (SYN_SENT)
  |                                                 |
2)|<------ SYN-ACK (seq=y, ack=x+1) ----------------| (SYN_RECEIVED)
  |                                                 |
3)|------- ACK (ack=y+1) -------------------------->| (ESTABLISHED)
  |                                                 |
4)|              CONNESSA / ESTABLISHED             |
  |                                                 |
  |              [TRASFERIMENTO DATI]               |
  |------- DATA (seq=x+1, len=n) ------------------>|
  |                                                 |
  |<------ ACK (ack=x+1+n) -------------------------|
  |                                                 |
  |            [CHIUSURA: 4-Way Handshake]          |
  |                                                 |
5)|------- FIN (seq=u) ---------------------------->| (FIN_WAIT_1)
  |                                                 | (CLOSE_WAIT)
6)|<------ ACK (ack=u+1) ---------------------------| (FIN_WAIT_2)
  |                                                 |
  |      (Il server finisce di inviare i dati)      |
  |                                                 | (LAST_ACK)
7)|<------ FIN (seq=v) -----------------------------|
  |                                                 |
8)|------- ACK (ack=v+1) -------------------------->| (TIME_WAIT)
  |                                                 |
  |                  [Chiusa]                       |
```

| Fase         | \#  | Azione                                           | Stato Client  | Stato Server   | Note                                                    |
| ------------ | --- | ------------------------------------------------ | ------------- | -------------- | ------------------------------------------------------- |
| **Apertura** | 1   | Client invia **SYN** (seq=x)                     | `SYN_SENT`    | `LISTEN`       | Richiesta di connessione con ISN client.                |
|              | 2   | Server risponde **SYN-ACK** <br>(seq=y, ack=x+1) | `SYN_SENT`    | `SYN_RECEIVED` | Il server conferma x e invia il suo ISN y.              |
|              | 3   | Client invia **ACK** (ack=y+1)                   | `ESTABLISHED` | `ESTABLISHED`  | La connessione è ora bidirezionale.                     |
| **Dati**     | 4   | Trasferimento **DATA**                           | `ESTABLISHED` | `ESTABLISHED`  | I dati vengono confermati in base alla lunghezza (len). |
| **Chiusura** | 5   | Client invia **FIN** <br>(seq=u)                 | `FIN_WAIT_1`  | `ESTABLISHED`  | Il client non ha più dati da inviare.                   |
|              | 6   | Server risponde **ACK** (ack=u+1)                | `FIN_WAIT_2`  | `CLOSE_WAIT`   | Il server conferma la chiusura del client.              |
|              | 7   | Server invia **FIN** (seq=v)                     | `FIN_WAIT_2`  | `LAST_ACK`     | Anche il server chiude la sua mandata.                  |
|              | 8   | Client risponde **ACK** (ack=v+1)                | `TIME_WAIT`   | `CLOSED`       | Chiusura definitiva dopo il timeout di sicurezza.       |

___
# Casi d'Uso Reali

- **Navigazione web (HTTP/HTTPS)**: Quando apri un sito, il browser stabilisce una connessione TCP con il server web (porta 443 per HTTPS). TCP garantisce che ogni byte della pagina HTML, CSS e JavaScript arrivi integro e nell'ordine corretto. Senza TCP, una pagina potrebbe caricarsi corrotta o incompleta.
- **Email (SMTP/IMAP)**: Quando invii un'email, il client apre una sessione TCP verso il server SMTP (porta 587). L'affidabilità di TCP assicura che il messaggio venga consegnato per intero al server, che poi lo instrada verso il destinatario.
- **Trasferimento file (FTP/SFTP)**: Durante il download di un file ISO da un server FTP, TCP si occupa di ritrasmettere automaticamente ogni pacchetto perso, garantendo che il file ricevuto sia bit-per-bit identico all'originale, senza necessità di checksum applicativi aggiuntivi.
___
# Limitazioni Tecniche

- **Head-of-line blocking**: Un segmento perso blocca la consegna di tutti i segmenti successivi già ricevuti, anche se in buffer. Questo è un limite strutturale della gestione ordinata dello stream (risolto parzialmente in HTTP/3 con QUIC).
- **Overhead elevato**: L'header TCP è di almeno 20 byte, più opzioni fino a 60 byte. Per applicazioni che trasmettono piccoli payload ad alta frequenza (es. telemetria IoT), questo overhead è sproporzionato rispetto al dato utile.
- **Latenza aggiuntiva da handshake**: Il three-way handshake introduce almeno 1 RTT (Round-Trip Time) prima che il primo dato applicativo possa essere inviato. In scenari con RTT elevato (es. connessioni satellitari), questo impatta significativamente la latenza percepita.
- **Problemi con NAT e middlebox**: I numeri di sequenza e le porte vengono modificati dai dispositivi NAT, e alcune opzioni TCP avanzate (es. TCP Fast Open) vengono bloccate o alterate da firewall e middlebox intermedi.
- **Scalabilità del TIME_WAIT**: Server ad alto traffico (es. reverse proxy) che aprono e chiudono migliaia di connessioni al secondo possono esaurire le porte disponibili a causa dell'accumulo di socket in stato TIME_WAIT (durata default: 2×MSL = ~60-120s).
- **Non adatto a multicast/broadcast**: TCP è esclusivamente unicast punto-a-punto. Non supporta natively la comunicazione uno-a-molti.
___
# PDU & Incapsulamento

- **Nome PDU**: Segmento (Segment)
- **Incapsulato in**: Pacchetto IP (Header IPv4 o IPv6)
- **Incapsula**: Dati applicativi (HTTP, FTP, SMTP, ecc.)

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header UDP ] PDU: Segmento
	             L5-7 [ Payload ]
```

___
# Struttura Del Pacchetto
## Header

| Campo                     | Dimensione | Descrizione                                                    |
| ------------------------- | ---------- | -------------------------------------------------------------- |
| **Source Port**           | 16 bit     | Porta del mittente                                             |
| **Destination Port**      | 16 bit     | Porta del destinatario                                         |
| **Sequence Number**       | 32 bit     | Numero di sequenza del primo byte del payload                  |
| **Acknowledgment Number** | 32 bit     | Prossimo byte atteso dal ricevitore (valido se ACK=1)          |
| **Data Offset (HLEN)**    | 4 bit      | Lunghezza header in word da 32 bit (min=5, max=15)             |
| **Reserved**              | 3 bit      | Riservati, devono essere 0                                     |
| **Control Flags**         | 9 bit      | URG, ACK, PSH, RST, SYN, FIN (+ ECN: CWR, ECE, NS)             |
| **Window Size**           | 16 bit     | Dimensione della finestra di ricezione in byte                 |
| **Checksum**              | 16 bit     | Verifica integrità header + payload (include pseudo-header IP) |
| **Urgent Pointer**        | 16 bit     | Offset dei dati urgenti (valido solo se URG=1)                 |
| **Options**               | 0–320 bit  | Opzioni facoltative (MSS, Window Scale, SACK, Timestamp…)      |
| **Padding**               | variabile  | Allineamento header a multiplo di 32 bit                       |

``` 
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Source Port          |       Destination Port        |
|             16 bit            |            16 bit             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Sequence Number                        |
|                            32 bit                             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                     Acknowledgment Number                     |
|                   32 bit — valido se ACK=1                    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| HLEN  |  Res. |N|C|E|U|A|P|R|S|F|        Window Size          |
| 4 bit | 3 bit |S|W|C|R|C|S|S|Y|I|           16 bit            |
|       |       | |R|E|G|K|H|T|N|N|                             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|            Checksum           |        Urgent Pointer         |
|            16 bit             |    16 bit — valido se URG=1   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options (0–320 bit)                        |
|         MSS, Window Scale, SACK, Timestamp, …                 |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                  Padding (allinea a 32 bit)                   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
|                       Payload / Dati                          |
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
## Body
I dati effettivi dell'applicazione (es. HTTP, FTP, TLS).
## Flags

| Bit | Flag    | Nome Esteso               | Descrizione e Utilizzo                                                                              |
| --- | ------- | ------------------------- | --------------------------------------------------------------------------------------------------- |
| 8   | **NS**  | *Nonce Sum*                 | Protezione contro la cancellazione accidentale dei segnali di congestione.                          |
| 9   | **CWR** | *Congestion Window Reduced* | Il mittente conferma di aver ridotto la finestra di invio dopo una congestione.                     |
| 10  | **ECE** | *ECN Echo*                  | Notifica che è stata rilevata congestione nella rete (livello IP).                                  |
| 11  | **URG** | *Urgent*                    | **Dati urgenti:** segnala al ricevitore di leggere i dati puntati dall'Urgent Pointer con priorità. |
| 12  | **ACK** | *Acknowledgment*            | **Conferma:** abilita il campo ACK Number. Fondamentale per la ricezione affidabile.                |
| 13  | **PSH** | *Push*                      | **Invia subito:** bypassa il buffer e consegna i dati immediatamente all'applicazione.              |
| 14  | **RST** | *Reset*                     | **Chiusura forzata:** interrompe il collegamento per errori gravi o porta chiusa.                   |
| 15  | **SYN** | *Synchronize*               | **Avvio:** sincronizza gli ISN durante il Three-Way Handshake.                                      |
| 16  | **FIN** | *Finish*                    | **Chiusura:** indica che il mittente ha terminato l'invio dei dati (chiusura formale).              |
___
# Porte e Protocolli Correlati

| Porta    | Livello OSI          | Protocollo | Uso                                  |
| -------- | -------------------- | ---------- | ------------------------------------ |
| **20**   | **7** (Applicazione) | FTP-DATA   | Trasferimento dati FTP               |
| **21**   | **7** (Applicazione) | FTP        | Controllo FTP                        |
| **22**   | **7** (Applicazione) | SSH        | Shell sicura, tunneling              |
| **23**   | **7** (Applicazione) | Telnet     | Accesso remoto non cifrato           |
| **25**   | **7** (Applicazione) | SMTP       | Invio email                          |
| **53**   | **7** (Applicazione) | DNS (TCP)  | Query DNS > 512 byte / zone transfer |
| **80**   | **7** (Applicazione) | HTTP       | Web non cifrato                      |
| **110**  | **7** (Applicazione) | POP3       | Ricezione email                      |
| **143**  | **7** (Applicazione) | IMAP       | Gestione email remota                |
| **443**  | **7** (Applicazione) | HTTPS      | Web cifrato (TLS su TCP)             |
| **3389** | **7** (Applicazione) | RDP        | Desktop remoto Windows               |
****
___
# Confronto

**TCP VS UDP**

| Caratteristica              | TCP                        | UDP                                |
| --------------------------- | -------------------------- | ---------------------------------- |
| **Connection-oriented**         | Sì (3-way handshake)       | No                                 |
| **Affidabilità**                | Sì (ACK + ritrasmissione)  | No                                 |
| **Ordinamento segmenti**        | Sì                         | No                                 |
| **Controllo del flusso**        | Sì (Window Size)           | No                                 |
| **Controllo della congestione** | Sì (cwnd)                  | No                                 |
| **Overhead header**             | 20–60 byte                 | 8 byte                             |
| **Latenza**                     | Maggiore (handshake + ACK) | Minore  (nessun handshake)         |
| **Casi d'uso**                  | HTTP, FTP, SSH, SMTP       | DNS, DHCP, VoIP, streaming, gaming |
| **Multicast / Broadcast**       | No                         | Sì                                 |
___
# Aspetti di Sicurezza

## Vulnerabilità Note
- **Prevedibilità dell'ISN (*Initial Sequence Number*)**: Nelle implementazioni storiche, l'ISN era prevedibile. Un attaccante poteva forgiare segmenti validi senza sniffare il traffico.
- **Half-open connections**: Lo stato SYN_RECEIVED consuma risorse sul server senza che la connessione sia completata alla base del SYN Flood.
- **TIME_WAIT assassination**: Un segmento RST con numero di sequenza nell'intervallo accettabile può abbattere connessioni in TIME_WAIT.
- **Session Hijacking**: Se un attaccante riesce a predire o osservare i numeri di sequenza, può iniettare dati in una sessione TCP stabilita.
## Attacchi Comuni
- **SYN Flood (DoS)**: Il client invia un gran numero di SYN senza mai completare l'handshake, esaurendo la tabella delle connessioni half-open del server.
- **TCP Session Hijacking**: L'attaccante si inserisce in una sessione TCP attiva iniettando segmenti con numeri di sequenza corretti.
- **RST Attack**: Invio di segmenti RST falsificati per abbattere connessioni legittime (usato anche da alcuni ISP per bloccare contenuti "TCP Reset Attack").
- **Man-in-the-Middle (MitM)**: In assenza di cifratura, un attaccante in posizione di rete intermedia può leggere e modificare i dati dello stream.
## Contromisure
- **SYN Cookies**: Il server non alloca stato per connessioni half-open: codifica le informazioni nel proprio ISN. La connessione viene confermata solo al ricevimento dell'ACK finale. Abilitabile su Linux con `net.ipv4.tcp_syncookies=1`.
- **Randomizzazione dell'ISN**: Le implementazioni moderne (Linux, Windows, BSD) usano ISN casuali crittograficamente sicuri per prevenire spoofing e hijacking.
- **TLS/SSL sopra TCP**: Cifra il payload e autentica i peer, rendendo inutili MitM e session hijacking sul contenuto applicativo.
- **Firewall stateful**: Tracciano lo stato delle connessioni TCP e bloccano segmenti anomali (RST fuori sequenza, SYN su connessioni già stabilite, ecc.).
- **Rate limiting SYN**: Limitare il numero di SYN al secondo per IP sorgente riduce l'efficacia di SYN Flood distribuiti.
___
# Comandi Cisco IOS

```bash
# Visualizzare le connessioni TCP attive sul router
show tcp brief

# Dettaglio di una connessione TCP specifica
show tcp tcb <indirizzo-TCB>

# Statistiche TCP (connessioni aperte, ritrasmissioni, ecc.)
show ip tcp statistics

# Verificare le sessioni aperte su un'interfaccia (include TCP)
show ip nat translations

# Abilitare il debug del three-way handshake (attenzione: verbose)
debug ip tcp transactions

# Debug dei pacchetti TCP (solo in lab, non in produzione)
debug ip tcp packet

# Visualizzare le connessioni delle applicazioni di gestione (SSH, Telnet)
show line
show users

# Configurare il timeout delle sessioni TCP inattive (in secondi)
ip tcp synwait-time 10

# Abilitare TCP Intercept per proteggere da SYN Flood
ip tcp intercept list <ACL>
ip tcp intercept mode watch
ip tcp intercept mode intercept
```
___
# Troubleshooting

**Sintomi comuni:**

| Sintomo / Errore                | Possibili Cause Tecniche                              | Descrizione del Fenomeno                                                                                                  |
| ------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Apertura lenta o incompleta** | SYN perso, Firewall restrittivo, MTU mismatch         | L'handshake non si conclude; i pacchetti SYN vengono scartati o frammentati in modo errato.                               |
| **Throughput basso (lentezza)** | Window Size piccola, RTT elevato, Ritrasmissioni      | La "finestra" limita i dati in transito; l'alta latenza (RTT) rallenta i pacchetti di conferma (ACK).                     |
| **Chiusura improvvisa**         | Flag **RST** inatteso, Idle timeout, Crash del server | Un dispositivo intermedio (Firewall/NAT) o il server stesso interrompono forzatamente il flusso.                          |
| **Applicazione "bloccata"**     | Head-of-line blocking, Buffer pieno (**Window=0**)    | Un segmento perso ferma la coda (TCP deve consegnare in ordine) o il ricevitore comunica di non avere più spazio.         |
| **"Connection refused"**        | Porta chiusa, Servizio non attivo                     | Il server è raggiungibile ma invia un **RST** perché nessun processo è in ascolto su quella specifica porta.              |
| **"Connection timed out"**      | Routing errato, Firewall "Drop", Host down            | Il pacchetto **SYN** viene inviato ma cade nel vuoto (nessuna risposta); il client smette di provare dopo un certo tempo. |

**Comandi di verifica:**

```bash
# Linux/Mac — stato connessioni TCP
ss -tnp
netstat -tnp

# Cattura traffico TCP su porta 80
tcpdump -i eth0 tcp port 80 -w cattura.pcap

# Verifica RTT e percorso
traceroute -T -p 443 <host>      # TCP traceroute
ping <host>                       # RTT base

# Test connettività TCP su porta specifica
nc -zv <host> <porta>
telnet <host> <porta>

# Statistiche ritrasmissioni su Linux
ss -s
cat /proc/net/tcp
```

**Cause frequenti:**

| Problema                   | Causa Tecnica                                                                       | Sintomo e Comportamento                                                                                                                          |
| -------------------------- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **MTU Mismatch**           | Differenza nella dimensione massima dei pacchetti tra due nodi.                     | I pacchetti piccoli (ACK) passano, quelli grandi vengono scartati (**Drop**) se hanno il flag **DF** (Don't Fragment).                           |
| **Firewall Asimmetrico**   | Il traffico di andata e ritorno segue percorsi diversi attraverso firewall diversi. | Il firewall scarta i pacchetti di risposta (**SYN-ACK**) perché non ha registrato il pacchetto di apertura (**SYN**) nella sua tabella di stato. |
| **NAT Timeout Aggressivo** | Il router NAT elimina la riga di traduzione IP/Porta troppo velocemente.            | Le connessioni lunghe (es. SSH) si "congelano" senza messaggi d'errore; il NAT non sa più a chi inoltrare i pacchetti in arrivo.                 |
| **Buffer Overflow (App)**  | L'applicazione ricevente non svuota il buffer TCP abbastanza velocemente.           | Il ricevitore invia un pacchetto con **Window=0** (Zero Window). Il mittente interrompe l'invio e attende un **Window Update**.                  |
___
# Note Esame

## Da sapere a memoria
| Argomento              | Dettagli Tecnici                                                          |
| ---------------------- | ------------------------------------------------------------------------- |
| **Definizione**        | Layer 4 (Trasporto), connection-oriented, affidabile, unicast.            |
| **Standard RFC**       | Originale: **793** (1981); Consolidato: **9293** (2022).                  |
| **Dimensione Header**  | Minimo **20 byte**; Massimo **60 byte** (con opzioni).                    |
| **Handshake Apertura** | Three-way: **SYN** → **SYN-ACK** → **ACK**.                               |
| **Handshake Chiusura** | Four-way: **FIN** → **ACK** → **FIN** → **ACK**.                          |
| **Sequence Number**    | **32 bit**: conta i singoli byte inviati, non i segmenti.                 |
| **Window Size**        | **16 bit** (max 64KB); estendibile fino a ~1GB con Window Scale.          |
| **Flag Principali**    | SYN, ACK, FIN, RST, PSH, URG.                                             |
| **Stato TIME_WAIT**    | Dura **2 × MSL** (tipicamente 60–120 secondi).                            |
| **Sicurezza (Flood)**  | **SYN Cookies**: evitano l'allocazione di risorse per attacchi SYN Flood. |
| **Incapsulamento**     | TCP viaggia su IP. PDU TCP = **Segmento**; PDU IP = **Pacchetto**.        |

## Trabocchetti frequenti

| Concetto Errato                  | Realtà Tecnica                                                                                   |
| -------------------------------- | ------------------------------------------------------------------------------------------------ |
| **ACK = Sequence ricevuto**      | **FALSO**. L'ACK indica il **prossimo byte atteso** (seq ricevuto + lunghezza payload).          |
| **FIN chiude tutto subito**      | **FALSO**. Chiude solo una direzione (**half-close**); servono due FIN (uno per lato).           |
| **TCP garantisce la consegna**   | **PARZIALMENTE VERO**. Tenta con ritrasmissioni, ma se il link cade la connessione fallisce.     |
| **RST = Chiusura normale**       | **FALSO**. RST è una chiusura **anomala/forzata** (abort); FIN è per la chiusura normale.        |
| **Porta sorgente fissa**         | **FALSO**. Il client usa solitamente una **porta effimera** dinamica (es. 49152–65535).          |
| **Window Size = Dim. pacchetto** | **FALSO**. È lo spazio libero nel **buffer del ricevitore** per dati non ancora confermati.      |
| **Porte TCP/UDP sono uguali**    | **VERO/FALSO**. Entrambi usano porte, ma sono **spazi indipendenti** (es. TCP 53 $\neq$ UDP 53). |
___
# Quick Reference Card

```
- ACK = prossimo byte atteso (non l'ultimo ricevuto)
- FIN chiude solo una direzione (half-close)
- RST = abort forzato, FIN = chiusura normale
- TIME_WAIT dura 2 × MSL (~60–120 s) 
- No multicast, no broadcast
```
___
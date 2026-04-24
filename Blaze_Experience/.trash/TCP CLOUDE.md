Data: 2026-04-23 | Reti/Protocolli | #Reti/Protocolli

---

# Index

- TCP
- Panoramica
- Versioni & Evoluzione
- Come Funziona
- Casi d'Uso Reali
- Limitazioni Tecniche
- Flusso Operativo
- PDU & Incapsulamento
- Struttura Header / Pacchetto
- Porte e Protocolli Correlati
- Confronto
- Aspetti di Sicurezza
  - Vulnerabilità Note
  - Attacchi Comuni
  - Contromisure
- Comandi Cisco IOS
- Troubleshooting
- Note Esame
  - Da sapere a memoria
  - Trabocchetti frequenti

---

# TCP — Transmission Control Protocol

## Panoramica
- **Livello OSI:** 4 — Transport Layer
- **Scopo:** Fornire una comunicazione affidabile, ordinata e con controllo degli errori tra due host su una rete IP.
- **RFC / Standard:** RFC 793 (1981), aggiornato da RFC 9293 (2022)
- **Connection-oriented / Connectionless:** Connection-oriented
- **Affidabile / Non affidabile:** Affidabile

---

## Versioni & Evoluzione

| Versione / RFC | Anno | Novità principali                                                                              |
| -------------- | ---- | ---------------------------------------------------------------------------------------------- |
| RFC 793        | 1981 | Specifica originale TCP                                                                        |
| RFC 1122       | 1989 | Correzioni e requisiti per host Internet                                                       |
| RFC 2581       | 1999 | Controllo della congestione (Slow Start, Congestion Avoidance, Fast Retransmit, Fast Recovery) |
| RFC 2018       | 1996 | SACK — Selective Acknowledgment                                                                |
| RFC 7323       | 2014 | TCP Extensions: Window Scaling, Timestamps (PAWS)                                              |
| RFC 9293       | 2022 | Consolidamento e aggiornamento della specifica base                                            |

---

## Come Funziona

TCP stabilisce una connessione logica tra mittente e destinatario prima di trasferire dati. Il meccanismo core si basa su tre fasi principali:

**1. Three-Way Handshake (apertura connessione)**
Il client invia un segmento SYN con un Initial Sequence Number (ISN) casuale. Il server risponde con SYN-ACK, confermando il SYN del client e annunciando il proprio ISN. Il client chiude l'handshake con un ACK. Da questo momento la connessione è stabilita e bidirezionale.

**2. Trasferimento dati affidabile**
Ogni byte trasmesso ha un numero di sequenza. Il ricevitore invia ACK cumulativi per confermare la ricezione. Se un segmento non viene confermato entro il timeout (RTO — Retransmission Timeout), viene ritrasmesso. Il meccanismo di finestra scorrevole (sliding window) permette di inviare più segmenti senza aspettare un ACK per ciascuno, aumentando il throughput.

**3. Four-Way Handshake (chiusura connessione)**
La chiusura è half-duplex: ciascun lato chiude indipendentemente la propria direzione con FIN + ACK. Lo stato TIME_WAIT sul lato che chiude per primo garantisce che eventuali segmenti ritardati in rete vengano scartati prima di riutilizzare la stessa porta.

**Controllo del flusso** — tramite il campo Window Size, il ricevitore comunica quanti byte può accettare nel proprio buffer. Se la finestra si azzera, il mittente si ferma fino a un Window Update.

**Controllo della congestione** — algoritmi come Slow Start, Congestion Avoidance, Fast Retransmit e Fast Recovery adattano dinamicamente la velocità di trasmissione in base alla congestione della rete (cwnd — congestion window).

---

## Casi d'Uso Reali

- **Esempio 1 — Navigazione web (HTTP/HTTPS):** Quando apri un sito, il browser stabilisce una connessione TCP con il server web (porta 443 per HTTPS). TCP garantisce che ogni byte della pagina HTML, CSS e JavaScript arrivi integro e nell'ordine corretto. Senza TCP, una pagina potrebbe caricarsi corrotta o incompleta.
- **Esempio 2 — Email (SMTP/IMAP):** Quando invii un'email, il client apre una sessione TCP verso il server SMTP (porta 587). L'affidabilità di TCP assicura che il messaggio venga consegnato per intero al server, che poi lo instrada verso il destinatario.
- **Esempio 3 — Trasferimento file (FTP/SFTP):** Durante il download di un file ISO da un server FTP, TCP si occupa di ritrasmettere automaticamente ogni pacchetto perso, garantendo che il file ricevuto sia bit-per-bit identico all'originale, senza necessità di checksum applicativi aggiuntivi.

---

## Limitazioni Tecniche

- **Head-of-line blocking:** Un segmento perso blocca la consegna di tutti i segmenti successivi già ricevuti, anche se in buffer. Questo è un limite strutturale della gestione ordinata dello stream (risolto parzialmente in HTTP/3 con QUIC).
- **Overhead elevato:** L'header TCP è di almeno 20 byte, più opzioni fino a 60 byte. Per applicazioni che trasmettono piccoli payload ad alta frequenza (es. telemetria IoT), questo overhead è sproporzionato rispetto al dato utile.
- **Latenza aggiuntiva da handshake:** Il three-way handshake introduce almeno 1 RTT (Round-Trip Time) prima che il primo dato applicativo possa essere inviato. In scenari con RTT elevato (es. connessioni satellitari), questo impatta significativamente la latenza percepita.
- **Problemi con NAT e middlebox:** I numeri di sequenza e le porte vengono modificati dai dispositivi NAT, e alcune opzioni TCP avanzate (es. TCP Fast Open) vengono bloccate o alterate da firewall e middlebox intermedi.
- **Scalabilità del TIME_WAIT:** Server ad alto traffico (es. reverse proxy) che aprono e chiudono migliaia di connessioni al secondo possono esaurire le porte disponibili a causa dell'accumulo di socket in stato TIME_WAIT (durata default: 2×MSL = ~60-120s).
- **Non adatto a multicast/broadcast:** TCP è esclusivamente unicast punto-a-punto. Non supporta natively la comunicazione uno-a-molti.

---

## Flusso Operativo

### Three-Way Handshake (connessione)

```
Client                            Server
  |                                  |
  |------- SYN (seq=x) ------------->|
  |                                  |
  |<------ SYN-ACK (seq=y, ack=x+1) |
  |                                  |
  |------- ACK (ack=y+1) ----------->|
  |                                  |
  |  [Connessione stabilita]         |
  |                                  |
  |------- DATA (seq=x+1) ---------->|
  |                                  |
  |<------ ACK (ack=x+1+len) --------|
  |                                  |
```

1. Il client invia **SYN** con il proprio ISN (x). Entra nello stato SYN_SENT.
2. Il server risponde con **SYN-ACK**: conferma il SYN del client (ack=x+1) e annuncia il proprio ISN (y). Entra nello stato SYN_RECEIVED.
3. Il client invia **ACK** (ack=y+1). Entrambi entrano nello stato ESTABLISHED.
4. Il trasferimento dati può iniziare. Ogni segmento dati viene confermato con ACK.

### Four-Way Handshake (chiusura)

```
Client                            Server
  |                                  |
  |------- FIN (seq=u) ------------->|   Client: FIN_WAIT_1
  |                                  |
  |<------ ACK (ack=u+1) ------------|   Server: CLOSE_WAIT / Client: FIN_WAIT_2
  |                                  |
  |<------ FIN (seq=v) --------------|   Server: LAST_ACK
  |                                  |
  |------- ACK (ack=v+1) ----------->|   Client: TIME_WAIT (2×MSL)
  |                                  |
  |  [Connessione chiusa]            |
```

1. Il client manda **FIN**: non invierà più dati, ma può ancora ricevere.
2. Il server risponde con **ACK**: può continuare a inviare dati (half-close).
3. Il server manda il proprio **FIN** quando ha terminato.
4. Il client risponde con **ACK** ed entra in **TIME_WAIT** per 2×MSL (~60-120s) per assorbire eventuali segmenti duplicati tardivi.

---

## PDU & Incapsulamento

- **Nome PDU:** Segmento (Segment)
- **Incapsulato in:** Pacchetto IP (Header IPv4 o IPv6)
- **Incapsula:** Dati applicativi (HTTP, FTP, SMTP, ecc.)

```
[ Header Ethernet / Frame L2 ]
    [ Header IP (L3) ]
        [ Header TCP (L4) — min 20 byte ]
            [ Payload: Dati Applicativi (L5-L7) ]
```

---

## Struttura Header / Pacchetto

| Campo                 | Dimensione | Descrizione                                                    |
| --------------------- | ---------- | -------------------------------------------------------------- |
| Source Port           | 16 bit     | Porta del mittente                                             |
| Destination Port      | 16 bit     | Porta del destinatario                                         |
| Sequence Number       | 32 bit     | Numero di sequenza del primo byte del payload                  |
| Acknowledgment Number | 32 bit     | Prossimo byte atteso dal ricevitore (valido se ACK=1)          |
| Data Offset (HLEN)    | 4 bit      | Lunghezza header in word da 32 bit (min=5, max=15)             |
| Reserved              | 3 bit      | Riservati, devono essere 0                                     |
| Control Flags         | 9 bit      | URG, ACK, PSH, RST, SYN, FIN (+ ECN: CWR, ECE, NS)             |
| Window Size           | 16 bit     | Dimensione della finestra di ricezione in byte                 |
| Checksum              | 16 bit     | Verifica integrità header + payload (include pseudo-header IP) |
| Urgent Pointer        | 16 bit     | Offset dei dati urgenti (valido solo se URG=1)                 |
| Options               | 0–320 bit  | Opzioni facoltative (MSS, Window Scale, SACK, Timestamp…)      |
| Padding               | variabile  | Allineamento header a multiplo di 32 bit                       |

**Flag principali:**

| Flag | Significato                                                        |
| ---- | ------------------------------------------------------------------ |
| SYN  | Synchronize — avvio connessione                                    |
| ACK  | Acknowledgment — conferma ricezione                                |
| FIN  | Finish — chiusura connessione                                      |
| RST  | Reset — chiusura forzata / connessione invalida                    |
| PSH  | Push — invia subito i dati al layer applicativo senza bufferizzare |
| URG  | Urgent — dati urgenti, puntati da Urgent Pointer                   |

---

## Porte e Protocolli Correlati

| Porta | Protocollo | Uso                                  |
| ----- | ---------- | ------------------------------------ |
| 20    | FTP-DATA   | Trasferimento dati FTP               |
| 21    | FTP        | Controllo FTP                        |
| 22    | SSH        | Shell sicura, tunneling              |
| 23    | Telnet     | Accesso remoto non cifrato           |
| 25    | SMTP       | Invio email                          |
| 53    | DNS (TCP)  | Query DNS > 512 byte / zone transfer |
| 80    | HTTP       | Web non cifrato                      |
| 110   | POP3       | Ricezione email                      |
| 143   | IMAP       | Gestione email remota                |
| 443   | HTTPS      | Web cifrato (TLS su TCP)             |
| 3389  | RDP        | Desktop remoto Windows               |

---

## Confronto

### TCP vs UDP

| Caratteristica              | TCP                        | UDP                                |
| --------------------------- | -------------------------- | ---------------------------------- |
| Connection-oriented         | Sì (3-way handshake)       | No                                 |
| Affidabilità                | Sì (ACK + ritrasmissione)  | No                                 |
| Ordinamento segmenti        | Sì                         | No                                 |
| Controllo del flusso        | Sì (Window Size)           | No                                 |
| Controllo della congestione | Sì (cwnd)                  | No                                 |
| Overhead header             | 20–60 byte                 | 8 byte                             |
| Latenza                     | Maggiore (handshake + ACK) | Minore                             |
| Casi d'uso                  | HTTP, FTP, SSH, SMTP       | DNS, DHCP, VoIP, streaming, gaming |
| Multicast / Broadcast       | No                         | Sì                                 |

---

## Aspetti di Sicurezza

### Vulnerabilità Note

- **Prevedibilità dell'ISN (Initial Sequence Number):** Nelle implementazioni storiche, l'ISN era prevedibile. Un attaccante poteva forgiare segmenti validi senza sniffare il traffico.
- **Half-open connections:** Lo stato SYN_RECEIVED consuma risorse sul server senza che la connessione sia completata — alla base del SYN Flood.
- **TIME_WAIT assassination:** Un segmento RST con numero di sequenza nell'intervallo accettabile può abbattere connessioni in TIME_WAIT.
- **Session Hijacking:** Se un attaccante riesce a predire o osservare i numeri di sequenza, può iniettare dati in una sessione TCP stabilita.

### Attacchi Comuni

- **SYN Flood (DoS):** Il client invia un gran numero di SYN senza mai completare l'handshake, esaurendo la tabella delle connessioni half-open del server.
- **TCP Session Hijacking:** L'attaccante si inserisce in una sessione TCP attiva iniettando segmenti con numeri di sequenza corretti.
- **RST Attack:** Invio di segmenti RST falsificati per abbattere connessioni legittime (usato anche da alcuni ISP per bloccare contenuti — "TCP Reset Attack").
- **Man-in-the-Middle (MitM):** In assenza di cifratura, un attaccante in posizione di rete intermedia può leggere e modificare i dati dello stream.

### Contromisure

- **SYN Cookies:** Il server non alloca stato per connessioni half-open: codifica le informazioni nel proprio ISN. La connessione viene confermata solo al ricevimento dell'ACK finale. Abilitabile su Linux con `net.ipv4.tcp_syncookies=1`.
- **Randomizzazione dell'ISN:** Le implementazioni moderne (Linux, Windows, BSD) usano ISN casuali crittograficamente sicuri per prevenire spoofing e hijacking.
- **TLS/SSL sopra TCP:** Cifra il payload e autentica i peer, rendendo inutili MitM e session hijacking sul contenuto applicativo.
- **Firewall stateful:** Tracciano lo stato delle connessioni TCP e bloccano segmenti anomali (RST fuori sequenza, SYN su connessioni già stabilite, ecc.).
- **Rate limiting SYN:** Limitare il numero di SYN al secondo per IP sorgente riduce l'efficacia di SYN Flood distribuiti.

---

## Comandi Cisco IOS

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

---

## Troubleshooting

**Sintomi comuni:**

- Connessioni che si aprono lentamente o non si completano → problemi nell'handshake (SYN perso, firewall che blocca, MTU mismatch)
- Throughput basso nonostante banda disponibile → Window Size piccola, alto RTT, ritrasmissioni frequenti
- Connessioni che si chiudono improvvisamente → RST inatteso da firewall/NAT, idle timeout, server che crasha
- Applicazione che "si blocca" → Head-of-line blocking su segmento perso, buffer pieno (Window=0)
- Errore "Connection refused" → Nessun processo in ascolto sulla porta destinazione (RST inviato dal server)
- Errore "Connection timed out" → SYN non raggiunge il server o la risposta non torna (routing, firewall, host irraggiungibile)

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

- MTU mismatch tra segmenti di rete → frammentazione o drop silenzioso (verificare con `ping -M do -s 1472`)
- Firewall asimmetrico → intercetta i SYN ma non i SYN-ACK (o viceversa), connessione si blocca dopo handshake
- NAT timeout aggressivo → connessioni long-lived vengono abbattute silenziosamente dal NAT intermedio
- Buffer overflow applicativo → ricevitore annuncia Window=0, mittente si ferma e aspetta Window Update

---

## Note Esame

### Da sapere a memoria

- TCP è **Layer 4**, connection-oriented, affidabile, unicast
- RFC originale: **793** (1981); consolidato in **RFC 9293** (2022)
- Header TCP minimo: **20 byte** (senza opzioni); massimo: **60 byte**
- **Three-way handshake:** SYN → SYN-ACK → ACK
- **Four-way handshake chiusura:** FIN → ACK → FIN → ACK
- Il campo **Sequence Number** è a **32 bit** → conta i byte, non i segmenti
- **Window Size** è a **16 bit** (max 65535 byte; con Window Scale option fino a ~1 GB)
- Flag principali e loro scopo: SYN, ACK, FIN, RST, PSH, URG
- **TIME_WAIT** dura **2×MSL** (Maximum Segment Lifetime, tipicamente 30–60s → TIME_WAIT = 60–120s)
- **SYN Cookies** → contromisura al SYN Flood, non alloca stato half-open
- TCP usa **IP** come protocollo di rete sottostante (PDU TCP = segmento, PDU IP = pacchetto)

### Trabocchetti frequenti

- **"ACK number = Sequence Number del segmento ricevuto"** → FALSO. ACK number = seq ricevuto **+ lunghezza payload** (cioè il prossimo byte atteso).
- **"FIN chiude la connessione immediatamente"** → FALSO. FIN chiude solo una direzione (half-close). Ci vogliono due FIN per chiudere entrambe le direzioni.
- **"TCP garantisce la consegna"** → PARZIALMENTE VERO in senso tecnico. TCP garantisce la consegna best-effort con ritrasmissione, ma se il link è irraggiungibile o il timeout scade, la connessione viene abbattuta con RST o errore.
- **"RST = connessione chiusa normalmente"** → FALSO. RST è una chiusura anomala/forzata. La chiusura normale usa FIN.
- **"La porta sorgente è fissa"** → FALSO. La porta sorgente del client è tipicamente **effimera** (range 49152–65535 su Linux/Windows moderni).
- **"Window Size = dimensione del pacchetto"** → FALSO. Window Size è la quantità di dati non ancora confermati che il ricevitore può accettare nel proprio buffer.
- **"TCP e UDP usano entrambi porte"** → VERO, ma le porte TCP e UDP sono **spazi indipendenti**: la porta TCP 53 e la porta UDP 53 coesistono senza conflitti.

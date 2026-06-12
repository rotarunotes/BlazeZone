Data: 2026-06-08
[Web_And_Communication](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Web_And_Communication
___
# Index
- [[#HyperText Transfer Protocol Secure (HTTPS)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Crittografia Ibrida]]
	- [[#Infrastruttura A Chiave Pubblica]]
- [[#Flusso Operativo]]
- [[#Casi D'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
	- [[#Header]]
	- [[#Body]]
	- [[#Flags]]
- [[#Porte E Protocolli Correlati]]
- [[#Confronto]]
- [[#Aspetti Di Sicurezza]]
	- [[#Vulnerabilità Note]]
	- [[#Attacchi Comuni]]
	- [[#Contromisure]]
- [[#Comandi Cisco IOS]]
- [[#Troubleshooting]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _HyperText Transfer Protocol Secure (HTTPS)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **443/TCP** |
| **Scopo** | Trasferimento sicuro di risorse ipertestuali tramite cifratura, autenticazione e integrità dei dati |
| **RFC / Standard** | RFC 2818 (HTTPS su TLS) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) con handshake crittografico TLS |
| **Affidabilità** | **Affidabile** (garantita da TCP e verificata dall'handshake TLS) |
| **PDU (Unità Dati)** | **Record TLS** |
| **Meccanismo di Controllo** | Scambio di certificati digitali e negoziazione di chiavi simmetriche temporanee |

___
# Versioni & Evoluzione

Il protocollo HTTPS non ha versioni proprie indipendenti, ma evolve in base alle versioni del protocollo di sicurezza sottostante: SSL, *Secure Sockets Layer*, e il più moderno TLS, *Transport Layer Security*.

| Protocollo | Anno | Stato e Note |
| :--- | :--- | :--- |
| **SSL 2.0** | 1995 | Rilasciato da Netscape. Deprecato rapidamente a causa di gravi vulnerabilità di sicurezza. |
| **SSL 3.0** | 1996 | Riscritto completamente. Deprecato nel 2015 a causa dell'attacco POODLE. |
| **TLS 1.0** (RFC 2246) | 1999 | Sostituto di SSL 3.0. Deprecato nel 2021 per debolezza degli algoritmi di cifratura. |
| **TLS 1.1** (RFC 4346) | 2006 | Aggiunto supporto per la protezione contro gli attacchi di tipo block cipher. Deprecato nel 2021. |
| **TLS 1.2** (RFC 5246) | 2008 | Versione ampiamente utilizzata. Introduce algoritmi crittografici avanzati come SHA-256 e AES. |
| **TLS 1.3** (RFC 8446) | 2018 | Versione corrente. Velocizza l'handshake (1 RTT in meno), rimuove algoritmi obsoleti e rende obbligatorio PFS, *Perfect Forward Secrecy*. |

___
# Come Funziona

HTTPS, *HyperText Transfer Protocol Secure*, non è un protocollo applicativo a sé stante, ma rappresenta l'applicazione del protocollo HTTP, *HyperText Transfer Protocol*, al di sopra di un tunnel crittografato creato da SSL o TLS.

Il protocollo garantisce tre pilastri fondamentali:
1. **Riservatezza** (cifratura): I dati scambiati tra client e server sono protetti contro l'intercettazione da parte di terzi.
2. **Integrità**: I dati non possono essere modificati o alterati durante il transito senza che le parti se ne accorgano.
3. **Autenticazione**: Il client ha la certezza di comunicare con il server reale e non con un server contraffatto.

## Crittografia Ibrida
HTTPS utilizza un sistema di **crittografia ibrida** che combina i vantaggi di due tecnologie:
- **Crittografia Asimmetrica** (a chiave pubblica): Utilizzata esclusivamente durante l'handshake iniziale per scambiare in modo sicuro una chiave segreta comune. Richiede una chiave pubblica (esposta nel certificato) e una chiave privata (segreta sul server). È computazionalmente pesante.
- **Crittografia Simmetrica** (a chiave condivisa): Una volta stabilita la chiave di sessione comune, i dati reali della sessione web vengono cifrati con questa chiave simmetrica. È estremamente veloce ed efficiente.

## Infrastruttura A Chiave Pubblica
Per garantire l'autenticità del server, si utilizza la PKI, *Public Key Infrastructure*.
- Il server ottiene un **certificato digitale** emesso da una CA, *Certificate Authority*, di fiducia.
- Il certificato contiene la chiave pubblica del server e la firma digitale della CA.
- Il browser del client contiene una lista di CA fidate pre-installate e verifica la firma del certificato. Se la firma è valida, il client si fida della chiave pubblica del server.

___
# Flusso Operativo

L'handshake TLS (basato su TLS 1.2) si inserisce subito dopo l'handshake TCP porta 443:

```
Client (Browser)                                         Server (Web Server)
   |                                                              |
   |==================== 1. Handshake TCP =======================>|
   |                                                              |
   |-------------------- 2. Client Hello ------------------------>|
   |     [Invia suite crittografiche supportate e Random C]       |
   |                                                              |
   |<------------------- 3. Server Hello & Certificate -----------|
   |     [Seleziona suite, invia Random S e Certificato con KPub] |
   |                                                              |
   |--------- 4. Client Key Exchange (Pre-Master Secret) -------->|
   |                                                              |
   |==================== 5. Calcolo Chiave Simmetrica ============|
   |     [Entrambi calcolano la chiave usando i Random e il PMS]  |
   |                                                              |
   |-------------------- 6. Change Cipher Spec & Finished ------->|
   |<------------------- 7. Change Cipher Spec & Finished --------|
   |                                                              |
   |<============ 8. Scambio Dati Cifrati (HTTP su TLS) =========>|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **TCP Connect** | 1 | Apertura della connessione TCP sulla porta 443 | Three-way handshake standard |
| **Client Hello** | 2 | Il client propone le versioni TLS supportate, le suite crittografiche e un valore casuale (Random Client) | Avvio dell'handshake TLS |
| **Server Hello** | 3 | Il server sceglie la suite crittografica e invia il suo valore casuale (Random Server) insieme al proprio Certificato Digitale | Invio della chiave pubblica del server |
| **Verifica** | 4 | Il client convalida il certificato digitale tramite la propria lista di CA fidate | Fase critica di autenticazione |
| **Key Exchange** | 5 | Il client genera un *Pre-Master Secret*, lo cifra con la chiave pubblica del server e lo invia | Nessun intercettatore può leggerlo senza la chiave privata del server |
| **Symmetric Key** | 6 | Entrambe le parti calcolano la medesima **chiave di sessione** a partire dal Pre-Master Secret e dai valori casuali scambiati | Da questo momento la cifratura è simmetrica |
| **Finished** | 7 | Client e server si scambiano messaggi di verifica cifrati per confermare che l'handshake è riuscito | Fine dell'handshake TLS |

___
# Casi D'Uso Reali

- **e-Commerce e Pagamenti online**: Protezione di numeri di carte di credito e dati finanziari.
- **Home Banking**: Accesso sicuro ai portali bancari.
- **Social Network e Portali Web**: Autenticazione degli utenti e protezione delle credenziali di login contro il furto di identità.
- **API di Servizio**: Comunicazione sicura tra server backend e app mobili che trattano dati personali.

___
# Limitazioni Tecniche

- **Latenza iniziale (RTT)**: L'handshake TLS richiede RTT aggiuntivi prima che i dati applicativi possano essere inviati. Risolto parzialmente da TLS 1.3 con la modalità 1-RTT e 0-RTT.
- **Consumo di risorse CPU**: La cifratura asimmetrica iniziale richiede una capacità di elaborazione superiore rispetto a HTTP semplice, sebbene l'hardware moderno riduca al minimo questo impatto.
- **Dipendenza da terze parti (CA)**: Se una CA viene compromessa o revoca un certificato per errore, il sito web risulta inaccessibile agli utenti.

___
# PDU & Incapsulamento

- **Nome PDU**: Record TLS
- **Incapsulato in**: Segmento TCP, a sua volta in pacchetto IP
- **Incapsula**: Messaggio HTTP (ora cifrato)

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header TLS Record ] PDU: Record TLS (contiene HTTP cifrato)
```

___
# Struttura Del Pacchetto

Il protocollo TLS opera incapsulando i dati applicativi in blocchi chiamati **Record TLS**.
## Header
L'header di un record TLS ha una dimensione fissa di **5 byte**:

| Campo | Dimensione | Descrizione |
| :--- | :--- | :--- |
| **Content Type** | 1 byte | Identifica il tipo di record: `20` = Change Cipher Spec, `21` = Alert, `22` = Handshake, `23` = Application Data (dati HTTP) |
| **Legacy Version** | 2 byte | Specifica la versione di TLS utilizzata (es. `0x0303` per TLS 1.2) |
| **Length** | 2 byte | Indica la lunghezza in byte del payload cifrato successivo (dimensione massima 16 KB) |

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  Content Type |        Legacy Version         |      Length   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     Length    |        Crypted Payload (HTML/Data)...         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
Il body contiene il payload cifrato che, nel caso di HTTPS, corrisponde al testo ASCII del messaggio HTTP (Request Line, Header e corpo).

## Flags
Nel protocollo TLS non ci sono flag di controllo come in TCP, ma la gestione avviene tramite il campo **Content Type** dell'header e i messaggi del sottoprocollo **Handshake** (es. Client Hello, Server Hello).

___
# Porte E Protocolli Correlati

| Porta       |   Livello OSI    | Protocollo | Uso                                                                   |
| :---------- | :--------------: | :--------- | :-------------------------------------------------------------------- |
| **443/TCP** | 7 (Applicazione) | HTTPS      | Canale standard sicuro per il traffico web                            |
| **80/TCP**  | 7 (Applicazione) | HTTP       | Canale standard in chiaro, spesso configurato per reindirizzare a 443 |

___
# Confronto

**HTTPS vs HTTP**

| Caratteristica | HTTPS | HTTP |
| :--- | :--- | :--- |
| **Sicurezza** | Cifrato (riservatezza, integrità, autenticazione) | In chiaro (vulnerabile a intercettazioni) |
| **Porta standard** | 443/TCP | 80/TCP |
| **Certificati** | Obbligatorio certificato X.509 emesso da CA | Non richiesto |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Certificati scaduti o non validi**: Consentono a chiunque di intercettare la sessione se l'utente ignora l'avviso del browser.
- **Protocolli deprecati**: L'uso di SSL 3.0 o TLS 1.0/1.1 espone a attacchi crittografici a causa di debolezze intrinseche degli algoritmi obsoleti.

## Attacchi Comuni
- *Man-in-the-Middle* **(MITM)**: Un attaccante intercetta la connessione e presenta un certificato falso. Se il client non valida correttamente la CA, la cifratura viene decodificata dall'attaccante.
- **SSL Stripping**: L'attaccante intercetta la richiesta iniziale HTTP (in chiaro) e impedisce il reindirizzamento sicuro a HTTPS, mantenendo la sessione in chiaro verso il client mentre comunica in HTTPS con il server reale.
- **Attacchi di downgrade**: Forzano l'uso di suite crittografiche deboli o versioni precedenti di TLS per decifrare le chiavi.

## Contromisure
- **Disabilitare versioni vecchie**: Disattivare il supporto a SSL 2.0/3.0 e TLS 1.0/1.1 sui web server.
- **HSTS**: Abilitare l'header HSTS, *HTTP Strict Transport Security*, per istruire i browser a connettersi esclusivamente tramite HTTPS.
- **Forward Secrecy**: Utilizzare algoritmi di scambio chiavi basati su curve ellittiche temporanee (ECDHE) che garantiscono che la compromissione della chiave privata del server non permetta di decifrare le sessioni registrate in passato.

___
# Comandi Cisco IOS

Configurazione di un router Cisco per abilitare l'interfaccia di gestione web protetta via HTTPS:

```cisco
! Generare le chiavi crittografiche RSA sul router
crypto key generate rsa

! Abilitare il server HTTPS protetto
ip http secure-server

! Disabilitare il server HTTP non sicuro
no ip http server

! Configurare il metodo di autenticazione per l'accesso web
ip http authentication local
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Avviso "Connessione non sicura" nel browser** | Certificato scaduto, non firmato da CA valida, o discrepanza nel nome di dominio (CN mismatch) | Il browser non si fida della catena di firma o il certificato è associato a un host differente. |
| **Errore SSL/TLS handshake failed** | Mismatch delle suite crittografiche supportate o versioni incompatibili di TLS | Client e server non riescono a concordare un algoritmo comune per la cifratura. |
| **Contenuti misti (Mixed Content)** | Il codice HTML del sito sicuro (HTTPS) richiede risorse (es. immagini, JS) tramite collegamenti HTTP | Il browser blocca le risorse non sicure o mostra un avviso di sicurezza. |

**Comandi di verifica**:

```bash
# Mostrare l'intera catena di certificati e l'handshake TLS
openssl s_client -connect www.example.com:443 -showcerts

# Testare la connessione forzando una specifica versione di TLS
openssl s_client -connect www.example.com:443 -tls1_3

# Visualizzare gli header di un sito HTTPS ignorando gli errori di certificato
curl -Iv -k https://www.example.com
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | HTTP incapsulato in un tunnel crittografato SSL/TLS a livello di trasporto. |
| **Porta standard** | **443/TCP** |
| **Crittografia ibrida** | Asimmetrica per scambiare la chiave segreta (handshake); simmetrica per la trasmissione dei dati. |
| **Certificato X.509** | Contiene la chiave pubblica del server ed è firmato digitalmente da una CA. |
| **PFS** | *Perfect Forward Secrecy* — garantito da algoritmi come DHE/ECDHE, protegge le sessioni passate. |

## Trabocchetti Frequenti

| Concetto Errato                                                | Realtà Tecnica                                                                                                                                                                      |
| :------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **HTTPS è un protocollo di livello trasporto**                 | **FALSO**. HTTPS è a livello **Applicazione** (OSI 7). È il TLS sottostante che si inserisce tra il trasporto e l'applicazione.                                                     |
| **I dati sono crittografati con la chiave privata del server** | **FALSO**. I dati sono cifrati con la **chiave simmetrica** concordata. La chiave privata del server serve solo a decifrare il Pre-Master Secret inviato dal client nell'handshake. |
| **HTTPS protegge il database del server da SQL injection**     | **FALSO**. HTTPS protegge solo i dati **in transito** sulla rete. Non impedisce ad input malevoli di raggiungere e compromettere il database.                                       |

___
# Quick Reference Card

```
PORTA:
  443/TCP → Porta standard HTTPS

HANDSHAKE TLS 1.2:
  1. Client Hello (Random C, ciphers)
  2. Server Hello (Random S, cipher scelto) + Certificato (KPub)
  3. Client verifica certificato
  4. Client Key Exchange (Pre-Master Secret cifrato con KPub)
  5. Calcolo chiave simmetrica comune
  6. Change Cipher Spec & Finished da entrambe le parti
  7. Dati cifrati

SICUREZZA CHIAVE:
  - Cifratura asimmetrica per handshake
  - Cifratura simmetrica per dati
  - TLS 1.3 riduce l'handshake a 1 RTT ed elimina suite insicure

CISCO IOS:
  crypto key generate rsa  → Genera chiavi RSA
  ip http secure-server    → Attiva server HTTPS (443)
  no ip http server        → Disattiva server HTTP (80)

VERIFICA:
  openssl s_client -connect <IP>:443 -showcerts  → Verifica certificato e handshake
```
___


Data: 2026-06-08
[Web_And_Communication](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Web_And_Communication
___
# Index
- [[#HyperText Transfer Protocol (HTTP)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Cos'è Un Web Server]]
	- [[#Comunicazione Client-Server]]
	- [[#Gestione Dello Stato]]
	- [[#Proxy HTTP]]
	- [[#Connessione Persistente Vs Non Persistente]]
- [[#Flusso Operativo]]
	- [[#Connessione Non Persistente]]
	- [[#Connessione Persistente]]
- [[#Casi D'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
	- [[#Header]]
		- [[#Struttura Della Richiesta]]
		- [[#Struttura Della Risposta]]
	- [[#Body]]
	- [[#Flags]]
		- [[#Metodi Di Richiesta]]
		- [[#Codici Di Stato (Status Code)]]
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
# _HyperText Transfer Protocol (HTTP)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **80/TCP** |
| **Scopo** | Trasferimento di risorse ipertestuali e multimediali su Internet |
| **RFC / Standard** | RFC 1945 (HTTP/1.0), RFC 2616 (HTTP/1.1), RFC 7540 (HTTP/2), RFC 9114 (HTTP/3) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) per HTTP/1.x e HTTP/2, **Connectionless** (UDP via QUIC) per HTTP/3 |
| **Affidabilità** | **Affidabile** (garantita dal protocollo di trasporto sottostante TCP o QUIC) |
| **PDU (Unità Dati)** | **Messaggio HTTP** |
| **Meccanismo di Controllo** | Richiesta/risposta stateless basata su metodi e codici di stato |
___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
| :--- | :--- | :--- |
| **HTTP/0.9** | 1991 | Versione primordiale. Supportava solo il metodo GET e rispondeva unicamente in formato HTML grezzo senza intestazioni (header). |
| **HTTP/1.0** (RFC 1945) | 1996 | Aggiunta delle intestazioni HTTP, introduzione di codici di stato e supporto a contenuti multimediali. Connessioni non persistenti. |
| **HTTP/1.1** (RFC 2616) | 1997 | Introduzione delle connessioni persistenti (keep-alive di default), pipelining delle richieste, header Host (per virtual hosting) e chunked transfer encoding. |
| **HTTP/2** (RFC 7540) | 2015 | Formato binario (invece di testo ASCII), multiplexing (richieste parallele su singola connessione TCP), compressione HPACK degli header, Server Push. |
| **HTTP/3** (RFC 9114) | 2022 | Utilizza il protocollo di trasporto QUIC, *Quick UDP Internet Connections*, su UDP anziché TCP. Elimina l'head-of-line blocking a livello di trasporto e velocizza l'handshake. |
___
# Come Funziona

Il protocollo HTTP, *HyperText Transfer Protocol*, è un sistema basato sullo scambio di messaggi in modalità richiesta/risposta. Un client invia una richiesta a un server, il quale elabora l'informazione e restituisce una risposta.

## Cos'è Un Web Server
Un **web server** è un servizio di rete progettato per accettare richieste HTTP e rispondere con risorse digitali, pagine web o messaggi di errore.

I suoi **scopi principali** sono:
1. **Rendere accessibili le risorse**: come file HTML, *HyperText Markup Language*, documenti, immagini e altri asset.
2. **Gestire applicazioni web dinamiche**: elaborando richieste che richiedono computazione lato server.
3. **Garantire comunicazioni affidabili**: tra i nodi della rete.

Dal punto di vista **hardware**, può essere ospitato su dispositivi semplici come un router o su complesse infrastrutture composte da centinaia di server per siti ad **alto** traffico.

Esistono diverse implementazioni software di web server, con architetture differenti:
- **Apache**: basato su **processi** (un thread o processo per ogni richiesta). Molto efficace per contenuti dinamici e linguaggi di scripting.
- **Nginx**: basato su **eventi** (un singolo processo asincrono gestisce molteplici connessioni). Ottimizzato per la distribuzione rapida di contenuti statici.
## Comunicazione Client-Server
Il funzionamento di HTTP si basa sul modello **client-server**:
- Il **browser (client)** genera una richiesta HTTP.
- Il **web server** riceve la richiesta, la interpreta e risponde con un messaggio di risposta HTTP.

Le **risorse** richieste dal client possono essere di due tipi:
- **Statiche**: file pre-esistenti archiviati sul server (es. immagini, fogli di stile CSS).
- **Dinamiche**: generate in tempo reale da script (es. PHP) che comunicano con basi di dati.
## Gestione Dello Stato
Poiché HTTP è un protocollo **stateless** (il server non ricorda le interazioni passate e ogni richiesta è indipendente), si utilizzano i cookie per mantenere uno stato applicativo tra le sessioni:
- Le informazioni di stato vengono inserite durante lo scambio di messaggi tramite l'header `Set-Cookie` inviato dal server.
- Il client memorizza queste informazioni a lungo termine e le reinvia in ogni richiesta successiva tramite l'header `Cookie`.
- Permette di identificare l'utente, mantenere carrelli della spesa attivi o memorizzare le sue preferenze.
## Proxy HTTP
Un **proxy** è un intermediario che risponde alle richieste del client senza necessariamente coinvolgere il server d'origine.
1. **Connettività**: una rete locale può accedere a internet tramite un unico gateway.
2. **Privacy**: nasconde l'indirizzo IP, *Internet Protocol*, reale del client.
3. **Caching**: se l'oggetto è presente in cache, il proxy risponde immediatamente senza contattare il server d'origine.
4. **Monitoraggio**: permette di tracciare e loggare le operazioni sulle richieste.
5. **Amministrazione**: si applicano regole per determinare quali richieste inoltrare o rifiutare.
___
# Flusso Operativo
Esistono due modalità principali per la gestione delle connessioni TCP, *Transmission Control Protocol*, sottostanti a HTTP:

## Connessione Non Persistente
Il client deve ripetere l'apertura della connessione per ogni singolo oggetto che scopre analizzando la pagina.
```
Client (Browser)                                         Server (Apache/Nginx)
   |                                                              |
   |---------- 1. Handshake TCP (Porta 80) ---------------------->|
   |<--------- 2. Connessione Accettata --------------------------|
   |                                                              |
   |---------- 3. Richiesta HTTP (GET /index.html) -------------->|
   |                                                              |
   |<--------- 4. Risposta HTTP (200 OK + HTML Body) -------------|
   |                                                              |
   |---------- 5. Chiusura Connessione TCP (se non persistente) ->|
```

| Fase             | #   | Azione                                                            | Note                                                          |
| :--------------- | :-- | :---------------------------------------------------------------- | :------------------------------------------------------------ |
| **Connessione**  | 1   | Il client apre una connessione TCP verso il server sulla porta 80 | Avviene il three-way handshake TCP                            |
| **Richiesta**    | 2   | Il client invia il messaggio di richiesta HTTP                    | Contiene Request Line, Header e Blank Line                    |
| **Elaborazione** | 3   | Il server interpreta la richiesta e localizza/genera la risorsa   | Può leggere un file statico o chiamare uno script dinamico    |
| **Risposta**     | 4   | Il server invia la risposta HTTP                                  | Contiene Status Line (es. 200 OK), Header e il corpo del file |
| **Chiusura**     | 5   | La connessione TCP viene chiusa o mantenuta attiva                | In HTTP/1.1 e successivi rimane aperta (persistenza)          |
## Connessione Persistente
La connessione viene chiusa solo dopo il download di tutti gli oggetti necessari o dopo un timeout di inattività.
```
Client (Browser)                                         Server (Apache/Nginx)
   |                                                              |
   |---------- 1. Handshake TCP (Porta 80) ---------------------->|
   |<--------- 2. Connessione Accettata --------------------------|
   |                                                              |
   |---------- 3. Richiesta HTTP (GET /index.html) -------------->|
   |                                                              |
   |<--------- 4. Risposta HTTP (200 OK + HTML Body) -------------|
   |                                                              |
```

| Fase             | #   | Azione                                                            | Note                                                          |
| :--------------- | :-- | :---------------------------------------------------------------- | :------------------------------------------------------------ |
| **Connessione**  | 1   | Il client apre una connessione TCP verso il server sulla porta 80 | Avviene il three-way handshake TCP                            |
| **Richiesta**    | 2   | Il client invia il messaggio di richiesta HTTP                    | Contiene Request Line, Header e Blank Line                    |
| **Elaborazione** | 3   | Il server interpreta la richiesta e localizza/genera la risorsa   | Può leggere un file statico o chiamare uno script dinamico    |
| **Risposta**     | 4   | Il server invia la risposta HTTP                                  | Contiene Status Line (es. 200 OK), Header e il corpo del file |

___
# Casi D'Uso Reali

- **Navigazione Web**: Caricamento e rendering di pagine HTML, fogli di stile CSS, immagini e script JavaScript nei browser.
- **REST API**: Trasferimento di dati strutturati (solitamente JSON o XML) tra applicazioni client-side e backend in architetture moderne.
- **Download Di File**: Trasferimento di file binari, documenti o aggiornamenti software.
- **Streaming Web**: Streaming audio/video non in tempo reale basato su blocchi HTTP (es. HLS o DASH).
___
# Limitazioni Tecniche

- **Stateless**: Non mantiene lo stato nativamente, costringendo all'uso di cookie o token che aumentano l'overhead e complicano la sicurezza delle sessioni.
- **Head-of-Line Blocking**: In HTTP/1.1, se una risorsa in coda è lenta a generarsi sul server, blocca tutte le risposte successive sulla stessa connessione TCP.
- **Overhead Degli Header**: In HTTP/1.x, gli header testuali non sono compressi e vengono ripetuti ad ogni richiesta, sprecando banda preziosa.
- **Latenza Di Avvio**: La necessità di stabilire connessioni TCP e negoziare TLS per ogni server aumenta i tempi di RTT, *Round Trip Time*.
___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio HTTP (Richiesta / Risposta)
- **Incapsulato in**: Segmento TCP (porta 80), a sua volta in pacchetto IP (Layer 3)
- **Incapsula**: Payload applicativo (HTML, JSON, immagini, ecc.)

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header HTTP ] PDU: Messaggio HTTP
```

___
# Struttura Del Pacchetto

## Header
I messaggi HTTP sono codificati in formato ASCII, *American Standard Code for Information Interchange*, e si compongono di:

### Struttura Della Richiesta
- **Request Line**: Contiene il metodo (GET, POST, ecc.), l'URI, *Uniform Resource Identifier*, della risorsa e la versione del protocollo (es. `GET /index.html HTTP/1.1`).
- **Header Lines**: Coppie nome-valore con metadati sulla richiesta (es. `Host: www.example.com`, `User-Agent: Mozilla/5.0`, `Cookie: session_id=123`).
- **Blank Line**: Una riga vuota obbligatoria che separa gli header dal corpo del messaggio.

```
+------------------------------------------------------------------------+
|  Request line                                                          |
|  +------------------+----+------------------+----+---------+----+---+  |
|  |      method      | sp |        URL       | sp | Version | cr | lf|  |
|  +------------------+----+------------------+----+---------+----+---+  |
+-----------------------------------------------------------------*------+
|  Header lines                                                          |
|  +-----------------------------+----+---------------+----+----+        |
|  |      header field name:     | sp |     value     | cr | lf |        |
|  +-----------------------------+----+---------------+----+----+        |
|  |                             ...                            |        |
|  +-----------------------------+----+---------------+----+----+        |
|  |      header field name:     | sp |     value     | cr | lf |        |
|  +-----------------------------+----+---------------+----+----+        |
+------------------------------------------------------------------------+
|  Blank line                                                            |
|  +----+----+                                                           |
|  | cr | lf |                                                           |
|  +----+----+                                                           |
+------------------------------------------------------------------------+
|  Entity body                                                           |
|  +------------------------------------------------------------------+  |
|  |                                                                  |  |
|  |                               ...                                |  |
|  |                                                                  |  |
|  +------------------------------------------------------------------+  |
+------------------------------------------------------------------------+
```
### Struttura Della Risposta
- **Status Line**: Contiene la versione del protocollo, il codice di stato numerico e una frase esplicativa (es. `HTTP/1.1 200 OK`).
- **Header Lines**: Informazioni aggiuntive inviate dal server (es. `Server: Apache`, `Content-Type: text/html`, `Set-Cookie: session_id=123`).
- **Blank Line**: Riga vuota obbligatoria di separazione.


```
+-----------------------------------------------------------------------+
|  Status line                                                          |
|  +---------+----+-------------+----+---------------------+----+----+  |
|  | Version | sp | Status code | sp |    Phrase (Reason)  | cr | lf |  |
|  +---------+----+-------------+----+---------------------+----+----+  |
+-----------------------------------------------------------------------+
|  Header lines                                                         |
|  +-----------------------------+----+---------------+----+----+       |
|  |      header field name:     | sp |     value     | cr | lf |       |
|  +-----------------------------+----+---------------+----+----+       |
|  |                             ...                            |       |
|  +-----------------------------+----+---------------+----+----+       |
|  |      header field name:     | sp |     value     | cr | lf |       |
|  +-----------------------------+----+---------------+----+----+       |
+-----------------------------------------------------------------------+
|  Blank line                                                           |
|  +----+----+                                                          |
|  | cr | lf |                                                          |
|  +----+----+                                                          |
+-----------------------------------------------------------------------+
|  Entity body                                                          |
|  +-----------------------------------------------------------------+  |
|  |                                                                 |  |
|  |                               ...                               |  |
|  |                                                                 |  |
|  +-----------------------------------------------------------------+  |
+-----------------------------------------------------------------------+
```

## Body
- **Richiesta**: Presente solo per alcuni metodi (come il POST), contiene i dati inviati dal client al server (es. dati di un modulo compilato).
- **Risposta**: Contiene il corpo della risorsa richiesta (il file HTML, l'immagine o i dati JSON).
## Flags
Nel protocollo HTTP non esistono flag binari come in TCP. Il controllo del comportamento della sessione avviene tramite i **Metodi** e i **Codici Di Stato**:

### Metodi Di Richiesta
| Metodo HTTP | Descrizione                                                          | Dati del Client           | Corpo del Messaggio     | Caso d'Uso Tipico                                       |
| ----------- | -------------------------------------------------------------------- | ------------------------- | ----------------------- | ------------------------------------------------------- |
| `GET`       | Richiede il download di un documento o risorsa dal server.           | Nell'URL (Query String)   | **Assente**             | Navigare su una pagina web, cercare prodotti.           |
| `POST`      | Invia informazioni al server per creare o aggiornare una risorsa.    | Nel corpo della richiesta | **Presente**            | Inviare un form di registrazione, pubblicare un post.   |
| `HEAD`      | Richiede solo gli header di risposta, escludendo il corpo.           | Nessuno / Nell'URL        | **Assente**             | Verificare se un link è valido o se un file è cambiato. |
| `PUT`       | Carica una nuova risorsa o sostituisce interamente quella esistente. | Nel corpo della richiesta | **Presente**            | Aggiornare interamente i dati di un profilo utente.     |
| `DELETE`    | Richiede la rimozione permanente di una risorsa specifica.           | Nell'URL (ID risorsa)     | **Assente** (di solito) | Eliminare un account, cancellare una foto dal server.   |
### Codici Di Stato (Status Code)

| Codice di Stato                  | Significato                  | Classe di Errore / Stato | Descrizione Dettagliata                                                                                                       |
| -------------------------------- | ---------------------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| `200 OK`                         | Successo                     | **2xx** (Success)        | La richiesta ha avuto successo e il server restituisce la risorsa.                                                            |
| `301 Moved Permanently`          | Reindirizzamento Permanente  | **3xx** (Redirection)    | La risorsa è stata spostata in modo permanente a un nuovo URL. I client futuri devono usare il nuovo indirizzo.               |
| `304 Not Modified`               | Non Modificato               | **3xx** (Redirection)    | La risorsa non è cambiata dall'ultima richiesta. Il client può usare la copia locale in cache, risparmiando banda.            |
| `400 Bad Request`                | Richiesta Errata             | **4xx** (Client Error)   | La richiesta non è stata compresa dal server per via di una sintassi errata o di dati malformati.                             |
| `401 Unauthorized`               | Non Autenticato              | **4xx** (Client Error)   | La richiesta richiede l'autenticazione del client (mancano o sono errate le credenziali/token).                               |
| `403 Forbidden`                  | Vietato                      | **4xx** (Client Error)   | Il server ha compreso la richiesta ma si rifiuta di autorizzarla (il client non ha i permessi necessari, es. amministratore). |
| `404 Not Found`                  | Non Trovato                  | **4xx** (Client Error)   | La risorsa richiesta non è stata trovata sul server (URL errato o risorsa eliminata).                                         |
| `500 Internal Server Error`      | Errore Interno del Server    | **5xx** (Server Error)   | Il server ha riscontrato una condizione imprevista o un errore generico nel codice lato backend.                              |
| `502 Bad Gateway`                | Gateway Errato               | **5xx** (Server Error)   | Il server (es. un proxy o un reverse proxy come Nginx) ha ricevuto una risposta non valida dal server a monte.                |
| `505 HTTP Version Not Supported` | Versione HTTP Non Supportata | **5xx** (Server Error)   | La versione del protocollo HTTP utilizzata nella richiesta non è supportata dal server.                                       |
___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **80/TCP** | 7 | HTTP | Connessioni web standard non cifrate (in chiaro) |
| **443/TCP** | 7 | HTTPS | Connessioni web sicure cifrate tramite TLS/SSL |
| **443/UDP** | 7 | HTTP/3 | HTTP/3 utilizza UDP via QUIC per la trasmissione |

___
# Confronto

**HTTP vs HTTPS**

| Caratteristica | HTTP | HTTPS |
| :--- | :--- | :--- |
| **Sicurezza** | Dati in chiaro, vulnerabile a sniffing | Dati cifrati tramite SSL/TLS, garantisce integrità e riservatezza |
| **Porta standard** | 80/TCP | 443/TCP |
| **Certificati** | Non richiesti | Richiede un certificato SSL/TLS firmato da una CA, *Certificate Authority* |
| **Overhead** | Assente | Minimo, dovuto all'handshake crittografico iniziale |

**HTTP/1.1 vs HTTP/2 vs HTTP/3**

| Caratteristica | HTTP/1.1 | HTTP/2 | HTTP/3 |
| :--- | :--- | :--- | :--- |
| **Trasporto** | TCP | TCP | UDP (via QUIC) |
| **Formato** | Testo ASCII | Binario | Binario |
| **Multiplexing** | No (solo pipelining) | Sì (su singola connessione TCP) | Sì (su UDP, eliminando HOLB di trasporto) |
| **Compressione** | Nessuna | HPACK (header) | QPACK (header) |
| **Sicurezza** | Opzionale (HTTPS) | Opzionale, ma di fatto obbligatoria | Obbligatoria (integrata in QUIC via TLS 1.3) |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Trasmissione in chiaro**: HTTP standard non cifra i dati, consentendo ad attaccanti sulla stessa rete di leggere credenziali, cookie di sessione e informazioni personali.
- **Session Hijacking**: Il furto dei cookie di sessione permette a terzi di sostituirsi all'utente autorizzato.

## Attacchi Comuni
- **Man-in-the-Middle (MITM)**: Intercettazione ed eventuale alterazione dei dati in transito tra client e server.
- **Sniffing Di Sessione**: Cattura dei cookie trasmessi su connessioni non protette.
- **Cross-Site Scripting (XSS)**: Iniezione di script malevoli nelle pagine web per rubare cookie o credenziali.

## Contromisure
- **Uso di HTTPS**: Cifrare tutto il traffico web. Abilitare HSTS, *HTTP Strict Transport Security*, per impedire connessioni HTTP non sicure.
- **Secure Cookie Flags**: Configurare i cookie con i flag `Secure` (trasmissione solo su HTTPS), `HttpOnly` (non accessibile da script per mitigare XSS) e `SameSite` (per mitigare CSRF, *Cross-Site Request Forgery*).
- **Validazione degli Input**: Sanificare i parametri passati nelle richieste GET e POST.

___
# Comandi Cisco IOS

Uno switch o router Cisco può essere configurato per abilitare l'interfaccia di gestione web tramite HTTP o HTTPS:

```cisco
! Abilitare il server HTTP in chiaro (porta 80)
ip http server

! Abilitare il server HTTPS sicuro (porta 443)
ip http secure-server

! Limitare l'accesso al server HTTP tramite una ACL, Access Control List
ip http access-class 10

! Configurare il metodo di autenticazione per l'accesso web
ip http authentication local
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Errore 404 Not Found** | URL errato, file rimosso o permessi errati | Il server non trova la risorsa nel percorso indicato. |
| **Errore 403 Forbidden** | Permessi del file non corretti o blocco IP da parte del server | Richiesta valida, ma il server nega l'accesso. |
| **Errore 500 Internal Error** | Errore di sintassi in file di configurazione (es. `.htaccess`) o script | Il server ha riscontrato una condizione imprevista. |
| **Errore 502 Bad Gateway** | Il proxy inverso (es. Nginx) non riesce a raggiungere il backend | Timeout o arresto del server applicativo a monte. |
| **Elevata latenza di caricamento** | Mancata persistenza delle connessioni o HOLB, *Head-of-Line Blocking* | Apertura continua di connessioni TCP con relativo overhead. |

**Comandi di verifica**:

```bash
# Richiedere solo le intestazioni (header) di risposta per una risorsa
curl -I http://www.example.com

# Visualizzare dettagli verbali (richiesta e risposta complete)
curl -v http://www.example.com

# Inviare una richiesta POST con parametri specifici
curl -d "username=admin&password=secret" -X POST http://www.example.com/login

# Testare le prestazioni del server (Apache Benchmark)
ab -n 500 -c 10 http://www.example.com/

# Verificare la raggiungibilità della porta 80 o 443
nc -zv www.example.com 80
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Livello OSI** | Layer 7 (Applicazione) |
| **Porte standard** | 80/TCP (HTTP), 443/TCP (HTTPS), 443/UDP (HTTP/3) |
| **Stato del protocollo** | Nativamente stateless; si affida ai cookie per mantenere lo stato. |
| **Connessioni persistenti** | Keep-alive introdotto in HTTP/1.1 per riutilizzare la medesima connessione TCP. |
| **Metodo HEAD** | Identico a GET ma non scarica il corpo della risposta. |
| **HTTP/3 e UDP** | Utilizza il protocollo di trasporto QUIC basato su UDP porta 443. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **HTTP/3 usa TCP** | **FALSO**. HTTP/3 è basato su QUIC e utilizza esclusivamente **UDP** porta 443. |
| **HTTP è un protocollo stateful** | **FALSO**. Ogni richiesta è indipendente. Lo stato viene emulato tramite cookie a livello applicativo. |
| **Il metodo GET ha un corpo della richiesta** | **FALSO** (nello standard). I parametri del GET sono inclusi unicamente nell'URL (query string). |
| **Un errore 5xx è causato da un errore del client** | **FALSO**. I codici 5xx indicano errori interni del **server**, i 4xx indicano errori del **client**. |

___
# Quick Reference Card

```
PORTE:
  80/TCP  → HTTP (connessione in chiaro)
  443/TCP → HTTPS (connessione cifrata TLS)
  443/UDP → HTTP/3 (QUIC su UDP)

STRUTTURA MESSAGGIO (ASCII):
  Richiesta: Request Line (Metodo URI Versione) -> Header -> Blank Line -> Body
  Risposta:  Status Line (Versione Codice Frase) -> Header -> Blank Line -> Body

METODI PRINCIPALI:
  GET    → Richiesta risorsa (parametri in URL)
  POST   → Invio dati (parametri in corpo)
  HEAD   → Richiesta solo header (no body)
  PUT    → Upload/sostituzione risorsa
  DELETE → Cancellazione risorsa

STATUS CODES CHIAVE:
  200 OK             → Successo
  301 Moved Perm.    → Spostato in modo permanente
  304 Not Modified   → Caching (nessuna modifica)
  400 Bad Request    → Richiesta del client non valida
  401 Unauthorized   → Autenticazione richiesta
  403 Forbidden      → Accesso vietato dal server
  404 Not Found      → Risorsa non trovata
  500 Internal Error → Errore generico lato server
  502 Bad Gateway    → Errore di comunicazione tra proxy/backend

CONFRONTO VERSIONI:
  HTTP/1.0 → Non persistente (1 connessione = 1 risorsa)
  HTTP/1.1 → Persistente (keep-alive), pipelining, Host header, HOLB
  HTTP/2   → Binario, multiplexing su TCP, HPACK, Server Push
  HTTP/3   → Basato su QUIC (UDP), zero HOLB di trasporto, TLS 1.3 integrato

CISCO IOS:
  ip http server        → Abilita server HTTP (porta 80)
  ip http secure-server → Abilita server HTTPS (porta 443)

VERIFICA:
  curl -I <URL>   → Mostra solo gli header di risposta
  curl -v <URL>   → Mostra transazione verbosa completa
```
___
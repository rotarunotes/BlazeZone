Data: 2026-01-15
[Network_Protocols](segaSistemai/Networking/Network_Protocols/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Network_Protocols
___
Video: https://youtu.be/7xIBNM3Bqhg?si=oCdc1bp4NvsNWtYY
# Index
- [[#Cos'è un Web Server]]
- [[#Comunicazione Client-Server]]
- [[#HyperText Transfer Protocol]]
- [[#Modalità di Connessione]]
- [[#Versioni HTTP]]
- [[#Messaggi HTTP: Richiesta e Risposta]]
- [[#Metodi di Richiesta HTTP]]
- [[#Status Code]]
- [[#HTTP Cookies]]
- [[#Proxy HTTP]]
- [[#Esempi di Web Server]]

---
# Cos'è un Web Server

Un **web server** è un servizio di rete progettato per accettare richieste `HTTP` e rispondere con pagine web o altre risorse, messaggi di errore.

Gli **scopi principali** di un web server sono:
1) **Rendere accessibili le risorse**: come file HTML, documenti e altri asset.
2) **Gestire applicazioni web dinamiche**: elaborando richieste che richiedono computazione lato server.
3) **Garantire comunicazioni affidabili**: tra i nodi della rete.

Dal punto di vista **hardware**, può essere ospitato su dispositivi semplici come un router o su complesse infrastrutture composte da centinaia di server per siti ad **alto** traffico.

---
# Comunicazione Client-Server

Il funzionamento si basa sul modello **client-server**:
- Il **browser (client)** genera una richiesta `HTTP`.
- Il **web server** riceve la richiesta, la interpreta e risponde con un messaggio `HTTP`.

La **risorsa** richiesta dal client possono essere di due tipi:
- **Statiche**: file pre-esistenti sul server (es. immagini, fogli di stile).
- **Dinamiche**: generate in tempo reale da script che comunicano con il server.

I protocolli standard utilizzati sono:
- **HTTP**: porta 80, dati trasmessi in chiaro.
- **HTTPS**: porta 443, dati crittografati per una maggiore sicurezza.

---

# HyperText Transfer Protocol

L'**HTTP** è un protocollo applicativo utilizzato come sistema primario per la trasmissione di informazioni su Internet.

Si appoggia sul protocollo **TCP** seguendo questi passaggi:
1) Il client avvia una connessione verso il server sulla porta 80.
2) Il server accetta la connessione.
3) Client e Server si scambiano informazioni multimediali.
4) La connessione TCP viene chiusa.

---
# Modalità di Connessione

Esistono due modalità principali per la gestione delle connessioni TCP:
## Connessione Non Persistente
- Viene creata una nuova connessione TCP per **ogni singolo oggetto** della pagina web.
- Dopo la consegna di un file (es. l'HTML), il server chiude la connessione.
- Il client deve ripetere l'apertura della connessione per ogni singolo oggetto che scopre anallizzando la pagina.

![[Connessione_Non_Persistente|500]]
## Connessione Persistente
- La connessione rimane aperta per il trasferimento di **più oggetti** della stessa pagina web.
- È la modalità di default nelle versioni moderne dell'HTTP.
- La connessione viene chiusa solo dopo il download di tutti gli oggetti necessari.

![[Connessionie_Persistente|500]]

---
# Versioni HTTP

| **Versione** | **Caratteristiche Principali**                                                                                                          |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| **HTTP/1.0** | Connessioni non persistenti (una connessione per risorsa).                                                                              |
| **HTTP/1.1** | Introduzione delle connessioni persistenti.                                                                                             |
| **HTTP/2**   | Compressione header, richieste parallele, crittografia e notifiche push dal server.                                                     |
| **HTTP/3**   | QUIC (transport layer protocol), utilizza più connessioni con richieste parallele<br>usando l’UDP, non soffre di head-of-line blocking. |

---
# Messaggi HTTP: Richiesta e Risposta

I messaggi sono codificati in formato **ASCII**.

Richiesta HTTP (Struttura):
- **Request Line**: contiene il metodo (GET, POST, ecc.) | l'URL | versione del protocollo.
- **Header Lines**: coppie nome-valore con info aggiuntive (es. Host, User-Agent, Cookie).
- **Blank Line**: riga vuota di separazione.
- **Entity Body**: corpo della richiesta, presente se necessario (es. dati di un form).
  
![[Richesta_HTTP|500]]

Risposta HTTP (Struttura):
- **Status Line**: contiene versione | codice di stato numerico | specifica l'esito.
- **Header Lines**: informazioni aggiuntive dal server.
- **Blank Line**: riga vuota di separazione.
- **Entity Body**: il contenuto della risorsa richiesta (es. il codice HTML della pagina).
  
![[Risposta_HTTP|500]]

___
# Metodi di Richiesta HTTP

I metodi definiscono l'azione che il **client** vuole eseguire:
- **GET**: richiede di scaricare un documento dal server, il documento è nel campo body di risposta
- **POST**: invia informazioni al server (es. credenziali di accesso).
- **HEAD**: richiede solo gli header informativi, senza il corpo del documento.
- **PUT**: utilizzato per caricare (upload) un documento sul server.
- **DELETE**: richiede la cancellazione di un documento.

---
# Status Code

Indicano l'esito della richiesta effettuata al server:
- **200 OK**: la richiesta ha avuto successo.
- **400 BAD REQUEST**: la richiesta non è stata compresa dal server.
- **404 NOT FOUND**: la risorsa richiesta non è stata trovata.
- **505 HTTP Version Not Supported**: la versione del protocollo non è supportata.

---
# HTTP Cookies

Poiché l'HTTP è un protocollo **stateless** (il server non ricorda le interazioni passate), si utilizzano i cookie per mantenere uno stato.
- Le informazioni di stato vengono inserite durante lo scambio di messaggi.
- Vengono memorizzate a lungo termine sia dal client che dal server per identificare l'utente o le sue preferenze.

---
# Proxy HTTP

Un **proxy** è un intermediario che risponde alle richieste del client senza necessariamente coinvolgere il server d'origine.
1) **Connettività**: una rete locale può accedere a internet tramite un unico computer
2) **Privacy**: nasconde l'indirizzo IP reale del client.
3) **Caching**: se l'oggetto è in cache, il proxy risponde subito, altrimenti lo recupera dal server d'origine.
4) **Monitoraggio**: permette di tracciare le operazioni sulle richieste.
5) **Amministrazione**: si applicano regole definite per determinare le richieste da inoltrare o rifiutare

---
# Esempi di Web Server

Esistono diverse implementazioni software di web server, con architetture differenti:
- **Apache**: basato su processi (un processo per ogni richiesta). Molto efficace per contenuti dinamici e linguaggi di scripting.
- **Nginx**: basato su eventi (un processo gestisce molteplici connessioni). Ottimizzato per la distribuzione di contenuti statici.

Spesso vengono usati insieme: Nginx come proxy per i contenuti statici e Apache per la gestione della logica dinamica.
___
 
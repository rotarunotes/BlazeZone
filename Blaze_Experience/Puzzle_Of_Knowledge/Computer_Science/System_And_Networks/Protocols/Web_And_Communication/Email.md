Data: 2026-06-08
[Web_And_Communication](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Web_And_Communication
___
# Index
- [[#Architettura Del Sistema E-mail]]
	- [[#Componenti Principali]]
	- [[#Flusso Di Invio E Ricezione]]
- [[#Protocolli Di Posta Elettronica]]
	- [[#Simple Mail Transfer Protocol]]
	- [[#Post Office Protocol]]
	- [[#Internet Message Access Protocol]]
- [[#Formato Dei Messaggi]]
	- [[#Struttura Standard RFC 5322]]
	- [[#Estensioni MIME]]
___
# Architettura Del Sistema E-mail

Il sistema di posta elettronica è un'infrastruttura di rete asincrona (il mittente ed il destinatario non devono essere connessi contemporaneamente) progettata per lo scambio di messaggi attraverso Internet.
## Componenti Principali
Il funzionamento del servizio si basa sulla cooperazione di tre agenti software distinti:

- **MUA**, *Mail User Agent*: È l'interfaccia client con cui l'utente interagisce per comporre, inviare e leggere le e-mail (es. Microsoft Outlook, Mozilla Thunderbird o interfacce webmail come Gmail).
- **MTA**, *Mail Transfer Agent*: È il server di posta (es. Postfix, Exim, Microsoft Exchange) responsabile dell'instradamento e del trasferimento dei messaggi tra i domini di rete. Gli MTA comunicano tra loro per inoltrare i messaggi dal mittente al server di destinazione.
- **MDA**, *Mail Delivery Agent*: È il servizio locale che riceve il messaggio dall'MTA finale e lo deposita fisicamente nella casella postale dell'utente (*mailbox*) sul server di destinazione, in attesa che venga scaricato dal client del destinatario.
## Flusso Di Invio E Ricezione

```
 Mittente (MUA)
      │
      ▼ (SMTP)
 MTA Mittente (Server)
      │
      ▼ (SMTP tramite ricerca DNS MX)
 MTA Destinatario (Server) ──► MDA (Mailbox)
                                 │
                                 ▼ (POP3 / IMAP)
                           Destinatario (MUA)
```

1. Il mittente compone l'e-mail sul proprio MUA e preme invia.
2. Il MUA trasmette il messaggio al proprio MTA locale utilizzando il protocollo SMTP, *Simple Mail Transfer Protocol*.
3. L'MTA mittente esamina il dominio del destinatario (es. `@destinatario.com`) ed interroga il server DNS, *Domain Name System*, richiedendo il record **MX** (*Mail Exchanger*) di quel dominio per identificare l'indirizzo IP del server di destinazione.
4. L'MTA mittente inoltra il messaggio all'MTA destinatario tramite SMTP sulla porta standard 25.
5. L'MTA destinatario riceve il messaggio e lo passa al proprio MDA locale, che lo archivia nella casella di posta (*mailbox*) dell'utente.
6. Il destinatario si connette tramite il proprio MUA e scarica o consulta le e-mail memorizzate nella casella postale sul server tramite i protocolli POP3, *Post Office Protocol Version 3*, o IMAP, *Internet Message Access Protocol*.

___
# Protocolli Di Posta Elettronica

La gestione dei messaggi avviene tramite protocolli specializzati per l'invio e la ricezione:

## Simple Mail Transfer Protocol
L'SMTP è un protocollo di tipo **push** (spinge i dati) utilizzato per l'invio dei messaggi da client a server e per il trasferimento tra server di posta (MTA-to-MTA).
- Opera sulla porta **25/TCP** per la comunicazione tra server.
- Opera sulla porta **587/TCP** per l'invio sicuro da client a server tramite crittografia STARTTLS.

## Post Office Protocol
Il POP3 è un protocollo di ricezione di tipo **pull** (il client interroga il server e scarica i dati).
- Scarica i messaggi dal server al computer locale e, per impostazione predefinita, li **cancella dal server**.
- Non è adatto per accessi multi-dispositivo poiché lo stato dei messaggi (es. letto/non letto) è memorizzato solo localmente sul client.
- Opera sulla porta **110/TCP** (in chiaro) o **995/TCP** (cifrato).

## Internet Message Access Protocol
L'IMAP è un protocollo di ricezione di tipo **pull** evoluto.
- Permette di accedere ai messaggi mantenendoli memorizzati sul **server**.
- Sincronizza lo stato dei messaggi (letti, non letti, bozze) e la struttura delle cartelle tra tutti i dispositivi associati alla casella postale.
- Supporta il download parziale (es. scarica solo l'intestazione dell'e-mail e recupera gli allegati solo su richiesta).
- Opera sulla porta **143/TCP** (in chiaro) o **993/TCP** (cifrato).

___
# Formato Dei Messaggi

Un messaggio di posta elettronica è composto interamente da testo ASCII, *American Standard Code for Information Interchange*, a 7 bit ed è suddiviso in due parti separate da una riga vuota.

## Struttura Standard RFC 5322
La struttura del messaggio prevede:
- **Intestazioni** (Header): Righe contenenti campi di metadati chiave-valore. I campi standard obbligatori o comuni sono:
	- `From`: L'indirizzo del mittente.
	- `To`: L'indirizzo del destinatario.
	- `Subject`: L'oggetto del messaggio.
	- `Date`: Data e ora di composizione.
- **Corpo** (Body): Il testo effettivo del messaggio composto dall'utente, situato dopo la riga vuota di separazione degli header.

## Estensioni MIME
Poiché lo standard originale supportava solo caratteri ASCII inglesi a 7 bit, è stato introdotto lo standard MIME, *Multipurpose Internet Mail Extensions*, per consentire:
- L'inserimento di caratteri non ASCII (es. lettere accentate o alfabeti non latini).
- La formattazione del testo tramite codice HTML.
- L'inclusione di allegati non testuali (immagini, documenti binari) codificati in formato Base64.
- La scomposizione del messaggio in più parti con tipologie di contenuto differenti (*multipart*).

___


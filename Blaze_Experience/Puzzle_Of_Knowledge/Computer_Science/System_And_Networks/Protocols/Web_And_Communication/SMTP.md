Data: 2026-06-08
[Web_And_Communication](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Web_And_Communication
___
# Index
- [[#Simple Mail Transfer Protocol (SMTP)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Il Sistema Di Trasferimento E-mail]]
	- [[#Protocollo Testuale ASCII]]
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
# _Simple Mail Transfer Protocol (SMTP)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **25/TCP** (trasferimento), **587/TCP** (invio client) |
| **Scopo** | Trasferimento affidabile di messaggi e-mail tra server di posta e invio da client a server |
| **RFC / Standard** | RFC 821 (originale), RFC 5321 (corrente) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) |
| **Affidabilità** | **Affidabile** (garantita da TCP con tentativi di riconsegna in coda) |
| **PDU (Unità Dati)** | **Messaggio SMTP** (comandi e risposte in testo ASCII) |
| **Meccanismo di Controllo** | Sessione interattiva basata su comandi testuali e codici di stato numerici |

___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
| :--- | :--- | :--- |
| **SMTP** (RFC 821) | 1982 | Versione iniziale definita da Jonathan Postel. Limitata a caratteri ASCII a 7 bit. Nessun meccanismo di autenticazione. |
| **ESMTP** (RFC 1869) | 1995 | *Extended SMTP*. Aggiunge la capacità di negoziare estensioni come l'autenticazione, la cifratura ed il trasferimento di allegati multimediali. |
| **SMTP-IN-TLS** (RFC 3207) | 2002 | Introduzione del comando STARTTLS per aggiornare al volo una sessione in chiaro in una cifrata. |
| **SMTP moderno** (RFC 5321) | 2008 | Specifica corrente che consolida ESMTP ed integra le migliori pratiche di gestione delle code e dei messaggi di rimbalzo (*bounce*). |

___
# Come Funziona

Il protocollo SMTP, *Simple Mail Transfer Protocol*, è un protocollo di tipo **push** (invia/spinge i dati verso la destinazione). Viene utilizzato per due scopi principali:
1. Spedire e-mail da un client (MUA, *Mail User Agent*) al server di posta di invio.
2. Trasferire e-mail tra server di posta intermedi (MTA, *Mail Transfer Agent*) fino a raggiungere il server di destinazione.

## Il Sistema Di Trasferimento E-mail
Il sistema postale digitale si articola in tre componenti logiche:
- **MUA** (*Mail User Agent*): Il client utilizzato dall'utente (es. Outlook, Thunderbird) per leggere e comporre le e-mail.
- **MTA** (*Mail Transfer Agent*): Il server di posta (es. Postfix, Exchange) incaricato di instradare i messaggi analizzando il record MX, *Mail Exchanger*, del server DNS, *Domain Name System*, del destinatario.
- **MDA** (*Mail Delivery Agent*): Il servizio locale che riceve il messaggio dall'MTA di destinazione e lo deposita nella casella postale fisica (*mailbox*) dell'utente.

## Protocollo Testuale ASCII
SMTP opera interamente in formato testuale ASCII, *American Standard Code for Information Interchange*, a 7 bit.
- La comunicazione consiste in uno scambio interattivo in cui il mittente invia comandi di 4 lettere ed il destinatario risponde con codici di stato a 3 cifre seguiti da testo descrittivo.
- Per inviare dati binari (immagini, allegati) o caratteri speciali non ASCII (accenti), il corpo del messaggio deve essere codificato in formato MIME, *Multipurpose Internet Mail Extensions*.

___
# Flusso Operativo

```
Client (MUA / MTA Mittente)                              Server (MTA Destinatario)
   |                                                              |
   |<--------- 1. Connessione TCP stabilita (220 Ready) ----------|
   |                                                              |
   |---------- 2. EHLO mail.mittente.com ------------------------>|
   |<--------- 3. 250 OK (Elenco estensioni supportate) ----------|
   |                                                              |
   |---------- 4. MAIL FROM:<mittente@mittente.com> ------------->|
   |<--------- 5. 250 Sender OK ----------------------------------|
   |                                                              |
   |---------- 6. RCPT TO:<destinatario@dest.com> --------------->|
   |<--------- 7. 250 Recipient OK -------------------------------|
   |                                                              |
   |---------- 8. DATA ------------------------------------------>|
   |<--------- 9. 354 Start mail input; end with <CRLF>.<CRLF> ---|
   |                                                              |
   |---------- 10. [Invio Header (Subject, ecc.) + Corpo] ------->|
   |---------- 11. <CRLF>.<CRLF> (Punto su riga singola) -------->|
   |<--------- 12. 250 OK (Messaggio accettato per consegna) -----|
   |                                                              |
   |---------- 13. QUIT ----------------------------------------->|
   |<--------- 14. 221 Bye (Connessione TCP chiusa) --------------|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **Saluto** | 1 | Il mittente si presenta con il comando `EHLO` (o `HELO`) | Il server risponde con `250 OK` ed i parametri supportati |
| **Mittente** | 2 | Il mittente definisce l'indirizzo di ritorno con `MAIL FROM` | Il server valida la sintassi dell'indirizzo |
| **Destinatario** | 3 | Il mittente definisce l'indirizzo di arrivo con `RCPT TO` | Può essere ripetuto per destinatari multipli |
| **Dati** | 4 | Il mittente avvia la sessione di scrittura dati con `DATA` | Il server risponde con il codice di invito `354` |
| **Trasmissione** | 5 | Invio del corpo del messaggio (inclusi header come Subject) | Terminata da una riga contenente solo un punto `.` |
| **Chiusura** | 6 | Il client chiude la sessione con il comando `QUIT` | Il server risponde con `221` e chiude la connessione TCP |

___
# Casi D'Uso Reali

- **Invio E-mail da client**: Configurazione del server di uscita sui client desktop o mobili.
- **Relay di posta (MTA-to-MTA)**: Trasferimento dei messaggi attraverso Internet tra i domini di posta (es. da Gmail a Outlook).
- **Notifiche applicative**: Sistemi automatizzati (siti web, monitoraggi) che inviano avvisi via e-mail all'amministratore o agli utenti.

___
# Limitazioni Tecniche

- **Nessuna crittografia nativa**: Lo standard SMTP originale trasmette le credenziali ed i messaggi in chiaro sulla rete.
- **Limitazione a 7 bit**: Non supporta nativamente file binari o caratteri non inglesi, richiedendo l'overhead della codifica MIME (che aumenta la dimensione del file del 33%).
- **Assenza di autenticazione mittente**: Chiunque può specificare un indirizzo falso nel campo `MAIL FROM`, facilitando lo spam e il phishing (mancanza di autenticazione intrinseca).

___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio SMTP (Comandi / Risposte)
- **Incapsulato in**: Segmento TCP (porte 25, 587, 465), a sua volta in pacchetto IP
- **Incapsula**: Dati MIME ed e-mail reali

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header SMTP ] PDU: Messaggio SMTP (Comando/Risposta)
```

___
# Struttura Del Pacchetto

Un messaggio SMTP è diviso in una busta (*envelope*), definita durante la sessione con i comandi `MAIL FROM` e `RCPT TO`, e nel contenuto reale trasmesso dopo il comando `DATA`.

## Header

A livello di sessione SMTP, i messaggi viaggiano come singole righe di testo ASCII terminate da `<CRLF>` (sequenza `\r\n`).

### Schema Del Comando SMTP (Client)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Comando (4 caratteri ASCII, es. MAIL, RCPT)          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Argomenti (es. FROM:<user@ip>) ...   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...           |     \r        |     \n        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### Schema Della Risposta SMTP (Server)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Codice Di Stato (3 caratteri ASCII, es. 250)         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Messaggio Descrittivo (es. OK) ...   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...           |     \r        |     \n        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

A livello di contenuto e-mail (dopo il comando `DATA`), gli header seguono lo standard RFC 5322:
- **From**: Indirizzo visualizzato del mittente.
- **To**: Indirizzo del destinatario principale.
- **Subject**: Oggetto del messaggio.
- **Date**: Data di composizione.
- **MIME-Version**: Versione dello standard MIME (es. `1.0`).
- **Content-Type**: Specifica il formato del corpo (es. `text/plain`, `text/html`, `multipart/mixed`).

## Body
Il corpo dell'e-mail, separato dagli header da una riga vuota. Può contenere testo semplice o blocchi codificati in Base64 (allegati).

## Flags
I codici di stato numerici a 3 cifre restituiti dal server controllano l'avanzamento della transazione:

### Codici Di Risposta Chiave
- **220**: Servizio pronto.
- **250**: Azione completata con successo (OK).
- **354**: Inizio inserimento dati, terminare con `<CRLF>.<CRLF>`.
- **421**: Servizio non disponibile, connessione in chiusura (errore temporaneo).
- **450**: Cassetta postale occupata o non disponibile (riprovare più tardi).
- **500**: Errore di sintassi, comando non riconosciuto.
- **550**: Cassetta postale inesistente o rifiutata (errore permanente).

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **25/TCP** | 7 | SMTP | Porta di default per lo scambio tra server (MTA-to-MTA) |
| **587/TCP** | 7 | SMTP (STARTTLS) | Porta submission consigliata per i client (MUA-to-MTA) con cifratura opzionale |
| **465/TCP** | 7 | SMTPS | Porta deprecata ma ancora utilizzata per SMTP sicuro su SSL/TLS implicito |

___
# Confronto

**SMTP vs POP vs IMAP**

| Caratteristica | SMTP | POP | IMAP |
| :--- | :--- | :--- | :--- |
| **Direzione** | Push (invio e-mail) | Pull (ricezione e-mail) | Pull (ricezione e-mail) |
| **Porta standard** | 25 / 587 | 110 | 143 |
| **Gestione Messaggi** | Trasferisce i messaggi verso il server | Scarica localmente ed elimina dal server (default) | Sincronizza i messaggi mantenendoli sul server |
| **Multi-dispositivo** | Non applicabile | Scarso (i messaggi letti spariscono dal server) | Ottimo (stato sincronizzato tra tutti i client) |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **E-mail Spoofing**: Mancando un controllo di identità, è possibile falsificare il mittente semplicemente inserendo un indirizzo arbitrario in `MAIL FROM`.
- **Open Relay**: Server configurati in modo errato che accettano e inoltrano messaggi da e verso chiunque, usati dagli spammer per nascondere la propria identità.

## Attacchi Comuni
- **Spamming massivo**: Invio di milioni di e-mail non sollecitate sfruttando server vulnerabili.
- **Phishing**: E-mail ingannevoli strutturate con mittenti fasulli per rubare credenziali o dati personali.

## Contromisure
- **STARTTLS**: Comando per cifrare la sessione SMTP in transito tramite TLS.
- **SMTP Auth**: Richiede nome utente e password validi prima di accettare l'invio di messaggi da un client.
- **SPF**: *Sender Policy Framework* — Record DNS TXT che elenca gli IP dei server autorizzati a inviare e-mail per conto di quel dominio.
- **DKIM**: *DomainKeys Identified Mail* — Firma digitale asimmetrica inserita negli header dell'e-mail per verificare che il messaggio non sia stato alterato.
- **DMARC**: *Domain-based Message Authentication, Reporting, and Conformance* — Policy DNS che indica al server destinatario cosa fare se i controlli SPF e DKIM falliscono (es. rifiutare o mettere in quarantena la mail).

___
# Comandi Cisco IOS

Non si configurano server di posta su router Cisco, ma è possibile impostare un server SMTP per inviare log o messaggi di errore (smart call home):

```cisco
! Configurare l'indirizzo del server SMTP per l'invio di alert
mail-server host 192.168.1.50

! Configurare l'indirizzo e-mail di provenienza delle notifiche
mail-server source-address router@azienda.com
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Errore 550 Relay Denied** | Il server rifiuta di inoltrare l'e-mail perché il mittente non è autenticato | Il server non riconosce l'utente o l'IP come autorizzato all'invio. |
| **Errore 550 Mailbox Not Found** | L'indirizzo e-mail del destinatario è errato o inesistente | Errore permanente di recapito. |
| **Timeout di connessione sulla porta 25** | L'ISP blocca il traffico in uscita sulla porta 25 per prevenire spam | Configurare l'invio sulla porta 587. |

**Comandi di verifica**:

```bash
# Avviare una sessione SMTP manuale in chiaro per testare il server
telnet mail.example.com 25

# Avviare una sessione SMTP sicura con STARTTLS
openssl s_client -connect mail.example.com:25 -starttls smtp

# Interrogare i record MX del server DNS per trovare il server SMTP di destinazione
nslookup -type=mx example.com
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo di tipo push per l'invio ed il trasferimento di e-mail. |
| **Porte standard** | **25/TCP** (tra server), **587/TCP** (da client a server con STARTTLS). |
| **Formato dati** | Testo ASCII a 7 bit; richiede codifica MIME per allegati e caratteri speciali. |
| **Comando DATA** | Avvia l'invio del corpo del messaggio. Si termina inserendo un punto su una riga vuota (`.`). |
| **Sicurezza** | SPF, DKIM e DMARC risolvono le vulnerabilità storiche di spoofing e spam. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **SMTP si usa per scaricare la posta sul client** | **FALSO**. SMTP è un protocollo solo di **invio** (push). Per scaricare la posta si usano POP o IMAP. |
| **Il mittente visualizzato nell'e-mail è garantito da SMTP** | **FALSO**. Il mittente visualizzato (From negli header) è un semplice testo ASCII che può essere falsificato liberamente se non filtrato da SPF/DKIM. |
| **SMTP invia file binari direttamente** | **FALSO**. SMTP supporta solo caratteri ASCII a 7 bit. I file binari devono essere preventivamente convertiti in testo tramite codifica Base64 all'interno di messaggi MIME. |

___
# Quick Reference Card

```
PORTE:
  25/TCP  → Trasferimento tra server (MTA-to-MTA)
  587/TCP → Invio da client (MUA-to-MTA) con crittografia STARTTLS
  465/TCP → SMTP sicuro legacy (implicit SSL/TLS)

COMANDI PRINCIPALI:
  EHLO <dominio>            → Avvia la sessione (Extended SMTP)
  MAIL FROM:<indirizzo>    → Specifica il mittente dell'invio
  RCPT TO:<indirizzo>      → Specifica il destinatario
  DATA                      → Avvia la scrittura del messaggio (termina con .)
  QUIT                      → Chiude la sessione TCP

STATUS CODES CHIAVE:
  220 → Servizio pronto
  250 → Operazione completata con successo
  354 → Inizio inserimento dati (invito)
  421 → Servizio non disponibile (errore temporaneo)
  550 → Casella di posta non disponibile o inesistente (errore permanente)

SICUREZZA DOMINIO:
  SPF    → Record TXT con lista IP autorizzati a inviare
  DKIM   → Firma digitale asimmetrica negli header del messaggio
  DMARC  → Regola DNS che definisce l'azione in caso di fallimento SPF/DKIM
```
___

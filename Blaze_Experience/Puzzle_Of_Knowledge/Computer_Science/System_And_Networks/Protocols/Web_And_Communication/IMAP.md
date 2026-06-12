Data: 2026-06-08
[Web_And_Communication](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Web_And_Communication
___
# Index
- [[#Internet Message Access Protocol (IMAP)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Gestione Dello Stato E Cartelle Remote]]
	- [[#Comandi Taggati E Comunicazione Asincrona]]
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
# _Internet Message Access Protocol (IMAP)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **143/TCP** (in chiaro), **993/TCP** (cifrato) |
| **Scopo** | Sincronizzare ed accedere ai messaggi e-mail mantenendoli memorizzati sul server remoto |
| **RFC / Standard** | RFC 1064 (IMAP2), RFC 2060 (IMAP4), RFC 3501 (IMAP4rev1 — corrente) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) con sessione interattiva persistente |
| **Affidabilità** | **Affidabile** (garantita da TCP durante le operazioni di sincronizzazione) |
| **PDU (Unità Dati)** | **Messaggio IMAP** (comandi taggati in testo ASCII) |
| **Meccanismo di Controllo** | Scambio asincrono di comandi identificati da tag alfanumerici univoci |

___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
| :--- | :--- | :--- |
| **IMAP1** | 1986 | Sviluppato alla Stanford University. Molto limitato, non rilasciato pubblicamente come standard. |
| **IMAP2** (RFC 1064) | 1988 | Prima versione standardizzata. Aggiunto il supporto per la gestione delle cartelle remote sul server. |
| **IMAP3** (RFC 1203) | 1991 | Tentativo di ridefinizione del protocollo. Rifiutato dal mercato a favore delle evoluzioni di IMAP2. |
| **IMAP4** (RFC 2060) | 1996 | Riscritto completamente. Aggiunto supporto per ricerche avanzate sul server, autenticazione crittografica e download parziale. |
| **IMAP4rev1** (RFC 3501) | 2003 | Versione corrente. Ottimizza la gestione delle connessioni multiple ed il risparmio di banda. |

___
# Come Funziona

Il protocollo IMAP, *Internet Message Access Protocol*, è un protocollo di ricezione e-mail di tipo **pull** che permette una gestione centralizzata e sincronizzata della posta. A differenza di POP3, i messaggi rimangono memorizzati sul server di destinazione ed il client locale si limita a sincronizzarne la visualizzazione.

## Gestione Dello Stato E Cartelle Remote
IMAP mantiene la struttura delle e-mail organizzata direttamente sul disco del server remoto:
- **Cartelle remote**: L'utente può creare, rinominare, eliminare e spostare cartelle. Queste modifiche si riflettono istantaneamente su qualsiasi altro dispositivo connesso.
- **Sincronizzazione dello stato**: Ogni messaggio è associato a dei contrassegni (*flags*) memorizzati sul server, come `\Seen` (letto), `\Answered` (risposto), `\Flagged` (importante) e `\Deleted` (cancellato).

## Comandi Taggati E Comunicazione Asincrona
IMAP introduce una gestione delle sessioni basata su **tag alfanumerici** (es. `a001`, `a002`) generati dal client per identificare univocamente ogni comando.
- Questo meccanismo permette al server di rispondere ai comandi in modo asincrono (non necessariamente nello stesso ordine di arrivo) e consente al client di inviare più richieste in parallelo sulla stessa connessione TCP.
- Il protocollo supporta inoltre il download parziale: il client può richiedere solo le intestazioni (*header*) per popolare la lista delle e-mail ed scaricare il corpo del messaggio o i relativi allegati solo quando l'utente decide di aprire l'e-mail.

___
# Flusso Operativo

```
Client (MUA)                                             Server (MDA/IMAP Server)
   |                                                              |
   |<--------- 1. Connessione TCP stabilita (* OK IMAP4ready) -----|
   |                                                              |
   |---------- 2. a001 LOGIN mario@esempio.com passSegreta ------>|
   |<--------- 3. a001 OK LOGIN completed ------------------------|
   |                                                              |
   |---------- 4. a002 SELECT INBOX ----------------------------->|
   |<--------- 5. * 2 EXISTS (Ci sono 2 messaggi in INBOX) -------|
   |<--------- 6. a002 OK [READ-WRITE] SELECT completed ----------|
   |                                                              |
   |---------- 7. a003 FETCH 1 (FLAGS BODY[HEADER.FIELDS (SUBJECT)]) ->|
   |<--------- 8. * 1 FETCH (FLAGS (\Seen) BODY... "Oggetto 1") --|
   |<--------- 9. a003 OK FETCH completed ------------------------|
   |                                                              |
   |---------- 10. a004 STORE 2 +FLAGS (\Deleted) -------------->|
   |<--------- 11. * 2 FETCH (FLAGS (\Seen \Deleted)) ------------|
   |<--------- 12. a004 OK STORE completed -----------------------|
   |                                                              |
   |---------- 13. a005 EXPUNGE (Elimina definitivamente msg 2) ->|
   |<--------- 14. * 2 EXPUNGE -----------------------------------|
   |<--------- 15. a005 OK EXPUNGE completed ---------------------|
   |                                                              |
   |---------- 16. a006 LOGOUT ---------------------------------->|
   |<--------- 17. * BYE IMAP4rev1 Server signing off -----------|
   |<--------- 18. a006 OK LOGOUT completed ----------------------|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **Connessione** | 1 | Il client si connette sulla porta 143 | Il server risponde con un banner di pronto `* OK` |
| **Login** | 2 | Invio comando `LOGIN` con tag alfanumerico (es. `a001`) | Il server autentica l'utente e risponde `a001 OK` |
| **Selezione** | 3 | Il client seleziona la cartella di lavoro con `SELECT` | Il server indica quante mail esistono in quella cartella |
| **Recupero** | 4 | Richiesta dettagli tramite `FETCH` | Il client può chiedere solo parti specifiche per risparmiare banda |
| **Modifica** | 5 | Modifica dei contrassegni sul server con `STORE` | Ad esempio, impostare il flag `\Deleted` per contrassegnare |
| **Rimozione** | 6 | Rimozione fisica dei messaggi marcati con `EXPUNGE` | Libera spazio sul server remoto |
| **Chiusura** | 7 | Invio del comando `LOGOUT` | Il server chiude la sessione TCP |

___
# Casi D'Uso Reali

- **Accesso multi-dispositivo**: Configurazione predefinita per l'utilizzo della posta su smartphone, tablet e PC, mantenendo lo stato "letto/non letto" e le cartelle sincronizzate ovunque.
- **Webmail**: Le interfacce web (es. Gmail, Outlook.com) utilizzano internamente IMAP per interrogare i server e mostrare la posta in tempo reale.
- **Uso professionale/aziendale**: Gestione condivisa di caselle di posta elettroniche di reparto (es. `info@azienda.com`) da parte di più operatori.

___
# Limitazioni Tecniche

- **Consumo spazio sul server**: Mantenendo tutti i messaggi e gli allegati sul server, lo spazio si esaurisce rapidamente se non monitorato.
- **Dipendenza dalla rete**: Senza connessione ad internet, molte operazioni non sono possibili poiché il client deve dialogare costantemente con il server remoto.
- **Maggiore carico sul server**: La gestione di ricerche complesse, sincronizzazioni e connessioni persistenti richiede più memoria e CPU sul server rispetto a POP3.

___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio IMAP (Comandi / Risposte)
- **Incapsulato in**: Segmento TCP (porte 143, 993), a sua volta in pacchetto IP
- **Incapsula**: E-mail testuale e relativi allegati MIME

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header IMAP ] PDU: Messaggio IMAP (Comando/Risposta)
```

___
# Struttura Del Pacchetto

Tutte le comunicazioni IMAP avvengono tramite stringhe di testo ASCII terminate da `<CRLF>`.

## Header

A livello di sessione IMAP, la comunicazione avviene interamente tramite righe di testo ASCII terminate da `<CRLF>` (`\r\n`).

### Schema Del Comando IMAP (Client)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Tag Alfanumerico (es. a001)                          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Comando (es. LOGIN, SELECT) ...      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...           |          Argomenti (opzionali) ...            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...                                           |   \r   |  \n  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### Schema Della Risposta IMAP (Server)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Tag (es. a001) / * (Non Taggata) / + (Continuazione) |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Esito o Messaggio Descrittivo ...    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...                                           |   \r   |  \n  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

I messaggi inviati dal client iniziano sempre con un **tag alfanumerico** univoco generato dal client (es. `a001`), seguito dal comando e dai relativi parametri.

## Body
Il server risponde con tre tipi di intestazioni:
- **Risposte Taggate**: Iniziano con lo stesso tag del comando client che le ha generate, per indicare l'esito finale (es. `a001 OK`, `a001 NO`, `a001 BAD`).
- **Risposte Non Taggate**: Iniziano con un asterisco (`*`) e contengono dati intermedi o avvisi generici del server (es. `* 2 EXISTS`).
- **Risposte di Continuazione**: Iniziano con un segno più (`+`) per invitare il client ad inviare ulteriori dati.

## Flags
I contrassegni dei messaggi (*flags*) servono a gestire lo stato dell'e-mail a livello server:
- `\Seen`: Messaggio letto.
- `\Answered`: Messaggio a cui si è risposto.
- `\Flagged`: Messaggio contrassegnato come speciale o importante.
- `\Deleted`: Messaggio marcato per l'eliminazione fisica.
- `\Draft`: Messaggio in bozza.

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **143/TCP** | 7 | IMAP | Connessione standard IMAP in chiaro o via STARTTLS |
| **993/TCP** | 7 | IMAPS | Connessione sicura IMAP cifrata implicitamente con SSL/TLS |

___
# Confronto

**IMAP vs POP3**

| Caratteristica | IMAP | POP3 |
| :--- | :--- | :--- |
| **Sincronizzazione** | Bidirezionale (sincronizza cartelle e stati) | Monodirezionale (scarica e basta) |
| **Porta sicura** | 993/TCP | 995/TCP |
| **Uso offline** | Richiede caching esplicito del client | Nativo (tutto scaricato localmente) |
| **Ricerca** | Eseguita sul server (veloce anche su mail vecchie) | Eseguita localmente sul client (richiede download) |
| **Uso di banda** | Ottimizzato (scarica solo ciò che serve) | Elevato inizialmente (scarica tutto subito) |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Credenziali in chiaro**: La porta standard 143 trasmette i comandi `LOGIN` contenenti password in chiaro, esponendoli ad intercettazioni.
- **Sniffing dei messaggi**: I dati delle e-mail viaggiano non crittografati in modalità standard.

## Attacchi Comuni
- **Cattura delle credenziali**: Sniffing di login e password su canali di rete locali non protetti.
- **Session hijacking**: Intercettazione della sessione TCP per accedere abusivamente alla casella postale.

## Contromisure
- **Forzare IMAPS**: Configurare la connessione dei client unicamente sulla porta sicura 993/TCP.
- **STARTTLS**: Comando per stabilire la cifratura TLS sulla porta standard 143 prima di inviare le credenziali.

___
# Comandi Cisco IOS

I dispositivi Cisco non eseguono né gestiscono servizi relativi al protocollo IMAP.

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Lentezza estrema nel caricamento delle cartelle** | Cartella con troppi messaggi (migliaia) senza indicizzazione o cache locale | Il client deve risincronizzare l'intero indice. Soluzione: archiviare le vecchie mail. |
| **Errore mailbox locked / session busy** | Un altro client sta modificando la stessa cartella in modo esclusivo | Il server blocca l'accesso simultaneo in scrittura ad alcune risorse. |
| **Messaggi cancellati che riappaiono** | È stata eseguita la marcatura per cancellazione (`\Deleted`) ma non è stato inviato il comando `EXPUNGE` | Le mail non vengono rimosse fisicamente dal server e ricompaiono al successivo login. |

**Comandi di verifica**:

```bash
# Aprire una sessione IMAP manuale in chiaro
telnet mail.example.com 143

# Aprire una sessione sicura IMAPS
openssl s_client -connect mail.example.com:993 -quiet
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo pull per l'accesso e la sincronizzazione centralizzata delle e-mail sul server. |
| **Porte standard** | **143/TCP** (in chiaro), **993/TCP** (cifrato via SSL/TLS). |
| **Tag alfanumerico** | Identifica univocamente i comandi del client (es. `a001`), permettendo comunicazioni asincrone. |
| **Risposta asterisco (*)** | Risposta non taggata del server contenente dati di stato (es. `* 2 EXISTS`). |
| **Flags principali** | `\Seen` (letto), `\Answered` (risposto), `\Flagged` (importante), `\Deleted` (cancellato). |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **IMAP scarica ed elimina le e-mail dal server** | **FALSO**. Questa è la modalità di default di POP3. IMAP conserva sempre le e-mail sul server. |
| **IMAP invia messaggi e-mail** | **FALSO**. IMAP è un protocollo utilizzato esclusivamente per la **ricezione** e la consultazione. Per l'invio si usa sempre SMTP. |
| **Il server IMAP risponde sempre nell'ordine esatto delle richieste** | **FALSO**. Grazie ai tag alfanumerici, il server IMAP può elaborare e rispondere alle richieste in modo asincrono per ottimizzare le prestazioni. |

___
# Quick Reference Card

```
PORTE:
  143/TCP → Connessione IMAP standard (in chiaro o via STARTTLS)
  993/TCP → Connessione IMAPS (cifrata)

COMANDI CLIENT PRINCIPALI:
  a001 LOGIN <user> <pass>  → Autentica l'utente sul server
  a002 SELECT <cartella>    → Seleziona una cartella (es. INBOX)
  a003 FETCH <num> <campi>  → Richiede parti specifiche del messaggio
  a004 STORE <num> <flags>  → Modifica i flags del messaggio
  a005 EXPUNGE              → Cancella fisicamente i messaggi marcati con \Deleted
  a006 LOGOUT               → Chiude la sessione di lavoro

RISPOSTE SERVER:
  * <dati>       → Risposta non taggata (dati di stato o informativi)
  a001 OK <msg>  → Comando completato con successo
  a001 NO <msg>  → Comando rifiutato dal server
  a001 BAD <msg> → Errore di sintassi nel comando del client
```
___

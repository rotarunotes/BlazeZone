Data: 2026-06-08
[Web_And_Communication](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Web_And_Communication
___
# Index
- [[#Post Office Protocol (POP)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Le Tre Fasi Della Sessione]]
	- [[#Protocollo Stateless]]
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
# _Post Office Protocol (POP)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **110/TCP** (in chiaro), **995/TCP** (cifrato) |
| **Scopo** | Scaricare i messaggi e-mail da un server remoto ad un client locale |
| **RFC / Standard** | RFC 918 (POP1), RFC 937 (POP2), RFC 1939 (POP3 — corrente) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) |
| **Affidabilità** | **Affidabile** (garantita da TCP durante il download) |
| **PDU (Unità Dati)** | **Messaggio POP** (comandi testuali e risposte dello stato) |
| **Meccanismo di Controllo** | Sessione a tre fasi gestita tramite comandi ASCII e conferme di esito |

___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
| :--- | :--- | :--- |
| **POP1** (RFC 918) | 1984 | Prima versione per scaricare le e-mail da sistemi centralizzati a macchine locali single-user. |
| **POP2** (RFC 937) | 1985 | Migliorato lo scambio di comandi e risposte, porta di default impostata a 109/TCP. |
| **POP3** (RFC 1939) | 1996 | Versione corrente. Introduce comandi ottimizzati, autenticazione crittografica MD5 (APOP) ed il supporto a connessioni sicure via TLS. Porta standard impostata a 110/TCP. |

___
# Come Funziona

Il protocollo POP, *Post Office Protocol*, è un protocollo di tipo **pull** (il client interroga il server e tira a sé i dati). Il suo funzionamento ricalca quello di un ufficio postale fisico: il client si connette alla cassetta postale, scarica tutti i messaggi disponibili sul proprio computer locale e, per impostazione predefinita, ne richiede la cancellazione immediata dal server.

## Le Tre Fasi Della Sessione
Una connessione POP3 si sviluppa in una sequenza rigorosa di tre fasi distinte:
1. **Autorizzazione** (*Authorization*): Il client apre la connessione TCP sulla porta 110 ed invia le credenziali di accesso.
2. **Transazione** (*Transaction*): Il client interroga il server per conoscere il numero ed il peso delle e-mail, le scarica localmente e contrassegna quelle lette per la rimozione.
3. **Aggiornamento** (*Update*): Il client invia il comando di chiusura. Il server rimuove fisicamente dal disco i messaggi contrassegnati e chiude la sessione TCP.

## Protocollo Stateless
A differenza di IMAP, POP3 è **stateless** (non mantiene traccia delle sessioni o delle modifiche sul server). Una volta completata la fase di aggiornamento ed eliminati i messaggi dal server, quest'ultimo non conserva alcuna memoria della transazione o dello stato dei messaggi (es. se sono già stati letti).

___
# Flusso Operativo

```
Client (MUA)                                             Server (MDA/POP3 Server)
   |                                                              |
   |<--------- 1. Connessione TCP stabilita (220 Ready) ----------|
   |                                                              |
   | [FASE 1: AUTORIZZAZIONE]                                     |
   |---------- 2. USER mario@esempio.com ------------------------>|
   |<--------- 3. +OK User accepted ------------------------------|
   |---------- 4. PASS passwordSegreta -------------------------->|
   |<--------- 5. +OK Mailbox unlocked and ready -----------------|
   |                                                              |
   | [FASE 2: TRANSAZIONE]                                        |
   |---------- 6. STAT ------------------------------------------>|
   |<--------- 7. +OK 2 3200 (2 messaggi, 3200 byte) -------------|
   |---------- 8. LIST ------------------------------------------>|
   |<--------- 9. +OK 2 messages (1 1500, 2 1700) ----------------|
   |---------- 10. RETR 1 (Scarica messaggio 1) ----------------->|
   |<--------- 11. +OK [Invia intero messaggio 1...] -------------|
   |---------- 12. DELE 1 (Contrassegna per eliminazione) ------->|
   |<--------- 13. +OK Message 1 marked for deletion -------------|
   |                                                              |
   | [FASE 3: AGGIORNAMENTO]                                      |
   |---------- 14. QUIT ----------------------------------------->|
   |<--------- 15. +OK POP3 server signing off (Rimuove msg 1) ---|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **Connessione** | 1 | Il client apre una sessione TCP sulla porta 110 | Il server si presenta con un banner di benvenuto `+OK` |
| **Autorizzazione** | 2 | Invio di nome utente (`USER`) e password (`PASS`) | Credenziali trasmesse in chiaro in modalità standard |
| **Stato** | 3 | Il client chiede lo stato della casella con il comando `STAT` | Il server risponde con numero totale e peso in byte delle mail |
| **Download** | 4 | Il client scarica il corpo della mail tramite `RETR <numero>` | Operazione ripetuta per ciascun messaggio |
| **Cancellazione** | 5 | Il client richiede l'eliminazione con `DELE <numero>` | Il file viene solo marcato sul server, non ancora rimosso |
| **Aggiornamento** | 6 | Il client chiude la sessione inviando il comando `QUIT` | Il server cancella le mail marcate e chiude la sessione TCP |

___
# Casi D'Uso Reali

- **Risparmio spazio su server**: Ideale per utenti con caselle e-mail fornite da provider che impongono limiti di spazio rigidi sul server.
- **Accesso offline**: Configurazione per scaricare tutta la posta sul computer dell'ufficio per poterla consultare anche senza connessione internet attiva.
- **Client singolo**: Utilizzo su un unico computer fisso dedicato alla gestione e archiviazione locale della posta.

___
# Limitazioni Tecniche

- **Inadatto per multi-dispositivo**: Se leggi le e-mail da smartphone e PC, i messaggi scaricati sul primo dispositivo non saranno visibili sul secondo perché già rimossi dal server.
- **Rischio di perdita dati**: Se il computer locale subisce un guasto o viene smarrito, tutte le e-mail storiche scaricate (e cancellate dal server) vanno perse se non si possiede un backup.
- **Nessuna sincronizzazione cartelle**: Le modifiche locali (es. spostamento in cartelle personalizzate o marcatura come "importante") non vengono replicate sul server.

___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio POP3 (Comandi / Risposte)
- **Incapsulato in**: Segmento TCP (porte 110, 995), a sua volta in pacchetto IP
- **Incapsula**: E-mail testuale e relativi allegati MIME

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header POP3 ] PDU: Messaggio POP3 (Comando/Risposta)
```

___
# Struttura Del Pacchetto

Il protocollo POP3 non prevede un pacchetto binario complesso. Lo scambio dati è composto da righe di testo in formato ASCII terminate dalla sequenza `<CRLF>`.

## Header

A livello di sessione POP3, la comunicazione è basata su righe di testo ASCII terminate da `<CRLF>` (`\r\n`).

### Schema Del Comando POP3 (Client)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Comando (3 o 4 caratteri ASCII, es. USER, RETR)       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Argomenti (opzionali) ...            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...           |     \r        |     \n        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### Schema Della Risposta POP3 (Server)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Stato (+OK / -ERR, 3 o 4 char) | Spazio (0x20) | Messaggio... |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...                                           |   \r   |  \n  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

Il client invia comandi costituiti da parole chiave di 3 o 4 caratteri (es. `STAT`), seguite opzionalmente da argomenti.

## Body
Il server risponde con una riga contenente un indicatore di stato ed un messaggio descrittivo.
- **Indicatori di stato**:
  - `+OK`: Segnala che il comando è stato completato con successo.
  - `-ERR`: Segnala un errore nell'elaborazione del comando (es. credenziali errate).

## Flags
Nel protocollo POP3 non ci sono flag di intestazione. Il controllo avviene tramite lo stato delle e-mail sul server durante la sessione (es. marcatura per cancellazione).

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **110/TCP** | 7 | POP3 | Connessione POP3 standard non protetta (in chiaro) |
| **995/TCP** | 7 | POP3S | POP3 protetto con cifratura implicita SSL/TLS |

___
# Confronto

**POP3 vs IMAP**

| Caratteristica | POP3 | IMAP |
| :--- | :--- | :--- |
| **Modalità** | Scarica ed elimina (default) | Sincronizza e mantiene sul server |
| **Porta sicura** | 995/TCP | 993/TCP |
| **Consumo spazio server** | Minimo (le e-mail vengono rimosse) | Elevato (le e-mail restano sul server) |
| **Velocità iniziale** | Lento all'avvio (deve scaricare l'intero corpo dei messaggi) | Veloce (scarica solo le intestazioni all'avvio) |
| **Stato del messaggio** | Gestito localmente dal client | Gestito e sincronizzato a livello server |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Trasmissione credenziali in chiaro**: La porta standard 110 trasmette sia il comando `USER` che `PASS` in chiaro sulla rete. Qualsiasi sniffing permette la cattura della password.
- **Intercettazione dei dati**: I messaggi e-mail scaricati viaggiano in chiaro sulla rete.

## Attacchi Comuni
- **Sniffing di rete**: Intercettazione delle password e del contenuto dei messaggi su reti Wi-Fi pubbliche non protette.
- **Replay attack**: Cattura della sessione di autorizzazione per riutilizzarla successivamente.

## Contromisure
- **Uso di POP3S**: Configurare il client per connettersi esclusivamente tramite la porta 995/TCP protetta da TLS.
- **APOP**: *Authenticated Post Office Protocol* — Estensione che permette di autenticarsi senza inviare la password in chiaro, utilizzando un hash MD5 basato su una chiave casuale inviata dal server.

___
# Comandi Cisco IOS

Non si configurano servizi POP3 sui dispositivi di rete Cisco. Gli switch e i router non interagiscono con questo protocollo.

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Errore -ERR Authentication Failed** | Username o password errati, o cassetta postale già aperta in un'altra sessione | POP3 permette una sola connessione simultanea per casella. Il server blocca la sessione se è attiva un'altra connessione. |
| **E-mail raddoppiate sul client** | L'opzione "Lascia una copia dei messaggi sul server" è attiva ma il file UIDL locale è corrotto | Il client non ricorda quali messaggi ha già scaricato e riscarica l'intero contenuto. |

**Comandi di verifica**:

```bash
# Aprire una sessione POP3 manuale in chiaro per testare il server
telnet mail.example.com 110

# Aprire una sessione sicura POP3S
openssl s_client -connect mail.example.com:995 -quiet
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo pull per il download locale delle e-mail dal server. |
| **Porte standard** | **110/TCP** (in chiaro), **995/TCP** (cifrato via SSL/TLS). |
| **Fasi** | Autorizzazione (USER/PASS) → Transazione (STAT/RETR/DELE) → Aggiornamento (QUIT). |
| **Rimozione e-mail** | I messaggi marcati con `DELE` vengono eliminati fisicamente dal server solo alla chiusura della sessione (`QUIT`). |
| **Stato delle risposte** | Il server risponde solo con `+OK` (successo) o `-ERR` (errore). |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **POP3 sincronizza le e-mail tra diversi dispositivi** | **FALSO**. POP3 nasce per scaricare e rimuovere i messaggi. Non supporta la sincronizzazione multi-dispositivo né la sincronizzazione delle cartelle personali. |
| **Il comando DELE cancella subito l'e-mail dal server** | **FALSO**. Il comando `DELE` inserisce solo un contrassegno. Se la connessione cade prima del comando `QUIT`, i messaggi non vengono eliminati. |
| **POP3 è una tecnologia push** | **FALSO**. POP3 è un protocollo di tipo **pull** (il client deve effettuare periodicamente un controllo per scaricare la posta). |

___
# Quick Reference Card

```
PORTE:
  110/TCP → Connessione POP3 standard (in chiaro)
  995/TCP → Connessione POP3S (cifrata)

FASI DELLA SESSIONE:
  1. Autorizzazione (User/Pass)
  2. Transazione    (Stat/List/Retr/Dele)
  3. Aggiornamento  (Quit -> eliminazione fisica dal server)

COMANDI PRINCIPALI:
  USER <username>   → Invia nome utente
  PASS <password>   → Invia password
  STAT              → Mostra numero totale messaggi e peso in byte
  LIST              → Elenca l'ID ed il peso di ogni messaggio
  RETR <numero>     → Scarica l'intero messaggio dal server
  DELE <numero>     → Marca il messaggio per l'eliminazione
  RSET              → Annulla le marcature di cancellazione effettuate
  QUIT              → Esegue l'eliminazione e chiude la sessione TCP

RISPOSTE SERVER:
  +OK  → Comando eseguito con successo
  -ERR → Errore durante l'esecuzione del comando
```
___

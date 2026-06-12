Data: 2026-06-08
[Management_And_Remote_Access](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Management_And_Remote_Access
___
# Index
- [[#File Transfer Protocol (FTP)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#La Doppia Connessione TCP]]
	- [[#Modalità Attiva Vs Modalità Passiva]]
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
# _File Transfer Protocol (FTP)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **21/TCP** (controllo), **20/TCP** (dati attiva) |
| **Scopo** | Trasferimento affidabile di file tra un client ed un server in modalità interattiva |
| **RFC / Standard** | RFC 959 (Specifiche originali del protocollo FTP) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) con due canali logici indipendenti |
| **Affidabilità** | **Affidabile** (garantita da TCP per entrambi i canali) |
| **PDU (Unità Dati)** | **Messaggio FTP** (comandi ASCII per controllo) / Segmento dati |
| **Meccanismo di Controllo** | Canale di controllo persistente associato a canali dati dinamici |

___
# Versioni & Evoluzione

Il protocollo FTP, *File Transfer Protocol*, è uno dei protocolli più longevi per la gestione dei file in rete.

| Versione / RFC | Anno | Novità principali |
| :--- | :--- | :--- |
| **RFC 114** | 1971 | Prima versione di FTP definita per la rete ARPANET. Utilizzava connessioni NCP. |
| **RFC 959** | 1985 | Specifiche correnti dello standard. Passaggio a connessioni TCP ed introduzione delle modalità attiva e passiva. |
| **FTPS** (RFC 4217) | 2005 | *FTP Secure*. Estensione di FTP che implementa la crittografia in transito sul canale di controllo e/o dati tramite SSL/TLS. |

___
# Come Funziona

Il protocollo FTP consente il caricamento (*upload*), lo scaricamento (*download*) ed il controllo remoto dei file (creazione directory, rimozione file) su un server remoto. Opera interamente in formato testuale ASCII per il canale dei comandi ed supporta sia dati di testo che binari per il canale di trasferimento.

## La Doppia Connessione TCP
La caratteristica principale di FTP è che separa nettamente la gestione dei comandi dal trasferimento reale dei dati, aprendo due connessioni TCP indipendenti:
- **Connessione di Controllo** (Porta 21/TCP): Viene stabilita inizialmente dal client e rimane aperta per tutta la durata della sessione. Serve per inviare comandi (es. autenticazione, richieste di trasferimento) e ricevere risposte di stato dal server.
- **Connessione Dati** (Porta 20/TCP o dinamica): Viene aperta solo quando è necessario trasferire fisicamente un file o visualizzare l'elenco dei file di una directory. Una volta completato il singolo trasferimento, la connessione dati viene chiusa immediatamente.

## Modalità Attiva Vs Modalità Passiva
La connessione dati può essere configurata in due modi, a seconda di chi avvia la connessione fisica:

### Modalità Attiva (Active Mode)
1. Il client stabilisce la connessione di controllo (porta 21).
2. Il client apre una porta casuale N (in ascolto) ed invia il comando `PORT N` al server tramite la connessione di controllo.
3. Il server avvia una connessione TCP **dalla propria porta 20** verso la porta N indicata dal client per trasferire i dati.
- *Problema*: Se il client si trova dietro un firewall o un router NAT, *Network Address Translation*, la connessione in ingresso proveniente dal server (porta 20) verrà bloccata.

```
Client (Porta N in ascolto)                             Server (Porta 20)
   |                                                              |
   |<============ 1. Connessione dati avviata dal server =========|
```

### Modalità Passiva (Passive Mode)
1. Il client stabilisce la connessione di controllo (porta 21).
2. Il client invia il comando `PASV` al server tramite la connessione di controllo.
3. Il server risponde aprendo una porta casuale P (in ascolto) e ne comunica l'indirizzo ed il numero di porta al client.
4. Il client avvia la connessione TCP **verso la porta P** del server per il canale dati.
- *Vantaggio*: Risolve i problemi di firewall e NAT sul lato client, poiché tutte le connessioni (sia controllo che dati) sono avviate dal client verso l'esterno.

```
Client (Porta casuale)                                  Server (Porta P in ascolto)
   |                                                              |
   |============ 2. Connessione dati avviata dal client =========>|
```

___
# Flusso Operativo

Esempio di sessione FTP in modalità passiva:

```
Client (Host locale)                                      Server (FTP Server)
   |                                                              |
   |-------------- 1. Handshake TCP (Porta 21) ------------------>|
   |<------------- 2. 220 Service Ready (Controllo aperto) -------|
   |                                                              |
   |-------------- 3. USER anonymous ---------------------------->|
   |<------------- 4. 331 User name okay, need password ----------|
   |-------------- 5. PASS guest -------------------------------->|
   |<------------- 6. 230 User logged in -------------------------|
   |                                                              |
   |-------------- 7. PASV (Richiesta porta dati) --------------->|
   |<------------- 8. 227 Entering Passive Mode (IP, Porta P) ----|
   |                                                              |
   |====== 9. Connessione dati TCP aperta dal client verso P =====►|
   |                                                              |
   |-------------- 10. RETR documento.pdf (Richiesta file) ------>|
   |<------------- 11. 150 File status okay; opening data chan ---|
   |<===== 12. Trasferimento file reale sulla connessione dati ===>|
   |<------------- 13. 226 Closing data connection (Successo) -----|
   |                                                              |
   |-------------- 14. QUIT -------------------------------------->|
   |<--------- 15. 221 Goodbye (Connessione controllo chiusa) ----|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **Controllo** | 1 | Apertura della sessione TCP sulla porta 21 | Creazione del canale di controllo |
| **Auth** | 2 | Invio di nome utente (`USER`) e password (`PASS`) | Credenziali trasmesse in chiaro |
| **Passiva** | 3 | Invio comando `PASV` per negoziare la porta dati | Il server risponde con IP e porta P |
| **Dati Open** | 4 | Il client apre la connessione dati TCP verso la porta P del server | Creazione temporanea del canale dati |
| **Comando** | 5 | Il client richiede il download del file con `RETR <nome>` | Comando inviato sul canale di controllo |
| **Invio** | 6 | Il server trasmette il file sul canale dati e chiude la connessione dati al termine | Segnalato da codice `150` all'avvio e `226` al termine |
| **Chiusura** | 7 | Invio del comando `QUIT` | Il server chiude la connessione di controllo |

___
# Casi D'Uso Reali

- **Aggiornamento di siti web**: Caricamento di file HTML e immagini su server web hosting legacy.
- **Distribuzione di software**: Server di download pubblici che consentono l'accesso in modalità anonima per scaricare immagini ISO di sistemi operativi.

___
# Limitazioni Tecniche

- **Incompatibilità con NAT/Firewall (Mod. Attiva)**: Richiede configurazioni speciali o l'uso esclusivo della modalità passiva.
- **Trasmissione credenziali in chiaro**: La sessione di controllo viaggia non cifrata, esponendo ad attacchi di sniffing delle password degli utenti.
- **Uso inefficiente delle risorse**: Richiede l'apertura e chiusura continua di connessioni TCP per ogni singolo file o elenco di directory trasferito.

___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio FTP (Comando / Risposta)
- **Incapsulato in**: Segmento TCP (porte 21, 20 o porte passive), a sua volta in pacchetto IP
- **Incapsula**: File binari o di testo e comandi ASCII

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header FTP ] PDU: Messaggio FTP (Comando/Risposta)
```

___
# Struttura Del Pacchetto

Tutte le comunicazioni sul canale di controllo avvengono tramite righe di testo ASCII terminate da `<CRLF>`.

## Header
I messaggi del canale di controllo presentano una struttura a riga:

### Schema Del Comando FTP (Client)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Comando (3 o 4 caratteri ASCII, es. USER, PASV)      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Parametri (opzionali) ...            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...                                           |   \r   |  \n  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### Schema Della Risposta FTP (Server)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Codice Di Stato (3 cifre ASCII, es. 220, 230)        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Spazio (0x20) |          Messaggio Descrittivo ...            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...                                           |   \r   |  \n  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
Il body sul canale dati contiene l'intero stream di byte del file binario o testuale trasferito senza intestazioni aggiuntive.

## Flags
La transazione viene controllata dai comandi client e dai codici di risposta numerici a 3 cifre del server:
- **1xx (Iniziale)**: L'azione è iniziata, in attesa di conferma (es. `150` = File status okay; opening data connection).
- **2xx (Successo)**: L'azione è stata completata con successo (es. `220` = Service ready, `230` = User logged in).
- **3xx (Intermedio)**: Comando accettato ma in attesa di ulteriori dati (es. `331` = Password required).
- **4xx (Errore Temporaneo)**: Comando non eseguito ma la condizione è transitoria (es. `425` = Can't open data connection).
- **5xx (Errore Permanente)**: Comando fallito in modo permanente (es. `530` = Not logged in, `550` = File not found).

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **21/TCP** | 7 | FTP Controllo | Invio comandi e ricezione risposte di stato |
| **20/TCP** | 7 | FTP Dati | Canale per il trasferimento dei file (solo in modalità attiva) |

___
# Confronto

**FTP vs SFTP vs TFTP**

| Caratteristica | FTP | SFTP | TFTP |
| :--- | :--- | :--- | :--- |
| **Cifratura** | Assente | Presente (cifrato via SSH) | Assente |
| **Porta standard** | 21 / 20 TCP | 22/TCP | 69/UDP |
| **Canali TCP** | 2 (Controllo e Dati) | 1 (Canale unico integrato in SSH) | Nessuno (connessione UDP) |
| **Uso tipico** | Gestione file legacy | Gestione file protetta | Backup firmware switch e boot PXE |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Autenticazione non sicura**: Nome utente e password viaggiano in chiaro sul canale di controllo, facilmente intercettabili tramite sniffing.
- **Vulnerabilità a attacchi di rimbalzo (FTP Bounce)**: Utilizzo del comando `PORT` per indurre il server FTP a effettuare scansioni di porte o connessioni verso altre macchine esterne.

## Attacchi Comuni
- **Sniffing di password**: Cattura delle credenziali sul canale di controllo.
- **Port scanning indiretto**: Utilizzo del server FTP come intermediario per scansionare reti private protette.

## Contromisure
- **Forzare FTPS**: Abilitare l'estensione crittografica SSL/TLS.
- **Passare a SFTP**: Utilizzare il protocollo SFTP integrato in SSH per eliminare la complessità delle due porte e garantire sicurezza nativa.
- **Disabilitare la modalità attiva**: Impedire l'uso di connessioni dati attive per evitare vulnerabilità sul lato server ed agevolare la gestione dei firewall.

___
# Comandi Cisco IOS

Non si installa un server FTP completo per utenti su Cisco IOS, ma è possibile definire le credenziali da utilizzare per fare backup o caricare l'immagine IOS su un server remoto:

```cisco
! Configurare le credenziali FTP predefinite sul router
ip ftp username amministratore
ip ftp password ChiaveSegreta123!

! Copiare la configurazione corrente su un server FTP esterno
copy running-config ftp://192.168.1.100/backup-config.cfg
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Blocco dopo il comando LIST o RETR (Timeout connessione dati)** | Il firewall del client sta bloccando la connessione dati in ingresso (porta 20) in modalità attiva | Il canale di controllo risponde ma il trasferimento dati non si avvia. Soluzione: forzare l'uso della modalità passiva (`PASV`). |
| **Errore 530 Login Incorrect** | Credenziali errate o il server non accetta accessi anonimi | Autenticazione fallita. |

**Comandi di verifica**:

```bash
# Avviare una sessione FTP interattiva da riga di comando
ftp 192.168.1.100

# Verificare la connettività di controllo sulla porta 21
nc -zv 192.168.1.100 21
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo bidirezionale a livello applicazione per il trasferimento di file. |
| **Porte standard** | **21/TCP** (controllo), **20/TCP** (dati in modalità attiva). |
| **Doppio canale** | Controllo e Dati viaggiano su sessioni TCP separate. |
| **Mod. Attiva** | Il server apre la connessione dati (dalla porta 20 a una porta N del client). |
| **Mod. Passiva** | Il client apre la connessione dati (da una porta casuale alla porta P del server). |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **La porta 20 è sempre attiva in tutte le connessioni FTP** | **FALSO**. La porta 20/TCP viene utilizzata dal server solo in modalità **attiva**. In modalità **passiva**, il server si mette in ascolto su una porta casuale e la porta 20 rimane inutilizzata. |
| **FTP e SFTP sono lo stesso protocollo** | **FALSO**. FTP (ed FTPS) è un protocollo a due porte basato su RFC 959. SFTP è un protocollo totalmente diverso integrato in SSHv2 che opera su una singola porta (22/TCP). |

___
# Quick Reference Card

```
PORTE:
  21/TCP → Canale di controllo (comandi)
  20/TCP → Canale dati (in modalità attiva)

MODALITÀ DI CONNESSIONE DATI:
  Attiva  → Client invia "PORT N". Server avvia connessione dati da porta 20 a N.
  Passiva → Client invia "PASV". Server apre porta P. Client avvia connessione a P.

COMANDI PRINCIPALI:
  USER <username>   → Nome utente
  PASS <password>   → Password
  PASV              → Richiede la modalità passiva al server
  PORT <IP,Porta>   → Specifica IP e porta per modalità attiva
  LIST              → Richiede l'elenco dei file della directory
  RETR <file>       → Scarica il file (Retrieve)
  STOR <file>       → Carica il file (Store)
  QUIT              → Chiude la sessione di controllo

RISPOSTE CHIAVE:
  150 → Apertura canale dati avviata
  220 → Server pronto
  226 → Trasferimento completato con successo
  230 → Autenticazione completata con successo
  331 → Password richiesta
  530 → Credenziali non corrette o non valide
```
___
--Gemini

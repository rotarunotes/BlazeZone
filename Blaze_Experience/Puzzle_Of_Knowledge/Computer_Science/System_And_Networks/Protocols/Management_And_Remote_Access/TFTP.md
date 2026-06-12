Data: 2026-06-08
[Management_And_Remote_Access](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Management_And_Remote_Access
___
# Index
- [[#Trivial File Transfer Protocol (TFTP)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Il Meccanismo Stop-And-Wait]]
	- [[#Identificatori Di Trasferimento (TID)]]
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
# _Trivial File Transfer Protocol (TFTP)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **69/UDP** |
| **Scopo** | Trasferimento semplice, leggero e veloce di file di configurazione o firmware senza autenticazione |
| **RFC / Standard** | RFC 1350 (Specifiche correnti di TFTP) |
| **Tipo Connessione** | **Connectionless** (UDP) |
| **Affidabilità** | **Affidabile a livello applicativo** (gestita tramite meccanismo di conferma stop-and-wait) |
| **PDU (Unità Dati)** | **Pacchetto TFTP** (formato binario fisso) |
| **Meccanismo di Controllo** | Attesa della conferma del blocco precedente prima dell'invio del blocco successivo |

___
# Versioni & Evoluzione

Il protocollo TFTP, *Trivial File Transfer Protocol*, è stato progettato per essere estremamente semplice da implementare nella memoria limitata dei dispositivi di rete (*ROM* o *bootloader*).

| Versione / RFC | Anno | Novità principali |
| :--- | :--- | :--- |
| **RFC 783** | 1981 | Specifiche iniziali del protocollo basate su UDP. |
| **RFC 1350** | 1992 | Versione corrente. Corretti problemi nel rilevamento dei pacchetti duplicati e modificato l'algoritmo di gestione degli errori. |
| **RFC 2347** | 1998 | Introduzione delle opzioni di negoziazione (es. modifica della dimensione dei blocchi). |

___
# Come Funziona

TFTP è un protocollo di trasferimento file ridotto all'osso. Non supporta l'autenticazione tramite nome utente e password, non consente la visualizzazione del contenuto delle directory ed supporta solo il caricamento diretto (*write*) ed lo scaricamento (*read*) dei file.

Il protocollo compensa l'uso di UDP, *User Datagram Protocol*, (in affidabile di natura) implementando un meccanismo di controllo dell'integrità a livello applicazione.

## Il Meccanismo Stop-And-Wait
Il trasferimento dei file si sviluppa dividendo il file in blocchi di **dimensione fissa pari a 512 byte**:
1. Il mittente invia il primo blocco da 512 byte contrassegnato con il numero progressivo `1`.
2. Il mittente si ferma ed attende la ricezione di un pacchetto di conferma ACK, *Acknowledgment*, con lo stesso numero progressivo dal destinatario.
3. Se l'ACK non arriva entro un tempo stabilito (timeout), il blocco viene ritrasmesso.
4. All'arrivo dell'ACK valido, il mittente invia il blocco successivo `2`.
- *Fine del trasferimento*: La ricezione di un blocco di dati con una dimensione **inferiore a 512 byte** (incluso un blocco vuoto da 0 byte) indica formalmente la fine del file.

## Identificatori Di Trasferimento (TID)
Sebbene la connessione venga avviata dal client verso la porta standard **69/UDP** del server, le due macchine concordano immediatamente delle porte casuali temporanee chiamate TID, *Transfer Identifier*, per il prosieguo dello scambio dati. Questo consente al server TFTP di gestire molteplici trasferimenti contemporanei svincolando la porta 69.

___
# Flusso Operativo

```
Client                                                   Server (TFTP Server)
  |                                                               |
  |-------------- 1. Richiesta Lettura (RRQ, Porta 69) ---------->|
  |                                                               |
  |      [Server apre porta casuale TID per invio dati]           |
  |                                                               |
  |<------------- 2. Blocco Dati 1 (512 byte, da TID) ------------|
  |                                                               |
  |-------------- 3. Conferma Ricezione (ACK 1, a TID) ---------->|
  |                                                               |
  |<------------- 4. Blocco Dati 2 (512 byte, da TID) ------------|
  |                                                               |
  |-------------- 5. Conferma Ricezione (ACK 2, a TID) ---------->|
  |                                                               |
  |<------------- 6. Blocco Dati 3 (200 byte - Fine File) --------|
  |                                                               |
  |-------------- 7. Conferma Ricezione (ACK 3) ----------------->|
  |                                                               |
  |      [Chiusura trasferimento e disallocazione porte]          |
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **Inizio** | 1 | Il client invia una richiesta di lettura (`RRQ`) o scrittura (`WRQ`) sulla porta UDP 69 | Specifica il nome del file e la modalità (octet/mail/netascii) |
| **Negoziazione** | 2 | Il server risponde da una porta casuale TID inviando il primo blocco di dati | La porta 69 del server viene liberata |
| **Trasmissione** | 3 | Il client riceve il blocco ed invia un `ACK` al server | Utilizzo del meccanismo stop-and-wait |
| **Loop dati** | 4 | Il server invia i blocchi successivi solo dopo aver ricevuto l'ACK di quelli precedenti | Ogni blocco contiene esattamente 512 byte |
| **Termine** | 5 | Il server invia l'ultimo blocco di dati di dimensioni inferiori a 512 byte | Segnale di fine file |
| **Conferma** | 6 | Il client risponde con l'ultimo `ACK` | Chiusura della sessione e rilascio porte |

___
# Casi D'Uso Reali

- **Backup e Ripristino di configurazioni**: Copiare i file di configurazione corrente di router e switch su server di backup in LAN aziendali.
- **Aggiornamento di Firmware e Sistemi Operativi**: Caricare nuove immagini IOS, *Internetwork Operating System*, su dispositivi Cisco o aggiornare il software di telefoni VoIP.
- **Avvio da rete (Boot PXE)**: Trasferimento iniziale del kernel e del bootloader del sistema operativo a macchine prive di disco durante la fase di avvio via scheda di rete (PXE, *Preboot Execution Environment*).

___
# Limitazioni Tecniche

- **Inadatto su reti geografiche (WAN)**: Il meccanismo stop-and-wait richiede un ACK per ogni singolo blocco di 512 byte. In presenza di latenze elevate (WAN), le prestazioni crollano drasticamente.
- **Assenza totale di sicurezza**: I file e i dati transitano in chiaro senza cifratura, ed non è richiesta alcuna credenziale per l'accesso.
- **Soglia limite di dimensione file**: La specifica originale prevedeva un massimo di 65535 blocchi da 512 byte, limitando la dimensione massima dei file a **32 MB** (risolto da estensioni successive).

___
# PDU & Incapsulamento

- **Nome PDU**: Pacchetto TFTP (Data / ACK / RRQ / WRQ / Error)
- **Incapsulato in**: Datagramma UDP (porta 69 o TID), a sua volta in pacchetto IP
- **Incapsula**: File binari o di testo convertiti in blocchi

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header UDP ] PDU: Datagramma
	             L7 [ Header TFTP ] PDU: Pacchetto TFTP (binario)
```

___
# Struttura Del Pacchetto

A differenza dei protocolli web testuali, TFTP utilizza un'intestazione binaria fissa a livello applicativo basata su codici operativi di 2 byte chiamati **Opcode**:
- `1` = Read Request (RRQ)
- `2` = Write Request (WRQ)
- `3` = Data (DATA)
- `4` = Acknowledgment (ACK)
- `5` = Error (ERROR)

## Header

### Schema Del Pacchetto DATA (Opcode 3)
Contiene l'opcode (valore 3), il numero del blocco sequenziale (2 byte) ed il payload di dati:

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|      Opcode (3 = DATA, 2B)    |      Block Number (2B)        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                     Data (0 a 512 byte) ...                   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### Schema Del Pacchetto ACK (Opcode 4)
Contiene l'opcode (valore 4) ed il numero del blocco di cui si conferma la ricezione (2 byte):

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|      Opcode (4 = ACK, 2B)     |      Block Number (2B)        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
- **DATA**: Il corpo contiene esclusivamente i byte grezzi (fino a 512) estratti dal file di origine.
- **RRQ / WRQ**: Il corpo contiene il nome del file in formato ASCII terminato da un byte vuoto (`0x00`), seguito dalla modalità di trasferimento (es. `octet` per file binari).

## Flags
Nel protocollo non esistono flag. La logica di controllo è determinata dall'Opcode e dal corretto allineamento dei numeri di blocco tra client e server.

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **69/UDP** | 7 | TFTP | Richiesta iniziale di lettura o scrittura file |
| **TID (Casuale)** | 7 | TFTP | Porte dinamiche negoziate per lo scambio dati effettivo |

___
# Confronto

**TFTP vs FTP**

| Caratteristica | TFTP | FTP |
| :--- | :--- | :--- |
| **Trasporto** | UDP (porta 69) | TCP (porte 20 / 21) |
| **Autenticazione** | Assente (nessuna password) | Presente (richiede credenziali) |
| **Gestione Directory** | No (solo upload/download cieco) | Sì (creazione, rimozione, elenco file) |
| **Affidabilità** | Gestita a livello applicazione | Nativa di livello trasporto (TCP) |
| **Dimensione codice** | Molto ridotta (ideale per ROM di boot) | Complessa |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Assenza di autenticazione e autorizzazione**: Qualsiasi client che conosce il nome del file può scaricarlo o, peggio, sovrascriverlo sul server se le autorizzazioni di scrittura della cartella lo consentono.
- **Trasmissione in chiaro**: Tutto il traffico dati può essere intercettato tramite sniffing, rivelando le password o le configurazioni sensibili degli apparati.

## Attacchi Comuni
- **File Harvesting**: Tentativi ripetuti di scaricare file di configurazione standard (es. `running-config`) sperando di indovinarne il nome.
- **Sniffing di rete**: Acquisizione di file di backup contenenti chiavi crittografiche o password cifrate dei dispositivi di rete.

## Contromisure
- **Limitare l'uso a reti LAN isolate**: Non esporre mai un server TFTP su interfacce pubbliche o reti WAN.
- **Configurare permessi restrittivi**: Consentire sul server TFTP solo l'accesso in lettura per i file di firmware ed limitare la scrittura a percorsi specifici.
- **Utilizzare ACL**: Permettere l'accesso alla porta 69/UDP solo agli IP registrati dei dispositivi aziendali.

___
# Comandi Cisco IOS

I comandi principali per fare backup o ripristino di file e sistemi operativi tramite TFTP:

```cisco
! Copiare la configurazione attiva (running-config) su un server TFTP
copy running-config tftp://192.168.1.50/switch-back.cfg

! Copiare un file di configurazione da un server TFTP alla configurazione di avvio
copy tftp://192.168.1.50/switch-back.cfg startup-config

! Caricare una nuova immagine del sistema operativo IOS nella memoria flash dello switch
copy tftp://192.168.1.50/c2960-lanbasek9-mz.150-2.SE4.bin flash:
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Errore "Timeout waiting for response" o "Transfer timed out"** | Il server TFTP non è raggiungibile, un firewall blocca UDP 69, o non è permessa la risposta dalle porte casuali TID | La richiesta iniziale si perde o il server non riesce a rispondere a causa del filtraggio delle porte dinamiche. |
| **Errore "Access violation" o "Permission denied"** | Il file sul server ha permessi di sola lettura, oppure la cartella del server TFTP non ha permessi di scrittura per l'utente anonimo | Il server rifiuta la scrittura o il caricamento del file. |

**Comandi di verifica**:

```bash
# Verificare la raggiungibilità della porta 69/UDP sul server
nc -zuv 192.168.1.50 69

# Eseguire un test di download manuale da riga di comando Linux
tftp 192.168.1.50 -c get firmware.bin
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo leggero e non sicuro per il trasferimento file basato su UDP. |
| **Porta standard** | **69/UDP** |
| **Affidabilità** | Gestita via stop-and-wait. Dimensione fissa dei blocchi a 512 byte. |
| **Fine file** | Riconosciuta quando la dimensione di un blocco dati ricevuto è inferiore a 512 byte. |
| **Utilizzo principale** | Backup/ripristino configurazioni Cisco, boot di rete PXE. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **TFTP si appoggia a TCP per garantire che i file arrivino intatti** | **FALSO**. TFTP si appoggia a **UDP** sulla porta 69. L'integrità e l'arrivo corretto dei dati sono gestiti direttamente dal protocollo stesso tramite l'attesa dei pacchetti ACK per ogni singolo blocco. |
| **TFTP consente di sfogliare le cartelle del server con il comando "ls" o "dir"** | **FALSO**. TFTP non ha alcuna interfaccia interattiva per sfogliare file o esplorare directory. L'utente deve conoscere preventivamente l'esatto nome del file per scaricarlo o caricarlo. |

___
# Quick Reference Card

```
PORTA:
  69/UDP → Richiesta iniziale del client (RRQ/WRQ)
  TID    → Porte dinamiche casuali per il trasferimento dati

OPCODES TFTP (2 byte binari):
  1 → Read Request (RRQ)  - Richiesta di lettura
  2 → Write Request (WRQ) - Richiesta di scrittura
  3 → Data (DATA)         - Invio blocco dati (max 512 byte)
  4 → Acknowledgment (ACK)- Conferma ricezione blocco
  5 → Error (ERROR)       - Segnalazione errore trasferimento

LOGICA STOP-AND-WAIT:
  Client invia blocco N -> Aspetta ACK N -> Invia blocco N+1
  Blocco < 512 byte = fine trasferimento

CISCO IOS:
  copy running-config tftp://<IP>/<FILE>  → Salva configurazione su TFTP
  copy tftp://<IP>/<FILE> flash:          → Scarica sistema operativo IOS
```
___
--Gemini

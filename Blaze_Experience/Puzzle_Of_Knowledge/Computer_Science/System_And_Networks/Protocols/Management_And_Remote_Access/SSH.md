Data: 2026-06-08
[Management_And_Remote_Access](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Management_And_Remote_Access
___
# Index
- [[#Secure Shell (SSH)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Fasi Dell'Handshake]]
	- [[#Integrità E Sicurezza]]
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
# _Secure Shell (SSH)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **22/TCP** |
| **Scopo** | Accesso remoto sicuro tramite interfaccia a riga di comando cifrata e trasferimento dati protetto |
| **RFC / Standard** | RFC 4251 (Architettura complessiva di SSHv2) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) con handshake crittografico |
| **Affidabilità** | **Affidabile** (garantita da TCP e verificata dall'integrità HMAC) |
| **PDU (Unità Dati)** | **Pacchetto SSH** (cifrato) |
| **Meccanismo di Controllo** | Autenticazione basata su chiavi asimmetriche ed impostazione di un tunnel simmetrico |

___
# Versioni & Evoluzione

| Versione | Anno | Stato e Note |
| :--- | :--- | :--- |
| **SSHv1** | 1995 | Sviluppato da Tatu Ylönen. Deprecato a causa di vulnerabilità strutturali che consentono l'inserimento di dati nel canale cifrato (*integer overflow*). |
| **SSHv2** (RFC 4251) | 2006 | Versione corrente. Ridisegnato da zero per correggere i limiti di SSHv1. Supporta algoritmi crittografici moderni, Diffie-Hellman per lo scambio chiavi e l'autenticazione tramite certificati. |

___
# Come Funziona

Il protocollo SSH, *Secure Shell*, crea un canale di comunicazione sicuro e cifrato tra due host attraverso una rete non protetta. Consente l'esecuzione di comandi interattivi, il port forwarding sicuro e il trasferimento di file (tramite SFTP, *Secure File Transfer Protocol*).

SSH basa la sua sicurezza su tre pilastri:
1. **Riservatezza** (cifratura): I dati scambiati tra client e server sono cifrati tramite algoritmi simmetrici (come AES) utilizzando una chiave di sessione temporanea.
2. **Autenticità**: Il client verifica l'identità del server tramite le chiavi pubbliche dell'host (*host keys*) per prevenire server fasulli. Il server valida il client tramite credenziali locali o chiavi asimmetriche (RSA, ECDSA).
3. **Integrità**: Il protocollo verifica che i dati non vengano manipolati durante il tragitto tramite HMAC, *Hash-based Message Authentication Code*.

## Fasi Dell'Handshake
Una sessione SSHv2 si instaura seguendo questi passaggi logici:
- **Negoziazione del protocollo**: Client e server si scambiano le versioni di SSH supportate.
- **Scambio delle chiavi** (Key Exchange - KEX): Le parti negoziano gli algoritmi di crittografia. Tramite l'algoritmo DH, *Diffie-Hellman*, generano una chiave simmetrica comune senza trasmetterla sulla rete. Il server firma l'handshake con la sua chiave privata dell'host per provare la sua identità.
- **Autenticazione del client**: Stabilito il tunnel cifrato simmetrico, il client si autentica inviando nome utente e password cifrati, oppure utilizzando una firma asimmetrica generata con la propria chiave privata (corrispondente alla chiave pubblica registrata sul server).
- **Apertura dei canali**: Una volta autenticato, il protocollo attiva il canale per ospitare la sessione interattiva della CLI, *Command Line Interface*.

## Integrità E Sicurezza
Ogni pacchetto inviato nel canale sicuro contiene una firma HMAC calcolata sulla chiave di sessione condivisa, sul numero di sequenza del pacchetto e sui dati del payload. Questo impedisce attacchi di manomissione dei dati o di iniezione di pacchetti estranei.

___
# Flusso Operativo

L'handshake SSHv2 avviene sopra una sessione TCP porta 22 già stabilita:

```
Client                                                          Server
  |                                                               |
  |==================== 1. Connessione TCP ======================>|
  |                                                               |
  |-------------------- 2. Scambio Versione SSH ----------------->|
  |<------------------- 3. Scambio Versione SSH ------------------|
  |                                                               |
  |<=================== 4. Negoziazione Ciphers =================>|
  |      [Scelta di algoritmi per cifratura, KEX e HMAC]          |
  |                                                               |
  |<=================== 5. Scambio Chiavi DH ====================>|
  |      [Generazione chiave simmetrica comune e firma host]      |
  |                                                               |
  |-- 6. Richiesta Autenticazione (User/Pass o Chiave Privata) ->|
  |                                                               |
  |<------------------- 7. 200 OK (Successo) ---------------------|
  |                                                               |
  |<================== 8. Apertura Canale CLI ===================>|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **TCP Connect** | 1 | Apertura della sessione TCP sulla porta 22 | Handshake a tre vie |
| **Version Exchange** | 2 | Invio di stringhe di testo ASCII con la versione SSH supportata | Identificazione del protocollo |
| **KEX Init** | 3 | Negoziazione degli algoritmi di cifratura simmetrica, asimmetrica e di hashing | Scelta delle suite crittografiche |
| **Diffie-Hellman** | 4 | Esecuzione dell'algoritmo DH per concordare la chiave simmetrica di sessione | Generazione del segreto condiviso in modo sicuro |
| **Auth Request** | 5 | Il client richiede l'accesso inviando nome utente ed una password cifrata o una firma digitale | Fase di riconoscimento utente |
| **Channel Open** | 6 | Apertura di un canale logico interattivo per la sessione shell | Inizio delle operazioni utente |

___
# Casi D'Uso Reali

- **Amministrazione remota di dispositivi**: Accesso sicuro alla configurazione di switch, router, server Linux o macchine virtuali su reti pubbliche o private.
- **Port Forwarding (Tunneling)**: Cifratura di protocolli non sicuri (es. database) facendoli transitare all'interno di un canale SSH sicuro.
- **Trasferimento file sicuro**: Utilizzo di SFTP per caricare o scaricare file in modo protetto rispetto al protocollo FTP standard.

___
# Limitazioni Tecniche

- **Sensibilità al ritardo**: Essendo basato su TCP, qualsiasi perdita di pacchetti causa il blocco temporaneo della visualizzazione dei caratteri sulla riga di comando (HOLB a livello di trasporto).
- **Host Key Spoofing iniziale**: Alla prima connessione, il client deve accettare la chiave dell'host del server manualmente (*trust on first use*). Se un attaccante intercetta la primissima connessione, può spacciarsi per il server reale.

___
# PDU & Incapsulamento

- **Nome PDU**: Pacchetto SSH
- **Incapsulato in**: Segmento TCP (porta 22), a sua volta in pacchetto IP
- **Incapsula**: Dati interattivi della CLI o file binari

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header SSH ] PDU: Pacchetto SSH (cifrato)
```

___
# Struttura Del Pacchetto

Un pacchetto SSHv2 a livello di sessione presenta una struttura specifica progettata per nascondere la reale dimensione dei dati trasmessi ed impedire analisi di traffico.

## Header
I campi del record SSHv2:

| Campo | Dimensione | Descrizione |
| :--- | :--- | :--- |
| **Packet Length** | 4 byte | Indica la lunghezza totale del pacchetto in byte (escluso il campo MAC e se stesso) |
| **Padding Length** | 1 byte | Specifica la lunghezza in byte del campo di riempimento (*random padding*) |

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                      Packet Length (4 byte)                   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Padding Len   |                                               |
+-+-+-+-+-+-+-+-+           Payload (variabile)                 |
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Random Padding (variabile)                 |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                  MAC - Message Authentication Code (opzionale)|
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
- **Payload**: I dati reali (comandi inseriti, risposte di testo della shell) cifrati tramite la chiave simmetrica stabilita.
- **Random Padding**: Byte casuali inseriti per fare in modo che la dimensione del blocco cifrato sia un multiplo della dimensione del blocco richiesta dall'algoritmo di cifratura simmetrica.

## Flags
I codici numerici all'inizio del campo payload definiscono il tipo di messaggio (es. `20` = KEXINIT, `21` = KEXDH_REPLY, `50` = USERAUTH_REQUEST, `94` = CHANNEL_DATA).

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **22/TCP** | 7 | SSH | Connessione SSH standard per sessioni interattive e SFTP |
| **23/TCP** | 7 | Telnet | Alternativa non protetta in chiaro |

___
# Confronto

**SSH vs Telnet**

| Caratteristica | SSH | Telnet |
| :--- | :--- | :--- |
| **Sicurezza** | Cifrato (riservatezza, integrità, autenticazione) | In chiaro (vulnerabile ad intercettazioni) |
| **Porta standard** | 22/TCP | 23/TCP |
| **Autenticazione Server** | Sì, tramite chiave dell'host | No |
| **Uso raccomandato** | Obbligatorio su qualsiasi rete | Da evitare sempre (utilizzabile solo in lab isolati) |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Debolezza delle chiavi dell'host**: L'uso di chiavi corte (es. RSA a 1024 bit) o algoritmi deprecati (come SHA-1 per lo scambio chiavi) facilita l'intercettazione.
- **Configurazioni deboli**: Consentire l'accesso diretto all'utente `root` o l'autenticazione con password vuote.

## Attacchi Comuni
- **Brute Force**: Attacchi ripetuti sulle porte 22 esposte a internet per indovinare le credenziali di amministrazione.
- **Man-in-the-Middle (MITM)**: Se l'host key non viene convalidata accuratamente al primo collegamento, un attaccante può intercettare la sessione decifrando i dati.

## Contromisure
- **Disabilitare SSHv1**: Permettere esclusivamente la versione SSHv2 sul server.
- **Autenticazione a chiavi asimmetriche**: Disabilitare l'accesso via password a favore di coppie di chiavi private/pubbliche forti.
- **Cambiare la porta di ascolto**: Spostare la porta SSH (es. su 2222) per evitare scansioni automatiche.
- **Limitazioni d'accesso**: Utilizzare ACL per consentire l'accesso SSH solo da IP di gestione fidati.

___
# Comandi Cisco IOS

Configurazione passaggi obbligatori per attivare SSHv2 su uno switch o router Cisco:

```cisco
! Impostare un hostname univoco (obbligatorio per le chiavi)
hostname SwitchAmministrativo

! Configurare un nome di dominio (obbligatorio per le chiavi)
ip domain-name azienda.local

! Generare la coppia di chiavi RSA (consigliato almeno 2048 bit)
crypto key generate rsa

! Abilitare esplicitamente la versione 2 di SSH
ip ssh version 2

! Configurare parametri di timeout ed autenticazione
ip ssh time-out 60
ip ssh authentication-retries 3

! Creare un utente locale con privilegi amministrativi
username admin privilege 15 secret PasswordComplessa123!

! Configurare le linee virtuali (VTY) per accettare solo SSH
line vty 0 15
 login local
 transport input ssh
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Avviso "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!"** | La chiave pubblica dell'host memorizzata localmente non corrisponde a quella inviata dal server | Indica una potenziale intercettazione MITM o, più comunemente, che il server è stato reinstallato o la sua chiave rigenerata. |
| **Connessione rifiutata (Connection Refused)** | Il servizio SSH non è attivo, le chiavi RSA non sono state generate o il dominio non è configurato | Il dispositivo rifiuta la sessione TCP sulla porta 22. |

**Comandi di verifica**:

```bash
# Connettersi via SSH specificando un utente ed una porta personalizzata
ssh -p 22 admin@192.168.1.1

# Rimuovere una chiave dell'host memorizzata localmente per risolvere l'avviso di cambio chiave
ssh-keygen -R 192.168.1.1

# Verificare lo stato del servizio SSH su uno switch Cisco
show ip ssh
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo sicuro a livello applicazione per l'amministrazione remota via CLI. |
| **Porta standard** | **22/TCP** |
| **Requisiti Cisco** | Richiede un Hostname, un Domain-name, la generazione di chiavi RSA ed un utente locale configurato. |
| **Comando di blocco VTY** | `transport input ssh` impedisce connessioni via Telnet non protette. |
| **Crittografia** | DH per lo scambio chiavi (asimmetrico); AES per la sessione dati (simmetrico); HMAC per l'integrità. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **SSH opera a livello di trasporto** | **FALSO**. SSH è a livello **Applicazione** (OSI 7), anche se si appoggia a TCP. |
| **SSH cifra i dati con la chiave privata del router** | **FALSO**. La chiave privata del router firma solo l'handshake per autenticare il dispositivo. I dati della sessione sono cifrati con una **chiave simmetrica** temporanea generata via Diffie-Hellman. |
| **Per attivare SSH basta scrivere "ip ssh version 2"** | **FALSO**. Se non sono state generate prima le chiavi RSA tramite `crypto key generate rsa`, il comando fallisce poiché non ci sono le basi crittografiche per il protocollo. |

___
# Quick Reference Card

```
PORTA:
  22/TCP → Porta standard SSH

CONFIGURAZIONE CISCO:
  hostname <NOME>
  ip domain-name <DOMINIO>
  crypto key generate rsa (almeno 2048 bit)
  ip ssh version 2
  username <USER> privilege 15 secret <PASS>
  line vty 0 4 -> login local -> transport input ssh

COMANDI VERIFICA CISCO:
  show ip ssh             → Mostra la versione ed i parametri temporali di SSH
  show ssh                → Mostra le sessioni SSH attive sul dispositivo
  show ip ssh connections → Dettagli delle sessioni attive

VERIFICA CLIENT:
  ssh -v <IP>             → Avvia una sessione con dettagli verbosi dell'handshake
```
___
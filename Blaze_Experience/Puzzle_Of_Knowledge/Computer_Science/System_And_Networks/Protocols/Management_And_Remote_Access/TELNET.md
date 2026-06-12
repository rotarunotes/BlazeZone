Data: 2026-06-08
[Management_And_Remote_Access](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Protocols/Management_And_Remote_Access
___
# Index
- [[#Telecommunication Network (Telnet)]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
	- [[#Il Terminale Virtuale Di Rete]]
	- [[#Negoziazione Delle Opzioni]]
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
# _Telecommunication Network (Telnet)_

## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 7 — Applicazione |
| **Porta** | **23/TCP** |
| **Scopo** | Accesso remoto non sicuro basato su testo ad un terminale a riga di comando |
| **RFC / Standard** | RFC 854 (Specifiche del protocollo Telnet) |
| **Tipo Connessione** | **Connection-Oriented** (TCP) |
| **Affidabilità** | **Affidabile** (garantita a livello trasporto da TCP) |
| **PDU (Unità Dati)** | **Carattere / Messaggio Telnet** (in chiaro) |
| **Meccanismo di Controllo** | Scambio di caratteri ASCII e sequenze IAC di controllo opzioni |

___
# Versioni & Evoluzione

Il protocollo Telnet, *Telecommunication Network*, è uno dei protocolli applicativi più vecchi di Internet.

| Versione / RFC | Anno | Stato e Note |
| :--- | :--- | :--- |
| **RFC 97** | 1971 | Prima proposta di Telnet per la rete ARPANET. Gestione base del terminale. |
| **RFC 854** | 1983 | Specifiche correnti dello standard. Definisce il concetto di terminale virtuale di rete (NVT) e la negoziazione delle opzioni. Rimasto sostanzialmente invariato per la sua natura testuale in chiaro. |

___
# Come Funziona

Telnet fornisce una sessione interattiva di terminale a riga di comando tra due host. Consente ad un client di inviare caratteri premuti sulla tastiera locale verso un server remoto, che li elabora restituendo l'output testuale a schermo.

## Il Terminale Virtuale Di Rete
Per far comunicare sistemi operativi diversi con tastiere ed interfacce differenti, Telnet definisce un NVT, *Network Virtual Terminal*.
- L'NVT è una tastiera virtuale ed una stampante virtuale immaginaria standardizzata.
- Il client traduce i caratteri e le scorciatoie della macchina locale nel formato standard NVT prima di inviarli sulla rete.
- Il server riceve il formato NVT e lo traduce nel formato nativo della propria macchina.

## Negoziazione Delle Opzioni
Telnet supporta l'attivazione di funzionalità aggiuntive (es. echo dei caratteri, dimensione dello schermo) tramite una negoziazione simmetrica basata su quattro comandi chiave:
- `WILL`: Il mittente propone di attivare un'opzione.
- `WONT`: Il mittente si rifiuta di attivare o disattivare un'opzione.
- `DO`: Richiesta al ricevente di attivare un'opzione.
- `DONT`: Richiesta al ricevente di disattivare un'opzione.

La sessione standard avviene interamente **in chiaro**. Qualsiasi pacchetto catturato lungo la rete conterrà i tasti premuti (inclusi nome utente e password) leggibili direttamente in testo ASCII.

___
# Flusso Operativo

Una sessione Telnet avviene instaurando una connessione TCP sulla porta 23:

```
Client (Host locale)                                      Server (Dispositivo remoto)
   |                                                              |
   |-------------- 1. Handshake TCP (Porta 23) ------------------>|
   |<------------- 2. Connessione Accettata ----------------------|
   |                                                              |
   |<------------- 3. Richiesta Credenziali (User: ) -------------|
   |                                                              |
   |-------------- 4. Invio Credenziali (In chiaro) ------------->|
   |                                                              |
   |<------------- 5. Risposta Login OK e Prompt CLI -------------|
   |                                                              |
   |<============= 6. Sessione Interattiva (In chiaro) ==========>|
```

| Fase | # | Azione | Note |
| :--- | :--- | :--- | :--- |
| **Connessione** | 1 | Il client avvia una connessione TCP verso il server sulla porta 23 | Creazione del canale di trasporto |
| **Opzioni** | 2 | Negoziazione iniziale dei parametri terminale tramite sequenze IAC | Scambio di comandi WILL/DO |
| **Auth** | 3 | Il server richiede l'inserimento di nome utente e password | Dati trasmessi byte per byte in chiaro |
| **Sessione** | 4 | Il client inserisce comandi ed il server rimanda l'echo dei caratteri a schermo | Interfaccia interattiva CLI, *Command Line Interface* |
| **Chiusura** | 5 | Chiusura della connessione TCP tramite comando `exit` o disconnessione fisica | Rimozione del canale logico |

___
# Casi D'Uso Reali

- **Laboratori di prova (Sandbox)**: Configurazione rapida all'interno di emulatori (es. GNS3, Cisco Packet Tracer) in ambienti protetti non connessi ad Internet.
- **Troubleshooting di porta**: Testare la raggiungibilità e l'apertura di una determinata porta TCP su un server inviando una richiesta Telnet a quella porta (es. `telnet 192.168.1.1 80`).

___
# Limitazioni Tecniche

- **Assenza totale di sicurezza**: Le credenziali ed i dati viaggiano in chiaro. Qualsiasi utente sulla stessa rete locale (es. tramite ARP spoofing) può intercettare la sessione ed ottenere i privilegi amministrativi.
- **Nessuna verifica di identità**: Non esiste un meccanismo per verificare che il server a cui ci si connette sia legittimo (assenza di host key).

___
# PDU & Incapsulamento

- **Nome PDU**: Carattere / Messaggio Telnet
- **Incapsulato in**: Segmento TCP (porta 23), a sua volta in pacchetto IP
- **Incapsula**: Caratteri ASCII della digitazione utente

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header TCP ] PDU: Segmento
	             L7 [ Header Telnet ] PDU: Messaggio Telnet (in chiaro)
```

___
# Struttura Del Pacchetto

Un messaggio Telnet è tipicamente costituito da singoli byte di caratteri digitati. I comandi di controllo iniziano sempre con il byte speciale IAC, *Interpret As Command*.

## Header
La struttura di un comando di controllo Telnet ha una dimensione minima di **2 o 3 byte**:

| Campo | Dimensione | Descrizione |
| :--- | :--- | :--- |
| **IAC** | 1 byte | Byte di avviso fisso impostato a `255` (in esadecimale `0xFF`) |
| **Comando** | 1 byte | Il comando di controllo da eseguire (es. `251`=WILL, `252`=WONT, `253`=DO, `254`=DONT) |
| **Opzione** | 1 byte | L'opzione specifica oggetto della negoziazione (es. `1` per echo dei caratteri) |

```
 0                   1                   2
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|   IAC (255)   |   Comando (DO/WILL, 251-254)  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Opzione (opzionale, es. 1 per Echo)           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
Il body del pacchetto contiene i caratteri digitati dall'utente o restituiti in formato testuale dal server (codifica ASCII standard).

## Flags
Nel protocollo non ci sono flag di pacchetto. Le opzioni sono gestite dinamicamente tramite lo scambio di sequenze di controllo IAC.

___
# Porte E Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| :--- | :---: | :--- | :--- |
| **23/TCP** | 7 | Telnet | Sessione remota standard in chiaro |
| **22/TCP** | 7 | SSH | Alternativa sicura cifrata standard |

___
# Confronto

**Telnet vs SSH**

| Caratteristica | Telnet | SSH |
| :--- | :--- | :--- |
| **Cifratura** | Assente (in chiaro) | Presente (crittografia ibrida forte) |
| **Porta di default** | 23/TCP | 22/TCP |
| **Autenticazione Server** | Nessuna | Tramite chiave pubblica dell'host |
| **Uso in produzione** | Assolutamente vietato | Obbligatorio |

___
# Aspetti Di Sicurezza

## Vulnerabilità Note
- **Sniffing passivo**: Qualsiasi computer sulla rete locale in modalità promiscua può acquisire il traffico catturando in pochi secondi le password digitate (es. tramite strumenti come Wireshark).

## Attacchi Comuni
- **Man-in-the-Middle (MITM)**: Intercettazione e manipolazione delle sessioni di configurazione del router in tempo reale.
- **Password Sniffing**: Acquisizione delle credenziali degli apparati di rete centrali.

## Contromisure
- **Disabilitazione del servizio**: Disattivare Telnet su tutti gli apparati di rete e server.
- **Filtrare gli accessi**: Se Telnet è temporaneamente necessario in ambienti legacy isolati, limitare l'accesso tramite ACL, *Access Control List*, solo agli IP degli host di amministrazione.
- **Utilizzare SSH**: Sostituire interamente Telnet con SSHv2.

___
# Comandi Cisco IOS

Configurazione per abilitare Telnet (da evitare in produzione, solo a scopo didattico) su uno switch o router Cisco:

```cisco
! Impostare una password locale di abilitazione (enable)
enable secret PasswordAbilitazione

! Creare un utente locale nel database del dispositivo
username admin privilege 15 secret PasswordAmministratore

! Configurare le linee virtuali (VTY) per accettare Telnet
line vty 0 15
 login local
 transport input telnet
```

Per disabilitare del tutto Telnet e consentire solo SSH:

```cisco
line vty 0 15
 transport input ssh
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| :--- | :--- | :--- |
| **Connessione rifiutata (Connection Refused)** | Il server non ha il servizio Telnet attivo o una ACL blocca la porta 23 | La sessione TCP non viene stabilita. |
| **Chiusura immediata dopo connessione (Connection closed by foreign host)** | Vengono accettate connessioni TCP ma il VTY non ha una password configurata | Per sicurezza, Cisco IOS rifiuta l'accesso se le linee virtuali non hanno una password o non è impostato `login local`. |

**Comandi di verifica**:

```bash
# Avviare una connessione Telnet da prompt dei comandi verso un indirizzo IP
telnet 192.168.1.1

# Testare se la porta 23 è in ascolto su un host remoto
nc -zv 192.168.1.1 23
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Protocollo non protetto a livello applicazione per l'amministrazione remota. |
| **Porta standard** | **23/TCP** |
| **Insicurezza** | Trasmette dati e credenziali in chiaro. Vulnerabile a sniffing. |
| **Comando di disattivazione** | `transport input ssh` applicato sulle linee VTY disabilita implicitamente Telnet. |
| **Comando IAC** | Byte speciale `255` utilizzato per indicare comandi di controllo negoziazione opzioni. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Telnet supporta la crittografia se si usa una password forte** | **FALSO**. Anche se la password creata sul router è complessa, il protocollo Telnet non applica alcuna crittografia in transito; le credenziali viaggeranno in chiaro sulla rete. |
| **Telnet è utilizzabile in sicurezza su reti WAN esterne** | **FALSO**. Telnet non deve mai essere usato al di fuori di laboratori isolati. Sulle reti esterne è obbligatorio l'uso di SSH. |

___
# Quick Reference Card

```
PORTA:
  23/TCP → Porta standard Telnet

CONFIGURAZIONE CISCO:
  line vty 0 4
   login local (o login bypassando utenti con password semplice)
   password cisco
   transport input telnet

DISATTIVAZIONE CISCO (RACCOMANDATA):
  line vty 0 15
   transport input ssh  → Esclude Telnet ed abilita solo SSH

COMANDI NEGOZIAZIONE OPZIONI (IAC):
  WILL (251) → Propone l'opzione
  WONT (252) → Rifiuta l'opzione
  DO   (253) → Richiede opzione all'altro host
  DONT (254) → Richiede la disattivazione dell'opzione
```
___
--Gemini

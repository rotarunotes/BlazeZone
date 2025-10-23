Data: 2025-10-22
[Network_Protocols](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Network_Protocols
___
# Dynamic Host Configuration Protocol

Il **DHCP** è il principale protocollo per la configurazione **automatica** degli host su una rete IP.
## Obiettivo  
Permettere a un server di assegnare **dinamicamente**:
- Indirizzi IP
- Subnet mask
- Gateway
- DNS
- Altri parametri di rete

Le assegnazioni sono temporanee, regolate da un periodo chiamato **lease (affitto)**.

---
# Storia: L'eredità di BOOTP

DHCP è un’evoluzione del protocollo **BOOTP** (Bootstrap Protocol).
## BOOTP:
- Creato per configurare automaticamente una macchina client durante il bootstrap **(processo di avvio di un computer)**. specialmente terminali diskless **(non può avviarsi né memorizzare dati da solo**.**)
- BOOTP **forniva** al client:
	1) Indirizzo IP
	2) Il gateway
	3) Indirizzo del server da cui scaricare il sistema operativo.
## Porte utilizzate:
- UDP 67 → Server
- UDP 68 → Client

**Limiti di BOOTP**:
- Nessuna gestione dinamica degli IP
- Non adatto a dispositivi mobili (es. Wi-Fi)
___

# Cosa fornisce un server DHCP?
- Indirizzo IP
- Subnet Mask
- Default Gateway
- DNS Server
- Lease Time
- Altri parametri opzionali

---
# Modalità di Assegnazione

Il server DHCP può assegnare IP in tre modalità:

| Modalità   | Descrizione                                                                                                                                              | Esempi                                                                                                                                                     |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Manuale    | Assegnazione statica tramite reservation è un modo per dire al  server DHCP di dare sempre lo stesso indirizzo IP a un dispositivo specifico. (IP - MAC) | Dispositivi che devono essere sempre raggiungibili allo **stesso** indirizzo IP. (stampante di rete )                                                      |
| Automatica | IP assegnato **permanentemente** la prima volta, preso da un pool                                                                                        | Reti piccole e stabili (es. ufficio) dove i dispositivi non cambiano spesso, ma non si vuole configurare ogni IP manualmente. (Modalità poco comune oggi). |
| Dinamica   | IP assegnato **temporaneamente** (lease); il client deve rinnovare                                                                                       | Una rete **Wi-Fi pubblica** (bar, aeroporto) o la rete di casa, dove smartphone e laptop si connettono e disconnettono frequentemente.                     |

Modalità più comune: Dinamica

---
# Vantaggi del DHCP

1) Gestione centralizzata degli indirizzi IP  
2) Configurazione automatica dei dispositivi  
3) Riduzione degli errori umani  
4) Supporto a reti dinamiche (es. Wi-Fi pubbliche)  
5) Scalabilità per grandi reti  

---
# Architettura e Funzionamento
## Architettura Client/Server

- Il client invia una richiesta in broadcast per scoprire un server DHCP
- Il server DHCP risponde con un’offerta
- Il client sceglie una delle offerte (se ce ne sono più di una) e invia una richiesta di conferma
- Il server conferma l’assegnazione con un messaggio di **ACK (Acknowledgment)**
- Il client configura il proprio indirizzo IP e gli altri parametri di rete ricevuti
## Server Multipli e DHCP Relay Agent

In reti suddivise in subnet, i router non inoltrano i broadcast, quindi le richieste DHCP iniziali non raggiungono i server.
### Soluzioni:
- **Server Multipli**
	- **Ridondanza** : Se un server DHCP si guasta o diventa irraggiungibile, gli altri server DHCP possono continuare a rispondere alle richieste dei client, evitando che i dispositivi restino senza configurazione IP. 
	- **Bilanciamento** : Con più server DHCP, le richieste di indirizzo IP possono essere distribuite tra i vari server, così nessuno viene sovraccaricato. 
- **DHCP Relay Agent**: intercetta le richieste broadcast DHCPDISCOVER nella subnet locale e le inoltra al server DHCP remoto usando un pacchetto unicast.

Spesso è integrato nei router o switch layer 3.

---
# Nota sul Mobile IP

Esiste un protocollo chiamato Mobile IP, pensato per mantenere lo stesso indirizzo IP anche quando l’host cambia rete.

A differenza di DHCP:
- DHCP assegna un nuovo IP in ogni rete
- Mobile IP cerca di mantenere l’IP fisso per non interrompere connessioni TCP attive

---

I messaggi DHCP viaggiano su UDP e sono formati da:
## Header

| Campo          | Descrizione                                                             |
| -------------- | ----------------------------------------------------------------------- |
| Operation Code | 1 = Request (dal client), 2 = Reply (dal server)                        |
| Hardware Type  | Tipo di rete (1 = Ethernet)                                             |
| HW Addr Length | Lunghezza indirizzo MAC (di solito 6 byte)                              |
| Hops           | Usato dal Relay Agent; incrementato a ogni salto                        |
| Transaction ID | ID generato dal client per associare richieste e risposte               |
| Seconds        | Tempo passato dalla richiesta (usato per priorità e rinnovo)            |
| Flags          | Include il Broadcast flag (se il client non ha IP per ricevere unicast) |

---
## Campi Aggiuntivi e Opzioni

Oltre all’header, ci sono altri campi:

| Campo         | Descrizione                                                             |
|---------------|-------------------------------------------------------------------------|
| yiaddr        | IP offerto o assegnato al client (Your IP Address)                     |
| giaddr        | IP del Relay Agent, se presente                                        |
| Directory     | Campo ereditato da BOOTP (usato per il boot da rete)                   |
| Filename      | Nome del file da scaricare (se boot da rete)                           |

---
## Opzioni DHCP (Vendor-Specific)

Sono un campo flessibile nei messaggi DHCP che permette di includere vari parametri aggiuntivi necessari per configurare **correttamente** un dispositivo in rete. Tra questi ci sono:

- Il tipo di messaggio DHCP (es. DISCOVER, OFFER, REQUEST, ACK)
- Parametri fondamentali come subnet mask, gateway predefinito, server DNS
- Durata del lease (lease time) e tempi di rinnovo (T1) e rebind (T2)
- Parametri personalizzati, specifici per ambienti aziendali o particolari dispositivi

In pratica, le opzioni DHCP consentono di fornire tutte le informazioni di **configurazione** di rete in modo **flessibile** e adattabile alle diverse necessità.

---
# Sequenza del Processo DHCP (7 Fasi)

1) **DHCPDISCOVER** (Broadcast)
   Il client invia un messaggio per cercare un server DHCP disponibile.

2) **DHCPOFFER**  
   Uno o più server DHCP rispondono con una proposta di configurazione IP.

3) **DHCPREQUEST**  (Broadcast)
   Il client accetta una delle offerte e invia una richiesta al server scelto.

4) **DHCPACK**  
   Il server conferma l’assegnazione e il client può usare l’indirizzo IP.

5) **DHCPNAK** (Broadcast)
   Se il server rifiuta la richiesta (es. perché l’IP non è più disponibile), invia un messaggio di rifiuto.

6) **DHCPRELEASE**  
   Il client rilascia l’indirizzo IP prima della scadenza del lease.

7) **DHCPINFORM**  
   Usato da client già configurati manualmente per ottenere solo parametri opzionali (es. DNS, gateway).

---
# Riepilogo

- DHCP assegna dinamicamente indirizzi IP e parametri di rete
- Utilizza UDP (porte 67 server / 68 client)
- Supporta tre modalità: Manuale, Automatica, Dinamica
- Utilizza messaggi come DISCOVER, OFFER, REQUEST, ACK
- Richiede relay agent in reti a più subnet
- Sostituisce BOOTP e semplifica la gestione IP
- Complementare (ma differente) da Mobile IP

---
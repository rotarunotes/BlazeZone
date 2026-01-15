Data: 2026-01-15
[Networking](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Network_Protocols
___
Video: "Nessun video utilizzato"
# Index
- [[#Simple Network Management Protocol (SNMP)]]
- [[#Componenti Principali dell'Architettura]]
- [[#Subagent e Managed Component]]
- [[#Management Information Base (MIB)]]
- [[#Master Agent]]
- [[#SNMP Network Manager]]
- [[#Gestione degli Eventi e Trap]]
- [[#Messaggi e PDU]]
- [[#Sicurezza nelle versioni SNMP]]

---
# Simple Network Management Protocol 

L'**SNMP** è un protocollo utilizzato per raccogliere e organizzare **informazioni** dai dispositivi di rete con lo scopo di modificare il loro comportamento.

Funziona secondo un modello **manager/agent** (simile al client/server) dove i dati sono strutturati in un database chiamato **MIB**, che descrive lo stato e la configurazione della rete.

L'`SNMP` **permette**:
- La raccolta di informazioni sullo **stato** della rete.
- La configurazione **remota** dei dispositivi. 
- L'interrogazione e la **manipolazione** dei dati tramite applicazioni di gestione.
  
---
# Componenti Principali dell'Architettura

L'architettura `SNMP` si basa sull'interazione questi elementi fondamentali:
1) **Managed components**: è il dispositivo da monitorare
2) **Subagents**: Il software, installato su ogni Managed components, che permette di raccogliere i dati tecnici.
3) **Management Information Bases (MIB)**: Il database gerarchico che descrive lo stato e la configurazione dei Managed components.
4) **SNMP Network Managers**: Il software che interroga gli agenti per ottenere statistiche e controllo.
5) **Master Agents**: L'interfaccia software tra il manager e i subagent.
## Subagent e Managed Component
Il **subagent** è il software installato sul dispositivo di rete che fornisce le informazioni specifiche del dispositivo al master agent.
### Caratteristiche principali:
- **Specificità:** Un singolo dispositivo può avere più subagent, ognuno dedicato a un componente (es. uno per la CPU, uno per la memoria, uno per la temperatura).
- **Feedback:** Notifica il master agent in caso di richieste non disponibili o invalide.
- **Managed Component:** È l'hardware o software fisico (router, switch, server, stampante) che ospita i subagent.
## Management Information Base (MIB)
Il **MIB** è un database strutturato gerarchicamente in cui vengono archiviati gli OID (Object IDentifer) degli oggetti del dispositivo.
### Struttura e Tipologie:
- **Standard di settore:** Oggetti **comuni** a tutti i produttori.
- **Proprietari (Vendor MIB):** Oggetti **specifici** definiti dal produttore del dispositivo.
#### Esempio di Gerarchia (SNMPv2-MIB):

![[OID_SNMP|600]]

## SNMP Network Manager
Il **Network Manager** è il software utilizzato dall'amministratore per interrogare i master agent e supervisionare la rete che chiede le informazioni ai master agent.
Il software ti permette di:
- **Monitoraggio**: Controllo remoto dei dispositivi.
- **Misurazione**: Registra le informazioni campionando  dispositivi.
- **Statistiche**: Fornisce statistiche riguardanti i dispositivi e la rete, con tramite grafici.

`SNMP` Utilizza il protocollo **UDP** per minimizzare l'occupazione di banda ed è possibile avere più di un **manager**.

L' accesso al **subagent** può essere **unidirezionale** (sola lettura/monitoraggio) o **bidirezionale** (gestione/configurazione).
## Master Agent
Il **master agent** è il software che fornisce una interfaccia tra il Network Manager e i vari subagent locali.

È installato sul dispositivo da monitorare e gestisce la comunicazione tra manager e più software subagent responsabili dei **MIB**.

Il master agent è indispensabile se si vuole monitorare e gestire il componente
### Task principali:
1) **Inoltro richieste**: Formatta le richieste del Manager e le invia ai subagent.
2) **Inoltro risposte**: Raccoglie i dati dai subagent, li formatta e li invia al Manager.
3) **Gestione errori**: Informa il Network Manager di richieste non valide o non disponibili.

![[Funzionamento_Generale_SNMP|600]]

---
# Gestione degli Eventi e Trap

Il sistema `SNMP` non è solo passivo (interrogazione); può reagire ad eventi critici.
- **Polling**: Il Network Manager interroga periodicamente (**un tantum**) i dispositivi per accumulare dati statistici.
- **Trap**: Evento straordinario inviato dal subagent al Network Manager sotto determinate condizioni preconfigurate.
	- **Diagnostica**: Dopo una trap, il manager può interrogare specificamente il componente per determinare la causa del problema.

---
# Messaggi e PDU

La comunicazione tra Network Manager e Master Agent avviene tramite **PDU (Protocol Data Units)** trasportate su **UDP**:
- Porta 161 per richieste/risposte
- Porta 162 per notifiche/trap
## Header

| IP Header | UDP Header | version | community | PDU-Type | request-id | error-status | error-<br>index | variable<br>bindings |
| --------- | ---------- | ------- | --------- | -------- | ---------- | ------------ | --------------- | -------------------- |

| **Versione** | **PDU Principali** | **Funzione**                                                                                                          |
| :----------- | :----------------- | :-------------------------------------------------------------------------------------------------------------------- |
| **v1**       |                    |                                                                                                                       |
|              | **GetRequest**     | ll manager chiede i dati all'agent, i dati sono specificati nel variable bindings                                     |
|              | **SetRequest**     | Il manager chiede di modificare il valore dei dati specificati nel body                                               |
|              | **GetNextRequest** | Scansione (discovery) dei MIB                                                                                         |
|              | **Response**       | La risposta alle richieste da parte del manager                                                                       |
|              | **Trap**           | Notifica asincrona dall'agente verso il manager                                                                       |
| **v2**       |                    |                                                                                                                       |
|              | **GetBulkRequest** | Versione più ottimizzata del GetNextRequest                                                                           |
|              | **InformRequest**  | Trap che richiede conferma di ricezione del manager, che successivamente il risponderà obbligatoriamente con un (ACK) |
|              | **SNMPv2-Trap**    | Trap è stato rinominato così                                                                                          |
| **v3**       |                    |                                                                                                                       |
|              | **ReportPDU**      | Utilizzato per segnalare problemi rilevati                                                                            |

---
# Sicurezza nelle versioni SNMP

La sicurezza è evoluta drasticamente per prevenire attacchi da configurazioni errate.
1) SNMPv1: Password (community string) inviate in chiaro.
2) SNMPv2: Introduzione dell'hashing delle password.
3) SNMPv3: Livello di sicurezza elevato con algoritmi di autenticazione e cifratura come SHA e DES4
---
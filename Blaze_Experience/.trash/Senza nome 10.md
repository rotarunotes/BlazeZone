Markdown

Data: 2026-04-24
[Application_Layer](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Application_Layer
___
# Index
- [[#Dynamic Host Configuration Protocol (DHCP)]]
    - [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
- [[#Flusso Operativo]]
- [[#Casi d'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
    - [[#Header]]
    - [[#Body]]
    - [[#Flags]]
- [[#Porte e Protocolli Correlati]]
- [[#Confronto]]
- [[#Aspetti di Sicurezza]]
    - [[#Vulnerabilità Note]]
    - [[#Attacchi Comuni]]
    - [[#Contromisure]]
- [[#Comandi Cisco IOS]]
- [[#Troubleshooting]]
- [[#Note Esame]]
    - [[#Da sapere a memoria]]
    - [[#Trabocchetti frequenti]]
___
# Dynamic Host Configuration Protocol (DHCP)
## Panoramica

| Caratteristica              | Dettaglio |
| --------------------------- | :-------: |
| **Livello OSI** | 7 — Applicazione |
| **Scopo** | Assegnazione dinamica e automatizzata di indirizzi IP e parametri di configurazione di rete (subnet mask, gateway, DNS). |
| **RFC / Standard** | RFC 2131 (DHCPv4), RFC 8415 (DHCPv6) |
| **Tipo Connessione** | **Connectionless** (utilizza UDP come protocollo di trasporto) |
| **Affidabilità** | **Gestita a livello applicativo** tramite timer e ritrasmissioni in caso di mancata risposta (poiché UDP è inaffidabile). |
| **PDU (Unità Dati)** | Messaggio DHCP (DHCP Message) |
| **Meccanismo di Controllo** | Meccanismo basato su lease time (scadenza del prestito dell'IP) e rinnovi periodici. |
___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
|----------|------|-------------------|
| BOOTP (RFC 951) | 1985 | Predecessore di DHCP, assegnava IP statici basati su MAC address senza meccanismo di scadenza (lease). |
| DHCPv4 (RFC 1531 / 2131) | 1993/1997 | Introdotto il concetto di "Lease", assegnazione dinamica da un pool, e fornitura di parametri extra (Opzioni DHCP). |
| DHCPv6 (RFC 3315 / 8415) | 2003/2018 | Versione per IPv6. Utilizza multicast invece di broadcast e si integra strettamente con SLAAC e ICMPv6. |
___
# Come Funziona

Il meccanismo core di DHCP si basa sul processo **DORA** (Discover, Offer, Request, Acknowledge), uno scambio a quattro vie tra client e server:
1. **Discover**: Il client, non avendo un IP, invia un messaggio di broadcast sulla rete locale cercando un server DHCP disponibile.
2. **Offer**: I server DHCP che ricevono la richiesta rispondono proponendo un indirizzo IP, una durata di lease e altri parametri di rete.
3. **Request**: Il client sceglie un'offerta (solitamente la prima ricevuta) e invia un broadcast per notificare formalmente a tutti i server l'accettazione di quella specifica offerta (liberando gli IP proposti dagli altri server).
4. **Acknowledge**: Il server selezionato conferma l'assegnazione finale inviando un ACK al client, che applica i parametri alla sua interfaccia di rete.
___
# Flusso Operativo

```

Client (0.0.0.0) Server DHCP (IP noto o in ascolto)

| |

1)|------ [DHCP DISCOVER] ------>| (Broadcast MAC e IP destinazione 255.255.255.255)

| |

2)|<------- [DHCP OFFER] --------| (Propone un IP, Unicast/Broadcast a seconda del flag)

| |

3)|------ [DHCP REQUEST] ------->| (Conferma scelta, in Broadcast per informare tutti)

| |

4)|<-------- [DHCP ACK] ---------| (Conferma definitiva e parametri extra completi)

| |

```

| Fase         | \#  | Azione | Stato Client | Stato Server | Note |
| ------------ | --- | ------ | ------------ | ------------ | ---- |
| **Apertura** | 1   | Il client invia il DHCP DISCOVER | INIT | ASCOLTO | Sorgente IP 0.0.0.0, Destinazione 255.255.255.255. Porta dest: 67 |
|              | 2   | Il server riserva un IP e invia DHCP OFFER | SELECTING | OFFERED | L'offerta contiene IP, Subnet, Lease Time. Porta dest: 68 |
|              | 3   | Il client invia DHCP REQUEST per l'IP scelto | REQUESTING | OFFERED | Ancora broadcast, include il Server Identifier dell'eletto. |
| **Dati** | 4   | Il server conferma con DHCP ACK | BOUND | BOUND | Il client è ora configurato e può comunicare in rete. |
| **Rinnovo** | 5   | Raggiunto il 50% del lease (T1), invia REQUEST | RENEWING | BOUND | Comunicazione Unicast verso il server che ha fornito l'IP. |
|              | 6   | Server estende il tempo e invia ACK | BOUND | BOUND | Il timer di lease viene azzerato sul client. |
| **Chiusura** | 7   | Se il client si spegne/disconnette (opzionale) | INIT | RELEASED | Invia DHCP RELEASE per liberare subito l'IP. |
|              | 8   | Il server reinserisce l'IP nel pool | - | DISPONIBILE | L'IP può essere assegnato a un nuovo client. |
___
# Casi d'Uso Reali

- **Esempio 1**: (Reti Aziendali) I dispositivi end-user (PC, smartphone) ottengono automaticamente non solo l'IP, ma anche l'indirizzo del gateway aziendale e i server DNS interni, riducendo drasticamente il carico amministrativo.
- **Esempio 2**: (Hotspot Wi-Fi Pubblici) In un bar o aeroporto, il DHCP assegna IP con lease time molto brevi (es. 1-2 ore) per garantire che il pool di indirizzi non si esaurisca con il continuo ricambio di clienti.
- **Esempio 3**: (Ambienti Cloud / Virtualizzazione) Durante il provisioning di nuove macchine virtuali, il DHCP assegna indirizzi IP iniziali permettendo script di automazione (es. cloud-init) di connettersi alla rete e completare il setup.
___
# Limitazioni Tecniche

- **Dipendenza dal Broadcast L2**: I messaggi di Discover sono limitati al dominio di broadcast locale. Per servire sottoreti diverse, è necessario un "DHCP Relay Agent" (IP Helper) sul router.
- **Assenza di Autenticazione Nativa**: Qualsiasi server sulla rete può rispondere a un DHCP Discover, permettendo l'assegnazione di parametri compromessi.
- **Singolo Point of Failure (SPOF)**: Se l'unico server DHCP fallisce e i lease scadono, i client perdono l'accesso alla rete. (Risolvibile con configurazioni di Failover/High Availability).
___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio DHCP (DHCP Message)
- **Incapsulato in**: Datagramma UDP
- **Incapsula**: Dati Applicativi e Opzioni DHCP (TLVs)

```

[ Header Ethernet / Frame L2 ]

[ Header IP (L3) ]

[ Header UDP (L4) ]

[ Payload / Dati : Messaggio DHCP ]

````
___
# Struttura Del Pacchetto
## Header

| Campo | Dimensione | Descrizione |
| ----- | ---------- | ----------- |
| **Opcode (op)** | 1 byte | Tipo di messaggio: 1 = Request (Client to Server), 2 = Reply (Server to Client). |
| **HTYPE (htype)** | 1 byte | Tipo di hardware (es. 1 = Ethernet). |
| **HLEN (hlen)** | 1 byte | Lunghezza dell'indirizzo hardware (es. 6 per un MAC address). |
| **Hops** | 1 byte | Usato dai DHCP Relay Agents; incrementato ad ogni salto router. Inizialmente 0. |
| **XID (xid)** | 4 bytes | Transaction ID; numero randomico generato dal client per associare richieste e risposte. |
| **Secs** | 2 bytes | Secondi trascorsi da quando il client ha iniziato la richiesta. |
| **Flags** | 2 bytes | Include il bit di Broadcast (per forzare risposte broadcast se il client non sa gestire unicast senza IP). |
| **CIADDR (ciaddr)** | 4 bytes | Client IP Address (usato solo se il client ha già un IP, es. durante il rinnovo). |
| **YIADDR (yiaddr)** | 4 bytes | "Your" IP Address (l'indirizzo offerto dal server al client). |
| **SIADDR (siaddr)** | 4 bytes | Server IP Address (usato tipicamente per TFTP/Boot server). |
| **GIADDR (giaddr)** | 4 bytes | Gateway IP Address (l'indirizzo IP del DHCP Relay Agent, se presente). |
| **CHADDR (chaddr)** | 16 bytes | Client Hardware Address (il MAC address del client). |
``` schema 
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     op (1)    |   htype (1)   |   hlen (1)    |   hops (1)    |
+---------------+---------------+---------------+---------------+
|                            xid (4)                            |
+-------------------------------+-------------------------------+
|           secs (2)            |           flags (2)           |
+-------------------------------+-------------------------------+
|                          ciaddr  (4)                          |
+---------------------------------------------------------------+
|                          yiaddr  (4)                          |
+---------------------------------------------------------------+
|                          siaddr  (4)                          |
+---------------------------------------------------------------+
|                          giaddr  (4)                          |
+---------------------------------------------------------------+
|                                                               |
|                          chaddr  (16)                         |
|                                                               |
+---------------------------------------------------------------+
````

## Body

Il Body contiene il campo "SNAME" (nome server opzionale), il "FILE" (nome file di boot opzionale) e il campo critico delle **Opzioni DHCP**. Le opzioni iniziano sempre con un "Magic Cookie" (0x63825363) seguito da formati TLV (Type-Length-Value) che specificano Subnet Mask, Default Router, server DNS, ecc.

## Flags

|**Flag**|**Significato**|**Significato**|
|---|---|---|
|**B (Bit 0)**|Broadcast Flag|0 = Unicast (Il client può ricevere IP via MAC L2 prima di configurare L3), 1 = Broadcast (Il client necessita risposta in broadcast IP).|
|**MBZ**|Must Be Zero (Bit 1-15)|Riservati per usi futuri. Devono essere sempre impostati a 0 e ignorati dal ricevitore.|

---

# Porte e Protocolli Correlati

|**Porta**|**Protocollo**|**Uso**|
|---|---|---|
|**67**|UDP|DHCP Server (Porta su cui il server ascolta le richieste dei client).|
|**68**|UDP|DHCP Client (Porta su cui il client ascolta le risposte dal server).|
|**546**|UDP|DHCPv6 Client (Versione IPv6).|
|**547**|UDP|DHCPv6 Server/Relay Agent (Versione IPv6).|

---

# Confronto

|**Caratteristica**|**DHCP**|**Assegnazione IP Statica**|
|---|---|---|
|**Metodo di assegnazione**|Automatico / Dinamico centralizzato|Manuale host per host|
|**Gestione dei conflitti IP**|Il server monitora i lease per evitare duplicati|Elevato rischio di errore umano (IP doppi)|
|**Manutenzione rete**|Cambiare DNS/Gateway è immediato per tutti via pool|Richiede intervento manuale su ogni singola macchina|
|**Disponibilità necessaria**|Richiede un server DHCP sempre raggiungibile|Funziona autonomamente senza server esterni|
|**Adatto per**|Dispositivi mobili, client aziendali, Wi-Fi|Server infrastrutturali, Stampanti, Router|

---

# Aspetti di Sicurezza

## Vulnerabilità Note

Essendo basato originariamente su broadcast e privo di difese crittografiche intrinseche, qualsiasi nodo nella rete locale può fingersi un server DHCP o un client disperato.

## Attacchi Comuni

- **Rogue DHCP Server**: Un attaccante inserisce un proprio server DHCP nella LAN. Quando i client fanno DISCOVER, l'attaccante risponde rapidamente proponendo se stesso come Gateway (Default Router) o server DNS, effettuando così attacchi Man-in-the-Middle (MitM) o DNS spoofing.
    
- **DHCP Starvation (Exhaustion)**: L'attaccante invia migliaia di pacchetti DHCP DISCOVER falsificando di continuo il MAC address sorgente. Il server DHCP legittimo esaurisce tutti gli IP disponibili nel suo pool, attuando un Denial of Service (DoS) per i nuovi client.
    

## Contromisure

- **DHCP Snooping**: Funzionalità degli switch di livello 2 che differenzia le porte tra "Trusted" (collegate al server legittimo) e "Untrusted" (tutte le altre). I messaggi DHCP OFFER generati da porte Untrusted vengono scartati e bloccati.
    
- **Port Security**: Limita il numero di MAC address apprendibili su una specifica porta di accesso switch, mitigando i tentativi di DHCP Starvation generati da un singolo host.
    

---

# Comandi Cisco IOS

Bash

```
# Configurare un pool DHCP
ip dhcp pool NOME_POOL
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.254
 dns-server 8.8.8.8 8.8.4.4
 lease 7

# Escludere indirizzi dal pool
ip dhcp excluded-address 192.168.1.1 192.168.1.50

# Visualizzare gli indirizzi assegnati (binding)
show ip dhcp binding

# Configurare un DHCP Relay Agent (da mettere sotto l'interfaccia VLAN/fisica che riceve il broadcast)
interface GigabitEthernet0/1
 ip helper-address 10.0.0.100

# Abilitare DHCP Snooping
ip dhcp snooping
ip dhcp snooping vlan 10
interface GigabitEthernet0/1 # Porta verso il server
 ip dhcp snooping trust
```

---

# Troubleshooting

- **Sintomi comuni**:
    

|**Sintomo / Errore**|**Possibili Cause Tecniche**|**Descrizione del Fenomeno**|
|---|---|---|
|**IP 169.254.x.x (APIPA)**|Server irraggiungibile / Pool esaurito|Il client Windows non riceve OFFER e si auto-assegna un IP di link-local non instradabile.|
|**Conflitto Indirizzi IP**|Presenza di IP statici non esclusi dal pool|Il server assegna un IP già configurato a mano su un altro host, causando "Duplicate IP address".|
|**Richieste non passano tra VLAN**|IP Helper-address mancante|I pacchetti di DISCOVER (broadcast L2) vengono droppati dal router della VLAN.|

- **Comandi di verifica**:
    

Bash

```
# Windows
ipconfig /release
ipconfig /renew
ipconfig /all

# Linux
dhclient -r
dhclient -v

# Cisco IOS
debug ip dhcp server packet
show ip dhcp conflict
```

- **Cause frequenti**:
    

|**Problema**|**Causa Tecnica**|**Sintomo e Comportamento**|
|---|---|---|
|**Pool Esaurito (Starvation/Sizing)**|Più dispositivi attivi dei lease disponibili, o lease troppo lunghi.|I nuovi client si bloccano nella fase di "Obtaining IP address" e cadono in APIPA, mentre i vecchi funzionano.|
|**Relay Agent Errato**|L'indirizzo puntato dall'`ip helper-address` è sbagliato o spento.|I broadcast del client arrivano al router ma il router non sa a quale server unicast inoltrarli. Nessuna OFFER torna al client.|
|**Rogue DHCP**|Un router casalingo è stato collegato alla rete aziendale via porta LAN.|Alcuni utenti ricevono IP corretti, altri ricevono IP di una classe errata (es. 192.168.0.x) e perdono accesso a internet.|

---

# Note Esame

## Da sapere a memoria

|**Argomento**|**Dettagli Tecnici**|
|---|---|
|**Fasi (DORA)**|Discover, Offer, Request, Acknowledge.|
|**Porte standard**|**67** (Server), **68** (Client) su protocollo **UDP**.|
|**DHCP Relay**|Usa il comando `ip helper-address`. Converte i broadcast L2 del client in messaggi Unicast L3 verso il server remoto, modificando il campo _giaddr_.|
|**Message Type (Discover/Request)**|Sono sempre inviati in **Broadcast** a livello 2 (FF:FF:FF:FF:FF:FF) e livello 3 (255.255.255.255).|
|**Message Type (Offer/ACK)**|Possono essere Unicast (se supportato dal client/rete) o Broadcast.|

## Trabocchetti frequenti

|**Concetto Errato**|**Realtà Tecnica**|
|---|---|
|**DHCP lavora a Livello 3 / Livello 4**|**FALSO**. DHCP è un protocollo di livello Applicazione (Livello 7) che distribuisce parametri di Livello 3.|
|**Il lease IP dura per sempre**|**FALSO**. L'IP viene prestato (lease time). A metà del tempo (T1) il client ne richiede l'estensione.|
|**DHCP usa il TCP per garantire l'affidabilità**|**FALSO**. DHCP usa UDP. In caso di perdita di pacchetti, il client riprova semplicemente a inviare la richiesta basandosi sui propri timer.|
|**Tutti gli IP di una rete sono gestiti dal DHCP**|**FALSO**. I router, switch, server e stampanti mantengono quasi sempre configurazioni IP statiche. Bisogna "escluderli" dal pool.|

---
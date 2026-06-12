Data: 2026-05-19
[Infrastructure_Services](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/IP_Services/Infrastructure_Services
___
# Index
- [[#Dynamic Host Configuration Protocol]]
    - [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
    - [[#Lease]]
    - [[#Storia: L'eredità di BOOTP]]
    - [[#Modalità di Assegnazione]]
    - [[#Architettura e Funzionamento]]
        - [[#Server Multipli e DHCP Relay Agent]]
    - [[#Nota sul Mobile IP]]
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
- [[#Quick Reference Card]]
___
# _Dynamic Host Configuration Protocol_

## Panoramica

| Caratteristica              |                                             Dettaglio                                              |
| --------------------------- | :------------------------------------------------------------------------------------------------: |
| **Livello OSI**             |                                          7 — Applicazione                                          |
| **Porta**                   |                             **67/UDP** (Server) — **68/UDP** (Client)                              |
| **Scopo**                   |         Assegnare dinamicamente indirizzi IP e parametri di rete agli host su una rete IP          |
| **RFC / Standard**          |                         RFC 2131 (1997) — DHCP; RFC 2132 —   Opzioni DHCP                          |
| **Tipo Connessione**        |                             **Connectionless** (UDP) — senza handshake                             |
| **Affidabilità**            |                         **Non affidabile** — nessuna conferma di consegna                          |
| **PDU (Unità Dati)**        |                                         **Messaggio DHCP**                                         |
| **Meccanismo di Controllo** | Assegnazione temporanea tramite **Lease** (affitto); il client deve rinnovare prima della scadenza |
___
# Versioni & Evoluzione

| Versione / RFC  | Anno | Novità principali                                                              |
| --------------- | ---- | ------------------------------------------------------------------------------ |
| BOOTP (RFC 951) | 1985 | Predecessore di DHCP — configurazione statica per client diskless al boot      |
| RFC 1531        | 1993 | Prima specifica DHCP — aggiunge assegnazione dinamica e lease rispetto a BOOTP |
| RFC 2131        | 1997 | Specifica definitiva DHCP — ancora in uso oggi                                 |
| RFC 2132        | 1997 | Definisce le opzioni DHCP (subnet mask, gateway, DNS, lease time…)             |
| RFC 3315        | 2003 | DHCPv6 — versione per IPv6                                                     |
| RFC 4361        | 2006 | Identificatori client DHCP per ambienti dual-stack (IPv4 + IPv6)               |
___
# Come Funziona

Il DHCP è il principale protocollo per la **configurazione automatica** degli host su una rete IP. Permette a un server di assegnare **dinamicamente** indirizzi IP, subnet mask, gateway, DNS e altri parametri di rete. Le assegnazioni sono temporanee e regolate da un periodo chiamato **lease**.

Il principio fondamentale è il modello **client/server**: il client invia richieste in broadcast, il server risponde con un'offerta di configurazione. Il client accetta l'offerta e il server conferma l'assegnazione.
## Lease
Il **lease** (noleggio a tempo) è il meccanismo con cui un server DHCP "presta" un indirizzo IP a un dispositivo per un periodo fisso (es. 24 ore).

- Il dispositivo deve periodicamente **rinnovare** il lease per mantenere l'IP assegnato.
- Se il dispositivo si disconnette e il lease **scade**, l'IP torna libero e può essere riassegnato ad altri dispositivi.
- Il rinnovo avviene tipicamente a **T1** (50% del lease time) e **T2** (87.5% del lease time) prima della scadenza.
- Serve a **non sprecare indirizzi IP** e a gestirli automaticamente in reti dinamiche.
## Storia: L'eredità di BOOTP
DHCP è un'evoluzione del protocollo **BOOTP** (Bootstrap Protocol), creato per configurare automaticamente client diskless durante il processo di avvio.

**Cosa forniva BOOTP al client**:

1. Indirizzo IP
2. Indirizzo del gateway
3. Indirizzo del server da cui scaricare il sistema operativo

**Limiti di BOOTP che DHCP risolve**:

- Nessuna gestione dinamica degli IP (assegnazioni solo statiche)
- Nessun supporto per il lease e il rinnovo
- Non adatto a dispositivi mobili (es. Wi-Fi) dove i client cambiano frequentemente

DHCP eredita da BOOTP le **porte UDP 67** (server) e **UDP 68** (client) e la struttura base del pacchetto.
## Modalità di Assegnazione

Il server DHCP può assegnare IP in tre modalità:

| Modalità       | Descrizione                                                                                                                                           | Esempi                                                                                                                                  |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Manuale**    | Assegnazione statica tramite **reservation**: il server DHCP associa sempre lo stesso IP a un dispositivo specifico tramite indirizzo MAC.            | Dispositivi che devono essere sempre raggiungibili allo stesso IP — es. stampanti di rete, server.                                      |
| **Automatica** | IP assegnato **permanentemente** la prima volta, preso da un pool; non viene mai riassegnato ad altri.                                                | Reti piccole e stabili (es. piccolo ufficio) dove i dispositivi non cambiano spesso. Poco comune oggi.                                  |
| **Dinamica**   | IP assegnato **temporaneamente** tramite lease; il client deve rinnovare prima della scadenza oppure ottiene un IP diverso alla prossima connessione. | Reti Wi-Fi pubbliche (bar, aeroporto) o reti domestiche con molti dispositivi che si connettono/disconnettono. **Modalità più comune**. |
## Server Multipli e DHCP Relay Agent
In reti suddivise in subnet, i router **non inoltrano i broadcast**, quindi le richieste DHCPDISCOVER iniziali non raggiungono i server in subnet diverse. Le soluzioni sono:

- **Server Multipli**: più server DHCP nella stessa rete garantiscono **ridondanza** (se uno cade, gli altri continuano a rispondere) e **bilanciamento del carico** (le richieste si distribuiscono tra i server).
- **DHCP Relay Agent**: un componente — spesso integrato nei router o switch layer 3 — che intercetta le richieste broadcast DHCPDISCOVER nella subnet locale e le **inoltra al server DHCP remoto** tramite pacchetti unicast. Il campo `giaddr` nell'header DHCP viene impostato con l'IP del Relay Agent per permettere al server di rispondere correttamente.

## Nota sul Mobile IP
Esiste un protocollo distinto chiamato **Mobile IP**, progettato per mantenere lo stesso indirizzo IP anche quando un host cambia rete. A differenza di DHCP:

- **DHCP** assegna un nuovo IP ogni volta che il dispositivo si connette a una rete diversa.
- **Mobile IP** cerca di mantenere l'IP fisso per non interrompere le connessioni TCP attive durante il roaming tra reti.
___
# Flusso Operativo

Il processo DHCP si svolge in **7 fasi** (DORA *Discover Offer Request Acknowledge* + fasi aggiuntive):

```
Client                                                    Server
  |                                                          |
1)|-------- DHCPDISCOVER (broadcast) ----------------------->| [Fase: Discover]
  |                                                          |
2)|<------- DHCPOFFER (unicast o broadcast) -----------------| [Fase: Offer]
  |                                                          |
3)|-------- DHCPREQUEST (broadcast) ------------------------>| [Fase: Request]
  |                                                          |
4)|<------- DHCPACK (unicast o broadcast) -------------------| [Fase: Acknowledge]
  |                                                          |
  :  - - - - - - - Scenario alternativo alla riga 3 - - - - -:
5)|<------- DHCPNAK (unicast o broadcast) -------------------| [Fase: Negative Ack]
  |                                                          |
  :  - - - - - - - - Processi post-configurazione - - - - - -:
  |                                                          |
  |   (dopo T1 — 50% del lease time)                         |
3)|-------- DHCPREQUEST (rinnovo, unicast) ----------------->|  [Rinnovo Lease]
4)|<------- DHCPACK (unicast) -------------------------------|  [Conferma Rinnovo]
  |                                                          |
  |   (rilascio volontario dell'indirizzo IP)                |
6)|-------- DHCPRELEASE (unicast) -------------------------->|  [Fase: Release]
  |                                                          |
  |   (richiesta opzioni aggiuntive per IP statico)          |
7)|-------- DHCPINFORM (unicast) --------------------------->|  [Fase: Inform]
  |                                                          |
```

| Fase         | #   | Messaggio      | Tipo di Invio           | Azione ed Effetto sulla Rete                                                                                      |
| ------------ | --- | -------------- | ----------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **Discover** | 1   | `DHCPDISCOVER` | Broadcast               | Il client cerca un server DHCP disponibile sulla rete locale.                                                     |
| **Offer**    | 2   | `DHCPOFFER`    | Unicast / Broadcast     | Il server risponde al client con una proposta di configurazione (IP, subnet, lease time).                         |
| **Request**  | 3   | `DHCPREQUEST`  | Broadcast *(o Unicast)* | **Iniziale:** Il client accetta l'offerta formalmente (avvisando anche gli altri server di ritirare le loro).<br> |
| **Acknowledge** | 4 | `DHCPACK` | Unicast / Broadcast | Il server conferma l'assegnazione dell'IP. Il client configura l'interfaccia e inizia il conteggio del lease. |
| **Negative Ack** | 5 | `DHCPNAK` | Unicast / Broadcast | Il server             rifiuta la richiesta (es. l'IP è già stato assegnato o il client è fuori subnet). Il client deve resettarsi e ripartire dal punto 1. |
| **Release** | 6 | `DHCPRELEASE` | Unicast | Il client rilascia esplicitamente l'indirizzo IP prima della scadenza naturale del contratto (es. spegnimento regolare). |
| **Inform** | 7 | `DHCPINFORM` | Unicast | Il client ha già un IP (configurato staticamente), ma interroga il server solo per ottenere parametri extra (es. server DNS, gateway). |

> [!NOTE] Titl
> Nota sul broadcast di **DHCPREQUEST** Il **DHCPREQUEST** è inviato in broadcast anche se il client ha già ricevuto un'offerta da un server specifico. Questo permette agli altri server che hanno inviato offerte di sapere che sono state **rifiutate**, così possono **liberare** gli IP che avevano riservato **temporaneamente**.

___
# Casi d'Uso Reali

- **Rete domestica**: Quando uno smartphone si connette al Wi-Fi di casa, il router (che svolge anche il ruolo di server DHCP) gli assegna automaticamente un IP dal pool disponibile (es. 192.168.1.x), insieme a subnet mask, gateway e DNS. Senza DHCP ogni dispositivo richiederebbe configurazione manuale.
- **Wi-Fi pubblica (bar, aeroporto)**: Centinaia di dispositivi si connettono e disconnettono continuamente. Il DHCP dinamico gestisce automaticamente il pool di IP disponibili, riassegnando gli indirizzi liberati dai dispositivi che si sono disconnessi.
- **Stampanti di rete**: Tramite reservation DHCP (modalità manuale), la stampante riceve sempre lo stesso IP basato sul suo MAC address. Questo permette di stampare sempre allo stesso indirizzo senza configurazione statica sul dispositivo.
- **Reti aziendali multi-subnet**: Un server DHCP centrale serve più subnet tramite DHCP Relay Agent configurati sui router di bordo. Ogni subnet ha un pool di IP dedicato configurato sul server centrale.

___
# Limitazioni Tecniche

- **Nessuna autenticazione nativa**: Il protocollo DHCP non verifica l'identità del client né del server. Qualsiasi dispositivo può rispondere a un DHCPDISCOVER come se fosse un server legittimo.
- **Dipendenza dal broadcast**: Le richieste DHCP iniziali sono broadcast, quindi non attraversano i router senza un Relay Agent. Reti grandi richiedono relay agent in ogni subnet.
- **Esaurimento del pool (pool exhaustion)**: Se tutti gli IP del pool sono assegnati, nuovi client non ricevono configurazione fino alla scadenza di lease esistenti.
- **Non adatto a IP fissi su larga scala**: In reti con molti server e dispositivi infrastrutturali, gestire centinaia di reservation DHCP diventa complesso; spesso si preferisce la configurazione statica diretta sul dispositivo.
- **Propagazione lenta dopo modifiche**: Se si modifica la configurazione DHCP (es. gateway, DNS), i client già connessi mantengono i vecchi parametri fino al prossimo rinnovo del lease.

___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio DHCP
- **Incapsulato in**: Datagramma UDP (porta 67 server / porta 68 client), a sua volta in pacchetto IP
- **Incapsula**: Payload applicativo (parametri di configurazione di rete)

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header UDP ] PDU: Datagramma
	             L7 [ Header DHCP ] PDU: Messaggio DHCP
```

> [!NOTE] Title
> Nota sulle porte DHCP usa **UDP 67** (server) e **UDP 68** (client). Il broadcast IP è 255.255.255.255. 
> Il client sorgente usa la porta 68, il server risponde dalla porta 67.

___
# Struttura Del Pacchetto

## Header

|Campo|Dimensione|Descrizione|
|---|---|---|
|**Op (Opcode)**|1 byte|Tipo di operazione: `1` = Request (client → server), `2` = Reply (server → client)|
|**Htype**|1 byte|Tipo di hardware di rete: `1` = Ethernet|
|**Hlen**|1 byte|Lunghezza dell'indirizzo hardware (MAC): di solito `6` byte|
|**Hops**|1 byte|Usato dal DHCP Relay Agent — incrementato ad ogni salto; a 0 per richieste dirette|
|**Xid**|4 byte|Transaction ID — numero casuale generato dal client per associare richieste e risposte|
|**Secs**|2 byte|Secondi trascorsi dall'inizio del processo di acquisizione IP (usato per priorità)|
|**Flags**|2 byte|Contiene il Broadcast flag (bit più significativo): `1` = il client non può ricevere unicast prima di avere un IP|
|**Ciaddr**|4 byte|Client IP Address — IP attuale del client (solo in fase di rinnovo, altrimenti 0.0.0.0)|
|**Yiaddr**|4 byte|Your IP Address — IP offerto o assegnato al client dal server|
|**Siaddr**|4 byte|Server IP Address — IP del server DHCP che ha inviato l'offerta|
|**Giaddr**|4 byte|Gateway IP Address — IP del Relay Agent, se presente (altrimenti 0.0.0.0)|
|**Chaddr**|16 byte|Client Hardware Address — indirizzo MAC del client (i primi 6 byte), padding a 16|
|**Sname**|64 byte|Nome del server (opzionale, ereditato da BOOTP)|
|**File**|128 byte|Nome del file di boot (opzionale, ereditato da BOOTP per client diskless)|
|**Options**|Variabile|Campo flessibile per tutti i parametri aggiuntivi (tipo messaggio, DNS, lease time…)|

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|    Op (1B)    |   Htype (1B)  |   Hlen (1B)   |   Hops (1B)   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                      Xid — Transaction ID (4B)                |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Secs (2B)            |          Flags (2B)           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   Ciaddr — Client IP Address (4B)             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   Yiaddr — Your IP Address (4B)               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   Siaddr — Server IP Address (4B)             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   Giaddr — Gateway IP Address (4B)            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|               Chaddr — Client Hardware Address (16B)          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Sname — Server Name (64B)                  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    File — Boot Filename (128B)                |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options — Variabile                        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
Le **Opzioni DHCP** (campo Options) sono il meccanismo flessibile che trasporta tutti i parametri di configurazione aggiuntivi. Ogni opzione è codificata nel formato **TLV** (Type-Length-Value):

|Opzione (codice)|Parametro|Descrizione|
|---|---|---|
|**53**|DHCP Message Type|Tipo del messaggio (DISCOVER=1, OFFER=2, REQUEST=3, ACK=5, NAK=6, RELEASE=7, INFORM=8)|
|**1**|Subnet Mask|Maschera di sottorete assegnata al client|
|**3**|Router (Default Gateway)|IP del gateway predefinito|
|**6**|DNS Server|Uno o più indirizzi IP di server DNS|
|**51**|Lease Time|Durata totale del lease in secondi|
|**58**|Renewal Time (T1)|Tempo al quale il client inizia il rinnovo (di default 50% del lease)|
|**59**|Rebinding Time (T2)|Tempo al quale il client tenta il rebind (di default 87.5% del lease)|
|**54**|Server Identifier|IP del server DHCP che ha emesso l'offerta|
|**50**|Requested IP Address|IP che il client vorrebbe ottenere (usato nel DHCPREQUEST)|
|**255**|End|Marcatore di fine delle opzioni|

## Flags
Il campo Flags è di **16 bit**, ma nella specifica DHCP solo il bit più significativo è definito:

|Bit|Flag|Nome Esteso|Descrizione e Utilizzo|
|---|---|---|---|
|15|**B**|_Broadcast Flag_|`1` = il client richiede che le risposte siano inviate in broadcast (usato quando il client non può ancora ricevere unicast prima di avere un IP)|
|0-14|**Riservati**|_Reserved (MBZ)_|Devono essere impostati a `0` (Must Be Zero)|
___
# Porte e Protocolli Correlati

| Porta       | Livello OSI          | Protocollo | Uso                                                                   |
| ----------- | -------------------- | ---------- | --------------------------------------------------------------------- |
| **67/UDP**  | **7** (Applicazione) | DHCP       | Porta del server DHCP — riceve richieste dai client e dai Relay Agent |
| **68/UDP**  | **7** (Applicazione) | DHCP       | Porta del client DHCP — riceve offerte e risposte dal server          |
| **546/UDP** | **7** (Applicazione) | DHCPv6     | Porta del client DHCPv6 (versione per IPv6)                           |
| **547/UDP** | **7** (Applicazione) | DHCPv6     | Porta del server DHCPv6                                               |
___
# Confronto

**DHCP vs BOOTP**

|Caratteristica|DHCP|BOOTP|
|---|---|---|
|**Assegnazione IP**|Dinamica (lease temporaneo) o statica|Solo statica (tabella predefinita sul server)|
|**Lease**|Sì — con rinnovo T1 e T2|No — assegnazione permanente|
|**Parametri di rete**|Molti (gateway, DNS, NTP, WINS…) tramite campo Options|Limitati (IP, gateway, server di boot)|
|**Supporto client mobili**|Sì — adatto a reti dinamiche|No — pensato per terminali fissi diskless|
|**Porte**|UDP 67 / 68 (ereditate)|UDP 67 / 68|
|**Complessità**|Alta|Bassa|

**DHCP vs DHCPv6**

|Caratteristica|DHCP (IPv4)|DHCPv6 (IPv6)|
|---|---|---|
|**Protocollo IP**|IPv4|IPv6|
|**Porte**|UDP 67 / 68|UDP 546 / 547|
|**Discovery**|Broadcast (255.255.255.255)|Multicast (FF02::1:2 — All_DHCP_Relay_Agents_and_Servers)|
|**Alternativa**|—|SLAAC (Stateless Address Autoconfiguration) — IPv6 può configurarsi senza server|
|**Lease**|Sì|Sì (con Preferred Lifetime e Valid Lifetime)|
___
# Aspetti di Sicurezza

## Vulnerabilità Note
- **Assenza di autenticazione**: DHCP non verifica l'identità del server né del client. Un server DHCP malevolo può rispondere alle richieste broadcast prima del server legittimo, fornendo configurazioni errate.
- **Assenza di cifratura**: Tutti i messaggi DHCP viaggiano in chiaro su UDP. Chiunque sulla rete locale può intercettare le comunicazioni e vedere i parametri di configurazione assegnati.
- **Pool exhaustion**: Un attaccante può esaurire il pool di IP disponibili inviando massivamente DHCPDISCOVER con MAC address falsi e diversi, impedendo ai client legittimi di ottenere un indirizzo IP.

## Attacchi Comuni
- **Rogue DHCP Server**: Un server DHCP non autorizzato risponde alle richieste DHCPDISCOVER prima del server legittimo (race condition), assegnando ai client un gateway o DNS malevolo. Permette attacchi Man-in-the-Middle e DNS Spoofing su tutta la rete locale.
- **DHCP Starvation**: L'attaccante invia migliaia di DHCPDISCOVER con MAC address sempre diversi (spoofing MAC) fino ad esaurire tutti gli IP del pool. I nuovi client legittimi non riescono più a connettersi alla rete (DoS). Tool come Yersinia automatizzano questo attacco.
- **DHCP Spoofing (MITM)**: Combinando DHCP Starvation (esaurisce il pool del server legittimo) con un Rogue DHCP Server, l'attaccante diventa il nuovo server DHCP per tutti i client, impostando se stesso come gateway e reindirizzando tutto il traffico.

## Contromisure
- **DHCP Snooping**: Funzionalità degli switch managed che classifica le porte come **trusted** (verso server DHCP legittimi) o **untrusted** (verso i client). I messaggi DHCPOFFER e DHCPACK provenienti da porte untrusted vengono scartati, bloccando i Rogue DHCP Server. Genera anche una **binding table** (MAC → IP → porta → VLAN) usata da ARP Inspection e IP Source Guard.
- **Dynamic ARP Inspection (DAI)**: Usa la binding table del DHCP Snooping per verificare che i pacchetti ARP abbiano IP e MAC coerenti con le assegnazioni DHCP legittime. Mitiga ARP Spoofing post-DHCP.
- **IP Source Guard**: Filtra il traffico in ingresso sulle porte untrusted in base alla binding table — scarta pacchetti con IP sorgente diverso da quello assegnato via DHCP, mitigando lo spoofing IP.
- **Rate Limiting DHCP**: Limitare il numero di messaggi DHCP per porta sugli switch managed mitiga il DHCP Starvation.
- **Port Security**: Limitare il numero di MAC address per porta switch riduce la possibilità di spoofing MAC massivo usato nello Starvation.
___
# Comandi Cisco IOS

```cisco
! Configurare il router come server DHCP
ip dhcp pool NOME_POOL
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.1
 dns-server 8.8.8.8
 lease 1                          ! Lease di 1 giorno (default)

! Escludere indirizzi dal pool (es. gateway, server)
ip dhcp excluded-address 192.168.1.1 192.168.1.10

! Reservation statica (IP fisso per MAC specifico)
ip dhcp pool STAMPANTE
 host 192.168.1.50 255.255.255.0
 hardware-address 00AA.BB11.CC22
 default-router 192.168.1.1

! Configurare il router come DHCP client su un'interfaccia
interface GigabitEthernet0/0
 ip address dhcp

! Configurare il DHCP Relay Agent su un'interfaccia
interface GigabitEthernet0/1
 ip helper-address 10.0.0.1       ! IP del server DHCP remoto

! Verificare le assegnazioni DHCP attive
show ip dhcp binding

! Verificare le statistiche e i messaggi DHCP
show ip dhcp statistics

! Verificare il pool DHCP configurato
show ip dhcp pool

! Verificare gli IP esclusi
show running-config | include ip dhcp excluded

! Cancellare una singola binding
clear ip dhcp binding 192.168.1.100

! Cancellare tutte le binding
clear ip dhcp binding *

! Debug DHCP (solo in lab)
debug ip dhcp server events
debug ip dhcp server packets

! Configurare DHCP Snooping
ip dhcp snooping
ip dhcp snooping vlan 10
!
interface GigabitEthernet0/1        ! Porta verso il server DHCP legittimo
 ip dhcp snooping trust
!
show ip dhcp snooping binding
```
___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore                        | Possibili Cause Tecniche                                                | Descrizione del Fenomeno                                                                                                   |
| --------------------------------------- | ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **IP non ottenuto (APIPA 169.254.x.x)** | Server DHCP non raggiungibile, pool esaurito, firewall blocca UDP 67/68 | Il client non riceve DHCPOFFER — Windows/Linux assegna un IP APIPA automatico. Ping al broadcast 255.255.255.255 fallisce. |
| **IP duplicato sulla rete**             | Pool sovrapposti tra più server DHCP, reservation errata                | Due dispositivi hanno lo stesso IP — conflitti di connessione intermittenti per entrambi.                                  |
| **IP scaduto non rinnovato**            | Server DHCP non raggiungibile al momento del rinnovo                    | Il client perde la connettività alla scadenza del lease se non riesce a rinnovare.                                         |
| **Gateway o DNS errato ricevuto**       | Rogue DHCP Server attivo sulla rete                                     | I client ricevono una configurazione malevola — impossibile navigare o connessioni reindirizzate.                          |
| **Lentezza nella prima connessione**    | Server DHCP lontano, alta latenza UDP                                   | Il processo DORA richiede diversi secondi prima che il client ottenga un IP e possa comunicare.                            |
| **Relay Agent non funzionante**         | `ip helper-address` non configurato, firewall blocca UDP 67             | I client in subnet diverse dal server non ricevono risposta — rimangono con APIPA.                                         |

**Comandi di verifica**:

```bash
# Windows — verifica configurazione IP attuale
ipconfig /all

# Windows — forza rinnovo DHCP
ipconfig /release
ipconfig /renew

# Linux — verifica configurazione IP
ip addr show
ip route show

# Linux — forza rinnovo DHCP (con dhclient)
sudo dhclient -r eth0      # release
sudo dhclient eth0         # nuova richiesta

# Cattura traffico DHCP (Wireshark / tcpdump)
tcpdump -i eth0 port 67 or port 68
tcpdump -i eth0 'udp and (port 67 or port 68)'

# Verifica se il server DHCP risponde (da Linux)
nmap --script broadcast-dhcp-discover
```

**Cause frequenti**:

|Problema|Causa Tecnica|Sintomo e Comportamento|
|---|---|---|
|**APIPA su client**|Nessun DHCPOFFER ricevuto entro il timeout|Client con 169.254.x.x — verificare connettività switch, Relay Agent, pool non esaurito|
|**Pool esaurito**|Lease time troppo lungo + molti client|I nuovi client non ricevono IP — ridurre lease time o espandere il pool|
|**Rogue DHCP Server**|Dispositivo non autorizzato risponde prima del server legittimo|I client ricevono gateway/DNS errati — attivare DHCP Snooping sugli switch|
|**MTU Mismatch**|Differenza nella dimensione massima dei pacchetti tra due nodi|I pacchetti piccoli (ACK) passano, quelli grandi vengono scartati se hanno il flag **DF** (Don't Fragment)|
___
# Note Esame

## Da sapere a memoria

|Argomento|Dettagli Tecnici|
|---|---|
|**Definizione**|Layer 7, assegna dinamicamente IP e parametri di rete tramite lease temporanei|
|**RFC**|**RFC 2131** (1997) — DHCP; **RFC 2132** (1997) — Opzioni DHCP|
|**Porte**|**67/UDP** (server) e **68/UDP** (client) — ereditate da BOOTP|
|**Sequenza DORA**|**D**ISCOVER → **O**FFER → **R**EQUEST → **ACK** (le 4 fasi principali)|
|**DHCPDISCOVER**|Broadcast — il client cerca un server DHCP|
|**DHCPOFFER**|Il server propone una configurazione IP|
|**DHCPREQUEST**|Broadcast — il client accetta un'offerta (informa anche gli altri server)|
|**DHCPACK**|Il server conferma — inizia il lease|
|**DHCPNAK**|Il server rifiuta — il client riparte da DISCOVER|
|**DHCPRELEASE**|Il client rilascia l'IP volontariamente|
|**DHCPINFORM**|Il client già configurato chiede solo i parametri opzionali|
|**Lease**|Durata temporanea dell'assegnazione IP — il client rinnova a T1 (50%) e T2 (87.5%)|
|**Campi chiave**|`yiaddr` = IP assegnato al client; `giaddr` = IP del Relay Agent; `xid` = Transaction ID|
|**Relay Agent**|Inoltra i broadcast DHCP tra subnet — usa `ip helper-address` in Cisco IOS|
|**DHCP Snooping**|Sicurezza switch — porta trusted (server) vs untrusted (client); blocca Rogue DHCP Server|
|**Modalità assegnazione**|Manuale (reservation MAC), Automatica (permanente da pool), Dinamica (lease — più comune)|
|**Opzione 53**|DHCP Message Type — identifica il tipo di messaggio nel campo Options|
|**BOOTP vs DHCP**|BOOTP: statico, no lease; DHCP: dinamico, lease, molte opzioni|
|**APIPA**|169.254.x.x — IP auto-assegnato quando nessun server DHCP risponde (Windows/Linux)|
## Trabocchetti frequenti

|Concetto Errato|Realtà Tecnica|
|---|---|
|**DHCP usa TCP**|**FALSO**. DHCP usa esclusivamente **UDP** — porta 67 (server) e 68 (client). Non c'è handshake TCP.|
|**DHCPREQUEST è unicast**|**PARZIALMENTE FALSO**. Nella fase iniziale DORA il DHCPREQUEST è **broadcast**, non unicast. Solo i rinnovi successivi usano unicast verso il server.|
|**Il server DHCP assegna sempre lo stesso IP**|**FALSO** in modalità dinamica. L'IP può cambiare ad ogni nuovo lease se quello precedente è stato riassegnato.|
|**DHCP è a layer 4**|**FALSO**. DHCP è un protocollo applicativo di **Layer 7** — usa UDP come trasporto a layer 4.|
|**Il Relay Agent modifica i dati**|**PARZIALMENTE VERO**. Il Relay Agent non modifica l'offerta, ma inserisce il proprio IP nel campo `giaddr` e incrementa `hops`.|
|**DHCP Snooping blocca tutti i server DHCP**|**FALSO**. Blocca solo i server su porte **untrusted**. Le porte **trusted** (verso il server legittimo) lasciano passare tutto.|
|**Con DHCP il client sceglie sempre il primo server**|**FALSO**. Il client riceve potenzialmente più DHCPOFFER da server diversi e sceglie (di solito il primo arrivato), poi lo comunica con DHCPREQUEST in broadcast.|
___
# Quick Reference Card

```
PORTE:
  67/UDP  → Server DHCP (riceve richieste da client e Relay Agent)
  68/UDP  → Client DHCP (riceve offerte e risposte dal server)
  546/UDP → Client DHCPv6
  547/UDP → Server DHCPv6

SEQUENZA DORA (fasi principali):
  1. DHCPDISCOVER  → Broadcast  — il client cerca un server
  2. DHCPOFFER     → Unicast    — il server propone una configurazione
  3. DHCPREQUEST   → Broadcast  — il client accetta l'offerta
  4. DHCPACK       → Unicast    — il server conferma (inizia il lease)

FASI AGGIUNTIVE:
  5. DHCPNAK       → Broadcast  — il server rifiuta (es. IP non più disponibile)
  6. DHCPRELEASE   → Unicast    — il client rilascia l'IP
  7. DHCPINFORM    → Unicast    — il client chiede solo parametri opzionali

CAMPI HEADER CHIAVE:
  Op      → 1=Request, 2=Reply
  Xid     → Transaction ID (associa richiesta e risposta)
  Yiaddr  → IP offerto/assegnato al client (Your IP)
  Giaddr  → IP del Relay Agent
  Chaddr  → MAC address del client
  Options → Parametri aggiuntivi (tipo messaggio, DNS, gateway, lease time…)

OPZIONI IMPORTANTI:
  Opzione 53  → DHCP Message Type (tipo del messaggio)
  Opzione 1   → Subnet Mask
  Opzione 3   → Default Gateway
  Opzione 6   → DNS Server
  Opzione 51  → Lease Time
  Opzione 58  → T1 — Renewal Time (50% del lease)
  Opzione 59  → T2 — Rebinding Time (87.5% del lease)
  Opzione 54  → Server Identifier

MODALITÀ DI ASSEGNAZIONE:
  Manuale    → Reservation (IP fisso per MAC) — es. stampanti
  Automatica → IP permanente dal pool — poco comune oggi
  Dinamica   → Lease temporaneo — la più comune

SICUREZZA:
  Rogue DHCP Server → DHCP Snooping (trusted/untrusted ports)
  DHCP Starvation   → Rate Limiting + Port Security
  Pool Exhaustion   → Monitoraggio pool + lease time adeguato

CISCO IOS:
  ip dhcp pool NOME         → Crea pool DHCP
  ip dhcp excluded-address  → Esclude IP dal pool
  ip helper-address IP      → Configura Relay Agent su interfaccia
  show ip dhcp binding      → Mostra assegnazioni attive
  show ip dhcp statistics   → Statistiche messaggi DHCP
  ip dhcp snooping          → Abilita DHCP Snooping globale
  ip dhcp snooping trust    → Porta trusted per DHCP Snooping

REGOLE CHIAVE:
  - DHCP usa SOLO UDP — mai TCP
  - DHCPREQUEST è broadcast nella fase DORA (anche dopo aver scelto un server)
  - Il campo giaddr identifica il Relay Agent ed è essenziale per reti multi-subnet
  - L'IP APIPA (169.254.x.x) indica che il client non ha trovato nessun server DHCP
  - DHCP Snooping usa porte trusted/untrusted — non blocca tutto, solo le porte non autorizzate
  - T1 = 50% del lease (rinnovo unicast), T2 = 87.5% (rebind broadcast)
```

___
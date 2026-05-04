Data: 2026-05-04
[Core_Protocols](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Core_Protocols
___
# Index
- [[#Address Resolution Protocol]]
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
- [[#Quick Reference Card]]
___
# Address Resolution Protocol

## Panoramica

| Caratteristica               |                                           Dettaglio                                           |
| ---------------------------- | :-------------------------------------------------------------------------------------------: |
| **Livello OSI**              |                            2 — Data Link (opera al confine L2/L3)                             |
| **Porta**                    |                      N/A — non usa porte; opera direttamente su Ethernet                      |
| **Scopo**                    | Risolvere un indirizzo IP (L3) nel corrispondente indirizzo MAC (L2) sulla stessa rete locale |
| **RFC / Standard**           |                                        RFC 826 (1982)                                         |
| **Tipo Connessione**         |                  **Connectionless** (request/reply stateless via broadcast)                   |
| **Affidabilità**             |               **Non affidabile** (nessun ACK, nessuna ritrasmissione garantita)               |
| **PDU (Unità Dati)**         |                          **Messaggio ARP** (ARP Request / ARP Reply)                          |
| **Meccanismo di Controllo**  |                     Cache ARP locale con TTL; nessun controllo del flusso                     |
___
# Versioni & Evoluzione

| Versione / RFC   | Anno  | Novità principali                                                                                   |
| ---------------- | ----- | --------------------------------------------------------------------------------------------------- |
| RFC 826          | 1982  | Specifica originale ARP per IPv4 su Ethernet                                                        |
| RFC 903          | 1984  | **RARP** (Reverse ARP): ottieni IP a partire da MAC — obsoleto, rimpiazzato da DHCP                 |
| RFC 2390         | 1998  | **InARP** (Inverse ARP): usato in reti Frame Relay per mappare DLCI → IP                            |
| RFC 5227         | 2008  | **ARP Probe / ARP Announcement**: rilevamento conflitti IP (usato da OS moderni al boot)            |
| RFC 4861         | 2007  | **NDP** (Neighbor Discovery Protocol): sostituto di ARP in IPv6, usa ICMPv6                         |
| Gratuitous ARP   | —     | Estensione non standard: un host annuncia il proprio IP/MAC senza richiesta (aggiorna cache altrui) |

___
# Come Funziona

ARP risolve il problema fondamentale del livello di rete: per inviare un frame Ethernet a destinazione, lo switch ha bisogno del **MAC address** (_Media Access Control_), ma il mittente conosce solo l'**IP address** del destinatario. Il meccanismo core si basa su due messaggi:
1. **ARP Request (Broadcast)**
   Il mittente non conosce il MAC dell'host di destinazione. Invia un frame Ethernet in **broadcast** (`FF:FF:FF:FF:FF:FF`) su tutta la LAN. Il messaggio contiene:
	- Il proprio IP e MAC (mittente)
	- L'IP target (destinatario cercato)
	- Il MAC target impostato a `00:00:00:00:00:00` (sconosciuto)
	Tutti gli host sulla LAN ricevono il frame, ma **solo chi ha quell'IP risponde**.
2. **ARP Reply (Unicast)**
   L'host che riconosce il proprio IP risponde con un messaggio **unicast** direttamente al mittente, comunicando il proprio MAC address.
3. **ARP Cache**
   Dopo la risoluzione, il mittente salva la coppia IP → MAC nella propria **ARP cache** con un TTL (tipicamente 60–300 secondi su sistemi moderni). Le richieste successive per lo stesso IP vengono soddisfatte dalla cache, senza inviare broadcast.
___
# Flusso Operativo

```
Host A (192.168.1.10)              Host B (192.168.1.20)         Altri host LAN
  |                                       |                              |
  |  Vuole comunicare con 192.168.1.20    |                              |
  |  MAC di B non è in cache              |                              |
  |                                       |                              |
1)|--- ARP Request (BROADCAST) ---------> |----------------------------->|
  |    Src IP:  192.168.1.10              |                              |
  |    Src MAC: AA:BB:CC:DD:EE:01         |                              |
  |    Dst IP:  192.168.1.20              |   (ricevono ma ignorano)     |
  |    Dst MAC: FF:FF:FF:FF:FF:FF         |                              |
  |                                       |                              |
  |           (B riconosce il proprio IP) |                              |
  |                                       |                              |
2)|<-- ARP Reply (UNICAST) ---------------|                              |
  |    Src IP:  192.168.1.20              |                              |
  |    Src MAC: AA:BB:CC:DD:EE:02         |                              |
  |    Dst IP:  192.168.1.10              |                              |
  |    Dst MAC: AA:BB:CC:DD:EE:01         |                              |
  |                                       |                              |
3)|  A aggiorna la propria ARP Cache      |                              |
  |  192.168.1.20 -> AA:BB:CC:DD:EE:02    |                              |
  |                                       |                              |
4)|  [Comunicazione IP normale (unicast)] |                              |

```

| Fase          | \#  | Azione                                        | Stato Mittente(A)            | Stato Destinatario(B)    | Note                                            |
| ------------- | --- | --------------------------------------------- | ---------------------------- | ------------------------ | ----------------------------------------------- |
| **Richiesta** | 1   | A invia **ARP Request** in broadcast          | Cache miss — in attesa       | Riceve il broadcast      | Tutti i dispositivi LAN ricevono il frame       |
| **Risposta**  | 2   | B risponde con **ARP Reply** in unicast       | Riceve il MAC di B           | Invia il proprio MAC     | Solo B risponde; gli altri ignorano             |
| **Cache**     | 3   | A salva la coppia **IP → MAC** in ARP Cache   | Cache aggiornata             | —                        | TTL tipico: 60–300s (variabile per OS) **Dati** |
| **Scadenza**  | 4   | Alla scadenza del TTL, la entry viene rimossa | Cache miss al prossimo invio | —                        | A dovrà inviare un nuovo ARP Request            |
___
____
# Casi d'Uso Reali

- **Navigazione web in LAN**: Quando il PC vuole raggiungere il gateway (es. `192.168.1.1`), controlla prima la ARP cache. Se non trova il MAC del router, invia un ARP Request in broadcast. Solo dopo aver ricevuto il MAC del gateway può costruire il frame Ethernet e inviare il pacchetto IP verso Internet.
- **Boot di una macchina (ARP Probe/Announce)**: Al boot, un host moderno invia un **ARP Probe** (ARP Request con IP sorgente `0.0.0.0`) per verificare che il proprio IP non sia già in uso. Se nessuno risponde, invia un **Gratuitous ARP** per aggiornare la cache di tutti gli host vicini con il proprio IP/MAC.
- **Failover/clustering (VRRP, HSRP)**: Quando un router backup subentra al primario, invia un **Gratuitous ARP** per aggiornare le ARP cache di tutti gli host LAN, redirigendo il traffico verso il proprio MAC senza aspettare la scadenza del TTL delle cache.
___
# Limitazioni Tecniche

- **Limitato alla stessa subnet (LAN)**: ARP opera esclusivamente sulla rete locale. Per comunicare con host su subnet diverse, il mittente invia i frame al **default gateway**, di cui deve risolvere il MAC via ARP — non all'host remoto direttamente.
- **Non scala in reti grandi**: Il meccanismo broadcast genera traffico su ogni host della LAN ad ogni risoluzione. In reti con migliaia di host, il volume di ARP Request può diventare significativo (ARP storm).
- **Cache con TTL fisso — nessuna notifica di cambio**: Se un host cambia IP o MAC (es. sostituzione NIC, VM live migration), le cache ARP degli altri host rimangono errate fino alla scadenza del TTL, causando interruzioni temporanee.
- **Assenza di autenticazione**: ARP non prevede nessun meccanismo di verifica dell'identità del rispondente. Qualsiasi host può rispondere a un ARP Request con informazioni false — alla base dell'ARP Spoofing.
- **Non supporta IPv6**: ARP è specifico per IPv4 su reti Ethernet/IEEE 802. IPv6 utilizza **NDP** (Neighbor Discovery Protocol) basato su ICMPv6, che supera molte limitazioni di ARP.
- **Dipendenza dalla dimensione del broadcast domain**: Un broadcast domain molto ampio (es. VLAN non segmentata con centinaia di host) amplifica il traffico ARP non necessario.
___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio ARP (ARP Message)
- **Incapsulato in**: Frame Ethernet (EtherType `0x0806`)
- **Incapsula**: Nessun protocollo superiore (ARP è il payload del frame Ethernet)

```
L1 [ Segnale Elettrico/Ottico/RF ] PDU: Bit
    L2 [ Header Ethernet | EtherType: 0x0806 ] PDU: Frame
         L2.5 [ ARP Message (Request o Reply) ] PDU: Messaggio ARP
              (nessun payload applicativo — ARP non trasporta dati utente)
```

> **Nota:** ARP è classificato a **livello 2** (Data Link), ma opera al confine tra L2 e L3, poiché gestisce la mappatura tra indirizzi L3 (IP) e L2 (MAC). Alcune fonti lo definiscono protocollo "Layer 2.5".

___
# Struttura Del Pacchetto
## Header
ARP non ha una separazione netta tra header e body: il pacchetto è composto da **8 campi fissi** (28 byte totali per IPv4 su Ethernet).

| Campo                          | Dimensione  | Descrizione                                                                         |             |                                                 |
| ------------------------------ | ----------- | ----------------------------------------------------------------------------------- | ----------- | ----------------------------------------------- |
| **HTYPE** (Hardware Type)      | 16 bit      | Tipo di rete fisica. `1` = Ethernet                                                 |             |                                                 |
| **PTYPE** (Protocol Type)      | 16 bit      | Protocollo L3 usato. `0x0800` = IPv4            **HLEN** (Hardware Addr Len)   n)   | 8 bit       | Lunghezza MAC address in byte. `6` per Ethernet |
| **PLEN** (Protocol Addr Len)   | 8 bit       | Lunghezza indirizzo IP in byte. `4` per IPv4                                        |             |                                                 |
| **OPER** (Operation)           | 16 bit      | `1` = ARP Request; `2` = ARP Reply; `3` = RARP Request; `4` = RARP Reply            |             |                                                 |
| **SHA** (Sender HW Address)    | 48 bit      | MAC del mittente                                                                    |             |                                                 |
| **SPA** (Sender Proto Addr)    | 32 bit      | IP del mittente                                                                     |             |                                                 |
| **THA** (Target HW Address)    | 48 bit      | MAC del destinatario. `00:00:00:00:00:00` nella Request (sconosciuto)               |             |                                                 |
| **TPA** (Target Proto Addr)    | 32 bit      | IP del destinatario cercato                                                         |             |                                                 |

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         HTYPE (16 bit)        |         PTYPE (16 bit)        |
|          Hardware Type        |         Protocol Type         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  HLEN (8 bit) |  PLEN (8 bit) |         OPER  (16 bit)        |
|  HW Addr Len  |  IP Addr Len  |     Operation (1=Req 2=Rep)   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   SHA -- Sender MAC Address                   |
|                      (48 bit, primi 32 bit)                   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  SHA (ultimi 16 bit)          |  SPA -- Sender IP (16 bit)    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|           SPA -- Sender IP Address (ultimi 16 bit)            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                   THA -- Target MAC Address                   |
|                      (48 bit, primi 32 bit)                   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  THA (ultimi 16 bit)          |  TPA -- Target IP (16 bit)    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|           TPA -- Target IP Address (ultimi 16 bit)            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
ARP non ha un body separato: tutti i dati significativi sono contenuti nei campi fissi. Non trasporta payload applicativo.
## Flags
ARP non usa flag nel senso tradizionale. Il campo equivalente è **OPER**:

| OPER | Tipo Messaggio    | Direzione | Descrizione |
| ---- | ----------------- | --------- | ----------- |
| `1`  | **ARP Request**   | Broadcast | "Chi ha l'IP X? Rispondimi con il tuo MAC" |
| `2`  | **ARP Reply**     | Unicast   | "Sono io! Il mio MAC è Y" |
| `3`  | **RARP Request**  | Broadcast | Obsoleto — chiedeva IP a partire da MAC (rimpiazzato da DHCP) |
| `4`  | **RARP Reply**    | Unicast   | Obsoleto — risposta del RARP server |
___
# Porte e Protocolli Correlati

| EtherType / Porta     | Livello OSI           | Protocollo          | Uso                                               |
| --------------------- | --------------------- | ------------------- | ------------------------------------------------- |
| `0x0806`              | **2** (Data Link)     | ARP                 | Risoluzione IP → MAC su IPv4                      |
| `0x0800`              | **3** (Rete)          | IPv4                | Protocollo di rete trasportato dal frame Ethernet |
| `0x86DD`              | **3** (Rete)          | IPv6                | Usa NDP al posto di ARP                           |
| `67/68` UDP           | **7** (Applicazione)  | DHCP                | Assegnazione IP dinamica (sostituisce RARP)       |
| ICMPv6 tipo 135/136   | **3** (Rete)          | NDP (IPv6)          | Equivalente di ARP per IPv6                       |
___
# Confronto

  **ARP vs NDP (IPv6)**

| Caratteristica               | ARP (IPv4)                                     | NDP — Neighbor Discovery (IPv6)                         |
| ---------------------------- | ---------------------------------------------- | ------------------------------------------------------- |
| **Protocollo base**          | Protocollo indipendente (EtherType `0x0806`)   | Basato su ICMPv6 (tipi 135/136)                         |
| **Meccanismo discovery**     | Broadcast L2                                   | Multicast Solicited-Node (più efficiente)               |
| **Autenticazione**           | Nessuna                                        | Supporta **SeND** (Secure Neighbor Discovery)           |
| **Rilevamento duplicati**    | ARP Probe (RFC 5227)                           | DAD — Duplicate Address Detection integrata             |
| **Scalabilità**              | Bassa (broadcast su tutta LAN)                 | Alta (multicast limita i destinatari)                   |
| **Configurazione router**    | Non gestita                                    | Router Advertisement/Solicitation integrati             |
| **Stateless Autoconf**       | Non supportata                                 | Supportata (SLAAC)                                      |
| **Sicurezza integrata**      | No                                             | Sì (opzionale con SeND)                                 |

___
# Aspetti di Sicurezza

## Vulnerabilità Note
- **Assenza di autenticazione**: ARP non verifica l'identità di chi risponde. Qualsiasi host può inviare un ARP Reply con informazioni false senza che il ricevente possa accorgersene.
- **Cache update non verificato**: I sistemi operativi aggiornano la ARP cache anche in risposta a Reply **non richiesti** (Gratuitous ARP). Questo è intenzionale per supportare failover, ma apre la porta al poisoning.
- **Broadcast domain exposure**: Tutti gli host sulla stessa VLAN ricevono ogni ARP Request, aumentando la superficie di attacco.
## Attacchi Comuni
- **ARP Spoofing / ARP Poisoning**: L'attaccante invia ARP Reply fasulle per associare il proprio MAC all'IP di un host legittimo (es. il gateway). Le vittime aggiornano la cache con il MAC dell'attaccante, che intercetta tutto il traffico destinato a quell'IP.
- **Man-in-the-Middle (MitM)**: Conseguenza diretta dell'ARP Spoofing. L'attaccante si posiziona tra due host e può leggere, modificare o bloccare il traffico in transito.
- **Denial of Service (ARP DoS)**: Invio massiccio di ARP Reply fasulle per corrompere le cache di tutti gli host, causando interruzioni di connettività.
- **ARP Storm**: Numero elevato di ARP Request simultanee (es. da broadcast storm o misconfiguration) che satura la banda della LAN e la CPU degli host.
- **MAC Flooding (correlato)**: Riempimento della CAM table dello switch con MAC fittizi, forzandolo in modalità hub e facilitando lo sniffing del traffico.

## Contromisure
- **Dynamic ARP Inspection (DAI)**: Funzionalità degli switch managed (es. Cisco). Lo switch valida ogni messaggio ARP confrontandolo con la tabella **DHCP Snooping Binding** (IP ↔ MAC ↔ porta). I messaggi non corrispondenti vengono scartati. Configurazione: `ip arp inspection vlan <id>`.
- **DHCP Snooping**: Prerequisito per DAI. Lo switch registra le assegnazioni DHCP (IP, MAC, porta, VLAN) creando una binding table trusted.
- **Static ARP Entries**: Configurare manualmente le entry ARP critiche (es. gateway) impedisce la sovrascrittura tramite Reply fasulli. Poco scalabile, adatto solo per host fissi.
- **Port Security**: Limita il numero di MAC per porta switch, riducendo attacchi di MAC flooding.
- **VLAN Segmentation**: Limitare la dimensione dei broadcast domain riduce il raggio d'azione di un attacco ARP Spoofing.
- **ARP Watch / Monitoraggio**: Tool come `arpwatch` rilevano variazioni inattese nelle mappature IP → MAC e generano alert.

___
# Comandi Cisco IOS

```bash
# Visualizzare la ARP cache del router
show arp

# ARP cache filtrata per IP specifico
show arp 192.168.1.1

# ARP cache filtrata per interfaccia
show arp interface GigabitEthernet0/0

# Cancellare una entry ARP specifica
clear arp-cache 192.168.1.10

# Cancellare tutta la ARP cache
clear arp-cache

# Aggiungere una entry ARP statica
arp 192.168.1.50 aabb.ccdd.ee01 arpa

# Impostare il timeout ARP su un'interfaccia (default: 4 ore = 14400 sec)
interface GigabitEthernet0/0
 arp timeout 300

# Abilitare DHCP Snooping (prerequisito per DAI)
ip dhcp snooping
ip dhcp snooping vlan 10

# Definire porte trusted per DHCP Snooping (es. uplink verso server DHCP)
interface GigabitEthernet0/1
 ip dhcp snooping trust

# Abilitare Dynamic ARP Inspection (DAI)
ip arp inspection vlan 10

# Definire porte trusted per DAI (es. uplink verso router)
interface GigabitEthernet0/1
 ip arp inspection trust

# Verificare DAI e statistiche
show ip arp inspection
show ip arp inspection statistics

# Debug ARP (solo in lab — verbose)
debug arp
```

___
# Troubleshooting

**Sintomi comuni**:

| Sintomo / Errore                        | Possibili Cause Tecniche                                       | Descrizione del Fenomeno                                                                                                |
| --------------------------------------- | -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Host irraggiungibile nella LAN**      | ARP cache corrotta, IP duplicato, host down                    | Il ping fallisce anche se l'host è fisicamente connesso; la cache contiene un MAC errato o assente.                     |
| **Connettività intermittente**          | ARP Spoofing in corso, flap di interfaccia                     | La cache viene aggiornata alternativamente con il MAC corretto e quello dell'attaccante, causando interruzioni casuali. |
| **Gateway irraggiungibile**             | ARP cache del gateway scaduta o avvelenata                     | Il PC non riesce a uscire dalla LAN; l'ARP Request al gateway non riceve risposta o riceve risposta falsa.              |
| **"Duplicate IP address detected"**     | Due host con lo stesso IP, configurazione errata               | Il sistema rileva un ARP Reply per il proprio IP proveniente da un MAC diverso (ARP Probe conflict).                    |
| **Traffico intercettato / MitM**        | ARP Poisoning attivo                                           | Un attaccante ha avvelenato le cache di due host; il traffico transita per il suo MAC prima di arrivare a destinazione. |
| **DAI scarta pacchetti legittimi**      | Porta non configurata come trusted, binding table incompleta   | Lo switch scarta ARP validi perché non trova corrispondenza nella tabella DHCP Snooping.                                |

**Comandi di verifica**:
```bash
# Linux/Mac -- visualizzare la ARP cache locale
arp -n
ip neigh show

# Inviare un ARP Request manuale (verifica raggiungibilità L2)
arping -I eth0 192.168.1.1

# Monitorare variazioni ARP in tempo reale
arpwatch -i eth0

# Catturare traffico ARP con tcpdump
tcpdump -i eth0 arp
tcpdump -i eth0 -e arp    # mostra anche i MAC degli header Ethernet

# Windows -- visualizzare ARP cache
arp -a

# Windows -- cancellare ARP cache
netsh interface ip delete arpcache

# Aggiungere entry ARP statica su Linux
sudo arp -s 192.168.1.1 aa:bb:cc:dd:ee:ff

# Verificare IP duplicati sulla LAN
arping -D -I eth0 192.168.1.10
```

**Cause frequenti**:

| Problema                    | Causa Tecnica                                                               | Sintomo e Comportamento                                                                                                |
| --------------------------- | --------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **MTU Mismatch**            | Differenza nella dimensione massima dei pacchetti tra due nodi.             | I pacchetti piccoli (ACK) passano, quelli grandi vengono scartati (**Drop**) se hanno il flag **DF** (Don't Fragment). |
| **IP Duplicato**            | Due host configurati con lo stesso indirizzo IP nella stessa subnet.        | Connettività instabile per entrambi gli host; il sistema rileva ARP Reply con MAC diverso per il proprio IP.           |
| **ARP Cache Stale**         | Entry in cache con MAC non più valido (host migrato, NIC sostituita).       | Ping fallisce nonostante l'host sia attivo; basta cancellare la cache per ripristinare la connettività.                |
| **DAI misconfiguration**    | Porta uplink non marcata come trusted; DHCP Snooping non attivo.            | Lo switch scarta ARP legittimi; gli host non riescono a risolvere i MAC anche se fisicamente connessi.                 |
___
# Note Esame

## Da sapere a memoria

| Argomento                   | Dettagli Tecnici                                                                          |
| --------------------------- | ----------------------------------------------------------------------------------------- |
| **Definizione**             | Protocollo L2/L2.5, risolve IP → MAC sulla stessa LAN. RFC 826 (1982).                    |
| **EtherType**               | `0x0806` — identifica un frame Ethernet contenente ARP.                                   |
| **Dimensione pacchetto**    | **28 byte** fissi (per IPv4 su Ethernet).                                                 |
| **ARP Request**             | Inviata in **broadcast** (`FF:FF:FF:FF:FF:FF`). OPER = `1`.                               |
| **ARP Reply**               | Inviata in **unicast**. OPER = `2`.                                                       |
| **Gratuitous ARP**          | ARP Request con SPA = TPA (stesso IP). Usato per failover e conflict detection.           |
| **ARP Cache TTL**           | Variabile per OS: Linux ~60s, Windows ~45s, Cisco IOS default 4 ore (14400s).             |
| **ARP Spoofing**            | Invio di Reply fasulle per avvelenare le cache; porta a MitM.                             |
| **Contromisura principale** | **Dynamic ARP Inspection (DAI)** su switch managed + **DHCP Snooping** come prerequisito. |
| **Equivalente IPv6**        | **NDP** (Neighbor Discovery Protocol) — usa ICMPv6 Neighbor Solicitation/Advertisement.   |
| **Incapsulamento**          | ARP viaggia **dentro un frame Ethernet** (non IP). Non usa porte UDP/TCP.                 |

## Trabocchetti frequenti

| Concetto Errato                              | Realtà Tecnica                                                                                            |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| **ARP funziona su Internet**                 | **FALSO**. ARP è limitato alla **stessa subnet (LAN)**. Oltre il gateway, si usa l'IP del router.         |
| **ARP usa porte UDP**                        | **FALSO**. ARP è incapsulato direttamente in Ethernet con EtherType `0x0806`, non usa IP né porte.        |
| **ARP Reply viene inviata in broadcast**     | **FALSO**. La Reply è **unicast** verso il MAC del richiedente. Solo la Request è broadcast.              |
| **ARP è affidabile**                         | **FALSO**. Non c'è conferma di ricezione, nessun ACK, nessuna ritrasmissione automatica.                  |
| **ARP è un protocollo di livello 3**         | **PARZIALMENTE FALSO**. Opera al confine L2/L3: trasportato da L2 (Ethernet), gestisce indirizzi L3 (IP). |
| **Gratuitous ARP è sempre un attacco**       | **FALSO**. È usato legittimamente per failover (HSRP/VRRP) e rilevamento duplicati.                       |
| **ARP funziona anche su IPv6**               | **FALSO**. IPv6 usa **NDP** (ICMPv6), non ARP.                                                            |
| **Cancellare la ARP cache è pericoloso**     | **FALSO**. È sicuro ed è spesso la prima mossa nel troubleshooting L2.                                    |

___
# Quick Reference Card

```
- ARP: risolve IP -> MAC sulla stessa LAN (RFC 826)

- Request = BROADCAST (FF:FF:FF:FF:FF:FF) | OPER=1

- Reply   = UNICAST verso richiedente      | OPER=2

- Gratuitous ARP: SPA=TPA, annuncia il proprio IP/MAC

- ARP NON usa porte, NON usa IP -- EtherType 0x0806

- ARP e' limitato alla subnet -- oltre il router non funziona

- Attacco principale: ARP Spoofing -> MitM

- Difesa principale: Dynamic ARP Inspection (DAI) + DHCP Snooping

- Equivalente IPv6: NDP (ICMPv6 tipo 135/136)

- Cache Cisco default timeout: 4 ore (14400s)
```

___
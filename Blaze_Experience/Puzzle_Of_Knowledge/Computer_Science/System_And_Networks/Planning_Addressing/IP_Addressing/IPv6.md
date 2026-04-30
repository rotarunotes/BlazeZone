Data: 2026-05-01

[IP_Addressing](./README.md)

#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/IP_Addressing

___

# Index

- [[#Internet Protocol version 6]]

    - [[#Panoramica]]

- [[#Versioni & Evoluzione]]

- [[#Come Funziona]]

  - [[#Struttura di un Indirizzo IPv6]]

  - [[#Abbreviazione degli Indirizzi]]

  - [[#Prefisso e Lunghezza del Prefisso]]

  - [[#Tipi di Indirizzi]]

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

# Internet Protocol version 6

  

## Panoramica

  

| Caratteristica              | Dettaglio                                                                                                  |
| --------------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Livello OSI**             | 3 — Rete                                                                                                   |
| **Porta**                   | Identificato dal servizio                                                                                  |
| **Scopo**                   | Identificare e instradare pacchetti su reti diverse tramite indirizzi logici a 128 bit, successore di IPv4 |
| **RFC / Standard**          | RFC 8200                                                                                                   |
| **Tipo Connessione**        | **Connectionless** (senza stato, ogni pacchetto è indipendente)                                            |
| **Affidabilità**            | **Non affidabile** (best-effort delivery, nessun ACK a livello IP)                                         |
| **PDU (Unità Dati)**        | **Pacchetto** (Packet)                                                                                     |
| **Meccanismo di Controllo** | Hop Limit (sostituisce TTL), Extension Headers, Flow Label per QoS                                         |
___

# Versioni & Evoluzione

  

| Versione / RFC | Anno | Novità principali |

| --- | --- | --- |

| RFC 1883 | 1995 | Prima specifica IPv6 — indirizzi 128 bit, header semplificato |

| RFC 2460 | 1998 | Revisione e consolidamento della specifica IPv6 |

| RFC 4291 | 2006 | Architettura degli indirizzi IPv6 — unicast, multicast, anycast |

| RFC 4862 | 2007 | SLAAC — Stateless Address Autoconfiguration |

| RFC 4861 | 2007 | NDP — Neighbor Discovery Protocol (sostituisce ARP) |

| RFC 8200 | 2017 | Standard corrente IPv6 — consolida e aggiorna RFC 2460 |

  

___

# Come Funziona

  

IPv6 opera a livello 3 del modello OSI con gli stessi compiti fondamentali di IPv4 — **indirizzamento** e **instradamento** — ma con un design profondamente rivisto per eliminare i limiti strutturali del predecessore.

  

## Struttura di un Indirizzo IPv6

  

Un indirizzo IPv6 è composto da **128 bit**, scritti in **notazione esadecimale** divisa in 8 gruppi da 16 bit (hextets), separati da due punti (`:`).

  

```

Completo:   2001:0db8:0000:0000:0000:ff00:0042:8329

```

  

## Abbreviazione degli Indirizzi

  

Due regole permettono di abbreviare gli indirizzi:

  

1. **Omissione degli zeri iniziali** in ogni gruppo:

```

2001:0db8:0000:0000:0000:ff00:0042:8329

→ 2001:db8:0:0:0:ff00:42:8329

```

  

2. **Sostituzione di una sequenza consecutiva di gruppi tutti zero** con `::` (solo una volta per indirizzo):

```

2001:db8:0:0:0:ff00:42:8329

→ 2001:db8::ff00:42:8329

```

  

## Prefisso e Lunghezza del Prefisso

  

IPv6 usa la notazione **CIDR** come IPv4: il numero dopo `/` indica i bit riservati alla rete.

Non esiste una subnet mask separata.

  

```

2001:db8::/32   →  primi 32 bit = rete, restanti 96 bit = host/interfaccia

```

  

Il suffisso a 64 bit (Interface ID) identifica il dispositivo nella rete ed è spesso derivato dall'indirizzo MAC tramite il processo **EUI-64**.

  

## Tipi di Indirizzi

  

IPv6 elimina il broadcast e introduce tre categorie:

  

| Tipo | Prefisso tipico | Descrizione |

| --- | --- | --- |

| **Unicast** | vari | Un mittente → un destinatario |

| **Multicast** | `ff00::/8` | Un mittente → un gruppo di destinatari (sostituisce broadcast e ARP) |

| **Anycast** | assegnato da operatore | Un mittente → il più vicino tra un gruppo di nodi con stesso indirizzo |

  

**Principali indirizzi unicast:**

  

| Tipo | Range / Prefisso | Equivalente IPv4 | Uso |

| --- | --- | --- | --- |

| **Global Unicast** | `2000::/3` | IP pubblico | Instradabile su Internet |

| **Link-local** | `fe80::/10` | `169.254.x.x` (APIPA) | Solo sul segmento locale, non instradato |

| **Unique Local (ULA)** | `fc00::/7` | `10.x.x.x` / `192.168.x.x` | Rete privata, non instradabile su Internet |

| **Loopback** | `::1` | `127.0.0.1` | Test stack locale |

| **Unspecified** | `::` | `0.0.0.0` | Sorgente DHCP iniziale / default route |

  

**Autoconfigurazione (SLAAC):** Un host IPv6 può configurarsi autonomamente senza DHCP:

1. Genera un indirizzo link-local (`fe80::` + Interface ID da MAC via EUI-64).

2. Invia un **Router Solicitation** (RS) al multicast `ff02::2` (tutti i router).

3. Il router risponde con un **Router Advertisement** (RA) contenente il prefisso di rete.

4. L'host combina prefisso (64 bit) + Interface ID (64 bit) → indirizzo Global Unicast definitivo.

  

**NDP (Neighbor Discovery Protocol):** Sostituisce ARP usando messaggi ICMPv6:

- **Neighbor Solicitation (NS)** → equivalente ARP Request (trova il MAC di un IP).

- **Neighbor Advertisement (NA)** → equivalente ARP Reply (risponde con il proprio MAC).

  

___

# Flusso Operativo

  

```

       Host A                              Router                    Host B

  2001:db8::1/64                       gateway locale           2001:db9::5/64

        |                                   |                         |

1)      | dest: 2001:db9::5 ≠ rete locale   |                         |

        |                                   |                         |

        |------ Pacchetto IPv6 ------------>|                         |

        |  src:  2001:db8::1                |                         |

        |  dst:  2001:db9::5                |                         |

        |  Hop Limit: 64                    |                         |

        |                                   |                         |

2)      |  Router consulta tabella          |                         |

        |  di routing                       |                         |

        |                                   |                         |

3)      |                                   | Hop Limit decrementato: 63

        |                                   |                         |

4)      |                                   |------ Pacchetto IPv6 -->|

        |                                   |  src:  2001:db8::1      |

        |                                   |  dst:  2001:db9::5      |

        |                                   |  Hop Limit: 63          |

```

  

| Fase | # | Azione | Note |

| --- | --- | --- | --- |

| **Locale** | 1 | L'host confronta il prefisso di destinazione col proprio | Stesso prefisso → NDP (Neighbor Solicitation); altrimenti → gateway |

| **Forwarding** | 2 | Il router consulta la routing table (longest prefix match) | Identico ad IPv4; usa le entry più specifiche |

| **Hop Limit** | 3 | Ogni router decrementa Hop Limit di 1 | Se Hop Limit = 0 → scarta e invia ICMPv6 "Time Exceeded" |

| **Arrivo** | 4 | L'ultimo router consegna al segmento finale via NDP | NDP (NS/NA) sostituisce ARP per la risoluzione MAC |

  

___

# Casi d'Uso Reali

  

- **Navigazione web nativa IPv6**: Molti grandi siti (Google, Facebook, Cloudflare) sono già raggiungibili via IPv6. Il browser risolve il nome via DNS (record AAAA invece di A), poi IPv6 instrada il traffico direttamente senza NAT, semplificando il percorso end-to-end.

- **Reti IoT e dispositivi mobili**: Con miliardi di dispositivi connessi, IPv6 elimina la necessità di NAT assegnando a ogni dispositivo un indirizzo pubblico univoco. I sensori industriali e i dispositivi smart home comunicano direttamente senza middlebox.

- **Transizione IPv4/IPv6 con dual stack**: La maggior parte delle reti aziendali usa oggi il **dual stack**: ogni dispositivo ha sia un indirizzo IPv4 che IPv6. Il traffico usa IPv6 quando disponibile e cade su IPv4 come fallback, garantendo compatibilità durante la migrazione.

- **Reti mobili (4G/5G)**: Gli operatori mobili assegnano indirizzi IPv6 agli smartphone tramite SLAAC o DHCPv6. Il prefisso `/64` permette ai dispositivi di auto-configurarsi appena si collegano a una nuova cella.

- **Data center e cloud**: Provider come AWS, Azure e GCP assegnano indirizzi IPv6 alle istanze, permettendo comunicazione diretta tra server senza traduzione NAT e semplificando le politiche di sicurezza.

  

___

# Limitazioni Tecniche

  

- **Transizione lenta e costosa**: Nonostante la disponibilità da decenni, l'adozione di IPv6 su Internet è intorno al 40-45%. Moltissimi apparati legacy, firewall e applicazioni supportano solo IPv4, rendendo la migrazione complessa e graduale.

- **Nessuna backward compatibility nativa con IPv4**: IPv6 e IPv4 sono protocolli separati. I meccanismi di transizione (dual stack, tunneling, NAT64) aggiungono complessità operativa e possono introdurre problemi di performance e sicurezza.

- **Complessità degli indirizzi**: Gli indirizzi a 128 bit in esadecimale sono più difficili da memorizzare, digitare e fare troubleshooting rispetto a IPv4. L'errore umano nella configurazione manuale è più probabile.

- **NDP vulnerabile a spoofing**: Il Neighbor Discovery Protocol non include autenticazione nativa. Un attaccante sulla stessa rete può inviare falsi Router Advertisement o Neighbor Advertisement (SEcure Neighbor Discovery — SEND — è raramente implementato).

- **Frammentazione solo all'origine**: In IPv6 i router intermedi non frammentano i pacchetti. Se il mittente non usa Path MTU Discovery e invia pacchetti troppo grandi, vengono scartati con ICMPv6 "Packet Too Big". La MTU minima garantita è 1280 byte.

- **Gestione degli indirizzi più complessa**: La notazione esadecimale, le regole di abbreviazione e la distinzione tra link-local/ULA/global unicast richiedono una comprensione più approfondita rispetto al classful IPv4.

  

___

# PDU & Incapsulamento

  

- **Nome PDU**: Pacchetto (Packet / Datagram)

- **Incapsulato in**: Frame di livello 2 (Ethernet, Wi-Fi, PPP…)

- **Incapsula**: Segmento TCP, Datagramma UDP, o altri protocolli L4 (ICMPv6, OSPFv3…)

  

```

L1 [ Header Cavo/Wi-Fi ] PDU: Bit

  L2 [ Header Ethernet ] PDU: Frame

      L3 [ Header IPv6 ] PDU: Pacchetto

          L4-7 [ Payload ]

```

  

___

# Struttura Del Pacchetto

  

## Header

  

L'header IPv6 è **fisso a 40 byte** (a differenza dei 20–60 byte variabili di IPv4). Le funzioni opzionali sono delegate agli **Extension Headers**, inseriti tra l'header principale e il payload.

  

| Campo | Dimensione | Descrizione |

| --- | --- | --- |

| **Version** | 4 bit | Versione IP (valore = 6 per IPv6) |

| **Traffic Class** | 8 bit | Priorità e QoS (equivalente DSCP/ToS di IPv4) |

| **Flow Label** | 20 bit | Identifica un flusso di pacchetti per trattamento QoS consistente |

| **Payload Length** | 16 bit | Dimensione del payload in byte (extension headers inclusi, header principale escluso) |

| **Next Header** | 8 bit | Identifica il protocollo successivo (TCP=6, UDP=17, ICMPv6=58, Extension Header…) |

| **Hop Limit** | 8 bit | Equivalente del TTL di IPv4 — decrementato di 1 ad ogni router |

| **Source Address** | 128 bit | Indirizzo IPv6 del mittente |

| **Destination Address** | 128 bit | Indirizzo IPv6 del destinatario |

  

```

 0                   1                   2                   3

 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

|Version| Traffic Class |            Flow Label                 |

| 4 bit |    8 bit      |              20 bit                   |

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

|         Payload Length        |  Next Header  |   Hop Limit   |

|            16 bit             |    8 bit      |    8 bit      |

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

|                                                               |

|                    Source Address (128 bit)                   |

|                                                               |

|                                                               |

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

|                                                               |

|                 Destination Address (128 bit)                 |

|                                                               |

|                                                               |

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

|                                                               |

|         Extension Headers (opzionali) + Payload              |

|                                                               |

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

```

  

## Body

- Dati dei Protocolli di Trasporto: TCP, UDP

- Messaggi di Controllo e Diagnostica: ICMPv6 (include le funzioni di ARP e IGMP di IPv4)

- Extension Headers (se presenti): Hop-by-Hop Options, Routing, Fragment, Destination Options, Authentication (AH), ESP

  

## Flags

  

IPv6 non ha un campo Flags separato come IPv4. Le funzioni equivalenti sono gestite tramite **Extension Headers** e il campo **Next Header**:

  

| Extension Header | Next Header ID | Equivalente IPv4 | Scopo |

| --- | --- | --- | --- |

| **Hop-by-Hop Options** | 0 | Options field | Opzioni esaminate da ogni router lungo il percorso |

| **Routing** | 43 | Loose Source Routing | Specifica un percorso parziale verso la destinazione |

| **Fragment** | 44 | Flags DF/MF + Offset | Frammentazione — solo il mittente può frammentare in IPv6 |

| **Destination Options** | 60 | Options field | Opzioni esaminate solo dal destinatario finale |

| **Authentication (AH)** | 51 | IPsec AH | Autenticazione e integrità del pacchetto |

| **Encapsulating Security Payload (ESP)** | 50 | IPsec ESP | Cifratura e autenticazione del payload |

  

___

# Porte e Protocolli Correlati

  

| Porta | Livello OSI | Protocollo | Uso |

| --- | --- | --- | --- |

| **53** | **7** (Applicazione) | DNS (AAAA) | Risoluzione nomi → indirizzo IPv6 (record AAAA) |

| **546** | **7** (Applicazione) | DHCPv6 Client | Ricezione configurazione dal server DHCPv6 |

| **547** | **7** (Applicazione) | DHCPv6 Server | Ascolto richieste client per assegnazione IP |

| — | **3** (Rete) | ICMPv6 (58) | NDP, Path MTU Discovery, diagnostica (ping6, traceroute6) |

| — | **3** (Rete) | OSPFv3 (89) | Routing dinamico su IPv6 |

  

___

# Confronto

  

**IPv6 vs IPv4**

  

| Caratteristica | IPv6 | IPv4 |

| --- | --- | --- |

| **Lunghezza indirizzo** | 128 bit | 32 bit |

| **Notazione** | Esadecimale con colons (`2001:db8::1`) | Decimale puntata (`192.168.1.1`) |

| **Spazio indirizzi** | ~340 undecilioni | ~4,3 miliardi |

| **Header** | Fisso (40 byte), senza checksum | Variabile (20–60 byte), checksum incluso |

| **Frammentazione** | Solo host sorgente | Router e host |

| **Broadcast** | No (sostituito da multicast) | Sì |

| **Risoluzione MAC** | NDP / ICMPv6 (multicast) | ARP (broadcast L2) |

| **IPsec** | Nativo nel design | Opzionale |

| **Autoconfigurazione** | SLAAC nativa (senza server) | Solo DHCP o manuale |

| **NAT** | Non necessario (indirizzi sufficienti) | Quasi obbligatorio (indirizzi esauriti) |

| **Checksum header** | Assente (delegato a L4) | Presente (16 bit) |

| **QoS** | Traffic Class + Flow Label (28 bit) | ToS/DSCP (8 bit) |

  

___

# Aspetti di Sicurezza

  

## Vulnerabilità Note

- **NDP Spoofing (Rogue RA / NA)**: In assenza di protezioni, un attaccante sulla stessa rete può inviare falsi Router Advertisement, reindirizzando il traffico di tutti gli host attraverso il proprio dispositivo. Equivalente al Gratuitous ARP poisoning di IPv4.

- **SLAAC Attack**: Un attaccante invia RA non autorizzati con un prefisso falso, causando misconfigurazioni degli indirizzi sugli host della rete.

- **ICMPv6 come vettore di ricognizione**: Poiché ICMPv6 è essenziale per NDP, bloccarlo completamente rompe la rete. I firewall devono consentire ICMPv6 selettivamente, lasciando superficie d'attacco.

- **Extension Header Abuse**: Catene di extension header molto lunghe o malformate possono bypassare sistemi di ispezione o causare crash in implementazioni non robuste.

  

## Attacchi Comuni

- **Rogue Router Advertisement**: Invio di RA con prefisso e gateway falsi per intercettare il traffico (MitM) o degradare il servizio (DoS).

- **Neighbor Cache Exhaustion**: Flooding di Neighbor Solicitation per esaurire la cache NDP del router, causando denial of service.

- **IPv6 Tunneling su reti IPv4**: Protocolli di transizione come 6to4 o Teredo possono bypassare i firewall aziendali configurati solo per IPv4, creando canali nascosti.

- **Amplification via Multicast**: Analogia con lo Smurf attack IPv4 — pacchetti inviati a indirizzi multicast `ff02::` possono generare risposte amplificate.

  

## Contromisure

- **RA Guard**: Configurazione sugli switch che permette Router Advertisement solo da porte autorizzate (porte router). Blocca i Rogue RA da host non autorizzati.

- **DHCPv6 Snooping**: Equivalente del DHCP Snooping IPv4 — filtra i messaggi DHCPv6 per prevenire server DHCPv6 non autorizzati.

- **SEND (SEcure Neighbor Discovery)**: Estensione crittografica di NDP basata su certificati per autenticare router e host. Raramente implementato per complessità operativa.

- **Firewall con supporto IPv6 nativo**: Molti firewall legacy non ispezionano correttamente IPv6 o i suoi extension headers. È necessario usare firewall con supporto completo dual-stack.

- **Disabilitare protocolli di transizione non usati**: 6to4, ISATAP e Teredo dovrebbero essere disabilitati nelle reti che non li richiedono esplicitamente.

  

___

# Comandi Cisco IOS

  

```bash

# Abilitare il routing IPv6 globalmente (obbligatorio)

ipv6 unicast-routing

  

# Assegnare un indirizzo IPv6 a un'interfaccia

interface GigabitEthernet0/0

  ipv6 address 2001:db8::1/64

  ipv6 address fe80::1 link-local

  no shutdown

  

# Abilitare SLAAC / EUI-64 (l'interfaccia genera il suo indirizzo dal MAC)

interface GigabitEthernet0/0

  ipv6 address 2001:db8::/64 eui-64

  

# Visualizzare gli indirizzi IPv6 configurati

show ipv6 interface brief

  

# Dettaglio completo di un'interfaccia IPv6

show ipv6 interface GigabitEthernet0/0

  

# Visualizzare la tabella di routing IPv6

show ipv6 route

  

# Configurare una route statica IPv6

ipv6 route 2001:db9::/64 2001:db8::254

  

# Configurare un default route IPv6

ipv6 route ::/0 2001:db8::254

  

# Visualizzare la tabella Neighbor Discovery (equivalente ARP)

show ipv6 neighbors

  

# Verificare connettività IPv6

ping ipv6 2001:db8::1

ping 2001:db8::1 source GigabitEthernet0/0

  

# Tracciare il percorso IPv6

traceroute ipv6 2001:db8::1

  

# Abilitare OSPFv3 per IPv6

ipv6 router ospf 1

  router-id 1.1.1.1

  

interface GigabitEthernet0/0

  ipv6 ospf 1 area 0

  

# Visualizzare le statistiche ICMPv6

show ipv6 traffic

  

# Abilitare RA Guard su uno switch (protezione da Rogue RA)

ipv6 nd raguard policy ROUTER_ONLY

  device-role router

interface GigabitEthernet0/1

  ipv6 nd raguard attach-policy ROUTER_ONLY

```

  

___

# Troubleshooting

  

**Sintomi comuni:**

  

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |

| --- | --- | --- |

| **Nessun indirizzo Global Unicast** | Router non invia RA, SLAAC disabilitato, prefisso errato | L'host ha solo un indirizzo link-local (`fe80::`) ma non riesce ad auto-configurarsi con un indirizzo globale |

| **"Destination unreachable - No route"** | Route mancante, default gateway non configurato | Il router non sa come raggiungere la destinazione IPv6 |

| **Ping verso link-local fallisce** | Interfaccia di uscita non specificata | Gli indirizzi `fe80::` sono validi solo sul segmento locale — occorre specificare l'interfaccia (`ping fe80::1%eth0`) |

| **NDP non risolve il MAC** | Firewall blocca ICMPv6, neighbor cache piena | L'host non riesce a trovare il MAC dell'indirizzo di destinazione — equivalente ARP failure in IPv4 |

| **Connettività IPv4 OK, IPv6 KO** | Dual stack mal configurato, firewall blocca IPv6, RA non arriva | L'host ha solo un indirizzo link-local o l'indirizzo globale non è raggiungibile da Internet |

| **Pacchetti "Packet Too Big" ICMPv6** | MTU del percorso inferiore a quella del mittente, firewall blocca ICMPv6 | Il mittente invia pacchetti troppo grandi; in IPv6 sono i router a segnalarlo (non a frammentare) |

  

**Comandi di verifica:**

  

```bash

# Linux/Mac — configurazione IPv6 locale

ip -6 addr show

ifconfig | grep inet6

  

# Tabella di routing IPv6

ip -6 route show

  

# Equivalente ARP per IPv6 (tabella NDP)

ip -6 neigh show

  

# Ping IPv6 (specificare interfaccia per link-local)

ping6 2001:db8::1

ping6 fe80::1%eth0

  

# Traceroute IPv6

traceroute6 2001:db8::1

traceroute -6 2001:db8::1     # Linux alternativo

  

# Cattura traffico IPv6 e ICMPv6

tcpdump -i eth0 ip6

tcpdump -i eth0 icmp6

  

# Verifica record DNS AAAA

dig AAAA google.com

nslookup -type=AAAA google.com

```

  

**Cause frequenti:**

  

| Problema | Causa Tecnica | Sintomo e Comportamento |

| --- | --- | --- |

| **MTU Mismatch** | Il percorso ha un link con MTU inferiore a 1500 byte | ICMPv6 "Packet Too Big" viene inviato al mittente; se il firewall blocca ICMPv6 il traffico si blocca silenziosamente |

| **RA bloccato dal firewall** | Il firewall filtra ICMPv6 Type 134 (Router Advertisement) | Gli host non ricevono il prefisso di rete e non completano SLAAC; rimangono con solo indirizzo link-local |

| **Dual Stack con Happy Eyeballs** | Il client preferisce IPv6 ma il percorso IPv6 è degradato | Il browser tenta prima IPv6, aspetta un timeout, poi cade su IPv4 — navigazione lenta ma funzionante |

| **Indirizzo temporaneo Privacy Extensions** | Linux/Windows generano Interface ID casuali per privacy | L'indirizzo dell'host cambia periodicamente — difficile tracciare le connessioni nei log di rete |

  

___

# Note Esame

  

## Da sapere a memoria

  

| Argomento | Dettagli Tecnici |

| --- | --- |

| **Definizione** | Layer 3 (Rete), connectionless, best-effort, indirizzi 128 bit. |

| **Standard RFC** | Corrente: **8200** (2017); Architettura indirizzi: **4291**; NDP: **4861**; SLAAC: **4862** |

| **Dimensione Header** | Fisso **40 byte** (nessun campo Options, nessun Checksum) |

| **Notazione** | 8 gruppi da 16 bit in esadecimale, separati da `:` — abbreviabili con `::` (una volta) |

| **Tipi principali** | Unicast · Multicast · Anycast (niente broadcast) |

| **Global Unicast** | `2000::/3` — instradabile su Internet (IP pubblico IPv6) |

| **Link-local** | `fe80::/10` — solo sul segmento locale, generato automaticamente |

| **Unique Local (ULA)** | `fc00::/7` — rete privata, non instradabile su Internet |

| **Multicast** | `ff00::/8` — sostituisce broadcast e ARP |

| **Loopback** | `::1` — equivalente di `127.0.0.1` |

| **Unspecified** | `::` — equivalente di `0.0.0.0` |

| **Hop Limit** | 8 bit — sostituisce TTL; decrementato di 1 ad ogni hop |

| **Next Header** | 8 bit — identifica protocollo successivo (6=TCP, 17=UDP, 58=ICMPv6) |

| **SLAAC** | Autoconfigurazione senza DHCP: prefisso dal RA + Interface ID (EUI-64 o casuale) |

| **NDP** | Sostituisce ARP: NS (Neighbor Solicitation) + NA (Neighbor Advertisement) via ICMPv6 |

| **Frammentazione** | Solo il mittente può frammentare; router intermedi scartano e inviano "Packet Too Big" |

| **Incapsulamento** | IPv6 viaggia dentro frame L2. PDU IPv6 = **Pacchetto** |

  

## Trabocchetti frequenti

  

| Concetto Errato | Realtà Tecnica |

| --- | --- |

| **`::` può essere usato più volte** | **FALSO**. La doppia due punti `::` può sostituire una sola sequenza di gruppi zero nell'indirizzo. Due `::` rendono l'indirizzo ambiguo. |

| **IPv6 ha risolto la sicurezza di rete** | **FALSO**. IPsec è parte del design ma non è obbligatorio nelle implementazioni pratiche. NDP è vulnerabile a spoofing senza SEND. |

| **Il broadcast viene usato in IPv6** | **FALSO**. IPv6 non ha broadcast. Le funzioni equivalenti usano indirizzi multicast specifici (es. `ff02::1` = tutti gli host). |

| **I router IPv6 frammentano i pacchetti** | **FALSO**. In IPv6 solo il mittente può frammentare tramite l'Extension Header Fragment. I router intermedi scartano e segnalano. |

| **L'indirizzo link-local è opzionale** | **FALSO**. Ogni interfaccia IPv6 abilitata genera automaticamente un indirizzo `fe80::` — è obbligatorio per NDP e SLAAC. |

| **IPv6 elimina la necessità di firewall** | **FALSO**. Con indirizzi pubblici diretti su ogni dispositivo, il firewall diventa ancora più importante (non c'è NAT come protezione implicita). |

| **`/64` è sempre il prefisso host** | **PARZIALMENTE VERO**. Per convenzione SLAAC usa sempre `/64` (64 bit rete + 64 bit Interface ID). Tecnicamente si possono usare altri prefissi, ma SLAAC richiede `/64`. |

| **DHCPv6 è necessario per IPv6** | **FALSO**. SLAAC permette la configurazione completa senza DHCPv6. DHCPv6 serve per distribuire opzioni aggiuntive (DNS, NTP) non gestite da SLAAC. |

  

___

# Quick Reference Card

  

```

TIPI DI INDIRIZZI:

  Global Unicast  → 2000::/3       instradabile su Internet

  Link-local      → fe80::/10      solo segmento locale (obbligatorio)

  Unique Local    → fc00::/7       rete privata (come 10.x / 192.168.x)

  Multicast       → ff00::/8       sostituisce broadcast e ARP

  Loopback        → ::1            equivalente 127.0.0.1

  Unspecified     → ::             equivalente 0.0.0.0

  

ABBREVIAZIONE:

  - Ometti zeri iniziali in ogni gruppo: 0042 → 42

  - Una sola sequenza di gruppi-zero → ::

  - 2001:0db8:0000:0000:0000:ff00:0042:8329

    → 2001:db8::ff00:42:8329

  

HEADER IPv6 (fisso 40 byte):

  Version(4) | Traffic Class(8) | Flow Label(20)

  Payload Length(16) | Next Header(8) | Hop Limit(8)

  Source Address(128)

  Destination Address(128)

  [Extension Headers opzionali]

  

NEXT HEADER (protocolli):

  0=Hop-by-Hop  6=TCP  17=UDP  43=Routing

  44=Fragment   58=ICMPv6  89=OSPF

  

NDP (sostituisce ARP):

  NS (Neighbor Solicitation)  → chi ha questo IP? (ARP Request)

  NA (Neighbor Advertisement) → io! (ARP Reply)

  RS (Router Solicitation)    → c'è un router? (SLAAC step 1)

  RA (Router Advertisement)   → sì, prefisso = X (SLAAC step 2)

  

SLAAC (autoconfigurazione):

  1. Genera fe80:: (link-local) via EUI-64

  2. RS → ff02::2 (tutti i router)

  3. RA ← router (prefisso /64)

  4. Indirizzo = prefisso(64bit) + Interface ID(64bit)

  

FORMULA host: spazio enorme — /64 = 2^64 host per subnet

```

  

___
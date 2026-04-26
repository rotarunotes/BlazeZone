Data: 2026-04-26
[IP_Addressing](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/IPv4
___
# Index
- [[#Internet Protocol version 4]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
- [[#Struttura di un Indirizzo IPv4]]
- [[#Classi di Indirizzi]]
- [[#Notazione CIDR]]
- [[#Subnetting]]
- [[#Indirizzi Speciali]]
- [[#Flusso Operativo — Instradamento di un Pacchetto]]
- [[#Casi d'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
	- [[#Header]]
	- [[#Flags]]
- [[#Protocolli Correlati]]
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
# Internet Protocol version 4

## Panoramica

| Caratteristica              |                                               Dettaglio                                               |
| --------------------------- | :---------------------------------------------------------------------------------------------------: |
| **Livello OSI**             |                                               3 — Rete                                                |
| **Scopo**                   | Identificare e instradare pacchetti tra dispositivi su reti diverse tramite indirizzi logici a 32 bit |
| **RFC / Standard**          |                                                RFC 791                                                |
| **Tipo Connessione**        |                    **Connectionless** (senza stato, ogni pacchetto è indipendente)                    |
| **Affidabilità**            |                  **Non affidabile** (best-effort delivery, nessun ACK a livello IP)                   |
| **PDU (Unità Dati)**        |                                        **Pacchetto** (Packet)                                         |
| **Meccanismo di Controllo** |                TTL (prevenzione loop), Checksum header, Frammentazione/Riassemblaggio                 |

___
# Versioni & Evoluzione

| Versione / RFC | Anno | Novità principali                                                       |
| -------------- | ---- | ----------------------------------------------------------------------- |
| RFC 791        | 1981 | Specifica originale IPv4 — indirizzi 32 bit, frammentazione, TTL        |
| RFC 950        | 1985 | Internet Subnetting Procedure — introduzione del subnetting             |
| RFC 1519       | 1993 | CIDR (Classless Inter-Domain Routing) — superamento delle classi rigide |
| RFC 1918       | 1996 | Indirizzi privati — definizione dei range non instradabili su Internet  |
| RFC 3022       | 2001 | NAT (Network Address Translation) — gestione degli IP privati           |
| RFC 6864       | 2013 | Revisione del campo Identification per la frammentazione                |

___
# Come Funziona

IPv4 opera a livello 3 del modello OSI e si occupa di due compiti fondamentali: **indirizzamento** e **instradamento**.
- **Indirizzamento**: Ogni dispositivo su una rete IP riceve un indirizzo a 32 bit univoco all'interno del suo dominio. 
  L'indirizzo è diviso in due parti logiche Il cui confine è determinato dalla **subnet mask**.
	- **Parte di rete** e
	- **Parte di host**
- **Instradamento (routing)**: Quando un host invia un pacchetto, confronta l'IP di destinazione con la propria subnet mask. 
  Se la destinazione è nella stessa rete (stesso network address), il pacchetto viene consegnato direttamente al livello 2 (ARP → MAC address). 
  Se è su una rete diversa, il pacchetto viene inoltrato al **default gateway** (router), che ripete il processo su ogni hop fino alla destinazione.

**Best-effort delivery**: IPv4 non garantisce consegna, ordine, né assenza di duplicati. Queste responsabilità sono delegate ai livelli superiori (es. TCP al livello 4).

**TTL (*Time To Live*)**: Ogni pacchetto nasce con un valore TTL (tipicamente 64 o 128). Ogni router che lo attraversa decrementa il TTL di 1. Quando arriva a 0, il pacchetto viene scartato e viene inviato un messaggio ICMP "Time Exceeded" al mittente. Questo meccanismo previene i loop di routing infiniti.

**Frammentazione**: Ogni link ha una MTU (*Maximum Transmission Unit*) la dimensione massima di un pacchetto che può attraversarlo (Ethernet: 1500 byte).
- **Frammentazione**: se un pacchetto supera la MTU, il router lo spezza in frammenti più piccoli, ognuno con il proprio header IPv4. Il destinatario finale li riassembla tramite il campo **Fragment Offset**. 
	- Costo: overhead per ogni frammento, e se uno si perde l'intero pacchetto va ritrasmesso.
- **Path MTU Discovery**: alternativa preferibile, il mittente imposta il flag **DF** (*Don't Fragment*). Se un router trova il pacchetto troppo grande, lo scarta e risponde con ICMP "Fragmentation Needed" indicando la sua MTU. Il mittente riduce la dimensione e riprova, finché trova la MTU più restrittiva dell'intero percorso.
## Struttura di un Indirizzo IPv4
Un indirizzo IPv4 è composto da **32 bit**, scritti in **notazione decimale puntata**: 4 gruppi da 8 bit (ottetti) separati da punti.

```
Decimale:        192.       168.         1.        1
Binario:   11000000 . 10101000 . 00000001 . 00000001
```

La **subnet mask** determina il confine tra la parte di rete e la parte di host:

```
IP:   192.168.10.45   →  11000000.10101000.00001010.00101101
Mask: 255.255.255.0   →  11111111.11111111.11111111.00000000
                                                    ^^^^^^^^
                                                    parte host
```

### Operazioni fondamentali
Per ricavare le informazioni di una rete dato un **indirizzo IP** e una **subnet mask**, si eseguono alcune operazioni bit a bit sull'indirizzo.
#### Network address
È il primo indirizzo della rete, identifica la rete stessa e non è assegnabile ad un host.
- Si ottiene con un AND bit a bit tra **IP** e **subnet mask**.
$$\text{Network} = \text{IP} \land \text{Mask}$$
$$192.168.10.0 = 192.168.10.45 \land 255.255.255.0$$
#### Broadcast
È l'ultimo indirizzo della rete, un pacchetto inviato a questo indirizzo raggiunge tutti gli host della rete.
- Si ottiene con un OR bit a bit tra l'**indirizzo di rete** e la subnet mask **inversa**.
$$\text{Broadcast} = \text{Network} \lor \lnot\text{Mask}$$
$$192.168.10.255 = 192.168.10.0 \lor 0.0.0.255$$

| Tipo                   | Indirizzo esempio | Scope               | Instradabile?    |
| ---------------------- | ----------------- | ------------------- | ---------------- |
| **Broadcast limitato** | `255.255.255.255` | Rete locale (L2)    | ❌ No             |
| **Broadcast diretto**  | `192.168.1.255`   | Rete specifica (L3) | ✅ (se abilitato) |
#### Numero di host
Il numero di indirizzi assegnabili agli host.
- Si sottraggono 2 perché **network** e **broadcast** non sono assegnabili.
$$\text{Host} = 2^{Nbit} - 2$$
$$254 = 2^8 - 2$$
#### Primo host
- Il primo indirizzo assegnabile ad un host.
$$\text{Primo host} = \text{Network} + 1 = 192.168.10.1$$
#### Ultimo host
- L'ultimo indirizzo assegnabile ad un host.

$$\text{Ultimo host} = \text{Broadcast} - 1 = 192.168.10.254$$
## Classi di Indirizzi

### Classful
La suddivisione **classful** (pre-CIDR) divide lo spazio IPv4 in classi in base al primo ottetto.
Oggi è in gran parte superata dal CIDR, ma rimane importante per capire i range privati e per gli esami.

| Classe | Range primo ottetto | Range indirizzi                 | Subnet Mask default   | Uso principale         |
| ------ | ------------------- | ------------------------------- | --------------------- | ---------------------- |
| **A**  | 1 – 126             | `1.0.0.0` – `126.255.255.255`   | `255.0.0.0` <br>(/8)  | Grandi reti            |
| **B**  | 128 – 191           | `128.0.0.0` – `191.255.255.255` | `255.255.0.0` (/16)   | Reti medie             |
| **C**  | 192 – 223           | `192.0.0.0` – `223.255.255.255` | `255.255.255.0` (/24) | Reti piccole           |
| **D**  | 224 – 239           | `224.0.0.0` – `239.255.255.255` | —                     | Multicast              |
| **E**  | 240 – 255           | `240.0.0.0` – `255.255.255.255` | —                     | Riservato/Sperimentale |
#### Indirizzi Privati (RFC 1918)
Questi indirizzi **non sono instradabili su Internet** e sono riservati per reti locali (LAN).
Il NAT permette ai dispositivi con IP privato di comunicare con l'esterno.

| Classe | Range privato                     | CIDR             | Host disponibili |
| ------ | --------------------------------- | ---------------- | ---------------- |
| A      | `10.0.0.0` – `10.255.255.255`     | `10.0.0.0/8`     | ~16 milioni      |
| B      | `172.16.0.0` – `172.31.255.255`   | `172.16.0.0/12`  | ~1 milione       |
| C      | `192.168.0.0` – `192.168.255.255` | `192.168.0.0/16` | ~65.000          |

SONO ARRIVATO QUA
### Notazione CIDR

Il **CIDR** (*Classless Inter-Domain Routing*) sostituisce il sistema a classi con una notazione flessibile: 
- **indirizzo/prefisso**: Il numero dopo `/` indica quanti bit sono riservati alla parte di rete.

```
192.168.1.0/24  →  primi 24 bit = rete, ultimi 8 bit = host
```
#### Tabella CIDR di riferimento

| CIDR | Subnet Mask     | Bit host | Host disponibili |
| ---- | --------------- | -------- | ---------------- |
| /8   | 255.0.0.0       | 24       | 16.777.214       |
| /16  | 255.255.0.0     | 16       | 65.534           |
| /24  | 255.255.255.0   | 8        | 254              |
| /25  | 255.255.255.128 | 7        | 126              |
| /26  | 255.255.255.192 | 6        | 62               |
| /27  | 255.255.255.224 | 5        | 30               |
| /28  | 255.255.255.240 | 4        | 14               |
| /29  | 255.255.255.248 | 3        | 6                |
| /30  | 255.255.255.252 | 2        | 2                |
| /32  | 255.255.255.255 | 0        | 1 (host singolo) |
##### Numero di host
-  Si sottraggono 2 perché **network** e **broadcast** non sono assegnabili.
$$2^{(32 − prefisso)} − 2$$
## Subnetting

Il **subnetting** consiste nel dividere una rete più grande in sottoreti più piccole, "rubando" bit alla parte host per creare bit di sottorete aggiuntivi.
## Indirizzi Speciali

| Indirizzo / Range       | Tipo                | Descrizione                                                            |
| ----------------------- | ------------------- | ---------------------------------------------------------------------- |
| `0.0.0.0`               | Default route / Any | "Qualsiasi rete": Usato in routing e come sorgente DHCP iniziale       |
| `127.0.0.1`             | Loopback            | Localhost: Test dello stack TCP/IP, traffico non lascia il dispositivo |
| `169.254.x.x`           | APIPA / Link-local  | Auto-assegnato se DHCP non risponde                                    |
| `10.x.x.x`              | Privato Classe A    | Uso interno, non instradabile su Internet                              |
| `172.16–31.x.x`         | Privato Classe B    | Uso interno                                                            |
| `192.168.x.x`           | Privato Classe C    | Uso interno                                                            |
| `224.0.0.0 – 239.x.x.x` | Multicast           | Gruppi multicast (es. OSPF usa 224.0.0.5)                              |
| `255.255.255.255`       | Broadcast limitato  | Tutti i dispositivi sul segmento locale, Non instradato dai router     |

___
# Flusso Operativo

```
       Host A                            Router                   Host B
   192.168.1.10/24                   gateway locale             10.0.0.5/8
         |                                |                         |
1)       |dest: 10.0.0.5≠ rete locale     |                         |
         |                                |                         |
         |                                |                         |
         |------ Pacchetto IP ----------->|                         |
         |  src: 192.168.1.10             |                         |
         |  dst: 10.0.0.5                 |                         |
         |  TTL: 64                       |                         |
         |                                |                         |
2)       |Router consulta tabella         |                         |
         |di routing                      |                         |
         |                                |                         |
3)       |                                | TTL decrementato: 63    |
         |                                |                         |
4)       |                                |------ Pacchetto IP ---->|
         |                                |  src: 192.168.1.10      |
         |                                |  dst: 10.0.0.5          |
         |                                |  TTL: 63                |
```

| Fase           | #   | Azione                                                                        | Note                                                                  |
| -------------- | --- | ----------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **Locale**     | 1   | L'host confronta IP destinazione con la propria subnet mask via AND bit a bit | Se stesso network → consegna diretta (ARP); altrimenti → gateway      |
| **Forwarding** | 2   | Il router consulta la routing table (longest prefix match)                    | Il router usa l'entry più specifica che corrisponde alla destinazione |
| **TTL**        | 3   | Ogni router decrementa TTL di 1                                               | Se TTL = 0 → scarta e invia ICMP Time Exceeded                        |
| **Arrivo**     | 4   | L'ultimo router consegna al segmento finale via ARP                           | L'host destinatario riceve il pacchetto                               |

___
# Casi d'Uso Reali

- **Navigazione web (HTTP/HTTPS)**: Il browser risolve il dominio tramite DNS (ottiene l'IP del server), poi IPv4 si occupa di instradare ogni pacchetto TCP attraverso i router di Internet fino al server web. Il campo TTL previene che i pacchetti girino all'infinito in caso di loop.
- **Reti aziendali con NAT**: Un'azienda usa internamente `10.0.0.0/8` per centinaia di dispositivi. Il router di bordo ha un solo IP pubblico: grazie al NAT, traduce ogni connessione uscente sostituendo l'IP privato con quello pubblico, permettendo a tutti di accedere a Internet con un singolo indirizzo pubblico.
- **Subnetting per segmentazione**: Un amministratore divide `172.16.0.0/16` in sottoreti separate per reparto (HR, IT, produzione). Ogni sottorete è isolata dalle altre tramite ACL o VLAN, limitando il broadcast e aumentando la sicurezza.
- **DHCP**: Un nuovo dispositivo si connette alla rete senza IP. Invia un broadcast a `255.255.255.255` (DHCP Discover). Il server DHCP risponde con un'offerta che include IP, subnet mask, gateway e DNS — tutto a livello IPv4.
- **Routing OSPF con indirizzi multicast**: I router OSPF si scambiano informazioni sulla topologia di rete usando l'indirizzo multicast `224.0.0.5` (tutti i router OSPF) invece del broadcast, riducendo il traffico non necessario.
___
# Limitazioni Tecniche

- **Esaurimento degli indirizzi**: Lo spazio di 32 bit consente ~4,3 miliardi di indirizzi unici. A causa della crescita di Internet e dell'allocazione inefficiente per classi, il pool di indirizzi pubblici IPv4 è esaurito dal 2011 (IANA). Il NAT è la soluzione tampone; IPv6 è la soluzione definitiva.
- **Frammentazione inefficiente**: I router intermedi possono frammentare i pacchetti se la MTU del link è inferiore alla dimensione del pacchetto. La riassemblatura avviene solo alla destinazione finale, aumentando latenza e consumo di risorse. Il flag DF (Don't Fragment) con Path MTU Discovery è preferibile.
- **Nessuna qualità del servizio nativa**: IPv4 dispone del campo ToS (Type of Service) per la priorità del traffico, ma l'implementazione è inconsistente tra vendor. La QoS richiede configurazioni aggiuntive (DSCP, policy di accodamento).
- **Sicurezza assente a livello protocollo**: IPv4 non prevede autenticazione né cifratura. L'IP spoofing (falsificazione dell'indirizzo sorgente) è tecnicamente banale. IPsec è un'estensione opzionale, non integrata nativamente.
- **Header di lunghezza variabile**: Il campo Options rende l'header di lunghezza variabile (20–60 byte), complicando il processing hardware ad alta velocità. IPv6 ha risolto questo con un header fisso.
- **Broadcast come meccanismo di scoperta**: Protocolli come ARP e DHCP usano il broadcast, che scala male in reti molto grandi (aumenta il traffico non utile su tutti i dispositivi del segmento).
___
# PDU & Incapsulamento

- **Nome PDU**: Pacchetto (Packet / Datagram)
- **Incapsulato in**: Frame di livello 2 (Ethernet, Wi-Fi, PPP…)
- **Incapsula**: Segmento TCP, Datagramma UDP, o altri protocolli L4 (ICMP, OSPF…)

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4-7 [ Payload ]
```

___
# Struttura Del Pacchetto

## Header

| Campo | Dimensione | Descrizione |
| ----- | ---------- | ----------- |
| **Version** | 4 bit | Versione IP (valore = 4 per IPv4) |
| **IHL (Internet Header Length)** | 4 bit | Lunghezza header in word da 32 bit (min=5→20 byte, max=15→60 byte) |
| **DSCP / ToS** | 8 bit | Differentiated Services Code Point — priorità/qualità del servizio |
| **Total Length** | 16 bit | Dimensione totale del pacchetto (header + payload), max 65.535 byte |
| **Identification** | 16 bit | Identificatore univoco del pacchetto — usato per riassemblare frammenti |
| **Flags** | 3 bit | Controllo della frammentazione (DF, MF) |
| **Fragment Offset** | 13 bit | Posizione del frammento nell'originale (in unità da 8 byte) |
| **TTL (Time To Live)** | 8 bit | Numero massimo di hop prima dello scarto (decrementato da ogni router) |
| **Protocol** | 8 bit | Protocollo L4 incapsulato (6=TCP, 17=UDP, 1=ICMP, 89=OSPF) |
| **Header Checksum** | 16 bit | Verifica integrità solo dell'header (non del payload) |
| **Source IP Address** | 32 bit | Indirizzo IP del mittente |
| **Destination IP Address** | 32 bit | Indirizzo IP del destinatario |
| **Options** | 0–320 bit | Opzioni facoltative (Record Route, Timestamp, Source Routing…) |
| **Padding** | variabile | Allineamento header a multiplo di 32 bit |

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version|  IHL  |    DSCP/ToS   |          Total Length         |
| 4 bit | 4 bit |    8 bit      |           16 bit              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Identification        |Flags|    Fragment Offset       |
|           16 bit              |3bit |        13 bit            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  Time to Live |    Protocol   |       Header Checksum         |
|    8 bit      |    8 bit      |           16 bit              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       Source IP Address                       |
|                           32 bit                              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Destination IP Address                     |
|                           32 bit                              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options (0–320 bit)                        |
|              Record Route, Timestamp, Strict/Loose SR…        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                  Padding (allinea a 32 bit)                   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
|              Payload (TCP / UDP / ICMP / …)                   |
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Flags

| Bit | Flag | Nome Esteso | Descrizione e Utilizzo |
| --- | ---- | ----------- | ---------------------- |
| 0 | **Riservato** | — | Deve essere 0 |
| 1 | **DF** | *Don't Fragment* | Se impostato, il router **non deve frammentare** il pacchetto. Se la dimensione supera la MTU, il router scarta il pacchetto e invia un ICMP "Fragmentation Needed". Usato nella **Path MTU Discovery**. |
| 2 | **MF** | *More Fragments* | Indica che **seguono altri frammenti**. È 0 sull'ultimo frammento (o su un pacchetto non frammentato). |

### Valori comuni del campo Protocol

| Valore | Protocollo | Descrizione |
| ------ | ---------- | ----------- |
| 1 | ICMP | Internet Control Message Protocol |
| 6 | TCP | Transmission Control Protocol |
| 17 | UDP | User Datagram Protocol |
| 47 | GRE | Generic Routing Encapsulation (tunneling) |
| 89 | OSPF | Open Shortest Path First |

___
# Protocolli Correlati

| Protocollo | Livello OSI | Relazione con IPv4 |
| ---------- | ----------- | ------------------ |
| **ARP** | 2/3 | Risolve IP → MAC address per la consegna locale (RFC 826) |
| **ICMP** | 3 (sopra IP) | Messaggi di controllo e diagnostica (ping, traceroute, TTL exceeded) |
| **DHCP** | 7 (app) | Assegnazione automatica di IP, mask, gateway, DNS ai dispositivi |
| **NAT** | 3/4 | Traduzione IP privato ↔ pubblico al bordo della rete |
| **DNS** | 7 (app) | Risoluzione nomi di dominio → indirizzi IP |
| **OSPF** | 3 (routing) | Protocollo di routing dinamico che usa direttamente IPv4 (proto 89) |
| **BGP** | 4/7 | Routing inter-dominio su Internet (usa TCP porta 179) |
| **IPsec** | 3 | Estensione per autenticazione e cifratura a livello IP |

___
# Confronto

**IPv4 vs IPv6**

| Caratteristica | IPv4 | IPv6 |
| -------------- | ---- | ---- |
| Lunghezza indirizzo | 32 bit | 128 bit |
| Notazione | Decimale puntata (`192.168.1.1`) | Esadecimale con colons (`2001:db8::1`) |
| Spazio indirizzi | ~4,3 miliardi | ~340 undecilioni |
| Header | Variabile (20–60 byte), checksum incluso | Fisso (40 byte), senza checksum |
| Frammentazione | Router e host | Solo host sorgente |
| Broadcast | Sì | No (sostituito da multicast) |
| ARP | Sì (broadcast L2) | No (sostituito da NDP/ICMPv6) |
| IPsec | Opzionale | Nativo (obbligatorio nel design) |
| QoS | ToS/DSCP (8 bit) | Traffic Class + Flow Label (28 bit) |
| Configurazione | Manuale o DHCP | Manuale, DHCPv6, o SLAAC (autoconfig) |
| Adozione | ~96% del traffico Internet | ~40% e in crescita |

___
# Aspetti di Sicurezza

## Vulnerabilità Note

- **IP Spoofing**: Un attaccante può forgiare il campo Source IP di un pacchetto IPv4 — non c'è autenticazione dell'indirizzo sorgente nel protocollo. Questo permette attacchi DDoS per amplificazione (DNS, NTP) dove le risposte vengono redirette alla vittima.
- **Frammentazione malevola**: Pacchetti frammentati appositamente sovrapposti (Teardrop attack) possono causare crash o comportamenti anomali nei sistemi di riassemblaggio. Filtri moderni e OS aggiornati mitigano questo.
- **ICMP come canale di ricognizione o tunneling**: `ping` e `traceroute` rivelano topologia di rete. Il tunnel ICMP permette di esfiltrare dati incapsulati in pacchetti ICMP, aggirando firewall che bloccano solo TCP/UDP.
- **Broadcast amplification (Smurf attack)**: Un attaccante invia un ping broadcast con IP sorgente falsificato (della vittima). Tutti i dispositivi della rete rispondono alla vittima, amplificando il traffico.

## Attacchi Comuni

- **IP Spoofing + DDoS per riflessione**: Il traffico di risposta viene diretto verso la vittima usando il suo IP come sorgente falsificato nelle richieste broadcast o verso servizi amplificatori (DNS, NTP, SSDP).
- **Teardrop / Fragmentation Overlap**: Invio di frammenti con offset sovrapposti che corrompono il buffer di riassemblaggio del sistema target.
- **Man-in-the-Middle (ARP Poisoning)**: Falsificando le tabelle ARP sulla rete locale, un attaccante può intercettare il traffico tra due host che usano IPv4 sullo stesso segmento.
- **Route Injection (BGP Hijacking)**: Un attore malevolo annuncia prefissi IP altrui tramite BGP, reindirizzando il traffico Internet verso sistemi controllati dall'attaccante.

## Contromisure

- **BCP38 / uRPF (Unicast Reverse Path Forwarding)**: I router verificano che il pacchetto in ingresso provenga dall'interfaccia corretta per quell'IP sorgente. Scarta i pacchetti con IP sorgente spoofato incompatibile col percorso di routing.
- **Ingress/Egress Filtering**: I provider di rete filtrano il traffico in uscita con IP sorgente non appartenente ai loro range — riduce l'efficacia dello spoofing.
- **Firewall stateful + ACL**: Filtrano il traffico in base a stato della connessione, IP, protocollo e porta — bloccano pacchetti inattesi o fuori contesto.
- **IPsec (AH + ESP)**: AH (Authentication Header) autentica l'IP sorgente e garantisce l'integrità del pacchetto; ESP (Encapsulating Security Payload) aggiunge anche cifratura.
- **Disabilitare il directed broadcast**: `no ip directed-broadcast` sulle interfacce Cisco previene gli attacchi Smurf.
- **RPKI (Resource Public Key Infrastructure)**: Firma crittografica delle route BGP per prevenire il BGP hijacking.

___
# Comandi Cisco IOS

```bash
# Assegnare un indirizzo IP a un'interfaccia
interface GigabitEthernet0/0
  ip address 192.168.1.1 255.255.255.0
  no shutdown

# Visualizzare gli indirizzi IP configurati su tutte le interfacce
show ip interface brief

# Dettaglio completo di un'interfaccia (IP, mask, broadcast, stato)
show ip interface GigabitEthernet0/0

# Visualizzare la tabella di routing IPv4
show ip route

# Visualizzare solo le route connesse direttamente
show ip route connected

# Visualizzare solo le route statiche
show ip route static

# Configurare un default gateway (route statica di default)
ip route 0.0.0.0 0.0.0.0 <next-hop-ip>

# Configurare una route statica
ip route 10.0.0.0 255.0.0.0 192.168.1.254

# Visualizzare la tabella ARP (IP → MAC)
show arp
show ip arp

# Verificare connettività (ICMP Echo)
ping 192.168.1.1
ping 10.0.0.5 source GigabitEthernet0/0

# Tracciare il percorso dei pacchetti
traceroute 8.8.8.8

# Visualizzare le statistiche IP (pacchetti ricevuti, inviati, scartati)
show ip traffic

# Visualizzare la configurazione NAT
show ip nat translations
show ip nat statistics

# Disabilitare il directed broadcast (sicurezza — anti Smurf)
interface GigabitEthernet0/0
  no ip directed-broadcast

# Abilitare debug IP (solo in lab — molto verboso)
debug ip packet
debug ip routing
```

___
# Troubleshooting

**Sintomi comuni:**

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| ---------------- | ------------------------ | ------------------------ |
| **"Destination host unreachable"** | Route mancante, ARP fallito, interfaccia down | Il router locale non sa come raggiungere la destinazione, o il next-hop non risponde ad ARP |
| **"Request timed out"** | Firewall blocca ICMP, TTL = 0, host down | I pacchetti ICMP Echo Request non ricevono risposta — il problema può essere nel percorso di andata o di ritorno |
| **Ping locale OK, Internet KO** | Default gateway errato o assente, NAT mal configurato | La rete locale funziona, ma il traffico verso Internet non trova il percorso corretto |
| **IP duplicato sulla rete** | Assegnazione manuale conflittuale, DHCP mal configurato | Due host con lo stesso IP causano comportamenti erratici — ARP genera conflitti, le connessioni si interrompono |
| **Connessione intermittente** | MTU mismatch, frammentazione bloccata dal firewall | I pacchetti grandi (es. HTTPS) vengono scartati perché il DF bit è impostato e il firewall blocca i messaggi ICMP "Fragmentation Needed" — fenomeno noto come **Black Hole routing** |
| **DHCP non assegna IP (169.254.x.x)** | Server DHCP irraggiungibile, relay agent assente | Il client riceve un indirizzo APIPA — non c'è comunicazione con il server DHCP |

**Comandi di verifica:**

```bash
# Linux/Mac — configurazione IP locale
ip addr show
ifconfig

# Verifica routing locale
ip route show
route -n

# Verifica connettività base
ping -c 4 192.168.1.1          # gateway
ping -c 4 8.8.8.8              # Internet (IP)
ping -c 4 google.com           # Internet + DNS

# Traceroute per identificare dove si interrompe il percorso
traceroute 8.8.8.8             # Linux/Mac
tracert 8.8.8.8                # Windows

# Verifica tabella ARP
arp -n                          # Linux
arp -a                          # Windows/Mac

# Cattura traffico per analisi
tcpdump -i eth0 host 192.168.1.1
tcpdump -i eth0 icmp

# Test MTU (Path MTU Discovery manuale)
ping -M do -s 1472 192.168.1.1  # Linux: pacchetto 1472 byte + 28 header = 1500 MTU
```

**Cause frequenti:**

| Problema | Causa Tecnica | Sintomo e Comportamento |
| -------- | ------------- | ----------------------- |
| **MTU Mismatch** | Differenza nella dimensione massima dei pacchetti tra due nodi. | I pacchetti piccoli passano, quelli grandi vengono scartati se hanno il flag **DF**. Si manifesta tipicamente con HTTPS che non funziona mentre HTTP sì. |
| **Route asimmetrica** | Il traffico di andata e ritorno seguono percorsi diversi attraverso firewall stateful diversi. | Il firewall scarta i pacchetti di risposta perché non ha registrato il SYN originale nella sua tabella di stato. |
| **Subnet mask errata** | Host configurato con mask diversa da quella della rete. | L'host tenta di comunicare direttamente con IP che ritiene sulla stessa rete, ma in realtà richiedono un router. ARP non riceve risposta. |
| **IP Spoofing / ARP Poisoning** | Tabella ARP corrotta da attaccante sulla stessa LAN. | Il traffico viene intercettato o reindirizzato; le sessioni TCP si interrompono o i dati vengono alterati. |

___
# Note Esame

## Da sapere a memoria

| Argomento | Dettagli Tecnici |
| --------- | ---------------- |
| **Definizione** | Layer 3 (Rete), connectionless, best-effort, indirizzi 32 bit. |
| **Standard RFC** | Originale: **791** (1981); CIDR: **1519** (1993); Privati: **1918** (1996). |
| **Dimensione Header** | Minimo **20 byte**; Massimo **60 byte** (con opzioni). |
| **Classi principali** | A: 1–126 /8 · B: 128–191 /16 · C: 192–223 /24 |
| **Privati RFC 1918** | `10.0.0.0/8` · `172.16.0.0/12` · `192.168.0.0/16` |
| **Loopback** | `127.0.0.1` (range `127.0.0.0/8`) — test stack TCP/IP |
| **APIPA** | `169.254.x.x` — auto-assegnato se DHCP non risponde |
| **Broadcast limitato** | `255.255.255.255` — non instradato dai router |
| **Formula host** | `2^(32 − prefisso) − 2` — si sottraggono network e broadcast |
| **TTL** | 8 bit — decrementato di 1 ad ogni hop; a 0 → scarto + ICMP |
| **Flag DF** | Don't Fragment — usato nella Path MTU Discovery |
| **Flag MF** | More Fragments — 0 sull'ultimo frammento |
| **Protocol field** | 1=ICMP · 6=TCP · 17=UDP · 89=OSPF |
| **Incapsulamento** | IP viaggia dentro frame L2. PDU IP = **Pacchetto**. |

## Trabocchetti frequenti

| Concetto Errato | Realtà Tecnica |
| --------------- | -------------- |
| **IPv4 garantisce la consegna** | **FALSO**. IPv4 è *best-effort*: non garantisce consegna, ordine né assenza di duplicati. È TCP (L4) a occuparsi dell'affidabilità. |
| **La subnet mask si applica alla destinazione** | **FALSO**. L'AND bit a bit viene fatto tra l'**IP di destinazione** e la **subnet mask del mittente** per determinare se la destinazione è locale o remota. |
| **127.0.0.1 è l'unico loopback** | **PARZIALMENTE FALSO**. Tutto il range `127.0.0.0/8` è loopback — ma in pratica si usa quasi solo `127.0.0.1`. |
| **Il broadcast diretto è sempre bloccato** | **FALSO**. I router possono essere configurati per instradarlo (anche se spesso è disabilitato per sicurezza). Il broadcast **limitato** `255.255.255.255` invece non è mai instradato. |
| **CIDR ha eliminato le classi** | **PARZIALMENTE VERO**. Il routing su Internet usa CIDR, ma i range privati RFC 1918 sono ancora definiti per classe (A, B, C). Le classi rimangono rilevanti per capire la struttura degli indirizzi. |
| **Il checksum IPv4 copre il payload** | **FALSO**. Il checksum nell'header IPv4 copre **solo l'header** — non il payload. L'integrità del payload è responsabilità dei protocolli L4 (TCP, UDP) o L7. |
| **Due host in /30 hanno 2 host utilizzabili** | **VERO**. `/30` → `2^2 − 2 = 2` host. Questo è il prefisso standard per i link point-to-point tra router. |
| **L'IP sorgente è sempre autentico** | **FALSO**. IPv4 non autentica l'IP sorgente — l'IP spoofing è trivialmente possibile. Serve BCP38/uRPF o IPsec per mitigarlo. |

___

## 📝 Quick Reference Card

```
CLASSI:
  A → 1–126.x.x.x        /8   privato: 10.x.x.x
  B → 128–191.x.x.x      /16  privato: 172.16–31.x.x
  C → 192–223.x.x.x      /24  privato: 192.168.x.x
  D → 224–239.x.x.x           multicast
  E → 240–255.x.x.x           riservato

SPECIALI:
  0.0.0.0         → default route / any
  127.0.0.1       → loopback (localhost)
  169.254.x.x     → APIPA (link-local, DHCP fallito)
  255.255.255.255 → broadcast limitato (non instradato)

CIDR:
  /prefisso = quanti bit sono di rete
  Host = 2^(32−prefisso) − 2
  Subnet mask: prefisso bit a 1, resto a 0
  Block size = 256 − valore ottetto interessato nella mask

HEADER IPv4 (min 20 byte):
  Version(4) | IHL(4) | DSCP(8) | Total Length(16)
  Identification(16) | Flags(3) | Fragment Offset(13)
  TTL(8) | Protocol(8) | Header Checksum(16)
  Source IP(32)
  Destination IP(32)
  [Options] [Padding]

FLAGS:
  DF = Don't Fragment (bit 1)
  MF = More Fragments (bit 2)

PROTOCOLLI (campo Protocol):
  1=ICMP  6=TCP  17=UDP  47=GRE  89=OSPF
```

## 🔗 Concetti Collegati

- [[Subnetting]] — Divisione di una rete in sottoreti con VLSM
- [[ARP]] — Risoluzione IP → MAC address a livello L2
- [[ICMP]] — Messaggi di controllo e diagnostica per IPv4
- [[NAT]] — Traduzione indirizzi privati ↔ pubblici
- [[DHCP]] — Assegnazione automatica degli indirizzi IP
- [[IPv6]] — Il successore con spazio a 128 bit
- [[Routing]] — Come i router instradano i pacchetti tra reti
- [[Transport_Layer]] — TCP e UDP che viaggiano dentro IPv4

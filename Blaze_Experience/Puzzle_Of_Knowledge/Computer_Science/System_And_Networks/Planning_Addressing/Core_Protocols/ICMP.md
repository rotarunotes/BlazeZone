Data: 2026-05-04
[Core_Protocols](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Core_Protocols
___
# Index

- [[#Internet Control Message Protocol]]
    - [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
    - [[#Tipi di Messaggi]]
    - [[#ICMP Echo (Ping)]]
    - [[#ICMP Error Reporting]]
    - [[#Traceroute]]
- [[#Flusso Operativo]]
- [[#Casi d'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
    - [[#Header]]
    - [[#Body]]
    - [[#Flag]]
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
# *Internet Control Message Protocol*

## Panoramica

| Caratteristica              |                                              Dettaglio                                               |
| --------------------------- | :--------------------------------------------------------------------------------------------------: |
| **Livello OSI**             |                                               3 — Rete                                               |
| **Porta**                   |                                      Nessuna (non usa TCP/UDP)                                       |
| **Scopo**                   | Segnalare errori di rete, diagnosticare la connettività e fornire messaggi di controllo a livello IP |
| **RFC / Standard**          |                              RFC 792 (1981) — ICMPv4; RFC 4443 — ICMPv6                              |
| **Tipo Connessione**        |                          **Connectionless** (ogni messaggio è indipendente)                          |
| **Affidabilità**            |                     **Non affidabile** (i messaggi ICMP non vengono confermati)                      |
| **PDU (Unità Dati)**        |                                       **Messaggio** (Message)                                        |
| **Meccanismo di Controllo** |                  Type + Code identificano il tipo di errore o richiesta diagnostica                  |
___
# Versioni & Evoluzione

|Versione / RFC|Anno|Novità principali|
|---|---|---|
|RFC 792|1981|Specifica originale ICMPv4 — messaggi di errore e diagnostica per IPv4|
|RFC 1122|1989|Chiarimenti sui requisiti obbligatori vs opzionali dei messaggi ICMP|
|RFC 1256|1991|ICMP Router Discovery — annuncio dinamico dei router (IRDP)|
|RFC 1393|1993|Traceroute con opzione ICMP (alternativa al metodo TTL scaduto)|
|RFC 4443|2006|ICMPv6 — riscrittura completa per IPv6; integra funzioni ARP (NDP) e IGMP|
|RFC 4884|2007|Estensioni ICMP per messaggi multi-parte (es. MPLS traceroute)|

---
# Come Funziona

ICMP è un protocollo **ausiliario di IP**: non trasporta dati applicativi, ma genera messaggi di controllo e di errore relativi al comportamento della rete IP. Tecnicamente è incapsulato dentro un pacchetto IP, ma opera concettualmente allo stesso livello di IP (L3).

ICMP **non** è un protocollo di trasporto: non ha porte, non stabilisce connessioni e non garantisce la consegna dei propri messaggi. Un messaggio ICMP perso non viene ritrasmesso.

**Regola fondamentale**: ICMP non genera mai errori in risposta ad altri messaggi di errore ICMP, questo previene loop di messaggi di errore infiniti.
## Tipi di Messaggi
I messaggi ICMP si dividono in due categorie principali:
- **Error Messages** (messaggi di errore): generati da router o host quando un pacchetto non può essere consegnato o elaborato. Contengono sempre una copia dell'header IP + i primi 8 byte del payload del pacchetto che ha causato l'errore, così il mittente originale può identificare quale sessione è coinvolta.
- **Query/Informational Messages** (messaggi informativi): scambiati in coppia richiesta/risposta tra due dispositivi, usati per diagnostica (es. ping).
## ICMP Echo (Ping)
Il meccanismo più noto di ICMP. Il mittente invia un **Echo Request** (Type 8), il destinatario risponde con un **Echo Reply** (Type 0). I campi **Identifier** e **Sequence Number** permettono di abbinare ogni risposta alla relativa richiesta e calcolare l'RTT (*Round-Trip Time*).

```
Host A                         Host B
  |                               |
  |--- Echo Request (Type 8) ---->|
  |    ID=1234, Seq=1             |
  |                               |
  |<-- Echo Reply   (Type 0) -----|
  |    ID=1234, Seq=1             |
  |                               |
  RTT = t_reply - t_request
```

## ICMP Error Reporting
Quando un router scarta un pacchetto, genera un messaggio ICMP verso il **mittente originale** del pacchetto (non verso il router successivo). I casi più comuni:
- **TTL Exceeded (Type 11, Code 0)**: Il TTL del pacchetto è arrivato a 0. Il router scarta il pacchetto e avvisa il mittente. Sfruttato da **traceroute**.
- **Destination Unreachable (Type 3)**: Il pacchetto non può raggiungere la destinazione. Il Code specifica il motivo (rete, host, porta, protocollo irraggiungibili, frammentazione necessaria...).
- **Fragmentation Needed (Type 3, Code 4)**: Il pacchetto ha il flag **DF** impostato, ma è troppo grande per il link. Il router lo scarta e indica la propria MTU, meccanismo alla base della **Path MTU Discovery**.
- **Redirect (Type 5)**: Un router informa un host che esiste un percorso migliore (gateway più vicino) per raggiungere una destinazione. L'host aggiorna la propria routing table locale.
## Traceroute
`traceroute` sfrutta il meccanismo di TTL Exceeded per mappare il percorso di rete:
1. Invia un pacchetto con TTL=1: Il primo router lo scarta e risponde con **ICMP TTL Exceeded**, si conosce il primo hop.
2. Invia un pacchetto con TTL=2: Il secondo router risponde, si conosce il secondo hop.
3. Si incrementa il TTL finché non si riceve un **ICMP Echo Reply** (o **Port Unreachable** su Unix) dalla destinazione.
___
# Flusso Operativo

**Scenario: ping con TTL che scade (traceroute step)**

```
Host A (TTL=1)            Router R1                    Host B
      |                       |                            |
1)    |--- IP pkt, TTL=1 ---->|                            |
      |                       |                            |
2)    |          R1 decrementa TTL → TTL=0, scarta pkt     |
      |                       |                            |
3)    |<-- ICMP TTL Exceeded--|                            |
      |    Type=11, Code=0    |                            |
      |    src=IP(R1)         |                            |
      |                       |                            |
4)    |--- IP pkt, TTL=2 ---->|--- IP pkt, TTL=1 --------> |
      |                       |                            |
5)    |                       |              Host B risponde con Echo Reply
      |<---------------------------------------- ICMP Echo Reply (Type=0)
```

| Fase              | #   | Azione                                               | Generato da | Ricevuto da | Note                                                |
| ----------------- | --- | ---------------------------------------------------- | ----------- | ----------- | --------------------------------------------------- |
| **Invio**         | 1   | Host A invia pacchetto con TTL=1                     | Host A      | Router R1   | TTL intenzionalmente basso (traceroute)             |
| **TTL Scaduto**   | 2   | R1 decrementa TTL a 0, scarta il pacchetto           | —           | —           | Il pacchetto non viene inoltrato                    |
| **Errore ICMP**   | 3   | R1 genera ICMP TTL Exceeded verso Host A             | Router R1   | Host A      | Contiene header IP + 8 byte del pacchetto originale |
| **TTL aumentato** | 4   | Host A riprova con TTL=2, raggiunge Host B           | Host A      | Host B      | Il pacchetto supera R1 (TTL=1 dopo R1) e arriva a B |
| **Risposta**      | 5   | Host B risponde con Echo Reply (se era Echo Request) | Host B      | Host A      | Fine del traceroute per questo hop                  |

___
# Casi d'Uso Reali

- **Ping per verifica connettività**: Uno sysadmin esegue `ping 8.8.8.8` per verificare se un host è raggiungibile e misurare la latenza. ICMP Echo Request/Reply fornisce RTT min/avg/max e percentuale di perdita pacchetti, la diagnostica di rete più immediata disponibile.
- **Traceroute per identificare colli di bottiglia**: Un tecnico usa **traceroute** per scoprire dove aumenta la latenza o dove i pacchetti vengono scartati lungo il percorso verso un server. Ogni hop che risponde con ICMP TTL Exceeded rivela un router nel percorso con il suo RTT.
- **Path MTU Discovery**: Un'applicazione che invia file grandi imposta il flag DF sui pacchetti. Se un router intermedio ha una MTU inferiore, risponde con **ICMP Fragmentation Needed (Type 3, Code 4)** indicando la propria MTU. Il mittente riduce la dimensione e riprova, senza frammentazione distribuita lungo il percorso.
- **ICMP Redirect per ottimizzazione routing locale**: Un router accorge che un host sta inviando traffico verso un gateway subottimale (c'è un router migliore sullo stesso segmento). Invia un **ICMP Redirect (Type 5)** all'host, che aggiorna la propria routing table per quel prefisso di destinazione.

___
# Limitazioni Tecniche

- **Nessuna affidabilità**: I messaggi ICMP non vengono confermati. Se un ICMP TTL Exceeded viene perso, `traceroute` mostra `* * *` per quell'hop senza alcuna notifica di errore.
- **Rate limiting e filtraggio diffuso**: Molti router limitano la generazione di messaggi ICMP (soprattutto errori) per evitare overhead. Firewall e ACL spesso bloccano ICMP selettivamente, rendendo ping e traceroute inaffidabili in reti aziendali o su Internet.
- **Nessuna autenticazione**: Non c'è alcun meccanismo per verificare che un messaggio ICMP provenga da chi dichiara. Questo apre la porta a spoofing e attacchi (vedi Sicurezza).
- **ICMP non può segnalare errori su messaggi ICMP**: Per prevenire loop, ICMP non genera errori in risposta ad altri errori ICMP. Questo significa che se un messaggio ICMP Error viene perso, il mittente non viene mai informato.
- **Assenza di porte**: Non essendoci porte, ICMP non può essere demultiplexato a livello applicativo come TCP/UDP. L'identificazione della sessione avviene tramite i campi Identifier e Sequence Number (solo per Echo).
- **Visibilità topologica**: `traceroute` e ping rivelano indirizzi IP interni e topologia di rete, informazioni utili per un attaccante nella fase di ricognizione.

___
# PDU & Incapsulamento

- **Nome PDU**: Messaggio ICMP (ICMP Message)
- **Incapsulato in**: Pacchetto IP
- **Incapsula**: Nessun payload applicativo; i messaggi di errore includono l'header IP + 8 byte del pacchetto originale che ha causato l'errore

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L3.5 [ Header ICMP + Payload ICMP ] PDU: Messaggio ICMP
```

> [!Note] Nota
> ICMP è incapsulato in IP ma opera concettualmente allo stesso livello — non è un protocollo L4.

___
# Struttura Del Pacchetto

## Header
È **fisso** a 8 byte.

| Campo              | Dimensione | Descrizione                                                                               |
| ------------------ | ---------- | ----------------------------------------------------------------------------------------- |
| **Type**           | 8 bit      | Tipo di messaggio ICMP (es. 0=Echo Reply, 3=Dest Unreachable, 8=Echo Request, 11=TTL Exc) |
| **Code**           | 8 bit      | Sottotipo del messaggio, specifica il motivo (es. Type 3 ha codici 0–15)                  |
| **Checksum**       | 16 bit     | Verifica integrità dell'intero messaggio ICMP (header + payload)                          |
| **Rest of Header** | 32 bit     | Dipende da Type/Code: può essere Identifier+SeqNum (Echo), unused (errori), Next-Hop MTU… |

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|      Type     |      Code     |           Checksum            |
|     8 bit     |     8 bit     |            16 bit             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Identifier            |        Sequence Number        |
|  16 bit (Echo Req/Reply)      |   16 bit (Echo Req/Reply)     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
|              Payload (variabile per tipo)                     |
|   Echo: dati arbitrari  |  Errori: IP hdr + 8 byte payload    |
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Body
Il payload ICMP dipende dal tipo di messaggio:
- **Echo Request / Echo Reply (Type 8 / Type 0)**: dati arbitrari impostati dal mittente (tipicamente timestamp + padding). La risposta deve restituire lo stesso payload della richiesta.
- **Messaggi di errore (Type 3, 11, 12…)**: contengono l'**header IP originale** (20 byte) + i **primi 8 byte del payload** del pacchetto che ha causato l'errore. Questo permette al mittente di identificare quale connessione TCP/UDP è coinvolta (porte sorgente e destinazione si trovano nei primi 8 byte del segmento TCP/UDP).
## Flag
ICMP non ha un campo Flags.
___
# Porte e Protocolli Correlati

| Protocol Field IP | Livello OSI | Protocollo | Uso                                                                 |
| ----------------- | ----------- | ---------- | ------------------------------------------------------------------- |
| 1                 | **3**       | ICMPv4     | Messaggi di controllo ed errore per IPv4                            |
| 58                | **3**       | ICMPv6     | Messaggi di controllo per IPv6 (include NDP, sostituisce ARP)       |
| 2                 | **3**       | IGMP       | Gestione gruppi multicast IPv4 (Internet Group Management Protocol) |
| —                 | **3**       | IP         | Protocollo di trasporto per i messaggi ICMP                         |

> [!NOTE] Nota
> ICMP non usa porte TCP/UDP. È identificato dal **campo Protocol dell'header IP** (valore 1 per ICMPv4).

___
# Confronto

**ICMPv4 vs ICMPv6**

|Caratteristica|ICMPv4|ICMPv6|
|---|---|---|
|**RFC**|RFC 792 (1981)|RFC 4443 (2006)|
|**Protocollo IP**|IPv4 (Protocol = 1)|IPv6 (Next Header = 58)|
|**Funzioni integrate**|Solo errori e diagnostica|Errori + NDP (sostituisce ARP) + MLD (sostituisce IGMP)|
|**ARP**|Usa ARP separato (L2 broadcast)|Integrato in ICMPv6 NDP (Neighbor Solicitation/Advertisement)|
|**Router Discovery**|IRDP opzionale (RFC 1256)|Nativo con Router Solicitation/Advertisement|
|**Messaggi Path MTU Discovery**|Type 3, Code 4 (Frag Needed)|Type 2 (Packet Too Big)|
|**Obbligatorietà**|Opzionale (spesso filtrato)|Critico per il funzionamento di IPv6|
|**Checksum**|Solo sull'header ICMP|Copre anche pseudo-header IPv6|

___
# Aspetti di Sicurezza

## Vulnerabilità Note
- **ICMP Spoofing**: i pacchetti ICMP non vengono autenticati. Un attaccante può forgiare messaggi ICMP (es. Redirect o Destination Unreachable) con IP sorgente falso per manipolare il comportamento di routing degli host vittima.
- **Ricognizione della topologia**: ping sweep e traceroute rivelano host attivi, indirizzi IP interni, distanze di hop e potenzialmente il tipo di OS (tramite TTL iniziale del Reply: Linux=64, Windows=128, Cisco=255).
- **ICMP Tunneling**: dati arbitrari possono essere nascosti nel payload di Echo Request/Reply, creando un canale covert per esfiltrazione dati o command & control, aggirando firewall che filtrano solo TCP/UDP.
- **Loop di errori**: senza la regola "no ICMP in response to ICMP error", sistemi mal implementati potrebbero generare sequenze di errori reciproci.

## Attacchi Comuni
- **Ping of Death**: invio di pacchetti ICMP frammentati la cui riassemblatura supera i 65.535 byte — causava crash su sistemi obsoleti. I sistemi moderni sono immuni.
- **Smurf Attack**: invio di Echo Request broadcast con IP sorgente della vittima. Tutti gli host della rete rispondono alla vittima con Echo Reply, amplificando il traffico (DDoS per amplificazione). Mitigato disabilitando il directed broadcast (`no ip directed-broadcast` su Cisco).
- **ICMP Redirect Attack**: un attaccante invia falsi messaggi Redirect per alterare la routing table di un host e deviare il traffico attraverso un gateway controllato dall'attaccante (Man-in-the-Middle).
- **ICMP Flood (Ping Flood)**: invio massiccio di Echo Request per saturare la banda o le risorse CPU dell'host target (DoS).
- **ICMP Tunneling (C2)**: tool come `ptunnel` o `icmptunnel` incapsulano sessioni TCP o shell interattive dentro Echo Request/Reply per aggirare firewall restrittivi.

## Contromisure
- **Rate limiting ICMP**: limitare il numero di messaggi ICMP generati per secondo (es. `ip icmp rate-limit unreachable 1000` su Cisco) riduce l'efficacia dei flood e limita l'overhead sui router.
- **Filtraggio selettivo**: bloccare ICMP Redirect in ingresso sugli host (`net.ipv4.conf.all.accept_redirects=0` su Linux) per prevenire routing manipulation. Permettere Echo Request/Reply solo da sorgenti fidate.
- **Disabilitare directed broadcast**: `no ip directed-broadcast` su tutte le interfacce Cisco per prevenire lo Smurf attack.
- **Firewall stateful per ICMP**: consentire solo Echo Reply che corrispondono a una Echo Request precedentemente inviata (conntrack), bloccando reply non sollecitati.
- **Ispezione profonda (DPI)**: rilevare payload anomali nei campi dati di Echo Request/Reply (ICMP tunneling ha pattern riconoscibili: grandi payload, traffico costante, payload cifrato).
- **BCP38 + uRPF**: prevenire lo spoofing dell'IP sorgente sui router di bordo, rendendo inefficaci Smurf e ICMP Flood con sorgenti falsificate.

___
# Comandi Cisco IOS

```bash
# Inviare un ping ICMP verso un host
ping 192.168.1.1

# Ping esteso (specifica sorgente, ripetizioni, dimensione, timeout)
ping 10.0.0.1 source GigabitEthernet0/0 repeat 100 size 1500 timeout 3

# Ping con DF bit impostato (test Path MTU Discovery)
ping 10.0.0.1 df-bit size 1472

# Traceroute (usa UDP verso porte alte, riceve ICMP TTL Exceeded)
traceroute 8.8.8.8

# Traceroute con sorgente specificata
traceroute 8.8.8.8 source GigabitEthernet0/0

# Disabilitare invio di ICMP Unreachable su un'interfaccia (riduce info per attaccanti)
interface GigabitEthernet0/0
no ip unreachables

# Disabilitare ICMP Redirect (evitare manipolazione routing su host)
interface GigabitEthernet0/0
no ip redirects

# Rate limiting messaggi ICMP Unreachable (previene flooding di errori)
ip icmp rate-limit unreachable 1000

# Disabilitare directed broadcast (anti-Smurf)
interface GigabitEthernet0/0
no ip directed-broadcast

# Verifica statistiche ICMP
show ip traffic

# Debug ICMP (solo in lab — verbose)
debug ip icmp
```

___
# Troubleshooting

**Sintomi comuni**:

|Sintomo / Errore|Possibili Cause Tecniche|Descrizione del Fenomeno|
|---|---|---|
|**`Request timed out` / `* * *`**|Firewall blocca ICMP, host down, ACL restrittiva|L'Echo Request è partito ma non arriva risposta — il blocco può essere nel percorso di andata o di ritorno|
|**Traceroute con hop `* * *` intermedi**|Router che non generano ICMP Unreachable, rate limiting|Alcuni router non rispondono ma lasciano passare il traffico — non significa necessariamente un problema di routing|
|**Ping OK ma HTTPS non funziona**|Path MTU Discovery bloccata (ICMP Type 3 Code 4 filtrato)|Il firewall filtra i messaggi "Fragmentation Needed" → il mittente non sa che deve ridurre la dimensione dei pacchetti (Black Hole)|
|**Ping funziona ma con latenza alta**|Congestione di rete, QoS che penalizza ICMP, route subottimale|L'RTT elevato indica collo di bottiglia — usare traceroute per identificare l'hop problematico|
|**Redirect ICMP non atteso**|Router mal configurato, attacco ICMP Redirect|L'host riceve un Redirect e cambia il proprio next-hop — verificare la legittimità del gateway che invia il Redirect|
|**Ping of Death / crash su ping**|Sistema non patchato, frammentazione malevola|Pacchetti ICMP frammentati con riassemblatura > 65535 byte — solo su sistemi molto obsoleti|

**Comandi di verifica**:

```bash
# Linux/Mac — ping base con statistiche
ping -c 4 192.168.1.1

# Ping con dimensione pacchetto specifica e DF bit (test MTU)
ping -M do -s 1472 192.168.1.1      # 1472 + 28 header = 1500 byte

# Traceroute (UDP su Linux, ICMP su Windows)
traceroute 8.8.8.8                  # Linux/Mac
tracert 8.8.8.8                     # Windows

# Traceroute ICMP su Linux (come Windows)
traceroute -I 8.8.8.8

# Traceroute TCP su porta specifica (aggira firewall che bloccano UDP/ICMP)
traceroute -T -p 443 8.8.8.8

# Cattura traffico ICMP
tcpdump -i eth0 icmp
tcpdump -i eth0 'icmp[icmptype] = icmp-echo'          # solo Echo Request
tcpdump -i eth0 'icmp[icmptype] = icmp-echoreply'     # solo Echo Reply

# Statistiche ICMP su Linux
cat /proc/net/snmp | grep Icmp
```

**Cause frequenti**:

|Problema|Causa Tecnica|Sintomo e Comportamento|
|---|---|---|
|**ICMP Frag Needed bloccato**|Firewall filtra Type 3 Code 4 (considerato "pericoloso")|Ping funziona (pacchetti piccoli), HTTPS/SSH con file grandi si blocca — classico **Black Hole routing**|
|**TTL troppo basso**|Configurazione errata del TTL iniziale o rete con molti hop|Pacchetti scartati prima di arrivare; ICMP TTL Exceeded ricevuto dal mittente con indicazione dell'hop dove avviene lo scarto|
|**ICMP Rate Limiting aggressivo**|Router che limita la generazione di errori ICMP|Traceroute mostra `* * *` su hop intermedi anche se il routing funziona — il router non risponde per policy, non per guasto|
|**MTU Mismatch**|Differenza MTU tra link e pacchetti con DF impostato, ICMP Frag Needed non recapitato|I pacchetti grandi vengono scartati silenziosamente; Path MTU Discovery non converge al valore corretto|

___
# Note Esame

## Da sapere a memoria

|Argomento|Dettagli Tecnici|
|---|---|
|**Definizione**|Layer 3 (Rete), companion di IP, connectionless, non affidabile, nessuna porta TCP/UDP|
|**RFC**|ICMPv4: **RFC 792** (1981); ICMPv6: **RFC 4443** (2006)|
|**Protocol Field IP**|ICMPv4 = **1**; ICMPv6 = **58** (Next Header in IPv6)|
|**Dimensione Header**|Fisso **8 byte** (Type 1B + Code 1B + Checksum 2B + variabile 4B)|
|**Type 0**|Echo Reply|
|**Type 3**|Destination Unreachable (Code 0=Net, 1=Host, 3=Port, 4=Frag Needed)|
|**Type 5**|Redirect (suggerisce un gateway migliore all'host)|
|**Type 8**|Echo Request (ping)|
|**Type 11**|Time Exceeded (Code 0=TTL, Code 1=Fragment Reassembly)|
|**Payload nei messaggi errore**|Header IP originale (20B) + **primi 8 byte** del payload del pacchetto che ha causato l'errore|
|**Ping**|Echo Request (Type 8) → Echo Reply (Type 0); RTT calcolato con Identifier + Sequence Number|
|**Traceroute**|Sfrutta TTL Exceeded (Type 11, Code 0) incrementando il TTL di 1 ad ogni iterazione|
|**Path MTU Discovery**|Usa DF bit + ICMP Type 3 Code 4 (Frag Needed) con Next-Hop MTU nel payload|
|**Smurf Attack**|Echo Request broadcast con IP sorgente falsificato → tutti rispondono alla vittima|
|**Regola no-error-on-error**|ICMP non genera mai errori in risposta ad altri messaggi di errore ICMP|
## Trabocchetti frequenti

|Concetto Errato|Realtà Tecnica|
|---|---|
|**ICMP è un protocollo L4**|**FALSO**. ICMP è incapsulato in IP (Protocol=1) ma opera a L3 — non usa porte e non è un protocollo di trasporto|
|**Ping usa TCP o UDP**|**FALSO**. Ping usa **ICMP Echo Request/Reply** (Type 8 / Type 0) — nessuna porta coinvolta|
|**Bloccare ICMP migliora la sicurezza**|**PARZIALMENTE VERO**. Bloccare ICMP Redirect e ping sweep ha senso, ma bloccare Type 3 Code 4 rompe la Path MTU Discovery|
|**ICMP genera errori su errori ICMP**|**FALSO**. ICMP non risponde mai con errori ad altri messaggi di errore ICMP — prevenzione dei loop|
|**traceroute mostra sempre tutti gli hop**|**FALSO**. I router che non generano ICMP o hanno rate limiting attivo appaiono come `* * *` anche se funzionanti|
|**ICMP TTL Exceeded viene da Host B**|**FALSO**. Il TTL Exceeded viene generato dal **router** che scarta il pacchetto, non dalla destinazione finale|
|**Type 3 significa sempre host down**|**FALSO**. Type 3 ha 16 codici diversi: Code 0=rete irraggiungibile, Code 1=host, Code 3=porta chiusa, Code 4=MTU…|
|**ICMPv6 = ICMPv4**|**FALSO**. ICMPv6 integra anche le funzioni di ARP (NDP) e IGMP (MLD) — è molto più ricco di ICMPv4|

___
# Quick Reference Card

```
TIPI PRINCIPALI:
  Type  0  → Echo Reply           (risposta ping)
  Type  3  → Destination Unreachable
               Code 0: Net Unreachable
               Code 1: Host Unreachable
               Code 3: Port Unreachable
               Code 4: Fragmentation Needed (Path MTU Discovery)
  Type  5  → Redirect             (gateway migliore disponibile)
  Type  8  → Echo Request         (ping)
  Type 11  → Time Exceeded
               Code 0: TTL = 0    (usato da traceroute)
               Code 1: Fragment Reassembly timeout
  Type 12  → Parameter Problem    (errore nell'header IP)

INCAPSULAMENTO:
  IP [Protocol=1] → ICMP [Type|Code|Checksum|Variabile] → Payload

HEADER: 8 byte fissi
  Type(8) | Code(8) | Checksum(16) | [Identifier(16) + SeqNum(16)] per Echo

REGOLE CHIAVE:
  - Nessuna porta TCP/UDP
  - Nessun ACK — non affidabile
  - Mai errori in risposta ad errori ICMP
  - Protocol field IP = 1 (ICMPv4), 58 (ICMPv6)
  - Payload errori = IP hdr (20B) + primi 8B del pacchetto originale

TOOL:
  ping      → Echo Request/Reply (Type 8/0)
  traceroute → TTL Exceeded (Type 11, Code 0)
  Path MTU  → Frag Needed (Type 3, Code 4)
```

___
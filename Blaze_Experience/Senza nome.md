# Routing Logic — Documentazione Tecnica ITS
> **Modulo**: Sistemi e Reti · **Livello**: Avanzato (post-diploma) · **Formato**: Reference tecnico-schematico

---


---

# 2. Static Routing

## Introduzione
Il **routing statico** consiste nella configurazione manuale di route nella RIB da parte dell'amministratore. Non richiede protocolli di routing, non genera traffico di controllo e offre il massimo determinismo. È ideale per topologie semplici, **stub network** e scenari dove la prevedibilità supera la scalabilità.

#### metti un immagine qua
*(Schema: Topologia Hub-and-Spoke con route statiche — Stub Networks, Default Route verso ISP, Floating Route di backup)*

---

### Tabella Tecnica Riassuntiva

| Parametro | Static Routing | Dynamic Routing |
|---|---|---|
| **Configurazione** | Manuale | Automatica (protocollo) |
| **Convergenza** | Istantanea (nessuna) | Variabile (secondi–minuti) |
| **Scalabilità** | Bassa | Alta |
| **Overhead CPU/Banda** | Nullo | Presente (hello, LSA, update) |
| **Adattabilità ai guasti** | Nulla (senza Floating) | Automatica |
| **Sicurezza** | Alta (nessun annuncio) | Richiede autenticazione |
| **Caso d'uso tipico** | Stub network, default GW, lab | Reti enterprise/ISP |

---

### Corpo Centrale

#### 2.1 Vantaggi e Svantaggi

**Vantaggi:**
- **Zero overhead** di banda e CPU (nessun protocollo attivo).
- **Determinismo totale**: il percorso è sempre quello configurato.
- **Sicurezza implicita**: il router non annuncia né apprende route non autorizzate.
- Semplicità di troubleshooting in reti piccole.

**Svantaggi:**
- **Non scalabile**: ogni modifica topologica richiede intervento manuale.
- **Nessuna resilienza automatica**: un link down non trigghera rerouting.
- Elevato rischio di **errore umano** in reti complesse.

#### 2.2 Tipologie di Route Statiche

| Tipo | Sintassi (IOS) | AD Default | Scopo |
|---|---|---|---|
| **Standard Static** | `ip route <net> <mask> <next-hop>` | 1 | Raggiungibilità verso rete specifica |
| **Default Route** | `ip route 0.0.0.0 0.0.0.0 <next-hop>` | 1 | Gateway of last resort (GW verso Internet) |
| **Summary Route** | `ip route <supernet> <mask> <next-hop>` | 1 | Aggregazione di prefix contigui (riduce RIB) |
| **Floating Static** | `ip route ... <next-hop> <AD>` (AD > protocollo primario) | Personalizzato | Backup: entra in RIB solo se la route primaria sparisce |

#### 2.3 Stub Networks
- Una **stub network** è una rete con un **unico punto di ingresso/uscita** verso il resto della topologia.
- Il router connesso a una stub network necessita solo di:
  - Route statiche verso le reti interne della stub.
  - Una **default route** per tutto il traffico verso l'esterno.
- Scenario tipico: **branch office** collegato alla sede tramite singolo link WAN.

#### 2.4 Floating Static Route — Logica di Failover

- Configurata con una **AD artificialmente alta** (es. AD = 5 per route di backup rispetto a OSPF con AD = 110... attenzione: deve essere *più alta* del protocollo primario, non più bassa).
- **Comportamento**:
  1. Finché la route primaria (dinamica o statica con AD inferiore) è presente nella RIB, la floating route **non è installata**.
  2. Al fallimento del link primario, la route primaria scompare dalla RIB.
  3. La floating route **entra automaticamente** nella RIB come best path.
- Tecnica semplice ed efficace per topologie con link di backup (es. MPLS primario + Internet VPN backup).

#### 2.5 Next-Hop vs Exit Interface

| Configurazione | Modalità | Comportamento | Raccomandato per |
|---|---|---|---|
| `ip route ... <next-hop IP>` | Recursive lookup | Il router risolve il next-hop IP nella RIB (lookup aggiuntivo) | Link point-to-multipoint (Ethernet) |
| `ip route ... <exit-interface>` | Directly connected | Il router considera la destinazione come direttamente connessa sull'interfaccia | Link point-to-point (seriale, tunnel) |
| `ip route ... <exit-int> <next-hop>` | Fully specified | Combina i due: nessun recursive lookup, comportamento deterministico | Raccomandato in generale |

> ⚠️ Configurare una static route con sola exit-interface su link Ethernet genera **una entry ARP per ogni destinazione**, causando potenziale **ARP table exhaustion**.

---

# 3. Dynamic Routing

## Introduzione
Il **routing dinamico** delega ai protocolli la scoperta, il mantenimento e l'aggiornamento delle route. I router si scambiano informazioni di raggiungibilità, calcolano autonomamente i percorsi ottimali e reagiscono automaticamente ai cambiamenti topologici. La qualità del processo è misurata dalla velocità di **convergenza**.

#### metti un immagine qua
*(Schema: Classificazione protocolli — IGP [RIP, OSPF, EIGRP, IS-IS] vs EGP [BGP]; Distance Vector vs Link State)*

---

### Tabella Tecnica Riassuntiva

| Caratteristica | Distance Vector | Link State |
|---|---|---|
| **Algoritmo** | Bellman-Ford | Dijkstra (SPF) |
| **Visione della rete** | Parziale (solo vicini) | Completa (LSDB globale) |
| **Struttura dati** | Routing Table | Link State Database (LSDB) + SPF Tree |
| **Aggiornamenti** | Periodici (intera tabella) | Triggered (solo cambiamenti, LSA/LSP) |
| **Convergenza** | Lenta (problema count-to-infinity) | Rapida |
| **Scalabilità** | Bassa–Media | Alta (con aree gerarchiche) |
| **Uso memoria/CPU** | Basso | Più elevato |
| **Protocolli** | RIP, RIPv2, EIGRP* | OSPF, IS-IS |

*EIGRP usa DUAL (Diffusing Update Algorithm), ibrido avanzato proprietario Cisco.*

---

### Corpo Centrale

#### 3.1 Strutture Dati dei Protocolli

| Struttura | Protocollo | Contenuto |
|---|---|---|
| **Neighbor Table** | OSPF, EIGRP | Elenco dei router adiacenti (adiacenze verificate) |
| **Topology Table** | EIGRP | Tutti i path noti verso ogni destinazione (non solo il best) |
| **LSDB** (Link State DB) | OSPF, IS-IS | Mappa completa della topologia dell'area |
| **Routing Table (RIB)** | Tutti | Best path installati, pronti per il forwarding |

#### 3.2 Classificazione: IGP vs EGP

| Classificazione | Descrizione | Protocolli |
|---|---|---|
| **IGP** (Interior Gateway Protocol) | Usato *all'interno* di un Autonomous System (AS) | RIP, RIPv2, OSPF, EIGRP, IS-IS |
| **EGP** (Exterior Gateway Protocol) | Usato *tra* Autonomous System diversi | BGP-4 (l'unico EGP moderno) |

- Un **Autonomous System** è un insieme di reti sotto il controllo di una singola organizzazione, identificato da un **ASN** (Autonomous System Number, 16 o 32 bit).
- **BGP** è il protocollo che regge il routing dell'Internet globale (Path Vector, usa policy e attributi come **AS_PATH**, **LOCAL_PREF**, **MED**).

#### 3.3 Algoritmi: Bellman-Ford vs Dijkstra

#### metti un immagine qua
*(Schema comparativo: Distance Vector — ogni router vede solo i vicini e aggiorna la propria tabella iterativamente; Link State — ogni router costruisce una mappa globale ed esegue SPF)*

**Bellman-Ford (Distance Vector):**
- Ogni router conosce solo la distanza verso le destinazioni e il next-hop (non la topologia completa).
- Aggiornamenti **periodici**: invia l'intera routing table ai vicini diretti ("routing by rumor").
- Problema: **count-to-infinity** in caso di loop → mitigato da Split Horizon, Poison Reverse, Hold-down timers.
- Convergenza: lenta (dipende dal numero di hop e dai timer).

**Dijkstra SPF (Link State):**
- Ogni router raccoglie **LSA (Link State Advertisement)** da tutta l'area, costruendo una **LSDB** identica su tutti i nodi.
- Esegue l'algoritmo **SPF** sulla LSDB locale → calcola il **Shortest Path Tree** con sé stesso come radice.
- Aggiornamenti **triggered**: inviati solo quando la topologia cambia (flooding controllato).
- Convergenza: rapida, deterministica.

#### 3.4 Metriche di Routing

| Metrica | Protocollo | Descrizione |
|---|---|---|
| **Hop Count** | RIP | Numero di router attraversati (max 15 per RIP) |
| **Costo (Cost)** | OSPF | `10^8 / Bandwidth` (reference BW = 100 Mbps per default) |
| **Bandwidth + Delay** | EIGRP | Composite metric: funzione di BW minimo e delay cumulativo del path |
| **Attributi Path** | BGP | AS_PATH length, LOCAL_PREF, MED, Weight (policy-based) |

> ⚠️ La metrica OSPF di default assegna **costo identico** a link 100 Mbps e 1 Gbps. Necessario rivedere la `auto-cost reference-bandwidth` per reti con link > 100 Mbps.

#### 3.5 Convergenza

- **Definizione**: stato in cui *tutti* i router della rete hanno una visione consistente e aggiornata della topologia e hanno installato i best path corretti nella RIB.
- **Fattori che influenzano la velocità di convergenza**:
  - Tipo di protocollo (LS converge più velocemente di DV).
  - Timer configurati (Hello interval, Dead interval, Hold timer).
  - Dimensione della rete e numero di route.
  - Utilizzo di tecniche come **BFD** (Bidirectional Forwarding Detection) per rilevamento rapido dei guasti.
- Durante la convergenza, il traffico può subire **black-holing** o **routing loop temporanei**.

---

# 4. First Hop Redundancy (FHRP)

## Introduzione
I protocolli **FHRP** risolvono il **Single Point of Failure** del default gateway negli host end. Tramite l'astrazione di un **Virtual Router** (IP e MAC virtuali condivisi tra più router fisici), garantiscono la continuità del servizio di gateway anche in caso di guasto di un router membro, senza richiedere alcuna riconfigurazione sugli host.

#### metti un immagine qua
*(Schema: Host con default gateway = Virtual IP; Router A (Active/Master) e Router B (Standby/Backup) condividono VIP e VMAC; failover automatico al guasto di A)*

---

### Tabella Tecnica Riassuntiva

| Parametro | HSRP | VRRP | GLBP |
|---|---|---|---|
| **Standard** | Proprietario Cisco | Open Standard (RFC 5798) | Proprietario Cisco |
| **Ruoli** | Active / Standby | Master / Backup | AVG + AVF (max 4) |
| **Virtual MAC** | `0000.0c07.acXX` | `0000.5e00.01XX` | `0007.b400.XXYY` |
| **Load Balancing** | No (solo failover) | No (solo failover) | Sì (fino a 4 gateway attivi) |
| **Versioni** | HSRPv1 (IPv4), HSRPv2 (IPv4/IPv6) | VRRPv2 (IPv4), VRRPv3 (IPv4/IPv6) | GLBPv1 |
| **Preemption** | Configurabile (default off) | Abilitato per default | Configurabile |
| **Autenticazione** | MD5, plaintext | MD5 (VRRPv3) | MD5 |

---

### Corpo Centrale

#### 4.1 Single Point of Failure del Default Gateway

- Gli host configurano **staticamente** (o via DHCP) un singolo indirizzo IP come **default gateway**.
- Se il router che detiene quell'IP diventa irraggiungibile, **tutto il traffico off-subnet viene interrotto**, indipendentemente dall'esistenza di router alternativi.
- Gli host non hanno meccanismi nativi per rilevare il guasto del gateway e passare automaticamente a uno alternativo.
- **FHRP** risolve questo problema presentando agli host un **gateway virtuale** immune al guasto di un singolo dispositivo fisico.

#### 4.2 Logica del Virtual Router — Astrazione VIP e VMAC

- Un **gruppo FHRP** è composto da due o più router fisici che condividono:
  - **Virtual IP (VIP)**: indirizzo IP configurato come default gateway sugli host. Non appartiene a nessuna interfaccia fisica.
  - **Virtual MAC (VMAC)**: indirizzo MAC associato al VIP. Gli host apprendono questo MAC tramite ARP (risposta al VIP).
- Il router **Active/Master** risponde alle richieste ARP per il VIP e forwarda il traffico.
- Il router **Standby/Backup** monitora l'Active tramite messaggi **Hello** periodici.
- Gli host non percepiscono mai il cambio di router fisico: il VIP e il VMAC rimangono invariati.

#### 4.3 Meccanismo di Failover: Hello e Hold Timer

| Timer | HSRP Default | VRRP Default | Descrizione |
|---|---|---|---|
| **Hello Timer** | 3 secondi | 1 secondo | Intervallo tra messaggi Hello inviati dall'Active/Master |
| **Hold Timer** | 10 secondi | 3 secondi | Tempo di attesa prima che lo Standby dichiari l'Active come down |
| **Failover time** | ~10 secondi | ~3 secondi | Tempo totale prima che il Backup assuma il ruolo Active |

**Sequenza di Failover:**
1. L'Active router smette di inviare messaggi **Hello**.
2. Allo scadere dell'**Hold Timer**, lo Standby/Backup dichiara l'Active irraggiungibile.
3. Il Backup **assume il ruolo Active**: inizia a rispondere al VIP/VMAC, invia **Gratuitous ARP** per aggiornare le ARP table degli switch e degli host.
4. Il traffico riprende in direzione del nuovo Active.

> ⚠️ I timer possono essere abbassati (es. Hello 200ms, Hold 600ms con millisecond timers su HSRP) per ridurre il downtime, a costo di maggiore overhead.

#### 4.4 Preemption

- **Preemption** permette a un router con **priorità più alta** di *riprendere* il ruolo Active quando torna online dopo un guasto, scalzando il router che lo aveva assunto temporaneamente.
- **HSRP**: preemption **disabilitata per default** → deve essere configurata esplicitamente (`standby X preempt`).
- **VRRP**: preemption **abilitata per default**.
- **Logica di priorità**: il router con **priority value** più alto (default 100, range 1–255) diventa Active. In caso di parità, vince l'IP più alto.

#### 4.5 Object Tracking — Preemption Intelligente

#### metti un immagine qua
*(Schema: Router Active con uplink verso ISP tracciato — se l'uplink cade, la priority scende sotto quella dello Standby → il Standby diventa Active anche senza preemption forzata)*

- **Object Tracking** permette di legare la **priorità FHRP** allo stato di un oggetto monitorato (interfaccia, route IP, stato SLA).
- **Scenario tipico**:
  - Router A: priority 110, Active, uplink verso ISP su `GigabitEthernet0/0`.
  - Configurazione: se `Gi0/0` va down → decrementa priority di 20 → priority scende a 90.
  - Router B: priority 100 → con preemption abilitato, diventa il nuovo Active.
- Evita il scenario in cui il router Active mantiene il ruolo anche avendo perso la connettività verso l'upstream.

#### 4.6 GLBP — Load Balancing Attivo

- A differenza di HSRP e VRRP (dove solo *un* router forwarda traffico per gruppo), **GLBP** introduce il concetto di **Active Virtual Gateway (AVG)** e fino a 4 **Active Virtual Forwarder (AVF)**.
- L'**AVG** risponde alle richieste ARP per il VIP, distribuendo *VMAC diversi* ai diversi host (Round Robin, Weighted, Host-Dependent).
- Ogni host riceve un VMAC diverso → il traffico viene **distribuito** su più router simultaneamente.
- In caso di guasto di un AVF, l'AVG riassegna quel VMAC a un altro membro del gruppo.

---

*Fine Documentazione · Routing Logic v1.0 · ITS — Sistemi e Reti*

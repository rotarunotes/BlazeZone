

# Sintesi Tecnica: Architetture Fisiche e Gestione Server

Il documento fornito si concentra sull'infrastruttura di Livello 1 (Fisico) del modello ISO/OSI e sulla progettazione sistemistica dei servizi aziendali. In sede di esame, queste nozioni andranno necessariamente integrate con i protocolli di livello superiore (es. 802.1Q per VLAN, OSPF per il routing).
## 1. Topologia e Cablaggio Strutturato

La scelta dell'infrastruttura fisica determina la scalabilità e la resilienza della rete.

- La topologia predominante nelle reti LAN è la **stella estesa (o gerarchica)**.
    
- Questa topologia consiste in più topologie a stella interconnesse tra loro.
    
- **Vantaggi:** Garantisce fault-tolerance, elevata flessibilità ed espandibilità.
    
- **Svantaggi:** Richiede un maggiore cablaggio ed è vulnerabile in caso di guasto dell'apparato al centro stella (Single Point of Failure).
    
- Il **Cablaggio Strutturato** detta le regole per il posizionamento e il collegamento dei nodi.
    
- È diviso in tre livelli gerarchici principali:
    
    - **1° Livello:** Centro stella di comprensorio (CD = Campus Distributor).
        
    - **2° Livello:** Centro stella di edificio (BD = Building Distributor).
        
    - **3° Livello:** Centro stella di piano (FD = Floor Distributor).
        
- A livello di interconnessione si distingue il cablaggio **Verticale (o dorsale, VCC)** e quello **Orizzontale (HCC)** che arriva fino alla presa utente (TO).
## 2. Architettura Server e Data Center (CED)

Un aspetto cruciale della traccia d'esame è solitamente la decisione su _dove_ e _come_ allocare i servizi (es. Web Server, Database, Gestionale). I server possono essere macchine standalone, risiedere in Data Center aziendali o in Server Farm esterne.

- **Standalone:** Server in case verticale con grande capacità di storage (ordine dei terabyte) e supporto RAID. Sono ideali per piccole filiali, condivisione file o virtualizzazione di base.
    
- **Data Center (CED):** Aree attrezzate per il trattamento e l'archiviazione sicura dei dati, spesso coincidenti con il locale tecnico del Campus Distributor (CD).
    

### Tabella Comparativa: Data Center Interno vs Server Farm Esterna

In sede d'esame, questa analisi è fondamentale per giustificare il "Make or Buy".

|**Caratteristica**|**Data Center Interno (Make)**|**Server Farm Esterna (Buy)**|
|---|---|---|
|**Sicurezza e Privacy**|Controllo diretto e garanzia totale sulla privacy dei dipendenti/clienti.|Delega all'esperienza professionale del fornitore, che dispone di sistemi fisici e logici avanzati (firewall).|
|**Costi**|Alti costi operativi (CAPEX e OPEX): affitto aree, acquisto hardware, formazione personale, aggiornamenti e sistemi di backup.|Eliminazione dei costi di manutenzione e allocazione interna (pagamento canone o locazione).|
|**Continuità Operativa**|Possibilità di intervento fisico tempestivo da parte del team IT interno in caso di guasti.|Garanzia di alimentazione ridondata (UPS), impianto di condizionamento e connettività stabile fornite dalla struttura.|
|**Rischio Intrusioni**|Alto impatto sulla LAN se un servizio web esposto subisce un attacco.|Le Web Application esterne limitano drasticamente i rischi di intrusione nella LAN aziendale.|

Le Server Farm (spesso ubicate nel sottosuolo per maggiore protezione ) offrono vari servizi contrattuali, tra cui l'**Hosting** (server del fornitore ospita servizi accessibili via web), l'**Housing / Colocation** (il server è di proprietà dell'azienda ma allocato fisicamente nella farm), Server Dedicati e Virtuali.

## 3. Virtualizzazione dei Server

La virtualizzazione è un argomento "jolly" che alza sempre la valutazione del candidato. Permette di creare più macchine virtuali (VM) su un unico server fisico, condividendone le risorse.

- **Vantaggi da citare sempre:** Riduzione dei costi hardware e dei consumi energetici del CED, allocazione dinamica delle risorse in tempo reale e riduzione drastica dei tempi di messa in opera (provisioning) di nuovi sistemi.
    

---

# Caso Aziendale Simile-Maturità: Progettazione Infrastrutturale

**Traccia:** _L'azienda "TechManifacturing SpA" possiede un Campus con un edificio principale (Direzione e CED) e un capannone di produzione adiacente. L'azienda necessita di una rete sicura divisa per dipartimenti, un gestionale interno per la produzione e un portale E-commerce esposto al pubblico. Progettare l'infrastruttura, giustificando le scelte tecnologiche e i paradigmi di sicurezza applicati._

### 1. Analisi dei Requisiti e Architettura Logico-Fisica

Seguendo il modello gerarchico , l'infrastruttura sarà basata su una **Topologia a Stella Estesa** per garantire fault-tolerance e flessibilità.

- **Edificio Principale (CD + BD):** Ospiterà il Campus Distributor (CD) e il CED interno. Il Core Switch sarà posizionato qui.
    
- **Capannone Produzione (BD2):** Connesso al CD tramite Dorsale di Comprensorio in Fibra Ottica per evitare interferenze elettromagnetiche (EMI).
    
- **Cablaggio Orizzontale (HCC):** Dai Floor Distributor (FD) alle prese utente (TO), realizzeremo i collegamenti in rame (Cat 6a o 7) per supportare Gigabit Ethernet.
    

### 2. Piano di Indirizzamento e Segmentazione (VLAN)

Per ragioni di broadcast control e sicurezza (Livello 2), segmenteremo la rete con le VLAN, utilizzando la classe di indirizzi privati `10.0.0.0/8` subnetting `/24`.

Plaintext

```
========================================================================
 PIANO DI INDIRIZZAMENTO IP E VLAN (Core Switch L3 come Default Gateway)
========================================================================
VLAN ID  | Dipartimento       | Rete / Subnet Mask      | Default Gateway
------------------------------------------------------------------------
VLAN 10  | Management         | 10.1.10.0 / 255.255.255.0 | 10.1.10.254
VLAN 20  | Produzione (IoT)   | 10.1.20.0 / 255.255.255.0 | 10.1.20.254
VLAN 30  | CED Interno (Dati) | 10.1.30.0 / 255.255.255.0 | 10.1.30.254
VLAN 99  | Management Devices | 10.1.99.0 / 255.255.255.0 | 10.1.99.254
========================================================================
```

### 3. Collocazione dei Servizi e Virtualizzazione

Adotteremo un approccio ibrido per i server:

- **Database e Gestionale (Dati Sensibili):** Ospitati nel **CED Interno** per avere controllo diretto sulla privacy. Utilizzeremo un server fisico di fascia alta implementando la **Virtualizzazione** (es. Hypervisor ESXi o Proxmox). Avremo una VM per l'Active Directory, una VM per il DBMS (SQL) e una VM per il software gestionale. I dischi saranno in **RAID 5 o 10** per la fault tolerance hardware.
    
- **Portale E-Commerce (Web App):** Sarà ospitato in **Hosting presso una Server Farm Esterna**. _Giustificazione tecnica:_ Mantenere applicazioni web esposte al pubblico al di fuori del CED interno limita criticamente i rischi di intrusioni dirette nella LAN aziendale , e sfrutta la connettività altamente stabile del provider.
    

### 4. Diagramma Logico Descrittivo

In sede di esame non potrai usare CAD, ma dovrai disegnare (o descrivere con chiarezza) i flussi:

1. **Internet / WAN** <--> **Router BGP (ISP)**
    
2. **Perimetro di Sicurezza:** Un **Next-Generation Firewall (NGFW)** posizionato a protezione della rete (esegue NAT/PAT, Intrusion Prevention System e fa da terminatore per le **VPN** IPsec per lo smart working dei dipendenti).
    
3. **Livello Core (CD):** Switch Layer 3 con funzionalità di inter-VLAN routing. Interconnesso in alta affidabilità (Link Aggregation).
    
4. **Livello Distribution (BD):** Switch gestiti collegati ai vari piani d'edificio in Fibra.
    
5. **Livello Access (FD):** Switch Layer 2 dotati di PoE (Power over Ethernet) per alimentare gli Access Point Wi-Fi e i telefoni VoIP fino ai TO (Telecommunications Outlet).
    

---

# Tips per la Maturità (Dalla Cattedra)

1. **Giustifica Sempre i Costi:** La commissione adora quando uno studente dimostra consapevolezza economica. Quando proponi un Data Center interno, scrivi esplicitamente: _"La scelta comporta elevati costi CAPEX e OPEX per condizionamento, sicurezza e personale, ma è un requisito imprescindibile per la normativa sulla compliance dei nostri dati critici"_.
    
2. **Non dimenticare l'Alimentazione:** Una rete non esiste se si spegne. Menziona sempre **UPS (Gruppi di Continuità)** e generatori diesel ridondati per il CED e per gli armadi di piano.
    
3. **Sicurezza vs Web App:** Sfrutta il "trucco" della Server Farm suggerito dal tuo testo. Esportare il web server in una Server Farm tramite Hosting/Housing svincola l'azienda dal dover creare e gestire una zona DMZ (Demilitarized Zone) complessa sul firewall locale, riducendo drasticamente la superficie d'attacco sulla rete privata.
    
4. **Usa correttamente gli acronimi:** Inserisci le terminologie CD, BD e FD per dimostrare padronanza delle normative sul cablaggio strutturato.
    

	Buono studio. Concentrati sul collegare i concetti sistemistici (i server) con l'infrastruttura di rete (gli switch/router). È lì che si vede il vero Progettista.

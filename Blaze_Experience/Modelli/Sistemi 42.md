
### Network_Fundamentals

- **Models**
	- `ISO_OSI.md`
	    - I 7 livelli: Fisico, Datalink, Rete, Trasporto, Sessione, Presentazione, Applicazione
	    - PDU per livello: bit → frame → pacchetto → segmento → dati
	    - Encapsulation/decapsulation e apparati

	- `TCP_IP.md`
	    - Mapping: Applicazione TCP/IP = Sessione+Presentazione+Applicazione OSI
	    - Perché TCP/IP è lo stack reale: 4 livelli pratici
	    - Implementazione reale

- **Physical_Layer** 
	- `Cables_And_Interfaces.md`
	    - Tipologie: UTP (Cat5e/6), Fiber (Single-mode vs Multi-mode), Coax
	    - Connettori: RJ-45, LC, SC; distanze massime per tipo di cavo
	    - PoE (Power over Ethernet): standard 802.3af/at, use cases (AP, IP Phone)
	    - Speed/Duplex: auto-negotiation, mismatch e impatto sulle performance
	-  `Topology_Types.md`
	    - Two-tier (Core-Access) vs Three-tier (Core-Distribution-Access)
	    - Spine-Leaf architecture (Data Center)
	    - WAN topologies: Point-to-Point, Hub-and-Spoke, Full Mesh
	    - On-premise vs Cloud vs Hybrid: impatto sul design


- **Transport_Layer**
	- `TCP.md`
		- Three-way handshake: SYN → SYN-ACK → ACK
		- Controllo di flusso (sliding window), controllo di congestione
		- Numeri di sequenza, ACK, ritrasmissione — connessione affidabile
	- `UDP.md`
		- Senza connessione, non affidabile, bassa latenza
		- Quando scegliere UDP: DNS, DHCP, streaming, VoIP, gaming
		- Header UDP: solo 8 byte vs header TCP 20+ byte	
___
### Planning_Addressing

- **IP_Addressing**:
    - `IPv4.md`
	    - Classi A/B/C, range privati: 10.x, 172.16-31.x, 192.168.x
	    - Loopback 127.0.0.1, broadcast diretto vs limitato
	    - Notazione CIDR: /prefix equivalente alla subnet mask
    - `Subnetting_VLSM_CIDR.md`
	    - Suddivisione a lunghezza variabile, adatta la maschera al numero di host
	    - Calcolo: N host → /prefix con 2^(32-prefix) - 2 ≥ N host utili
	    - CIDR: aggregazione di rotte (supernetting) per ridurre tabelle di routing
    - `IPv6.md`
        - 128 bit, notazione esadecimale, doppi due punti per comprimere zero
        - Tipi: Global Unicast, Link-Local (fe80::/10), Multicast
        - NDP sostituisce ARP; stateless autoconfiguration (SLAAC)
        - DHCPv6 (Stateful vs Stateless), EUI-64, migrazione da IPv4

- **Core_Protocols**
    - `ARP.md`
	    - ARP Request (broadcast) → ARP Reply (unicast): IP → MAC
	    - ARP cache e aging time; Gratuitous ARP
	    - ARP Poisoning: attacco MITM — collegamento con sicurezza
    - `ICMP.md`
	    - Ping (Echo Request/Reply), Traceroute (TTL decrement)
	    - Messaggi ICMP: Destination Unreachable, Time Exceeded, Redirect
	    - ICMP non trasporta dati utente, solo controllo e diagnostica
    - `CDP.md` 
        - CDP (Cisco Discovery Protocol): proprietario Cisco, Layer 2
        - Comandi: show cdp neighbors detail, show lldp neighbors
        - Use case: scoperta topologia, troubleshooting, inventario dispositivi
        - Sicurezza: disabilitare CDP/LLDP su porte verso utenti non fidati
	- `LLDP.md` 
		- LLDP (Link Layer Discovery Protocol): standard IEEE 802.1AB, vendor-neutral

- **Routing_Logic**
	- `Forwarding_Decisions.md`
        - Come il router sceglie la rotta: 1) Longest Match, 2) Administrative Distance (AD), 3) Metrica
	- `Static_Routing.md`
		- Rotte configurate manualmente: IP route \<rete> \<maschera> \<next-hop>
		- Default route: 0.0.0.0/0 — gateway di last resort
		- Administrative Distance: misura di fiducia della sorgente della rotta
	- `Dynamic_Routing.md`
		- Distance Vector (RIP): invia tabella completa ai vicini, max 15 hop
		- Link State (OSPF e OSPFv2): mappa completa della rete, algoritmo Dijkstra SPF
		- Convergenza: tempo per cui tutti i router concordano sulla topologia
		- [ESPANDI] OSPFv3 per IPv6, OSPF multi-area, DR/BDR election
    - `First_Hop_Redundancy.md` 
        - Concetti di ridondanza del Gateway (HSRP, VRRP)

- **WAN_Technologies** [NUOVO]
	- `WAN_Concepts.md`
	    - MPLS: label switching, traffic engineering, VPN su MPLS
	    - Connessioni WAN: Leased Line, Metro Ethernet, Broadband (DSL, Cable)
	    - Internet VPN vs MPLS VPN: trade-off costo/sicurezza/latenza
	    - SD-WAN: overlay su WAN multipli, centralizzazione della policy

---
### Switching_And_Network_Access
- **VLAN**
	- `VLAN_Segmentation.md`
	    - Data VLANs: Traffico dati standard degli utenti
	    - Voice VLAN: Permette di separare il traffico voce da quello dati sulla stessa porta dello switch (fondamentale per telefoni IP)
	    - Native VLAN: L'unica VLAN che attraversa un trunk senza "tag" (default VLAN 1). Importante per motivi di sicurezza e controllo (STP, CDP)
	    - Management VLAN: VLAN dedicata al traffico di gestione dei dispositivi
	- `802.1Q_Tagging.md`
		- Lo standard industriale che aggiunge un tag di 4 byte nell'header Ethernet per identificare a quale VLAN appartiene il frame
	- `Access_Vs_Trunk.md`
	    - Access Port: Appartiene a una sola VLAN. Usata per PC, Stampanti, Server
	    - Trunk Port: Trasporta il traffico di più VLAN contemporaneamente. Usata tra Switch o tra Switch e Router
	- `DTP.md`
	    - Negozia automaticamente se una porta deve diventare Access o Trunk
	    - switchport mode dynamic desirable (tenta attivamente) vs dynamic auto (aspetta che l'altro inizi)
	- `VTP_VLAN_Trunking_Protocol.md`
	    - Un protocollo proprietario Cisco che permette di creare/eliminare VLAN su un unico switch "Server" e propagare le modifiche automaticamente a tutti gli altri switch "Client"
	    - Server / Client / Transparent
	    - Il numero di Revision è critico. Se colleghi uno switch con un numero di revisione più alto, rischi di cancellare l'intero database VLAN della tua rete

- **Inter-VLAN_Routing**
	- `Router-On-A-stick.md`
	    - Un router collegato tramite un unico trunk a uno switch. Usa le Sub-interfaces (es. int g0/0.10) per gestire ogni VLAN
	- `Layer_3_Switch_SVI.md`
	    - Uso di SVI (Switched Virtual Interface) per fare routing alla velocità dell'hardware. È il metodo più moderno ed efficiente

- **Redundancy_and_Aggregation**
	- `STP.md`
		- Impedisce i "Broadcast Storm" bloccando logicamente i percorsi ridondanti (Loop prevention)
	    - Root Bridge Selection (basato sul Bridge ID più basso) → Root Ports → Designated Ports → Blocking Ports
	    - RSTP (802.1w): Versione rapida (Rapid STP), riduce i tempi di convergenza da 50 secondi a pochi millisecondi
	    - [ESPANDI] PortFast, BPDU Guard, BPDU Filter — porte verso end-device
	- `EtherChannel_LACP.md`
	    - Raggruppa fino a 8 link fisici in un unico link logico
	    - LACP (Standard 802.3ad) vs PAgP (Cisco)
	    - Se un cavo si rompe, il traffico continua sugli altri senza che STP debba ricalcolare tutto

---
### IP_Services [NUOVO]

- **Infrastructure_Services**
    - `DNS.md`
        - [ESPANDI] Risoluzione ricorsiva vs iterativa, record A/AAAA/MX/CNAME/PTR
    - `DHCP.md`
        - [ESPANDI] DORA process, DHCP relay agent (ip helper-address), conflitti e riserve
    - `NTP.md`
        - [ESPANDI] Stratum levels, NTP server/client config su IOS, importanza per logging e certificati
    - `SNMP.md`
        - [ESPANDI] v2c vs v3 (autenticazione/cifratura), MIB, OID, trap vs polling

- **Traffic_Management** [NUOVO]
	- `QoS.md`
	    - Perché QoS: latenza, jitter e perdita di pacchetti per VoIP/video
	    - Classificazione e marcatura: DSCP (Layer 3), CoS 802.1p (Layer 2)
	    - Meccanismi di accodamento: FIFO, WFQ, CBWFQ, LLQ
	    - Policing vs Shaping: drop vs buffer; trust boundary

- **Network_Address_Translation**
	- `NAT.md` [SPOSTATO da Core_Protocols]
		- NAT statico, dinamico, overload (PAT)
		- Problema NAT con VoIP e FTP (ALG Application Layer Gateway)
	- `PAT.md` [SPOSTATO da Core_Protocols]
		- PAT dinamico: tabella di traduzione IP:porta interna ↔ IP pubblico:porta esterna

---
### Protocols
- **Web_And_Communication**
	- `HTTP.md`
	- `HTTPS.md`
	- `Email.md`
	- `SMTP.md`
	- `POP.md`
	- `IMAP.md`
- **Management_And_Remote_Access**
	- `SSH.md`
	- `TELNET.md`
	- `FTP.md` [NUOVO]
	    - FTP: autenticazione, attivo vs passivo, problemi con NAT
	    - TFTP: backup/restore IOS e config su dispositivi Cisco
	- `TFTP.md`
---
### Security_Cryptography
- **Security**
	- `Security_Concepts.md`
        - chiave: Minacce, Vulnerabilità, Exploit, tecniche di Mitigazione
        - [ESPANDI] Attacchi comuni: DoS/DDoS, Spoofing, Man-in-the-Middle, Phishing, Social Engineering
        - [ESPANDI] Password attacks: Dictionary, Brute Force, Rainbow Table
	- `Device_Hardening.md`
        - Password complesse, SSH vs Telnet, Login banners, blocco tentativi bruteforce
        - [ESPANDI] Disabilitare servizi non usati, CDP selettivo, unused port shutdown

- **Cryptography**
	- `Symmetric_Cryptography.md`
	- `Asymmetric_Cryptography.md`
	- `Hashing_And_Integrity.md`
	- `PKI_Certificates_X509.md`

- **Network_Defense**
	- `Layer_2_Security.md`
		- Port Security (Max MAC addresses, Violation modes: Protect, Restrict, Shutdown)
		- [ESPANDI] DHCP Snooping, Dynamic ARP Inspection (DAI), IP Source Guard
	- `Firewall_Types.md`
	    - Packet Filtering: Stateless, based on ACLs
	    - Stateful Inspection: Tracks the state of active connections
	    - Next-Generation (NGFW): Deep Packet Inspection (DPI) and Application Layer awareness
	- `Cisco_ACLs.md`
	    - Standard: Source IP only (posizionare vicino alla destinazione)
	    - Extended: Source/Dest IP, Protocol, and Port numbers (posizionare vicino alla sorgente)
	    - [ESPANDI] Named ACLs, ACL su interfaccia (in/out), wildcard mask
	- `DMZ.md`
	    - Demilitarized Zone. A sub-network that contains an organization's external-facing services (Web, Mail, DNS) to protect the internal network
	- `AAA_Framework.md`
		- Authentication, Authorization, Accounting; protocolli RADIUS e TACACS+

- **Secure_Connectivity_VPN**
	- `IPsec_Protocol.md`
	    - Architecture for securing IP communications
	    - Tunnel Mode (entire packet encrypted) vs Transport Mode (only payload encrypted)
	    - Components: ESP (Encryption), AH (Authentication), and IKE (Key Management)
	- `SSL.md`
	- `TLS.md`
	- `VPN.md`
	    - [ESPANDI] Site-to-Site VPN vs Remote Access VPN; GRE tunnel (no encryption)

---
### Wireless
- **Wireless_Fundamentals**
	- `802_11_Standards_And_RF.md`
	    - Bands (2.4GHz vs 5GHz), Channels (1, 6, 11), and 802.11 variants (n, ac, ax)
	    - Antenna types (Omni-directional, Patch, Yagi)
	- `Wireless_Media_Access.md`
	    - CSMA/CA (Collision Avoidance)
	    - Understanding the "Hidden Node Problem" and the use of RTS/CTS (Request to Send/Clear to Send)

- **Cisco_Architectures**
	- `WLC_And_AP_Deployment_Models.md`
	    - Local mode, FlexConnect (for branches), Sniffer, and Monitor modes
	    - Autonomous (Standalone) vs Cloud-based (Meraki) vs Centralized (Split-MAC)
	- `CAPWAP_And_AP_Join_Process.md`
	    - Split-MAC Architecture: Real-time tasks on AP, Management tasks on WLC
	    - The AP Join Process: 1) Discovery, 2) Join, 3) Image Download, 4) Config
	    - DHCP Option 43: Used to tell the AP the IP address of the WLC
	- `Deployment_Models.md`
		- Local mode, FlexConnect (per uffici remoti), Bridge, Sniffer

- **WLAN_Security_And_Config**
	- `Encryption_Standards.md`
		- Evoluzione da TKIP a AES-CCMP
	- `Wireless_Security_Protocols.md`
	    - WPA2 (AES/CCMP) vs WPA3 (SAE)
	    - 802.1X (EAP): Using a RADIUS server for enterprise-grade security
	- `WLC_Management_Interfaces.md`
	    - Management Interface (for WLC access) vs Dynamic Interfaces (mapped to specific VLANs for user traffic)
	    - Steps to create a WLAN on a WLC: General Tab (SSID) → Security Tab (L2/L3) → Advanced Tab

---
### Automation_And_Programmability
- `SDN_And_Controller.md`
    - Rete tradizionale vs Software Defined Networking (SDN)
    - Separation of Planes (Data plane, Control plane, Management plane)
    - Cisco DNA Center, SD-Access, SD-WAN
- `API_And_Automation.md`
    - chiave: REST APIs (GET, POST, PUT, DELETE), codici di stato HTTP
    - [AGGIORNATO v1.1] Configuration Management: Ansible (agentless, YAML/playbook) e Terraform (IaC, declarativo) — Puppet e Chef rimossi dal syllabus v1.1
- `Data_Formats.md`
    - esame: Interpretazione e lettura di dati in formato JSON
    - [ESPANDI] YAML (usato da Ansible), XML — struttura e confronto con JSON
- `Cloud_Network_Management.md` [NUOVO — aggiunto in v1.1]
    - Cloud deployment models: IaaS, PaaS, SaaS — differenze e use case
    - Cloud network concepts: Virtual Private Cloud (VPC), scalabilità on-demand
    - Cisco cloud solutions: Meraki (cloud-managed), Webex, Intersight
    - Impatto del cloud sulla gestione e sul design delle reti aziendali
- `AI_ML_In_Networking.md` [NUOVO — aggiunto in v1.1]
    - AI predittiva: analisi del traffico, anomaly detection, capacity planning
    - AI generativa: assistenti di configurazione, troubleshooting automatizzato
    - Machine Learning in operazioni di rete: pattern recognition nei log
    - Cisco AI tools: Cisco AI Assistant, ThousandEyes per network intelligence

---
### Network_Design

- `Requirements_Analysis.md`
	- Data gathering: number of users per department, required services, future growth, budget
	- Define: logical topology (VLAN), physical topology (cabling, racks)
	- Constraints: 100m UTP distance limit, fiber optics for backbone, required redundancy?
- `Analysis_And_Sizing.md`
	- Topologie Star/Mesh, scelta apparati Core/Dist/Access
- `Structured_Cabling.md`
    - Organizzazione in sottosistemi: cablaggio orizzontale (verso le postazioni), backbone (tra i piani), aree di terminazione nei rack
- `Device_Selection_And_Sizing.md`
	- Access vs Distribution vs Core switches: functions and port density requirements
	- Router: throughput, WAN interfaces, dynamic routing support, VPN
	- IP Addressing: one VLAN per department using VLSM, servers in a dedicated VLAN
- `Services_And_Placement.md`
	- DHCP: one pool per VLAN, DHCP relay on the router if using a centralized server
	- DNS, NTP, Syslog: placement on internal servers (DMZ or Management LAN)
	- Redundancy: HSRP/VRRP for default gateway, STP for loop prevention, link aggregation (EtherChannel)
- `Technical_Report_Outline.md`
	- Report structure: objectives → analysis → logical design → physical design → security → costs
	- Network diagram: devices with hostname, interface IP addresses, VLAN IDs, connections
	- Addressing table: VLAN, subnet, gateway, DHCP range, static servers

---
### Troubleshooting [NUOVO — dominio trasversale all'esame]

- `Troubleshooting_Methodology.md`
    - Approccio sistematico: Top-Down, Bottom-Up, Divide & Conquer
    - OSI come mappa mentale: partire dal Layer 1 (cavi) → Layer 7
    - Documentare sintomi, isolare il problema, testare la soluzione
- `Common_Issues_And_Commands.md`
    - Layer 1/2: show interfaces (errors, duplex mismatch, no carrier)
    - Layer 3: show ip route, ping, traceroute, show ip arp
    - VLAN/STP: show vlan brief, show spanning-tree, show mac address-table
    - OSPF: show ip ospf neighbor, show ip ospf database
    - ACL: show ip access-lists, debug ip packet
    - DHCP: show ip dhcp binding, show ip dhcp conflict
    - Wireless: show ap summary, show client detail

___
### Cisco Packet Tracer
- Fondamentali e Gestione
	- **Accesso al Dispositivo**: Metodi di connessione fisica (Console) e logica
	- **Modalità Operative**: Navigazione tra le modalità (User EXEC, Privileged EXEC, Global Config)
	- **Password**: Protezione degli accessi alle varie modalità e linee
	- **File di Configurazione**: Gestione della running-config e startup-config
	- **Comandi Show**: Verifica dello stato e delle impostazioni del dispositivo
	- **Indirizzi IP**: Assegnazione degli indirizzi alle interfacce fisiche e virtuali (SVI)
- Connettività e Servizi IP
	- **Telnet e SSH**: Configurazione delle linee VTY per l'accesso remoto sicuro
	- **TFTP**: Protocollo per il backup e il ripristino delle immagini IOS e delle configurazioni
	- **Ripristino Dispositivi**: Procedure di password recovery e factory reset
	- **DHCP**: Configurazione del servizio per l'assegnazione automatica degli indirizzi
	- **Routing**: Concetti di inoltro dei pacchetti e instradamento tra reti diverse
- Switching e Sicurezza Layer 2
	- **VLAN**: Segmentazione logica della rete locale
	- **VTP**: Propagazione automatica delle informazioni sulle VLAN tra gli switch
	- **Vlan Routing (Routing on stick)**: Uso di un router (o switch L3) per permettere il traffico tra VLAN diverse
	- **Port Security**: Limitazione degli accessi basata sui MAC address per proteggere le porte dello switch
- Tecnologie Avanzate e Sicurezza
	- **WLAN e WLC**: Architetture wireless e gestione centralizzata tramite controller
	- **VOIP**: Integrazione del traffico voce sulla rete dati
	- **Firewall**: Implementazione delle policy di sicurezza e filtraggio del traffico
	- **CDP/LLDP** [NUOVO]: Verifica della topologia con show cdp/lldp neighbors
	- **QoS** [NUOVO]: Configurazione base di marcatura e accodamento
	- **Passaggi**: Sequenze operative per l'implementazione delle tecnologie sopra citate
	  




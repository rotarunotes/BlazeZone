

### 📁 `system_and_networks`

0. **00_FONDAMENTA_E_MODELLI_DI_RETE**
    
    _(Unisce le basi fisiche, i modelli teorici e il livello di trasporto)_
    
    - 📁 `Modelli_e_Architetture`
        
        - `ISO_OSI_7_Livelli.md` (PDU, differenze encapsulation/decapsulation, ruoli di hub/switch/router)
            
        - `TCP_IP_vs_OSI.md` (Mapping dei livelli, perché TCP/IP è lo stack reale)
            
    - 📁 `Livello_Trasporto`
        
        - `TCP_Protocollo.md` (Three-way handshake, sliding window, controllo congestione)
            
        - `UDP_Protocollo.md` (Bassa latenza, use cases come DNS/VoIP, struttura header)
            
    - 📁 `Infrastruttura_Fisica`
        
        - `Componenti_di_Rete.md` (Router, switch L2/L3, firewall, AP, WLC)
            
        - `Topologie_e_Cablaggi.md` (Spine-leaf, Star, rame vs fibra ottica single/multi-mode)
            
        - `Virtualizzazione_Base.md` (Concetti di VM e container)
            
1. **01_ACCESSO_ALLA_RETE_L2**
    
    _(Si concentra su switching, VLAN e protocolli di data link)_
    
    - 📁 `Switching_Avanzato`
        
        - `VLAN_e_Inter-VLAN.md` (Creazione, 802.1Q tagging, router-on-a-stick, access vs trunk)
            
        - `Spanning_Tree_STP.md` (Prevenzione loop, Root Bridge, RSTP)
            
        - `EtherChannel.md` (Aggregazione link, LACP)
            
    - 📁 `Protocolli_Core_L2_L3`
        
        - `ARP_Protocollo.md` (ARP request/reply, gratuitous ARP, poisoning)
            
2. **02_CONNETTIVITA_IP_E_ROUTING**
    
    _(Il cuore della rete: indirizzamento logico e instradamento)_
    
    - 📁 `IP_Addressing`
        
        - `IPv4_Classi_e_Privati.md` (Classi A/B/C, loopback, broadcast, notazione CIDR)
            
        - `Subnetting_VLSM_CIDR.md` (Calcolo host, maschere a lunghezza variabile, supernetting)
            
        - `IPv6_Overview.md` (Indirizzi a 128 bit, tipi di indirizzo, NDP, SLAAC)
            
    - 📁 `Routing_Logic`
        
        - `Routing_Statico.md` (Rotte manuali, default route, distanza amministrativa)
            
        - `Routing_Dinamico.md` (Distance Vector vs Link State, RIP, OSPFv2, tempi di convergenza)
            
        - `FHRP_Ridondanza_Gateway.md` (HSRP, concetti di ridondanza al primo salto)
            
    - 📁 `Diagnostica`
        
        - `ICMP_Diagnostica.md` (Ping, Traceroute, messaggi di errore e controllo)
            
3. **03_SERVIZI_IP_E_APPLICATIVI**
    
    _(Servizi essenziali per la gestione e l'uso della rete a livello 7)_
    
    - 📁 `Network_Address_Translation`
        
        - `NAT_PAT.md` (NAT statico, dinamico, PAT/Overload, porte)
            
    - 📁 `Infrastructure_Services`
        
        - `DHCP_Processo_DORA.md` (DORA, DHCP relay, scope e lease time)
            
        - `DNS_Architettura.md` (Gerarchia, record A/AAAA/MX/CNAME, risoluzione iterativa/ricorsiva)
            
        - `NTP_Sincronizzazione.md` (Stratum, porta UDP 123, importanza per i log e certificati)
            
        - `SNMP_e_Syslog.md` (MIB, OID, SNMPv2c vs SNMPv3, logging eventi)
            
    - 📁 `Web_and_Communication`
        
        - `HTTP_HTTPS.md` (Metodi GET/POST, codici stato, handshake TLS)
            
        - `Email_SMTP_POP_IMAP.md` (Porte, protocolli, meccanismi anti-spoofing SPF/DKIM/DMARC)
            
4. **04_WIRELESS_WLAN**
    
    _(Isola i concetti legati al mondo 802.11)_
    
    - 📁 `Tecnologia_e_Standard`
        
        - `Standard_802.11.md` (Frequenze 2.4/5/6GHz, canali sovrapposti, CSMA/CA)
            
    - 📁 `Architetture_Wireless`
        
        - `Architettura_WLAN_Enterprise.md` (BSS, ESS, WLC, Lightweight AP vs Autonomous AP)
            
    - 📁 `Sicurezza_Wireless`
        
        - `Protocolli_Sicurezza_WLAN.md` (WEP, WPA2, WPA3 SAE, 802.1X + RADIUS/EAP)
            
5. **05_SICUREZZA_E_CRITTOGRAFIA**
    
    _(Difesa perimetrale, crittografia e VPN)_
    
    - 📁 `Crittografia_DeepDive`
        
        - `Crittografia_Simmetrica.md` (Problema distribuzione chiavi, AES, DES)
            
        - `Crittografia_Asimmetrica.md` (Coppia chiavi, firma digitale, RSA, Diffie-Hellman)
            
        - `Hashing_Integrita.md` (Funzioni one-way, MD5, SHA-256, HMAC)
            
        - `PKI_Certificati_X509.md` (CA, Chain of Trust, CRL e OCSP)
            
    - 📁 `Network_Defense`
        
        - `Controllo_Accessi.md` (Password locali, Port Security, AAA, SSH)
            
        - `Firewall_Tipologie.md` (Packet Filtering, Stateful Inspection, NGFW)
            
        - `ACL_Cisco.md` (Standard vs Extended, posizionamento, deny implicito)
            
        - `DMZ_Architettura.md` (Architettura a due firewall, server pubblici)
            
    - 📁 `Secure_Connectivity_VPN`
        
        - `IPsec_Protocollo.md` (Transport vs Tunnel mode, IKE, AH vs ESP)
            
        - `SSL_TLS_VPN.md` (VPN applicative, differenze d'uso con IPsec)
            
6. **06_AUTOMAZIONE_E_PROGRAMMABILITA**
    
    _(La parte software-defined e moderna della rete)_
    
    - 📁 `SDN_e_Controller`
        
        - `Controller_based_Networking.md` (Gestione tradizionale vs SDN)
            
        - `Cisco_DNA_Center.md` (Gestione centralizzata e intent-based networking)
            
    - 📁 `Programmabilita`
        
        - `API_e_Data_Formats.md` (REST API, struttura JSON)
            
        - `Strumenti_di_Gestione.md` (Introduzione a Puppet, Chef, Ansible)
            
7. **07_PROGETTAZIONE_RETI**
    
    _(Messa in pratica per simulazioni o prove d'esame)_
    
    - 📁 `Fasi_di_Progetto`
        
        - `Analisi_Requisiti.md` (Raccolta dati utenti, servizi, vincoli fisici e di budget)
            
        - `Scelta_e_Dimensionamento.md` (Apparati di core/distribuzione/accesso, calcolo VLAN e subnet)
            
        - `Servizi_e_Posizionamento.md` (Dove piazzare DHCP, DNS, NTP, gestione ridondanza)
            
        - `Relazione_Tecnica_Schema.md` (Come strutturare il documento, mappe logiche, tabelle IP)
            

8. **08_LABS_E_CONFIGURAZIONI_CLI** _(La tua palestra pratica: solo comandi IOS e topologie)_
	
	- 📁 `Base_Device_Config`
	    
	    - `Configurazione_Iniziale_IOS.md` (Hostname, password secret, banner MOTD, salvataggio config)
	        
	    - `Line_Console_e_SSH.md` (Setup accessi remoti, VTY, crypto key generate)
	        
	    - `Gestione_Interfacce.md` (Assegnazione IP, no shutdown, description)
	        
	- 📁 `Switching_Labs`
	    
	    - `Lab_VLAN_e_Trunking.md` (Comandi `vlan X`, `switchport access/trunk`, `allowed vlan`)
	        
	    - `Lab_EtherChannel_LACP.md` (Comandi `channel-group`, `interface port-channel`)
	        
	    - `Lab_Port_Security.md` (Comandi `switchport port-security mac-address sticky`)
	        
	- 📁 `Routing_Labs`
	    
	    - `Lab_Routing_Statico.md` (Sintassi `ip route` e default route `0.0.0.0`)
	        
	    - `Lab_OSPF_Single_Area.md` (Sintassi `router ospf`, `network ... area 0`, passive interfaces)
	        
	    - `Lab_Router_on_a_Stick.md` (Creazione sub-interfaces, `encapsulation dot1q`)
	        
	- 📁 `Services_e_Security_Labs`
	    
	    - `Lab_DHCP_Server_e_Relay.md` (Comandi `ip dhcp pool`, `ip helper-address`)
	        
	    - `Lab_NAT_e_PAT.md` (Comandi `ip nat inside/outside`, source static, overload)
	        
	    - `Lab_ACL_Standard_Estese.md` (Sintassi `access-list`, applicazione `ip access-group in/out`)

---
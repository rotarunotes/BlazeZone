---
date: 2026-05-06
tags: [synthesis, exam, cheatsheet]
---

# SCALETTA SECONDA PROVA — Bigliettino

1. ANALISI
	- Sedi? Utenti? Servizi? (VoIP, web, VPN, IoT)
	- Req. Funzionali (cosa fa) + Non Funzionali (banda, sicurezza, budget)
	- Approccio **Top-Down** (da L7 a L1)
2. TOPOLOGIA
	- **Stella Estesa Gerarchica**: CD → BD → FD
	- Dorsali: **Fibra Ottica** (immune EMI)
	- Orizzontale: **Rame Cat6a** (PoE per AP/VoIP)
	- Wireless: **Wi-Fi 6** + WPA3/RADIUS
3. INDIRIZZAMENTO
	- IP Privato (10.x.x.x o 192.168.x.x)
	- **VLSM**: ordina reparti per host ↓ → 2^n ≥ host+2 → /x
	- **VLAN** su switch Managed + 802.1Q trunk
	- Inter-VLAN: **Switch L3** (meglio) o Router-on-a-Stick
	- DHCP pool per VLAN. Server/stampanti → IP statico
4. SERVER
	- **CED Interno** (Make): DB + Gestionale → VM su RAID 5/10
	- **Server Farm / Cloud** (Buy): Web Server, Mail → IaaS o Hosting
	- Virtualizzazione: VMware/Proxmox → riduzione costi, snapshot
5. SICUREZZA
	- **Firewall** 3 interfacce: WAN | DMZ | LAN
	- **Dynamic PAT** → dipendenti navigano (unidirezionale)
	- **Static PAT** → esponi Web Server in DMZ (bidirezionale, port forwarding)
	- DMZ: Web, Mail, FTP, Proxy. DMZ→LAN controllata da App Firewall
	- ACL: permit/deny su IP+porta
6. VPN
	- **Site-to-Site** (sede↔filiale): IPsec ESP Tunneling + IKE
	- **Remote-Access** (smart worker): SSL/TLS + AAA (MFA)
	- SSL meglio di IPsec per client: no problemi NAT-Traversal, config minima
7. CONTINUITÀ
	- UPS + Generatore
	- RAID 5/10
	- Backup incrementale + off-site
	- Dual ISP + HSRP/VRRP
	- Snapshot VM + Live Migration
	- RPO = max dati persi, RTO = max tempo offline
8. DATABASE
	- **E/R**: Entità (rettangoli) + Relazioni (rombi) + Cardinalità (1:N, N:N)
	- N:N → tabella ponte
	- Normalizzazione ≥ 1FN (attributi atomici)
	- `CREATE TABLE ... PRIMARY KEY, FOREIGN KEY REFERENCES`
9. WEB APP
	- **LAMP**: Linux + Apache + MySQL + PHP
	- Frontend: HTML5 + CSS3 + JS (responsive)
	- Backend: PHP + sessioni + query SQL
	- Scambio dati: XML/JSON via HTTPS (porta 443)
	1. BONUS
	- **Cloud**: IaaS (picchi traffico), PaaS (dev), SaaS (mail/office)
	- **IoT**: sensori ESP32 → gateway RPi → Cloud. MQTT (leggero). VLAN dedicata

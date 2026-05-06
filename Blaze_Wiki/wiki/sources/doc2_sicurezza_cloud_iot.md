---
date: 2026-05-06
tags: [source, security, cloud, iot, vpn, raid]
source_count: 1
---

# Documento 2: Sicurezza, Cloud Computing e IoT (Teoria e Strategie)

**Fonte Originale:** `raw/Documento 2 - Sicurezza, Cloud Computing e IoT.pdf`
**Tipo:** Dispensa strutturata (3 pagine)

## Takeaway Chiave

### 1. Difesa Perimetrale — Defense in Depth
- Non basta un solo dispositivo: servono **più livelli di difesa** combinati.
- [[Firewall]] con almeno **3 interfacce**: WAN (ISP), LAN (interna), [[DMZ]] (server pubblici).
- Se il Web Server in DMZ viene compromesso → l'attaccante NON ha accesso diretto alla LAN grazie alle ACL del firewall (DMZ → LAN bloccato).

### 2. [[VLAN]] (Virtual LAN)
- Separazione logica dei gruppi di lavoro sullo stesso switch fisico (es. VLAN Ospiti, VLAN Admin).
- **Pro:** Limita broadcast, migliora performance e sicurezza.
- **Contro:** Richiede switch **Managed** (più costosi) e configurazione corretta del protocollo **802.1Q (Trunking)** per inter-VLAN routing tramite Router o Switch Layer 3.

### 3. VPN (Conferma fonti precedenti)
- **Site-to-Site:** IPsec, trasparente per utenti, configurazione statica complessa.
- **Remote-Access:** SSL/TLS (es. OpenVPN), facile via browser/client, carico maggiore sul server VPN.

### 4. Business Continuity e [[RAID]]
| Livello | Descrizione | Pro | Contro |
|---|---|---|---|
| **RAID 1** (Mirroring) | 2 dischi identici, uno è copia dell'altro | Alta sicurezza, lettura veloce | Costo doppio, metà spazio perso |
| **RAID 5** (Parità) | Min. 3 dischi, dati + parità distribuiti | Ottimo equilibrio spazio/sicurezza | Scrittura lenta, ricostruzione lunga |

### 5. [[Cloud Computing]]
- **IaaS (Infrastructure as a Service):** Affitto VM e rete, tu gestisci OS e App. (es. AWS EC2)
- **PaaS (Platform as a Service):** Piattaforma dev, tu gestisci solo il codice. (es. Heroku)
- **SaaS (Software as a Service):** Software pronto via web. (es. Gmail, Microsoft 365)
- Esempio d'esame: E-commerce con picchi stagionali → Cloud per **scalabilità elastica**.

### 6. [[IoT]] (Internet of Things)
- Connette oggetti fisici a Internet per raccolta dati e attuazione.
- Protocollo: **MQTT (Publish/Subscribe)** — molto più leggero di HTTP per dispositivi con risorse limitate.
- **Architettura Smart Agriculture (esempio d'esame):**
  1. Sensori (umidità) → ESP32/Arduino
  2. Gateway → Raspberry Pi (Wi-Fi/LoRa)
  3. Cloud → DB + interfaccia web
  4. Attuatore → Pompa irrigazione attivata da Cloud

## Entità/Concetti Collegati
- [[Firewall]]
- [[DMZ]]
- [[VLAN]]
- [[RAID]]
- [[Cloud Computing]]
- [[IoT]]

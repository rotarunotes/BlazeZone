---
date: 2026-05-06
tags: [synthesis, exam, template, professional]
---

# TEMPLATE PROGETTO DI RETE — Seconda Prova Maturità

> Compila ogni sezione sostituendo i placeholder `[...]` con i dati della traccia.

---

## 1. ANALISI DEI REQUISITI

### 1.1 Scenario
- Azienda: `[Nome/Tipo azienda]`
- Sedi: `[N sedi]` — Sede Centrale a `[città]`, filiali a `[città]`
- Settore: `[produttivo / sanitario / PA / commerciale]`

### 1.2 Requisiti Funzionali

| ID | Requisito | Servizio Associato |
|---|---|---|
| RF1 | `[es. Accesso Internet per N dipendenti]` | NAT/PAT, DHCP |
| RF2 | `[es. Sito web pubblico / e-commerce]` | Web Server in DMZ o Cloud |
| RF3 | `[es. Collegamento sicuro tra sedi]` | VPN Site-to-Site (IPsec) |
| RF4 | `[es. Smart working per N agenti]` | VPN Remote-Access (SSL/TLS) |
| RF5 | `[es. Gestionale / ERP interno]` | DB Server nel CED |
| RF6 | `[es. VoIP / videoconferenza]` | QoS, VLAN dedicata |

### 1.3 Requisiti Non Funzionali

| Vincolo | Specifica |
|---|---|
| Performance | Banda minima `[x]` Mbps per sede |
| Sicurezza | Isolamento reparti, GDPR, cifratura dati |
| Scalabilità | Predisposizione per `[N]` host futuri |
| Budget | `[alto/medio/basso]` → guida scelta Make vs Buy |

**Approccio progettuale: Top-Down** (dall'analisi applicativa L7 → scelta hardware L1).

---

## 2. TOPOLOGIA FISICA E CABLAGGIO STRUTTURATO

### 2.1 Architettura Gerarchica Cisco a 3 Livelli

```
           ┌──────────────┐
           │  INTERNET     │
           └──────┬───────┘
                  │
           ┌──────┴───────┐
           │ Router ISP    │ ← IP Pubblico [x.x.x.x]
           └──────┬───────┘
                  │
           ┌──────┴───────┐
           │  FIREWALL     │ ← 3 interfacce: WAN | DMZ | LAN
           └──┬────┬──┬───┘
              │    │  │
         ┌────┘    │  └────┐
         ▼         ▼       ▼
       [DMZ]   [CORE SW]  [WAN]
               L3 Switch
              ┌────┴────┐
              ▼         ▼
          [BD/FD]    [BD/FD]
          Switch     Switch
          Access     Access
           L2         L2
          PoE        PoE
           │          │
        PC/AP/VoIP  PC/AP/VoIP
```

### 2.2 Mezzi Trasmissivi (Standard EN-50173)

| Tratta | Mezzo | Motivazione |
|---|---|---|
| Core ↔ Distribution | Fibra Ottica SM | Immune EMI, 10+ Gbps, distanze campus |
| Distribution ↔ Access | Fibra Ottica MM | Distanze intra-edificio <500m |
| Access → TO (prese) | Rame UTP Cat 6a | Max 100m, PoE (802.3at) per AP e VoIP |
| Mobilità / BYOD | Wi-Fi 6 (802.11ax) | WPA3-Enterprise + server RADIUS |

---

## 3. PIANO DI INDIRIZZAMENTO IP (VLSM) E VLAN

### 3.1 Procedura VLSM
1. Ordina segmenti per N° host **decrescente**.
2. Per ogni segmento: `2^n ≥ host_richiesti + 2` → prefix `/x`.
3. Assegna subnet consecutive.

### 3.2 Tabella di Indirizzamento

> Rete assegnata dalla traccia: `[es. 10.1.0.0/16]`

| VLAN | Segmento | N° Host | Subnet | Mask/Prefix | Range Utilizzabile | Gateway |
|---|---|---|---|---|---|---|
| 10 | `[Reparto 1]` | `[N]` | `[x.x.x.x]` | `/[x]` | `.1 – .[N]` | `.[ultimo]` |
| 20 | `[Reparto 2]` | `[N]` | `[x.x.x.x]` | `/[x]` | `.1 – .[N]` | `.[ultimo]` |
| 30 | CED / Server | ~10 | `[x.x.x.x]` | `/28` | `.1 – .14` | `.14` |
| 40 | DMZ | ~5 | `[x.x.x.x]` | `/28` | `.1 – .14` | `.14` |
| 50 | Guest / Wi-Fi | `[N]` | `[x.x.x.x]` | `/[x]` | — | — |
| — | Link P2P (router) | 2 | `[x.x.x.x]` | `/30` | `.1 – .2` | — |

### 3.3 Configurazione VLAN (IOS-like)
```
! Core Switch L3 — Interfacce VLAN
interface vlan 10
 ip address [GW_VLAN10] [MASK]
 description [Reparto 1]
!
interface vlan 30
 ip address [GW_VLAN30] 255.255.255.240
 description CED-Server
!
! Trunk tra switch
interface GigabitEthernet0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30,40,50
```

### 3.4 DHCP
```
ip dhcp pool VLAN10
 network [SUBNET] [MASK]
 default-router [GW]
 dns-server [DNS_IP]
 lease 7
ip dhcp excluded-address [GW]
ip dhcp excluded-address [RANGE_SERVER_STATICI]
```

---

## 4. ARCHITETTURA SERVER E VIRTUALIZZAZIONE

| Servizio | Collocazione | Tecnologia | VLAN |
|---|---|---|---|
| DBMS (MySQL/MariaDB) | CED Interno — VM | Proxmox/VMware, RAID 5 | 30 |
| Gestionale / ERP | CED Interno — VM | Stessa macchina fisica | 30 |
| DHCP + DNS Interno | CED Interno — VM | Bind9 / Windows DNS | 30 |
| Web Server Pubblico | Server Farm Esterna / IaaS | Apache/Nginx, HTTPS | Esterna |
| Mail | SaaS (Microsoft 365) | — | — |

**Giustificazione Make vs Buy:**
- DB e Gestionale **interni** → controllo diretto, latenza minima, privacy dati (GDPR).
- Web Server **esterno** → elimina la necessità di una DMZ complessa on-site, scalabilità elastica, il provider gestisce availability e sicurezza fisica.

---

## 5. SICUREZZA PERIMETRALE

### 5.1 Firewall — Regole NAT/PAT

| Tipo | Direzione | Regola | Scopo |
|---|---|---|---|
| Dynamic PAT | LAN → WAN | `[IP_privati]` → `[IP_pubblico]`:`random_port` | Navigazione dipendenti (unidirezionale) |
| Static PAT | WAN → DMZ | `[IP_pub]`:443 → `[IP_WebSrv]`:443 | Esporre HTTPS Web Server (bidirezionale) |
| Static PAT | WAN → DMZ | `[IP_pub]`:25 → `[IP_MailSrv]`:25 | SMTP in ingresso |

### 5.2 ACL Essenziali
```
! Outbound: LAN naviga su HTTP/HTTPS
access-list 101 permit tcp [LAN_SUBNET] [WILDCARD] any eq 443
access-list 101 permit tcp [LAN_SUBNET] [WILDCARD] any eq 80
access-list 101 deny ip any any

! Inbound: Solo HTTPS verso DMZ Web Server
access-list 102 permit tcp any host [IP_WEB_DMZ] eq 443
access-list 102 deny ip any any

! DMZ → LAN: Solo Web Server verso DB (MySQL 3306)
access-list 103 permit tcp host [IP_WEB_DMZ] host [IP_DB_CED] eq 3306
access-list 103 deny ip [DMZ_SUBNET] [WILDCARD] [LAN_SUBNET] [WILDCARD]
```

### 5.3 DMZ — Servizi Esposti
- Web Server, Mail Server, Reverse Proxy, DNS Pubblico.
- Comunicazione DMZ→LAN filtrata da **Application Firewall** (anti SQL-Injection).

---

## 6. CONNETTIVITÀ REMOTA (VPN)

### 6.1 Sede ↔ Filiale: IPsec Site-to-Site

| Parametro | Valore |
|---|---|
| Modalità | **Tunneling** (intero pacchetto IP cifrato) |
| Protocollo | **ESP** (cifratura AES-256 + autenticazione SHA-256) |
| Scambio chiavi | **IKEv2** — 2 fasi (IKE SA → IPsec SA) |
| Topologia | Security Gateway ↔ Security Gateway (trasparente per utenti) |

```
! Router Sede — Crypto Map (IOS)
crypto isakmp policy 10
 encr aes 256
 authentication pre-share
 group 14
crypto isakmp key [CHIAVE_CONDIVISA] address [IP_PUB_FILIALE]
!
crypto ipsec transform-set MYSET esp-aes 256 esp-sha-hmac
crypto map VPNMAP 10 ipsec-isakmp
 set peer [IP_PUB_FILIALE]
 set transform-set MYSET
 match address 110
!
access-list 110 permit ip [LAN_SEDE] [WILDCARD] [LAN_FILIALE] [WILDCARD]
```

### 6.2 Smart Worker: SSL/TLS Remote-Access
- Protocollo: **SSL/TLS** (L5 Session) — client leggero (OpenVPN / browser).
- Autenticazione **AAA**: Username + Password + **MFA** (token/app).
- Autorizzazione per ruolo: l'agente accede solo al gestionale, non alla contabilità.
- Accounting: log sessioni (durata, dati, IP) per audit e conformità.

**Perché SSL e non IPsec per i client?** SSL non richiede configurazione di rete complessa, non ha problemi di NAT-Traversal e protegge il traffico TCP applicativo (sufficiente per Web/gestionale).

---

## 7. BUSINESS CONTINUITY

| Rischio | Contromisura | RPO | RTO |
|---|---|---|---|
| Guasto disco | RAID 5 / RAID 10 | 0 (nessuna perdita) | 0 (trasparente) |
| Black-out | UPS 30 min + Generatore Diesel | — | < 1 min |
| Corruzione dati | Backup incrementale giornaliero + off-site (Cloud) | 24h | 4h (restore VM snapshot) |
| Guasto ISP | Dual ISP + HSRP/VRRP (failover automatico GW) | — | < 30 sec |
| Guasto server | VM Snapshot + Live Migration su altro host | RPO da ultimo snapshot | < 15 min |
| Disconnessione stazioni remote | Cache locale (XML/JSON su SSD) + re-invio automatico | 0 (dati salvati localmente) | Variabile |

---

## 8. PROGETTAZIONE DATABASE

### 8.1 Schema Concettuale (E/R)
```
┌──────────┐         ┌──────────────┐         ┌──────────┐
│ [ENTITÀ1]│──1────N──│ [RELAZIONE]  │──N────1──│ [ENTITÀ2]│
│ PK: ...  │         │              │         │ PK: ...  │
│ attr1    │         └──────────────┘         │ attr1    │
│ attr2    │                                  │ attr2    │
└──────────┘                                  └──────────┘
```
> Sostituisci con le entità dalla traccia. Indica le cardinalità (1:1, 1:N, N:N).

### 8.2 Schema Logico Relazionale
```
[ENTITÀ1] (PK_campo, attr1, attr2, ...)
[ENTITÀ2] (PK_campo, attr1, attr2, FK_entita1*)
[TABELLA_PONTE] (FK_entita1*, FK_entita2*, attr_relazione)  ← solo per N:N
```

### 8.3 Schema Fisico (SQL)
```sql
CREATE TABLE [Entita1] (
    Cod[Entita1] INT PRIMARY KEY AUTO_INCREMENT,
    [Attributo1] VARCHAR(50) NOT NULL,
    [Attributo2] VARCHAR(100),
    [AttributoData] DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE [Entita2] (
    Cod[Entita2] INT PRIMARY KEY AUTO_INCREMENT,
    [Attributo1] VARCHAR(50) NOT NULL,
    Cod[Entita1] INT,
    FOREIGN KEY (Cod[Entita1]) REFERENCES [Entita1](Cod[Entita1])
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Query esempio: elenco con JOIN
SELECT e1.[Attr], e2.[Attr], e2.[AttrData]
FROM [Entita2] e2
INNER JOIN [Entita1] e1 ON e2.Cod[Entita1] = e1.Cod[Entita1]
WHERE e2.[AttrData] >= CURDATE()
ORDER BY e2.[AttrData] DESC;
```

**Normalizzazione applicata:**
- 1FN: attributi atomici (Indirizzo → Via, Città, CAP).
- 2FN: dipendenza completa dalla PK.
- 3FN: nessuna dipendenza transitiva.

---

## 9. ARCHITETTURA APPLICAZIONE WEB

### 9.1 Stack Tecnologico: LAMP
```
┌─────────────────────────────────────────────┐
│              CLIENT (Browser)               │
│  HTML5 + CSS3 (responsive) + JavaScript     │
└──────────────────┬──────────────────────────┘
                   │ HTTPS :443
┌──────────────────▼──────────────────────────┐
│           WEB SERVER (Apache)               │
│  PHP 8.x — Sessioni, Logica Applicativa     │
└──────────────────┬──────────────────────────┘
                   │ TCP :3306
┌──────────────────▼──────────────────────────┐
│         DATABASE SERVER (MySQL)             │
│  VLAN 30 — CED Interno — RAID 5            │
└─────────────────────────────────────────────┘
```

### 9.2 Codice PHP — Autenticazione
```php
<?php
session_start();
$conn = new mysqli("[IP_DB]", "[user]", "[pass]", "[db_name]");

// Login
$user = $conn->real_escape_string($_POST['username']);
$pass = hash('sha256', $_POST['password']);
$sql = "SELECT * FROM Dipendente WHERE User=? AND Password=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $user, $pass);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $_SESSION['logged'] = true;
    $_SESSION['ruolo'] = $result->fetch_assoc()['Ruolo'];
    header("Location: dashboard.php");
} else {
    echo "Credenziali non valide.";
}
?>
```

### 9.3 Scambio Dati con Sistemi Esterni
```php
// Generazione JSON per API REST
header('Content-Type: application/json');
$data = [];
$sql = "SELECT * FROM [Tabella] WHERE [condizione]";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);
```

---

## 10. GIUSTIFICAZIONE SCELTE TECNOLOGICHE

| Scelta | Alternativa Scartata | Motivazione Tecnica |
|---|---|---|
| Topologia Stella Gerarchica | Mesh / Bus | Fault-tolerance, scalabilità, standard industriale Cisco |
| OSPF per routing IGP | RIP v2 | Link-State (Dijkstra), convergenza rapida, no limite 15 hop |
| Switch L3 per Inter-VLAN | Router-on-a-Stick | Wire-speed routing, no collo di bottiglia su singola interfaccia |
| Fibra Ottica per dorsali | Rame Cat6a | Immunità EMI, banda 10-100 Gbps, distanze >100m |
| Dynamic PAT per LAN | Static NAT | Risparmio IP pubblici, unidirezionale = sicurezza implicita |
| IPsec ESP per S2S VPN | AH / PPTP | ESP cifra (AH no), PPTP obsoleto e insicuro |
| SSL/TLS per Remote VPN | IPsec Trasporto | Config client minima, no NAT-Traversal issues, browser-based |
| RAID 5 per CED | RAID 0 / RAID 1 | Equilibrio prestazioni/ridondanza/costo (tolleranza 1 guasto) |
| Cloud IaaS per Web | DMZ on-premises | Scalabilità elastica, zero CAPEX, SLA 99.9% dal provider |
| MySQL/MariaDB | Oracle / SQL Server | Open-source, integrato in stack LAMP, documentazione vasta |
| MQTT per IoT | HTTP | Payload minimo, Publish/Subscribe, ideale per dispositivi low-power |

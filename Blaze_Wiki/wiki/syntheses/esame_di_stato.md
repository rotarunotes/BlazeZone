---
date: 2026-05-06
tags: [synthesis, exam, design]
source_count: 10
---

# Prontuario per lo Scritto: Strategia di Progettazione

Questo documento aggrega le conoscenze presenti in tutte le fonti del wiki per fornire linee guida architetturali pronte all'uso per i casi di studio della Seconda Prova.

## 0. Metodologia di Progettazione
- **Approccio Top-Down (CONSIGLIATO):** Parti dalle applicazioni (Livelli alti OSI), stima la banda, progetta l'architettura logica (IP/[[VLAN]]) e solo alla fine scegli l'hardware. Dimostra maturità progettuale al commissario.
- **Analisi dei Requisiti:** Dividi sempre in **Funzionali** (cosa deve fare la rete) e **Non Funzionali** (performance, sicurezza, scalabilità, budget).

## 1. Topologia e Cablaggio Strutturato
- **Regola Aurea:** Usa sempre una topologia a **Stella Estesa (Gerarchica)** divisa in Livelli (Access, Distribution, Core).
- **Centri Stella:**
  - CD (Campus Distributor): Centro Stella di Comprensorio, ospita il CED (Server Interni) e i Core Switch (Layer 3).
  - BD (Building Distributor): Centro Stella di Edificio.
  - FD (Floor Distributor): Centro Stella di Piano.
- **Mezzi Trasmissivi:** Dorsali in Fibra Ottica (tra CD e BD per immunità EMI); Cablaggio Orizzontale in Rame (Cat 6a) o Wi-Fi 6 (Access Point) alimentato tramite PoE (Power over Ethernet) dagli switch Access.

## 2. Indirizzamento, [[Subnetting e VLSM]] e [[VLAN]]
- Scegli sempre l'indirizzamento **Privato IPv4** (es. Classe A `10.0.0.0/8` subnetting `/16` o `/24`) per le LAN aziendali.
- **VLSM:** Ordina i reparti in ordine decrescente di host → calcola la potenza di 2 → assegna subnet consecutive. Lascia sempre un blocco libero per espansioni.
- **[[VLAN]]:** Implementa SEMPRE le VLAN per separare i domini di broadcast. Richiede switch Managed + protocollo **802.1Q** per il trunking. Inter-VLAN routing tramite **Switch Layer 3** (preferito) o Router-on-a-Stick.
- **DHCP:** Configura un pool per reparto. IP statico per server e stampanti (esclusi dal pool).
- Posiziona i server DB su una VLAN dedicata e molto restrittiva.

## 3. Scelte di Routing (OSPF vs RIP, BGP)
- **Routing Interno (IGP):**
  - **Perché OSPF invece di RIP?** OSPF è un protocollo Link-State basato sull'algoritmo di Dijkstra, supporta reti di grandi dimensioni, convergenza rapida e metriche basate sulla larghezza di banda (costo). RIP è Distance-Vector, limitato a 15 hop, convergenza lenta. All'esame, scegli SEMPRE OSPF per reti complesse.
- **Routing Esterno (EGP):**
  - **Protocollo BGP:** Utilizzato esclusivamente tra Autonomous System (Internet Service Provider) per scambiare rotte su Internet. L'azienda userà un gateway di default per instradare verso l'ISP, non BGP (a meno che non sia una multinazionale multi-homed).

## 4. Architettura dei Server (Make vs Buy)
- **Database e Gestionali (Make):** Posizionati nel CED Interno su server fisici con **[[Virtualizzazione]]** (VMware/Proxmox) e **[[RAID]]** 5 o 10 per fault tolerance.
- **Siti Web ed E-Commerce (Buy):** Allocati in una Server Farm Esterna in Hosting, oppure in **[[Cloud Computing]]** (IaaS/PaaS). Questa scelta esonera l'azienda dai costi operativi e mitiga il rischio di intrusione.
- **Business Continuity:** Menziona SEMPRE UPS, generatori, RAID e backup. La commissione valuta pesantemente l'assenza di questi elementi. Vedi [[Continuita del Servizio]] per la strategia completa (RPO/RTO, cache locale, re-invio automatico).

## 4b. [[Modello ER e Progettazione DB]]
- **Diagramma E/R OBBLIGATORIO:** Entità + Attributi + Relazioni con cardinalità.
- **Modello Relazionale:** Trasforma E/R in tabelle. Relazioni N:N → tabella ponte. Normalizza almeno fino alla 1FN.
- **DBMS:** MySQL/MariaDB (soluzione classica da citare).

## 4c. [[Architettura Client-Server Web]]
- **Stack LAMP** (Linux + Apache + MySQL + PHP) per le applicazioni web richieste dalla traccia.
- **Frontend:** HTML5 + CSS3 + JavaScript (responsive design).
- **Backend:** PHP per logica, SQL per query DB, sessioni per autenticazione.
- **Formati di scambio:** XML o JSON per l'invio dati a sistemi esterni (es. FIA, Federazioni).

## 5. Sicurezza e VPN
- **Defense in Depth:** Non basta un solo dispositivo. Combina [[Firewall]], [[DMZ]], [[VLAN]], [[VPN]], ACL e autenticazione forte.
- **[[Firewall]] Perimetrale:** 3 interfacce minime (WAN, LAN, DMZ). Configuralo con regole di **Dynamic PAT** per far navigare i dipendenti e **Static PAT** per esporre i server in DMZ.
- **Sede - Filiale:** Crea una **[[VPN]] Site-to-Site** utilizzando **[[IPsec]]** in modalità Tunneling (con protocollo **ESP** per la cifratura).
- **Smart Worker / Agenti:** Usa una **VPN Remote-Access** con protocollo **[[SSL-TLS]]**. Richiedi l'autenticazione tramite politica AAA (MultiFactor Authentication).

---

## Schema di Flusso Standard — Checklist Operativa per l'Esame

> ⚠️ Ogni punto va svolto in ordine. Saltare un punto costa punti alla commissione. Ogni sezione include *cosa scrivere* e *come giustificarlo*.

---

### STEP 1 — Analisi dei Requisiti
**Cosa fare:** Leggi la traccia e costruisci due elenchi.

**Requisiti Funzionali** (cosa deve fare il sistema):
- Quante sedi? (Sede Centrale + filiali + magazzini + punti vendita)
- Quanti utenti per sede? (dipendenti, clienti, ospiti, dispositivi IoT)
- Quali servizi? (VoIP, e-mail, e-commerce, gestionale, sensori, smart working)
- Il sistema deve esporre servizi pubblici su Internet? (sito web, catalogo, portale clienti)
- Ci sono utenti remoti? (agenti, smart worker → servirà VPN Remote-Access)
- Ci sono filiali distanti? (→ servirà VPN Site-to-Site)

**Requisiti Non Funzionali** (vincoli):
- Performance: banda minima, latenza massima accettabile.
- Sicurezza: privacy dei dati, conformità GDPR, isolamento tra reparti.
- Scalabilità: previsione di crescita futura (nuove sedi, più utenti).
- Budget: vincoli economici che guidano la scelta Make vs Buy.

> 💡 **Approccio Top-Down:** Dimostra al commissario che parti dall'analisi delle applicazioni (L7 OSI) e scendi verso l'hardware (L1). Non iniziare mai dal cablaggio.

---

### STEP 2 — Topologia e [[Cablaggio Strutturato]]
**Cosa disegnare:** Uno schema a blocchi della rete fisica.

**Architettura gerarchica a 3 livelli:**
- **Core Layer** (CD - Campus Distributor): Core Switch L3, Router di bordo, [[Firewall]], CED con server. Locale tecnico climatizzato con UPS e controllo accessi.
- **Distribution Layer** (BD - Building Distributor): Switch di distribuzione L3 per inter-[[VLAN]] routing.
- **Access Layer** (FD - Floor Distributor): Switch Access L2 con PoE per AP Wi-Fi e telefoni VoIP.

**Mezzi trasmissivi** (standard EN-50173 / TIA-EIA-568):

| Tratta | Mezzo | Perché |
|---|---|---|
| CD ↔ BD (dorsale campus) | **Fibra Ottica monomodale** | Immune EMI, distanze km, 10-100 Gbps |
| BD ↔ FD (dorsale edificio) | **Fibra Ottica multimodale** | Immune EMI, distanze <500m |
| FD → TO (orizzontale) | **Rame Cat 6a** | Max 100m, PoE per AP/VoIP/telecamere, costo contenuto |
| Sale riunioni / BYOD | **Wi-Fi 6 (802.11ax)** | Mobilità, zero cablaggio. Autenticazione WPA3/RADIUS |

> 💡 **Tip:** Disegna sempre una legenda nel diagramma. Usa simboli diversi per router, switch, firewall, server, AP.

---

### STEP 3 — Indirizzamento IP, [[Subnetting e VLSM]] e [[VLAN]]
**Cosa calcolare:** Tabella di indirizzamento completa.

**Procedura VLSM:**
1. Elenca i reparti/segmenti in ordine **decrescente** di host.
2. Per ogni segmento: trova 2^n ≥ (host richiesti + 2), calcola il prefix /x.
3. Assegna subnet consecutive, partendo dalla rete assegnata dalla traccia.
4. Riserva sempre un blocco per link Point-to-Point (/30) tra router.

**Tabella d'esempio** (rete `10.1.0.0/16`):

| VLAN ID | Segmento | Subnet | Prefix | Range Utilizzabile | GW |
|---|---|---|---|---|---|
| 10 | Produzione (200 host) | 10.1.1.0 | /24 | .1 – .254 | .254 |
| 20 | Amministrazione (50) | 10.1.2.0 | /26 | .1 – .62 | .62 |
| 30 | CED / Server | 10.1.3.0 | /28 | .1 – .14 | .14 |
| 40 | DMZ | 10.1.4.0 | /28 | .1 – .14 | .14 |
| 50 | Ospiti / Wi-Fi | 10.1.5.0 | /24 | .1 – .254 | .254 |
| 99 | Management Devices | 10.1.99.0 | /24 | .1 – .254 | .254 |

**VLAN — configurazione:**
- Switch Managed con **IEEE 802.1Q** (trunking) sui link tra switch.
- Inter-VLAN routing: **Switch Layer 3** al Core (consigliato) o Router-on-a-Stick.
- **DHCP:** Un pool per ogni VLAN. Server e stampanti → IP statico escluso dal pool.

---

### STEP 4 — Architettura Server e [[Virtualizzazione]]
**Decisione Make vs Buy:**

| Servizio | Dove Posizionarlo | Perché |
|---|---|---|
| DB aziendale / Gestionale | **CED Interno** (VLAN 30) | Controllo diretto, privacy, bassa latenza |
| Active Directory / LDAP | **CED Interno** (VLAN 30) | Autenticazione centralizzata |
| Web Server / E-Commerce | **Server Farm Esterna** o **[[Cloud Computing]]** (IaaS) | Elimina DMZ complessa, scalabilità, costi variabili |
| Mail Server | Server Farm o Cloud (**SaaS** → Microsoft 365/Gmail) | Zero manutenzione |

**CED Interno — configurazione:**
- Server fisico di fascia alta con **[[RAID]] 5** (o RAID 10 se budget lo consente).
- **[[Virtualizzazione]]** con VMware ESXi o Proxmox VE: più VM sullo stesso hardware.
  - VM 1: DBMS (MySQL/MariaDB)
  - VM 2: Gestionale aziendale
  - VM 3: DHCP + DNS interno
- Vantaggi da citare: riduzione costi, consumi, provisioning rapido, snapshot per backup.

---

### STEP 5 — Sicurezza: [[Firewall]], [[DMZ]] e [[NAT e PAT]]
**Principio: Defense in Depth** — più livelli di difesa combinati.

**Firewall Perimetrale** (3 interfacce minime):

```
        INTERNET
           |
    [Router ISP] — IP Pubblico
           |
    ===[ FIREWALL ]===
     /      |       \
  WAN     DMZ      LAN
(outside) (VLAN 40) (inside)
```

**Regole NAT/PAT da configurare:**
- **Dynamic PAT (outbound):** Tutti gli IP privati della LAN → 1 IP pubblico + porta random. **Unidirezionale** = sicuro: l'esterno non può iniziare connessioni verso l'interno.
- **Static PAT (inbound):** IP Pubblico:443 → IP Web Server in DMZ:443. **Bidirezionale** = necessario per esporre il servizio.

**DMZ — servizi esposti:**
- Web Server, Mail Server, FTP Server, Proxy Server.
- La comunicazione **DMZ → LAN interna** (es. Web Server che interroga il DB) DEVE essere controllata da un **Application Firewall** (prevenzione SQL Injection).
- Architettura a **singolo firewall** (3 interfacce) o **doppio firewall** (maggiore sicurezza ma più costoso).

**ACL — esempi da scrivere all'esame:**
```
! Permetti navigazione HTTP/HTTPS dalla LAN
permit tcp 10.1.0.0/16 any eq 80
permit tcp 10.1.0.0/16 any eq 443

! Permetti accesso al Web Server in DMZ dall'esterno
permit tcp any host 10.1.4.1 eq 443

! Blocca tutto il resto dalla DMZ verso la LAN
deny ip 10.1.4.0/28 10.1.0.0/16

! Permetti solo il Web Server DMZ verso il DB interno (porta MySQL)
permit tcp host 10.1.4.1 host 10.1.3.1 eq 3306
```

---

### STEP 6 — Connettività Remota: [[VPN]], [[IPsec]] e [[SSL-TLS]]

**Sede Centrale ↔ Filiale → VPN Site-to-Site con [[IPsec]]:**
- Modalità **Tunneling** (incapsula l'intero pacchetto originale in un nuovo header IP pubblico).
- Protocollo **ESP** (Encapsulating Security Payload) → cifratura + autenticazione. **NON usare AH** da solo (non cifra!).
- Negoziazione chiavi tramite **IKE** in 2 fasi (IKE SA → IPsec SA).
- Trasparente per gli utenti: le LAN delle due sedi comunicano come se fossero collegate direttamente.

**Smart Worker / Agenti → VPN Remote-Access con [[SSL-TLS]]:**
- Protocollo **SSL/TLS** a Livello 5 (Session), Client/Server.
- Vantaggio: configurazione client quasi nulla (basta browser o client leggero tipo OpenVPN).
- Autenticazione con politica **AAA:**
  - **Authentication:** Username + Password + MFA (Multi-Factor Authentication).
  - **Authorization:** Policy di accesso per ruolo (l'agente non vede i dati contabili).
  - **Accounting:** Log di sessione (durata, dati trasferiti) per audit e sicurezza.

**Perché SSL e non IPsec per i client?**
- SSL non ha problemi di **NAT-Traversal** (IPsec può avere conflitti con il PAT).
- SSL protegge il traffico TCP, sufficiente per le applicazioni web/gestionale.
- IPsec protegge tutto il traffico IP → più pesante, più complesso da configurare.

---

### STEP 7 — [[Continuita del Servizio|Continuità del Servizio]] e Business Continuity

**Elementi da menzionare OBBLIGATORIAMENTE:**

| Componente | Soluzione | Cosa Protegge |
|---|---|---|
| **Alimentazione** | UPS + Generatore Diesel | Black-out elettrici |
| **Storage** | [[RAID]] 5 o 10 | Guasto disco |
| **Dati** | Backup giornaliero incrementale + copia off-site (Cloud/nastri) | Corruzione/perdita dati |
| **Rete** | Dual ISP + HSRP/VRRP (gateway ridondante) | Guasto connettività |
| **Server** | [[Virtualizzazione]] con snapshot + Live Migration | Guasto hardware |

**Metriche da citare (plus per il commissario):**
- **RPO (Recovery Point Objective):** Max dati perdibili → es. "RPO = 24h con backup giornaliero".
- **RTO (Recovery Time Objective):** Max tempo offline → es. "RTO = 4h con restore da snapshot VM".

**Resilienza applicativa (dal caso Esame 2014):**
- Dispositivi remoti (sensori, stazioni) salvano i dati **localmente** (file XML su flash/SSD).
- In caso di disconnessione Internet → re-invio automatico al ristabilimento della connessione.
- Le operazioni di re-invio devono essere **idempotenti** (no duplicati).

---

### STEP 8 — [[Modello ER e Progettazione DB]]
**Sempre richiesto all'esame. Procedura:**

**1. Analisi delle Entità** (dalle specifiche della traccia):
- Identifica i "sostantivi" chiave (Cliente, Ordine, Prodotto, Dipendente, Sede...).
- Per ogni entità: definisci gli attributi e la **chiave primaria** (sottolineata).

**2. Diagramma E/R:**
- Disegna le entità come rettangoli.
- Collega con linee le relazioni (rombi).
- Indica le **cardinalità**: 1:1, 1:N, N:N.
- Attributi negli ovali (o elencati dentro il rettangolo per brevità).

**3. Trasformazione in Modello Relazionale:**
- Ogni entità → una tabella.
- Relazione 1:N → chiave esterna nella tabella lato "N".
- Relazione N:N → **tabella ponte** (associativa) con le PK delle due entità.
- **Normalizzazione** almeno fino alla 1FN (attributi atomici: "Indirizzo" → Via + Città + CAP).

**4. Esempio di schema SQL:**
```sql
CREATE TABLE Cliente (
    CodCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Via VARCHAR(100),
    Citta VARCHAR(50),
    CAP CHAR(5),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Ordine (
    CodOrdine INT PRIMARY KEY AUTO_INCREMENT,
    DataOrdine DATETIME DEFAULT CURRENT_TIMESTAMP,
    Importo DECIMAL(10,2),
    CodCliente INT,
    FOREIGN KEY (CodCliente) REFERENCES Cliente(CodCliente)
);
```

---

### STEP 9 — [[Architettura Client-Server Web]]
**Se la traccia chiede un sito web / portale / interfaccia di gestione:**

**Stack tecnologico (LAMP):**
- **Server:** Linux + Apache + MySQL + PHP.
- **Client:** HTML5 + CSS3 + JavaScript.
- Menziona il **responsive design** (accessibilità da mobile) e l'**usabilità** dell'interfaccia.

**Struttura tipica dell'applicazione:**
```
/var/www/html/
├── index.php          ← Home page (pubblica)
├── login.php          ← Autenticazione dipendenti (sessioni PHP)
├── dashboard.php      ← Pannello gestione (area riservata)
├── api/
│   └── dati.php       ← Endpoint per scambio dati (XML/JSON)
├── css/
│   └── style.css      ← Foglio di stile responsive
└── js/
    └── app.js         ← Logica client-side (validazione form)
```

**Esempio PHP — connessione al DB e query:**
```php
<?php
session_start();
$conn = new mysqli("10.1.3.1", "utente", "password", "azienda_db");

if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
}

$sql = "SELECT * FROM Ordine WHERE DataOrdine >= CURDATE() ORDER BY DataOrdine DESC";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    echo "<tr><td>" . $row["CodOrdine"] . "</td><td>" . $row["Importo"] . "</td></tr>";
}
$conn->close();
?>
```

**Formati di scambio con sistemi esterni:**
- **XML:** Formato strutturato per invio dati a federazioni/enti (es. FIA nell'Esame 2014).
- **JSON:** Più leggero, ideale per API REST moderne.
- **HTTPS (porta 443):** Comunicazione cifrata con [[SSL-TLS]] obbligatoria per dati sensibili.

---

### STEP 10 — Bonus: [[Cloud Computing]] e [[IoT]]
**Se la traccia menziona scalabilità, picchi di traffico, sensori o automazione:**

**Cloud Computing — quando citarlo:**
- E-commerce con picchi stagionali → **IaaS** (scale-up on demand, pago solo ciò che uso).
- Startup senza budget per CED → **PaaS** (Heroku, Google App Engine).
- Email/Office → **SaaS** (Microsoft 365, Google Workspace).

**IoT — quando citarlo:**
- Sensori ambientali, monitoraggio industriale, smart agriculture, smart building.
- Protocollo **MQTT** (Publish/Subscribe) → molto più leggero di HTTP per dispositivi con risorse limitate.
- Architettura: Sensori (ESP32) → Gateway (Raspberry Pi) → Cloud (DB + Web).
- **SICUREZZA IoT:** Isolare i dispositivi in una [[VLAN]] dedicata + MQTTS (MQTT over TLS).


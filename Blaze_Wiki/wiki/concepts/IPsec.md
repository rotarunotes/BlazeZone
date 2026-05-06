---
date: 2026-05-06
tags: [concept, networking, security, vpn]
source_count: 2
---

# IPsec

**IPsec (IP Security)** è una suite di protocolli che opera a **Livello 3 (Network)** del modello OSI. Permette di realizzare sia VPN Remote-Access che Site-to-Site.

## I Tre Protocolli

### 1. AH (Authentication Header)
- **Servizi:** Autenticazione, Integrità, Protezione anti-replay.
- **NON fornisce:** Cifratura (confidenzialità). ⚠️ *Errore classico all'esame: dire che AH cifra.*
- Campo chiave: **SPI** (Security Parameter Index) → identifica la SA usata.
- **Modalità Trasporto:** Header IP orig. → AH → TCP → Dati. Tutto autenticato.
- **Modalità Tunneling:** Nuovo Header IP → AH → Header IP orig. → TCP → Dati. Tutto autenticato.

### 2. ESP (Encapsulating Security Payload)
- **Servizi:** Tutto ciò che fa AH **+ Confidenzialità (cifratura)**.
- L'autenticazione ESP **non copre** l'header IP esterno (a differenza di AH).
- **Modalità Trasporto:** Header IP | Header ESP | TCP + Dati cifrati | Trailer ESP | Auth ESP.
- **Modalità Tunneling:** Nuovo Header IP | Header ESP | Header IP orig. + TCP + Dati cifrati | Trailer ESP | Auth ESP.

### 3. IKE (Internet Key Exchange)
- Opera a **Livello Applicazione**.
- Gestisce in modo **automatico** le Security Association (SA).
- Reliable: ritrasmette su UDP se non riceve risposta.
- **Due fasi:** (1) Crea IKE SA per un canale sicuro. (2) Usa quel canale per negoziare le IPsec SA.

## Flusso Pacchetti (SPD / SAD)

### Pacchetto in Uscita
1. Consulta **SPD** (Security Policy Database) → 3 azioni possibili: Scartare | Inoltrare in chiaro | Applicare IPsec.
2. Se IPsec → Consulta **SAD** (Security Association Database) → SA esiste?
3. Se no → Crea SA (via IKE) → Elaborazione IPsec → Invio.

### Pacchetto in Entrata
1. È un pacchetto IPsec? → Se no, consulta SPD → Scartare o Inoltrare in chiaro.
2. Se sì → Consulta SAD → SA trovata? → Se no, Scarta. Se sì → Elaborazione IPsec → Invio.

## Modalità: Trasporto vs Tunneling

| Aspetto | Trasporto | Tunneling |
|---|---|---|
| **Uso tipico** | Remote-Access | **Site-to-Site** |
| **Header IP** | Originale in chiaro | Nuovo header IP pubblico, originale cifrato |
| **Cosa protegge** | Solo il payload TCP/UDP | **Intero pacchetto originale** |

## Fonti Collegate
- [[VPN_Appunti]]
- [[vpn_slides]]

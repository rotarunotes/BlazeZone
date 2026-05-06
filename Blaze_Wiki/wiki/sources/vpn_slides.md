---
date: 2026-05-06
tags: [source, slides, vpn, networking, security]
source_count: 1
author: Zanardelli Alessio
---

# Slide: VPN (vpn.pdf)

**Fonte Originale:** `raw/vpn.pdf`
**Tipo:** Presentazione didattica (45 slide)

## Takeaway Chiave

### Reti Private vs VPN
- **Reti Private Dedicate:** Larghezza di banda garantita, nessuna congestione, sicurezza. MA: costi altissimi, non scalabili, nessuna ridondanza.
- **VPN:** Scalabili, ridondanti, buon rapporto costo/funzionalità. MA: variabilità latenza, necessità autenticazione e cifratura.

### Tipologie
- **Remote-Access:** Utente singolo → LAN aziendale. Emula il desktop in ufficio.
- **Site-to-Site:** LAN-to-LAN via Internet. Intranet (stessa società) o Extranet (società diverse).

### Sicurezza (AAA + Cifratura + Tunneling)
- **Authentication:** Verifica identità con MFA (MultiFactor Authentication).
- **Authorization:** Policy di accesso per ogni utente.
- **Accounting:** Log di sessione (durata, dati trasferiti).
- **Cifratura:** Algoritmi 3DES, IDEA; chiavi scambiate tramite protocolli sicuri.
- **Tunneling:** Incapsulamento (Passenger Protocol → Tunneling Protocol → Carrier Protocol IPv4).

### Protocollo [[IPsec]] (L3 Network)
- **AH:** Autenticazione + integrità + anti-replay. **NON cifra** il payload. SPI identifica la SA.
  - Trasporto: autentica header IP originale + payload.
  - Tunneling: nuovo header IP + AH + header IP originale + payload (tutto autenticato).
- **ESP:** Tutto ciò che fa AH + **confidenzialità (cifratura)**. L'autenticazione NON copre l'header IP esterno.
  - Trasporto: Header IP originale | Header ESP | payload cifrato | Trailer ESP | Auth ESP.
  - Tunneling: Nuovo header IP | Header ESP | Header IP orig + payload cifrati | Trailer ESP | Auth ESP.
- **IKE:** Gestione automatica delle SA. Peer-to-peer in 2 fasi: (1) crea IKE SA, (2) negozia IPsec SA. Reliable (ritrasmette su UDP).

### Flusso Pacchetti IPsec (SPD/SAD)
- **Uscita:** Consulta SPD → Scartare? → Inoltrare in chiaro? → IPsec? → Consulta SAD → SA esiste? → Se no, crea SA → Elaborazione IPsec → Invio.
- **Entrata:** IPsec? → Se no, consulta SPD → Se sì, consulta SAD → SA trovata? → Elaborazione IPsec → Invio.

### Protocollo [[SSL-TLS]] (L5 Session)
- Client/Server, usato per Remote-Access VPN.
- **Handshake:** Client invia lista algoritmi + numero casuale → Server risponde con certificato + algoritmo scelto + numero casuale → Client verifica certificato → Client invia proprio certificato + pre-master key crittografata con chiave pubblica del server → Server conferma → Canale cifrato stabilito.

### Classificazione per Sicurezza
- **Trusted VPN:** Sicurezza delegata a ISP (QoS), nessuna cifratura/tunneling.
- **Secure VPN:** Cifratura + tunneling + autenticazione.
- **Hybrid VPN:** Secure VPN che opera come parte di una rete Trusted VPN.

### Altri Utilizzi VPN
- Protezione IP personale, accesso a contenuti geo-bloccati (streaming), gaming, home banking.

## Integrazione con Fonti Precedenti
Queste slide sono la **versione completa e didattica** del contenuto in [[VPN_Appunti]]. Aggiungono:
- Il diagramma dettagliato dell'incapsulamento AH/ESP in modalità Trasporto vs Tunneling.
- Il flusso di uscita/entrata pacchetti IPsec con diagramma decisionale SPD/SAD.
- L'handshake SSL/TLS passo-passo.
- La menzione di altri protocolli di tunneling (PPTP, SSH, BGP/MPLS, 802.1Q).
- Gli usi personali delle VPN.

## Entità/Concetti Collegati
- [[VPN]]
- [[IPsec]]
- [[SSL-TLS]]
- [[NAT e PAT]]

---
date: 2026-05-06
tags: [concept, networking, security]
source_count: 2
---

# VPN (Virtual Private Network)

Le **VPN** creano "tunnel" sicuri attraverso infrastrutture pubbliche (Internet) simulando i benefici di un collegamento dedicato e privato (Leased Line), riducendo drasticamente i costi operativi.

## Architetture
- **Site-to-Site (LAN-to-LAN):** Collega tra loro due LAN distanti geograficamente (es. Sede Centrale HQ e Filiale). Per la sicurezza, i Security Gateway ai bordi delle reti negoziano il tunnel. Totalmente trasparente per gli utenti della LAN. Implementazione ideale: **IPsec in Modalità Tunneling** (aggiunge nuovo header IP pubblico, incapsulando la subnet interna).
- **Remote-Access (Client-to-Site):** Consente ad un singolo utente mobile (Smart Worker, Agente) di connettersi alla LAN aziendale. Implementazione ideale: **SSL/TLS**, per la facilità d'uso (solo browser o client leggero richiesto) o IPsec in Modalità Trasporto.

## Sicurezza: AAA + Cifratura + Tunneling
- **AAA:** Authentication (MFA), Authorization (policy per utente), Accounting (log sessioni).
- **Cifratura:** Algoritmi 3DES, IDEA. Chiavi scambiate tramite protocolli sicuri.
- **Tunneling:** Incapsulamento a tre strati: Passenger Protocol → Tunneling Protocol → Carrier Protocol (IPv4).

## Classificazione per Sicurezza
- **Trusted VPN:** Sicurezza delegata all'ISP (QoS), nessuna cifratura/tunneling.
- **Secure VPN:** Cifratura + tunneling + autenticazione forte.
- **Hybrid VPN:** Secure VPN come parte di una rete Trusted VPN.

## Concetti Cruciali per Progettazione
- **Cifratura ([[IPsec]] ESP):** Se in un esame di stato viene richiesto di proteggere i segreti industriali, menzionare ESP per la confidenzialità è fondamentale (evitare l'uso del solo AH).
- **Routing Sicuro:** Il router di bordo verifica una tabella chiamata SPD (Security Policy Database) per decidere se un pacchetto verso una certa destinazione necessiti di essere criptato e incapsulato o meno.
- **Protocolli di Tunneling:** IPsec, [[SSL-TLS]], BGP/MPLS, PPTP, SSH, IEEE 802.1Q.

## Altri Utilizzi delle VPN
- Protezione IP personale, accesso a contenuti geo-bloccati (streaming), gaming, home banking.

## Fonti Collegate
- [[VPN_Appunti]]
- [[vpn_slides]]

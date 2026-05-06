---
date: 2026-05-06
tags: [concept, networking, security, vpn]
source_count: 2
---

# SSL/TLS

**SSL (Secure Sockets Layer)** e **TLS (Transport Layer Security)** sono protocolli di sicurezza che operano a **Livello 5 (Session)** del modello OSI. TLS deriva da SSL con minime differenze; sono non compatibili ma interoperabili.

## Caratteristiche
- Architettura **Client/Server** (a differenza di [[IPsec]] che è Peer-to-Peer).
- Protegge il **traffico TCP** (non tutto il traffico IP come IPsec).
- Uso principale: **VPN Remote-Access** per smart worker e agenti.
- Vantaggio chiave: **Non richiede configurazione complessa** sui dispositivi client (spesso basta un browser web).

## Handshake SSL/TLS (Passo-Passo)

```
1. CLIENT → SERVER:  Lista algoritmi di cifratura supportati
                     + numero casuale per pre-master key

2. SERVER → CLIENT:  Certificato digitale del server
                     + algoritmo di cifratura scelto
                     + numero casuale per pre-master key
                     + richiesta certificato client

3. CLIENT:           Controlla il certificato del server
                     → Se negativo: connessione fallisce

4. CLIENT → SERVER:  Certificato digitale del client
                     + pre-master key crittografata con
                       chiave pubblica del server
                     + richiesta comunicazioni crittografate

5. SERVER:           Conferma → Canale cifrato stabilito
```

## Confronto con IPsec

| Aspetto | IPsec | SSL/TLS |
|---|---|---|
| **Architettura** | Complessa (3 protocolli), Peer-to-Peer | Semplice (1 protocollo), Client/Server |
| **Livello OSI** | Network (L3) | Session (L5) |
| **Traffico protetto** | Tutto il traffico IP | Solo traffico TCP |
| **Uso ideale** | Site-to-Site | Remote-Access |
| **Config. client** | Complessa | Minima (browser) |

## Fonti Collegate
- [[VPN_Appunti]]
- [[vpn_slides]]

# 🌐 IPv4 — Indirizzamento IP versione 4

  

> **Tags:** #networking #ip #addressing #cidr #subnetting  

> **Collegati a:** [[OSI Model]], [[Subnetting]], [[IPv6]], [[Routing]]

  

---

  

## 📌 Cos'è IPv4?

  

IPv4 (Internet Protocol version 4) è il protocollo di rete usato per identificare dispositivi su una rete tramite indirizzi a **32 bit**, scritti in notazione decimale puntata (es. `192.168.1.1`).

  

Ogni indirizzo è composto da 4 **ottetti** (gruppi da 8 bit), separati da punti:

  

```

192  .  168  .   1  .   1

11000000.10101000.00000001.00000001

```

  

---

  

## 🗂️ Classi di Indirizzi IPv4

  

La suddivisione classful (pre-CIDR) divide lo spazio IPv4 in classi in base al primo ottetto.

  

| Classe | Range primo ottetto | Range indirizzi               | Subnet Mask default | Uso principale       |

|--------|---------------------|-------------------------------|---------------------|----------------------|

| **A**  | 1 – 126             | `1.0.0.0` – `126.255.255.255` | `255.0.0.0` (/8)    | Grandi reti          |

| **B**  | 128 – 191           | `128.0.0.0` – `191.255.255.255` | `255.255.0.0` (/16) | Reti medie           |

| **C**  | 192 – 223           | `192.0.0.0` – `223.255.255.255` | `255.255.255.0` (/24) | Reti piccole       |

| **D**  | 224 – 239           | `224.0.0.0` – `239.255.255.255` | —                   | Multicast            |

| **E**  | 240 – 255           | `240.0.0.0` – `255.255.255.255` | —                   | Riservato/Sperimentale |

  

> ⚠️ Il range `127.x.x.x` è **escluso dalla Classe A** perché riservato al loopback.

  

---

  

## 🔒 Indirizzi Privati (RFC 1918)

  

Questi indirizzi **non sono instradabili su Internet** e sono riservati per reti locali (LAN). Il NAT (Network Address Translation) permette ai dispositivi con IP privato di comunicare con l'esterno.

  

| Classe | Range privato                       | CIDR          | Numero di host disponibili |

|--------|-------------------------------------|---------------|----------------------------|

| A      | `10.0.0.0` – `10.255.255.255`       | `10.0.0.0/8`  | ~16 milioni                |

| B      | `172.16.0.0` – `172.31.255.255`     | `172.16.0.0/12` | ~1 milione               |

| C      | `192.168.0.0` – `192.168.255.255`   | `192.168.0.0/16` | ~65.000                  |

  

### Mnemonica

```

10.x.x.x         → classe A privata  (1 rete enorme)

172.16–31.x.x    → classe B privata  (16 reti grandi)

192.168.x.x      → classe C privata  (256 reti piccole)

```

  

---

  

## 🔁 Indirizzo di Loopback

  

```

127.0.0.1  →  localhost

```

  

- Riservato al range `127.0.0.0/8` (ma praticamente si usa solo `127.0.0.1`)

- Permette a un dispositivo di **comunicare con sé stesso** senza passare per la rete fisica

- Usato per test, debug, e servizi locali (es. un server web in sviluppo)

- Il traffico sul loopback **non lascia mai il dispositivo**

  

> 💡 `ping 127.0.0.1` è il primo test per verificare che lo stack TCP/IP funzioni correttamente.

  

---

  

## 📡 Indirizzi di Broadcast

  

Il broadcast invia un pacchetto a **tutti i dispositivi** in una rete.

  

### Broadcast Limitato

```

255.255.255.255

```

- Inviato a **tutti i dispositivi sulla rete locale** (stesso segmento)

- **Non viene instradato** dai router

- Usato da protocolli come **DHCP** (il client cerca un server senza conoscere l'IP)

  

### Broadcast Diretto

```

<indirizzo di rete> con tutti i bit host a 1

Esempio: rete 192.168.1.0/24 → broadcast = 192.168.1.255

```

- Indirizzato a **tutti i dispositivi di una specifica rete**

- Può attraversare i router (se configurati per farlo, ma spesso bloccato)

  

### Confronto rapido

  

| Tipo               | Indirizzo esempio    | Scope               | Instradabile? |

|--------------------|----------------------|---------------------|---------------|

| Broadcast limitato | `255.255.255.255`    | Rete locale (L2)    | ❌ No          |

| Broadcast diretto  | `192.168.1.255`      | Rete specifica (L3) | ✅ (se abilitato) |

  

---

  

## 📐 Notazione CIDR (Classless Inter-Domain Routing)

  

Il CIDR sostituisce il sistema a classi con una notazione più flessibile: `indirizzo/prefisso`.

  

```

192.168.1.0/24

```

  

Il numero dopo `/` indica **quanti bit sono riservati alla parte di rete** (network prefix).

  

### Equivalenze CIDR ↔ Subnet Mask

  

| CIDR | Subnet Mask       | Bit host | Host disponibili |

|------|-------------------|----------|------------------|

| /8   | 255.0.0.0         | 24       | 16.777.214       |

| /16  | 255.255.0.0       | 16       | 65.534           |

| /24  | 255.255.255.0     | 8        | 254              |

| /25  | 255.255.255.128   | 7        | 126              |

| /26  | 255.255.255.192   | 6        | 62               |

| /27  | 255.255.255.224   | 5        | 30               |

| /28  | 255.255.255.240   | 4        | 14               |

| /29  | 255.255.255.248   | 3        | 6                |

| /30  | 255.255.255.252   | 2        | 2                |

| /32  | 255.255.255.255   | 0        | 1 (host singolo) |

  

> 💡 **Formula host disponibili:** `2^(32 - prefisso) - 2`  

> Si sottraggono 2 perché il primo indirizzo è la **rete** e l'ultimo è il **broadcast**.

  

### Come si calcola la subnet mask dal prefisso?

  

Esempio con `/24`:

```

Prefisso = 24 bit a 1, poi 8 bit a 0

11111111.11111111.11111111.00000000

= 255.255.255.0

```

  

Esempio con `/26`:

```

11111111.11111111.11111111.11000000

= 255.255.255.192

```

  

---

  

## 🧩 Struttura di un indirizzo IPv4

  

Un indirizzo IPv4 è diviso in due parti:

  

```

[ Parte di RETE | Parte di HOST ]

```

  

La subnet mask determina il confine:

- Bit a **1** nella mask → parte di rete

- Bit a **0** nella mask → parte di host

  

### Esempio pratico

  

```

IP:   192.168.10.45   →  11000000.10101000.00001010.00101101

Mask: 255.255.255.0   →  11111111.11111111.11111111.00000000

  

Rete:      192.168.10.0   (AND tra IP e mask)

Broadcast: 192.168.10.255 (tutti i bit host a 1)

Host:      192.168.10.1 – 192.168.10.254

```

  

---

  

## ⚡ Indirizzi Speciali — Riepilogo

  

| Indirizzo / Range        | Tipo                  | Descrizione                              |

|--------------------------|-----------------------|------------------------------------------|

| `0.0.0.0`                | Default route / Any   | "Qualsiasi rete" (es. in routing)        |

| `127.0.0.1`              | Loopback              | Localhost, test stack TCP/IP             |

| `169.254.x.x`            | APIPA / Link-local    | Auto-assegnato se DHCP non risponde      |

| `10.x.x.x`               | Privato Classe A      | RFC 1918, uso interno                    |

| `172.16–31.x.x`          | Privato Classe B      | RFC 1918, uso interno                    |

| `192.168.x.x`            | Privato Classe C      | RFC 1918, uso interno                    |

| `224.0.0.0 – 239.x.x.x` | Multicast             | Gruppi multicast                         |

| `255.255.255.255`        | Broadcast limitato    | Tutti i dispositivi sul segmento locale  |

  

---

  

## 🔗 Concetti Collegati

  

- [[Subnetting]] — Come dividere una rete in sottoreti

- [[NAT]] — Come gli IP privati comunicano con Internet

- [[DHCP]] — Assegnazione automatica degli indirizzi IP

- [[IPv6]] — Il successore di IPv4 con spazio a 128 bit

- [[Routing]] — Come i router instradano i pacchetti tra reti diverse

  

---

  

## 📝 Quick Reference Card

  

```

CLASSI:

  A → 1–126.x.x.x      /8   privato: 10.x.x.x

  B → 128–191.x.x.x    /16  privato: 172.16–31.x.x

  C → 192–223.x.x.x    /24  privato: 192.168.x.x

  

SPECIALI:

  127.0.0.1     → loopback (localhost)

  255.255.255.255 → broadcast limitato

  169.254.x.x   → link-local (APIPA)

  

CIDR:

  /prefisso = quanti bit sono di rete

  Host = 2^(32-prefisso) - 2

  Subnet mask: prefisso bit a 1, resto a 0

```
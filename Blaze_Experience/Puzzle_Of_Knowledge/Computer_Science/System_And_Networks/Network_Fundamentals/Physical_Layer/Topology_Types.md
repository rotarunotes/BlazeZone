Data: 2026-04-23
[Physical_Layer](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Physical_Layer
___
# Index
___
# Tipologie Di Rete

Le reti si classificano in base alla loro estensione geografica:

|  Sigla  | Nome                      | Copertura                             | Esempio              |
| :-----: | ------------------------- | ------------------------------------- | -------------------- |
| **GAN** | Global Area Network       | Mondiale                              | Internet - Satellite |
| **WAN** | Wide Area Network         | Regione / Nazione — più ISP coinvolti | Fibra lunga          |
| **MAN** | Metropolitan Area Network | Città                                 | WiMAX                |
| **LAN** | Local Area Network        | Edificio o Campus — alta velocità     | Ethernet - Wi-Fi     |
| **PAN** | Personal Area Network     | Stanza / dispositivi personali        | Bluetooth - NFC      |

![Struttura Modello ISO/OSI](../../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/TIpologie_Di_Rete.png)
## Reti Aziendali
- **Intranet** — Rete privata interna all'azienda, accessibile solo ai dipendenti.
- **Extranet** — Estensione controllata della rete aziendale che consente l'accesso a utenti esterni autorizzati (es. fornitori, partner).
## Rete Convergente
In passato, dati, voce e video viaggiavano su infrastrutture separate e dedicate.  
Oggi si utilizza un'**unica infrastruttura unificata (convergente)** capace di trasportare simultaneamente tutti e tre i tipi di traffico.
___
# Diagrammi di Rete

| Tipo                 | Cosa mostra                                                       |
| -------------------- | ----------------------------------------------------------------- |
| **Diagramma Fisico** | Cavi, stanze, rack fisici                                         |
| **Diagramma Logico** | Indirizzi IP, porte, dispositivi intermedi (router, switch, ecc.) |

![Struttura Modello ISO/OSI](../../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/Diagrammi_Di_Rete.png)
___


## 📡 Domini di Rete

  
### Dominio di Collisione

Insieme dei nodi che **competono per l'accesso allo stesso mezzo trasmissivo**.  

Una collisione avviene quando due dispositivi trasmettono contemporaneamente.

  

- **Hub** → crea **un unico** dominio di collisione per tutte le porte.

- **Switch** → crea **un dominio di collisione per ogni porta** (riduce le collisioni drasticamente).

  

### Dominio di Broadcast

Insieme dei dispositivi che **ricevono un messaggio broadcast** inviato da un nodo della rete.

  

- I **router** separano i domini di broadcast (il traffico broadcast non viene instradato oltre il router).

- Gli **switch**, di default, non separano i domini di broadcast (tutto il traffico broadcast rimane nella stessa LAN).

  

---

  

> 📝 *Appunti personali — Sistemi e Reti*
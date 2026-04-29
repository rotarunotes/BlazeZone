### Procedura generale

1. Determinare il numero di sottoreti necessarie → quanti bit di subnet servono? `2^n ≥ sottoreti richieste`
2. Determinare gli host per sottorete → verificare `2^m − 2 ≥ host richiesti`
3. Calcolare il nuovo prefisso: `/prefisso_originale + n`
4. Calcolare il **block size** (salto tra sottoreti): `256 − valore dell'ottetto interessato nella mask`

### Esempio pratico

Dividere `192.168.1.0/24` in 4 sottoreti uguali:

```
Sottoreti richieste = 4  →  2^2 = 4  →  servono 2 bit di subnet
Nuovo prefisso = /24 + 2 = /26
Subnet mask = 255.255.255.192
Block size = 256 - 192 = 64

Sottorete 0:  192.168.1.0/26    host: .1 – .62    broadcast: .63
Sottorete 1:  192.168.1.64/26   host: .65 – .126  broadcast: .127
Sottorete 2:  192.168.1.128/26  host: .129 – .190 broadcast: .191
Sottorete 3:  192.168.1.192/26  host: .193 – .254 broadcast: .255
```

### VLSM (Variable Length Subnet Mask)

Il VLSM permette di assegnare a ciascuna sottorete la dimensione esatta necessaria (invece di suddividere tutto in blocchi uguali). Si parte sempre dalla sottorete più grande e si procede verso le più piccole, assegnando i blocchi in sequenza.



## Formule

**Indice bit:** 128 - 64 - 32 - 16 - 8 - 4 - 2 - 1
**Bit presi in prestito:** $2^n \ge \text{numero sottoreti richiesto}$
**Nuovo CIDR:** /CIDR + bit presi in prestito
**Host per sottorete:** $2^{(32- \text{nuova prefisso o prefisso originale})}-2$

## Esercizio 1
*Indirizzo IP:* 192.168.4.0/22
*Subnet Mask (SM):* 255.255.252.0
*Sottoreti Richieste:* 20

***Subnet Mask***
Bit presi in prestito: $2^n \ge 20 \implies n = 5$
Nuovo Prefisso: $/22 + 5 = \mathbf{/27}$
Nuova Subnet Mask (SM): $/27 \implies 255.255.255.11100000 \space (255.255.255.224)$

***HOST***
Host per sottorete: $2^{(32-27)}-2 = 2^5-2 = 30$
Incremento: $256 - 224 = \mathbf{32}$

| **#**  | **Indirizzo di Rete (/27)** | **Primo Indirizzo Utile** | **Ultimo Indirizzo Utile** | **Indirizzo di Broadcast** |
| ------ | --------------------------- | ------------------------- | -------------------------- | -------------------------- |
| **1**  | $\mathbf{192.168.4.0}$      | $192.168.4.1$             | $192.168.4.30$             | $192.168.4.31$             |
| **2**  | $\mathbf{192.168.4.32}$     | $192.168.4.33$            | $192.168.4.62$             | $192.168.4.63$             |
| **3**  | $\mathbf{192.168.4.64}$     | $192.168.4.65$            | $192.168.4.94$             | $192.168.4.95$             |
| **4**  | $\mathbf{192.168.4.96}$     | $192.168.4.97$            | $192.168.4.126$            | $192.168.4.127$            |
| **5**  | $\mathbf{192.168.4.128}$    | $192.168.4.129$           | $192.168.4.158$            | $192.168.4.159$            |
| **6**  | $\mathbf{192.168.4.160}$    | $192.168.4.161$           | $192.168.4.190$            | $192.168.4.191$            |
| **7**  | $\mathbf{192.168.4.192}$    | $192.168.4.193$           | $192.168.4.222$            | $192.168.4.223$            |
| **8**  | $\mathbf{192.168.4.224}$    | $192.168.4.225$           | $192.168.4.254$            | $192.168.4.255$            |
| **9**  | $\mathbf{192.168.5.0}$      | $192.168.5.1$             | $192.168.5.30$             | $192.168.5.31$             |
| **10** | $\mathbf{192.168.5.32}$     | $192.168.5.33$            | $192.168.5.62$             | $192.168.5.63$             |
| **11** | $\mathbf{192.168.5.64}$     | $192.168.5.65$            | $192.168.5.94$             | $192.168.5.95$             |
| **12** | $\mathbf{192.168.5.96}$     | $192.168.5.97$            | $192.168.5.126$            | $192.168.5.127$            |
| **13** | $\mathbf{192.168.5.128}$    | $192.168.5.129$           | $192.168.5.158$            | $192.168.5.159$            |
| **14** | $\mathbf{192.168.5.160}$    | $192.168.5.161$           | $192.168.5.190$            | $192.168.5.191$            |
| **15** | $\mathbf{192.168.5.192}$    | $192.168.5.193$           | $192.168.5.222$            | $192.168.5.223$            |
| **16** | $\mathbf{192.168.5.224}$    | $192.168.5.225$           | $192.168.5.254$            | $192.168.5.255$            |
| **17** | $\mathbf{192.168.6.0}$      | $192.168.6.1$             | $192.168.6.30$             | $192.168.6.31$             |
| **18** | $\mathbf{192.168.6.32}$     | $192.168.6.33$            | $192.168.6.62$             | $192.168.6.63$             |
| **19** | $\mathbf{192.168.6.64}$     | $192.168.6.65$            | $192.168.6.94$             | $192.168.6.95$             |
| **20** | $\mathbf{192.168.6.96}$     | $192.168.6.97$            | $192.168.6.126$            | $192.168.6.127$            |

| **#**  | **Indirizzo di Rete (Decimale)** | **Primo Ottetto** | **Secondo Ottetto** | **Terzo Ottetto (Rete Madre)** | **Quarto Ottetto (Subnet ID + Host)** |
| ------ | -------------------------------- | ----------------- | ------------------- | ------------------------------ | ------------------------------------- |
| **1**  | $192.168.4.0$                    | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{000}00000$                   |
| **2**  | $192.168.4.32$                   | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{001}00000$                   |
| **3**  | $192.168.4.64$                   | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{010}00000$                   |
| **4**  | $192.168.4.96$                   | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{011}00000$                   |
| **5**  | $192.168.4.128$                  | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{100}00000$                   |
| **6**  | $192.168.4.160$                  | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{101}00000$                   |
| **7**  | $192.168.4.192$                  | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{110}00000$                   |
| **8**  | $192.168.4.224$                  | $11000000$        | $10101000$          | $00000\mathbf{100}$            | $\mathbf{111}00000$                   |
| **9**  | $192.168.5.0$                    | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{000}00000$                   |
| **10** | $192.168.5.32$                   | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{001}00000$                   |
| **11** | $192.168.5.64$                   | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{010}00000$                   |
| **12** | $192.168.5.96$                   | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{011}00000$                   |
| **13** | $192.168.5.128$                  | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{100}00000$                   |
| **14** | $192.168.5.160$                  | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{101}00000$                   |
| **15** | $192.168.5.192$                  | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{110}00000$                   |
| **16** | $192.168.5.224$                  | $11000000$        | $10101000$          | $00000\mathbf{101}$            | $\mathbf{111}00000$                   |
| **17** | $192.168.6.0$                    | $11000000$        | $10101000$          | $00000\mathbf{110}$            | $\mathbf{000}00000$                   |
| **18** | $192.168.6.32$                   | $11000000$        | $10101000$          | $00000\mathbf{110}$            | $\mathbf{001}00000$                   |
| **19** | $192.168.6.64$                   | $11000000$        | $10101000$          | $00000\mathbf{110}$            | $\mathbf{010}00000$                   |
| **20** | $192.168.6.96$                   | $11000000$        | $10101000$          | $00000\mathbf{110}$            | $\mathbf{011}00000$                   |

## Esercizio 2
*Indirizzo IP:* 192.168.36.25/21
*Subnet Mask (SM):* 255.255.248.0 = 11111111.11111111.11111000.00000000
*Trova:* l'ind. di rete, numero di host per sottorete

**Host per sottorete:** $2^{(32-21)}-2 = 2^{11}-2 = 2046$
**Indirizzo di rete:** bisogna effettuare l'and logico tra la SM e l'IP
255.255.11111 000.0
192.168.00100 100.25
192.168.00100 000.0 = 192.168.32.0

**Indirizzo di broadcast:**
192.168.00100 111.11111111 = 192.168.39.255

## Esercizio 3
*Indirizzo IP:* 192.168.10.0/26
*Subnet Mask (SM):* 255.255.255.192
*Trova:* l'ind. di rete e broadcast, numero di host

**Host:** $2^{(32-26)}-2 = 2^6-2 = 62$
**Indirizzo di rete:** bisogna effettuare l'and logico tra la SM e l'IP
255.255.255.11 000000
192.168.10.0 => Ind. di rete

**Indirizzo di broadcast:** 192.168.10.63
**Primo indirizzo:** 192.168.10.1
**Ultimo indirizzo:** 192.168.10.62

## Esercizio 4
*Indirizzo IP:* 192.168.1.0/24
*Subnet Mask (SM):* 255.255.255.0
*Trova:* SM, l'ind. di rete e broadcast, numero di host, range IP per host delle prime 4 sottoreti

## SM
**Bit presi in prestito:** $2^n \ge 4 \implies n = 2$
**Nuovo Prefisso:** $/24 + 2 = \mathbf{/26}$
**Nuova Subnet Mask (SM):** $/26 \implies 255.255.255.11000000 \space (255.255.255.192)$

**Host per sottorete:** $2^{(32-26)}-2 = 2^6-2 = 62$
**Incremento:** $256 - 192 = \mathbf{64}$

| **#** | **Indirizzo di Rete (/27)** | **Primo Indirizzo Utile** | **Ultimo Indirizzo Utile** | **Indirizzo di Broadcast** |
| ----- | --------------------------- | ------------------------- | -------------------------- | -------------------------- |
| **1** | 192.168.1.0                 | 192.168.1.1               | 192.168.1.62               | 192.168.1.63               |
| **2** | 192.168.1.64                | 192.168.1.65              | 192.168.1.126              | 192.168.1.127              |
| **3** | 192.168.1.128               | 192.168.1.129             | 192.168.1.190              | 192.168.1.191              |
| **4** | 192.168.1.192               | 192.168.1.193             | 192.168.1.254              | 192.168.1.255              |

## Esercizio 5
*Indirizzo IP:* 192.168.1.0/24
*Subnet Mask (SM):* 255.255.255.0
*Trova:* 16 sottoreti

**Bit presi in prestito:** $2^n \ge 16 \implies n = 4$
**Nuovo Prefisso:** $/24 + 4 = \mathbf{/28}$
**Nuova Subnet Mask (SM):** $/28 \implies 255.255.255.11110000 \space (255.255.255.240)$

**Host per sottorete:** $2^{(32-28)}-2 = 2^4-2 = 14$
**Incremento:** $256 - 240 = \mathbf{16}$

| **#**  | **Indirizzo di Rete (/27)** | **Primo Indirizzo Utile** | **Ultimo Indirizzo Utile** | **Indirizzo di Broadcast** |
| ------ | --------------------------- | ------------------------- | -------------------------- | -------------------------- |
| **1**  | 192.168.1.0                 | 192.168.1.1               | 192.168.1.14               | 192.168.1.15               |
| **2**  | 192.168.1.16                | 192.168.1.17              | 192.168.1.30               | 192.168.1.31               |
| **3**  | 192.168.1.32                | 192.168.1.33              | 192.168.1.46               | 192.168.1.47               |
| **4**  | 192.168.1.48                | 192.168.1.49              | 192.168.1.62               | 192.168.1.63               |
| **5**  | 192.168.1.64                |                           |                            |                            |
| **6**  | 192.168.1.80                |                           |                            |                            |
| **7**  | 192.168.1.96                |                           |                            |                            |
| **8**  | 192.168.1.112               |                           |                            |                            |
| **9**  | 192.168.1.128               |                           |                            |                            |
| **10** | 192.168.1.144               | 192.168.1.145             | 192.168.1.158              | 192.168.1.159              |
| **11** |                             |                           |                            |                            |
| **12** |                             |                           |                            |                            |
| **13** |                             |                           |                            |                            |
| **14** |                             |                           |                            |                            |
| **15** |                             |                           |                            |                            |
| **16** |                             |                           |                            |                            |

Per trovare l'ind. di rete di una sottorete in particolare, bisogna fare: **incremento*(numero sottorete-1)** es. 192.168.1.144 16*(10-1) = 144

## Esercizio 6
*Indirizzo IP:* 172.16.45.77/20
*Subnet Mask (SM):* 255.255.240.0 = 11111111.11111111.11110000.00000000
*Trova:* IP rete e broadcast, numero host per sottorete

**Host per sottorete:** $2^{(32-20)}-2 = 2^{12}-2 = 4094$
**Incremento:** $256 - 240 = \mathbf{16}$

**Indirizzo di rete:**
11111111.11111111.1111 0000.00000000
10110000.00010100.0010 1100.00000000
10110000.00010100.0010 0000.00000000 = 172.16.32.0 => ind. di rete

**Indirizzo di broadcast:**
10110000.00010100.0010 1111.11111111 = 172.16.47.255 => ind. di broadcast

## Esercizio 7
*Indirizzo IP:* 10.0.0.0/16
*Subnet Mask (SM):* 255.255.0.0 = 11111111.11111111.00000000.00000000
*Trova:* creare sottoreti da 1000 host, subnet mask, numero sottoreti, IP rete 1 e rete 2

**Host per sottoreti:** $1024 = 2^{10}$ potenza per quelle sottoreti
**Nuova Subnet Mask:** 10.0.0.0/22 perchè (32-10 = 22)
**Numero di sottoreti:** $(22-16) = 6$ quindi abbiamo $2^{6} = 64$ sottoreti

**Rete 1:** 10.0.0.0/22
**Rete 2:** 10.0.4.0/22

Perchè 1024 diviso 256 fa 4t

Data: 2025-10-23
[Subnetting_Practice](Modelli/segaSistemai/Networking/Subnetting_Practice/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Subnetting_Practice
___
Esercizi: https://www.edutecnica.it/informatica/retix/retix.htm
# Numero di Sottoreti (Subnet)

**Formula:**  
$$
\text{Numero di sottoreti} = 2^s
$$
$$\text{s = N. bit presi in prestito dagli host}$$

**Esempio (Esercizio 1):**  
- IP di Classe B (`/16`)
- Vuoi creare una maschera `/18` → hai preso in prestito 2 bit dagli host (`s = 2`)
- Numero di sottoreti = 2² = 4
---
# Numero di Host per Sottorete

**Formula:**  
$$
\text{Numero di host} = 2^h - 2
$$
$$
\text{h = N. bit dedicati agli host}
$$

**Nota:** Il "-2" serve perché:
- Il primo indirizzo (tutti i bit host a 0) è l’**Indirizzo di Rete**  
 - L’ultimo indirizzo (tutti i bit host a 1) è l’**Indirizzo di Broadcast**  
 Questi non possono essere assegnati ai dispositivi.

**Esempio (Esercizio 1):**  
- Maschera `/22` → 32 - 22 = 10 bit per host → `h = 10`
- Numero di host = 2¹⁰ - 2 = 1024 - 2 = 1022 host utilizzabili

---
# Passaggi Pratici per il Calcolo delle Sottoreti

**Esempio (Esercizio 7):**  
IP: `131.175.21.1/22`  
- **Maschera CIDR:** `/22`  
- **Maschera estesa:** `255.255.252.0`  
	22 bit a 1 → `11111111.11111111.11111100.00000000`

## A. Trovare l'Indirizzo di Rete

**Metodo:** AND logico bit-a-bit tra IP e Subnet Mask.

**Conversione binaria (ottetto "interessante"):**  

| IP (3° ottetto) | 21 → `00010101` |
| Mask (3° ottetto)| 252 → `11111100` |

**AND bit-a-bit:**  

| Bit        | 7   | 6   | 5   | 4   | 3   | 2   | 1   | 0   |
| ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
| IP (21)    | 0   | 0   | 0   | 1   | 0   | 1   | 0   | 1   |
| Mask (252) | 1   | 1   | 1   | 1   | 1   | 1   | 0   | 0   |
| AND        | 0   | 0   | 0   | 1   | 0   | 1   | 0   | 0   |
00010100 = 20
 
**Indirizzo di Rete:** `131.175.20.0`

---
## B. Trovare l'Indirizzo di Broadcast

**Metodo:** Imposta tutti i bit host a 1.  

- Indirizzo di rete (binario): `10000011.10101111.00010100.00000000`  
- Mask binaria: `11111111.11111111.11111100.00000000`  
- Ultimi 10 bit sono per host → impostati a 1
- Indirizzo di broadcast (binario): 10000011.10101111.000101`11.11111111`  

**Risultato:** `131.175.23.255`

---
## C. Trovare Numero Subnet e Host

- Indirizzo: `131.175.21.1` → Classe B (maschera default `/16`)  
- Maschera data: `/22`  
- Bit per Subnet ($s$): $22 - 16 = 6$  
- **Numero Sottoreti** = $2^6 = 64$  
- Bit per Host ($h$): $32 - 22 = 10$  
- **Numero Host** = $2^{10} - 2 = 1022$

---
# Caso Avanzato: Trovare la "N-esima" Sottorete
## Concetto chiave: Incremento (Magic Number)
**Formula:**
$$
\text{Incremento} = 256 - \text{valore otteto maschera}
$$

**Esempio (Esercizio 8):**  
IP: `150.12.0.0/22`  
Domanda: primo/ultimo host della 30ª e 50ª sottorete.

- Ottetto "interessante": 3° ottetto  
- Incremento = `256 - valore ottetto maschera`  
- `/22 → 255.255.252.0`  
- Incremento = `256 - 252 = 4`  

 Le sottoreti "saltano" di 4 in 4 nel terzo ottetto.

---
## Calcolo Sottoreti

| Sottorete       | Indirizzo di Rete           |
| --------------- | --------------------------- |
| 0ª (indice 0)   | 150.12.0.0                  |
| 1ª (indice 1)   | 150.12.4.0                  |
| 2ª (indice 2)   | 150.12.8.0                  |
| ...             | ...                         |
| 30ª (indice 29) | 29 × 4 = 116 → 150.12.116.0 |
| 50ª (indice 49) | 49 × 4 = 196 → 150.12.196.0 |

---
## Primo e Ultimo Host

- **30ª sottorete:**  
	- Primo Host = `150.12.116.1`  
	- Broadcast = `150.12.119.255`  
	- Ultimo Host = `150.12.119.254`

- **50ª sottorete:**  
	- Primo Host = `150.12.196.1`  
	- Broadcast = `150.12.199.255`  
	- Ultimo Host = `150.12.199.254`

 Metodo valido anche per esercizi tipo "trova il 20° host della 10ª subnet":  
 - Trova l'indirizzo di rete della sottorete  
 - Aggiungi l'indice host (es. +20) per ottenere l'IP richiesto.


# Subnetting con CIDR

  

Il **subnetting** in ottica CIDR consiste nel prendere un blocco di indirizzi e dividerlo in blocchi più piccoli aumentando il prefisso.

  

> ⬆️ Aumentare il prefisso di **1** dimezza gli host, ma **raddoppia** il numero di subnet.

  

## Dividere una rete — esempio pratico

  

**Scenario**: Dividere `192.168.1.0/24` in **4 subnet uguali**.

  

Servono 4 subnet → `2^2 = 4` → si aggiungono **2 bit** al prefisso → `/24 + 2 = /26`

  

Block size di `/26` = `64` indirizzi

  

| Subnet | Network | Primo host | Ultimo host | Broadcast | Host |
| --- | --- | --- | --- | --- | --- |
| 1 | 192.168.1.0 | 192.168.1.1 | 192.168.1.62 | 192.168.1.63 | 62 |
| 2 | 192.168.1.64 | 192.168.1.65 | 192.168.1.126 | 192.168.1.127 | 62 |
| 3 | 192.168.1.128 | 192.168.1.129 | 192.168.1.190 | 192.168.1.191 | 62 |
| 4 | 192.168.1.192 | 192.168.1.193 | 192.168.1.254 | 192.168.1.255 | 62 |

  

**Formula generale per il subnetting:**

  

$$\text{Nuove subnet} = 2^{\text{bit aggiunti}}$$

$$\text{Nuovo prefisso} = \text{Prefisso originale} + \text{bit aggiunti}$$

  

## Supernetting (Route Aggregation)

  

Il **supernetting** è l'operazione inversa: si accorpano più reti contigue in un unico prefisso più grande (prefisso più corto).

  

**Esempio**: Aggregare `192.168.0.0/24`, `192.168.1.0/24`, `192.168.2.0/24`, `192.168.3.0/24`

  

Sono 4 reti contigue → `2^2 = 4` → si tolgono **2 bit** al prefisso → `/24 − 2 = /22`

  

```

192.168.0.0/22  →  copre 192.168.0.0 – 192.168.3.255

```

  

> ⚠️ Il supernetting funziona **solo** se le reti sono contigue e allineate al blocco (il network address del superblocco deve essere multiplo della block size).



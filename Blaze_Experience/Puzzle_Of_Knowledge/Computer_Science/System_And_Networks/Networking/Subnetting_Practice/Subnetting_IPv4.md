Data: 2025-10-23
[Subnetting_Practice](./README.md)
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

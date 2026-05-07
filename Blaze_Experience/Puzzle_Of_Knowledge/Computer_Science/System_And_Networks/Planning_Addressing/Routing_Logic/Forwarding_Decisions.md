Data: 2026-05-07
[Routing_Logic](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Routing_Logic
___
# Index
- [[#Come il router sceglie la rotta]]
	- [[#1. Longest Prefix Match]]
	- [[#2. Administrative Distance (AD)]]
	- [[#3. Metrica]]
- [[#Riepilogo del processo decisionale]]
- [[#Considerazioni]]
___
# Come il router sceglie la rotta

Quando un pacchetto arriva su un router, questo deve decidere **dove instradarlo**. La scelta segue tre criteri in ordine gerarchico:
## 1. Longest Prefix Match
Il router confronta l'indirizzo IP di destinazione con tutte le rotte presenti nella **routing table** e sceglie quella con la **maschera più lunga**.

**Esempio**:

| Rotta nella tabella | Maschera     | Specifica |
| ------------------- | ------------ | --------- |
| 192.168.1.0         | /24          | Media     |
| 192.168.1.128       | /25          | Alta ✅    |
| 0.0.0.0             | /0 (default) | Minima    |

Se il pacchetto è diretto a `192.168.1.200`, il router sceglie `192.168.1.128/25` perché è la corrispondenza **più specifica**.
## 2. *Administrative Distance* (AD)
Se esistono **due rotte verso la stessa rete con la stessa lunghezza di prefisso** ma apprese da sorgenti diverse, il router preferisce quella con la **AD più bassa**.
- **Ripasso**: La AD è un numero che rappresenta la "**fiducia**" verso la sorgente della rotta: più è basso, più la rotta è considerata affidabile.

**Esempio**:

| Fonte della Rotta | Destinazione    | Next Hop (Via) | AD (Affidabilità) |
| ----------------- | --------------- | -------------- | ----------------- |
| **Statica**       | 192.168.10.0/24 | Router B       | **1** (Altissima) |
| **OSPF**          | 192.168.10.0/24 | Router A       | **110** (Media)   |

Il router sceglierà la **Rotta Statica** per arrivare alla rete `192.168.10.0/24`
## 3. Metrica
Se due rotte hanno **stesso prefisso e stessa AD** (cioè provengono dallo stesso protocollo), il router sceglie quella con la **metrica più bassa**.
- **Ripasso**: La metrica in breve, indica il "**costo**" o la "**fatica**" necessaria per percorrere una specifica strada verso la destinazione.

**Esempio**:

| Fonte della Rotta | Destinazione    | Next Hop (Via) | AD (Affidabilità) | Metrica |
| ----------------- | --------------- | -------------- | ----------------- | ------- |
| **RIP**           | 192.168.10.0/24 | Router B       | **110**           | 100     |
| **OSPF**          | 192.168.10.0/24 | Router A       | **110**           | 120     |
Il router sceglie di inoltrare i pacchetti al Router B

Una rotta **statica**, quindi configurata da un umano, ho sempre una metrica più bassa dei protocolli di routing citati.
___
# Riepilogo del processo decisionale

```
Pacchetto in arrivo
       │
       ▼
Longest Prefix Match
(quale rotta è più specifica?)
       │
  Più rotte con stesso prefisso?
       │
       ▼
Administrative Distance
(quale sorgente è più affidabile?)
       │
  Stessa AD?
       │
       ▼
Metrica
(quale percorso è più "corto"?)
       │
       ▼
Pacchetto inoltrato
```

---
# Considerazioni

- Se non esiste nessuna rotta corrispondente (nemmeno una default route), il pacchetto viene **scartato** e il router invia un messaggio ICMP "Destination Unreachable" al mittente.
- La **default route** (`0.0.0.0/0`) ha il prefisso più corto possibile: viene scelta solo se nessuna altra rotta è più specifica.
___
Data: 2025-11-14
[](./README.md)
#Red_Lab/Giochi/Reverse
___
# Reversi (Othello)

Reversi, noto anche come *Othello*, è un gioco da tavolo per due giocatori giocato su una griglia quadrata **8×8** con **64 pedine bicolori** (bianche da un lato, nere dall’altro).
Lo scopo è terminare la partita con **più pedine del proprio colore** rispetto all’avversario.

---
## 🎯 Obiettivo del gioco
Il gioco termina quando:
* la tavola è piena, **oppure**
* nessun giocatore ha mosse valide.
Vince chi possiede **più pedine del proprio colore** sulla scacchiera.
Se i punteggi sono uguali → **pareggio**.

---
## 🧩 Materiale
* Tavola 8×8 (64 caselle)
* 64 pedine bicolori
* Ogni giocatore controlla un colore (bianco o nero)
---
## ♟️ Preparazione
1. La tavola inizialmente è vuota.
2. Ogni giocatore prende 32 pedine.
3. Si posizionano 4 pedine al centro del tabellone:

```
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . W B . . .
. . . B W . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
```

(W = bianco, B = nero)

---
## 🔄 Turni di gioco
* Il giocatore **nero** inizia per primo.
* I giocatori alternano i turni.
---
## 📏 Regole di posizionamento
Una mossa è valida solo se:
### ✅ Una pedina viene posata su una casella vuota
**e allo stesso tempo intrappola almeno una pedina avversaria** tra:

* la nuova pedina posata
* un’altra pedina dello stesso colore

in **linea retta**:

* orizzontale
* verticale
* diagonale
Quando questo accade, diciamo che avviene una **cattura per intrappolamento**.

---
## 🔁 Cattura e conversione

Tutte le pedine avversarie intrappolate in una o più linee vengono:
* **girate**
* **diventano del colore del giocatore che ha fatto la mossa**
Esempio: se il nero intrappola pedine bianche, queste diventano nere.

---
## ⏭ Passare il turno
* Se un giocatore **non ha mosse valide**, deve **passare**.
* Se entrambi non possono muovere, la partita termina.
---
## 🏁 Fine della partita
Il gioco finisce quando:

* la scacchiera è piena
  **oppure**
* nessuno dei due giocatori può muovere
---
## 🏆 Vittoria
Il vincitore è chi ha il **maggior numero di pedine del proprio colore** sulla scacchiera alla fine.


Se il numero è uguale → **pareggio**.

---
Se vuoi, posso anche:
✔ creare una versione *compatto*, *per studenti*, *per regolamento ufficiale*, oppure
✔ aggiungere diagrammi grafici in ASCII,
✔ oppure trasformarlo in un PDF.
Data: 2026-02-21
[](./README.md)
#Puzzle_Of_Knowledge/Math
___
# Equazione della circonferenza

- **Definizione geometrica**: La circonferenza è definita come il luogo dei punti $P(x; y)$ del piano la cui distanza da un punto fisso $C(\alpha; \beta)$, detto centro, è costante e pari a $r$ (raggio).

**Equazione in forma canonica**: Deriva direttamente dalla formula della distanza tra due punti:
$$
r^2 = (x - \alpha)^2 + (y - \beta)^2
$$
$$
x^2 - 2\alpha x + \alpha^2 + y^2 - 2\beta y + \beta^2 - r^2 = 0
$$
**Sviluppo** dell'equazione generale della forma canonica si ottiene:
$$
x^2 + y^2 + ax + by + c = 0
$$
Dove i coefficienti sono legati al centro dalle relazioni: 
1) $a = -2\alpha$. 
2) $b = -2\beta$. 
3) $c = \alpha^2 + \beta^2 - r^2$.

> [!NOTE] ESEMPIO
> 
> Se hai $x^2 + y^2 - 4x + 6y + 9 = 0$:
> 
> - $a = -4 \rightarrow \alpha = -(-4)/2 = 2$
>     
> - $b = 6 \rightarrow \beta = -(6)/2 = -3$
>     
> - Il centro è $C(2; -3)$.

Il termine noto $c$ non è il raggio, ma un numero che "raggruppa" tutti i **termini costanti** dello sviluppo:
$$c = \alpha^2 + \beta^2 - r^2$$
Da questa relazione ricaviamo la formula per calcolare il raggio partendo dai coefficienti:
$$
r = \sqrt{\alpha^2 + \beta^2 - c} = \sqrt{\frac{a^2}{4} + \frac{b^2}{4} - c}
$$
Una circonferenza esiste nel piano cartesiano se e solo se il radicando della formula del raggio è non negativo: $\frac{a^2}{4} + \frac{b^2}{4} - c \ge 0$. 
Se tale valore è uguale a zero, la circonferenza si dice "**degenere**" e coincide con il solo punto del centro.

 **In sintesi**: 
1) Coordinate del centro: $C\left(-\frac{a}{2}; -\frac{b}{2}\right)$. 
2) Misura del raggio: $r = \sqrt{\frac{a^2}{4} + \frac{b^2}{4} - c}$.

---
# Determinare l’equazione di una circonferenza

**Gradi di libertà**: Poiché l'equazione $x^2 + y^2 + ax + by + c = 0$ presenta tre parametri incogniti ($a, b, c$), sono sempre necessarie tre informazioni indipendenti per definirla univocamente.

**Tipologie di condizioni comuni**: 
1) **Passaggio per tre punti**: Se sai che la circonferenza passa per i punti $P_1$, $P_2$ e $P_3$, devi sostituire le loro coordinate $(x; y)$ nell'equazione $x^2 + y^2 + ax + by + c = 0$. 
   Facendolo per tutti e tre i punti, ottieni un sistema di 3 equazioni in 3 incognite ($a, b, c$) che, una volta risolto, ti dà l'equazione finale.
2) **Centro e raggio noti**: Si sostituiscono direttamente i valori nella formula canonica $(x - \alpha)^2 + (y - \beta)^2 = r^2$. 
3) **Centro e passaggio per un punto**: Si calcola il raggio come distanza tra il centro $C$ e il punto $A$ con la formula distanza fra 2 punti e poi si procede come nel caso precedente. 
4) **Tangenza a una retta**: Se è noto il centro e la retta tangente, il raggio si ottiene calcolando la distanza punto-retta tra il centro e la retta stessa.
$$r = \frac{|a\alpha + b\beta + c|}{\sqrt{a^2 + b^2}}$$


ho studiato fino a qua----------------------------

---
# Posizione reciproca di una retta e una circonferenza

- **Analisi del discriminante**: Mettendo a sistema l'equazione della retta $y = mx + q$ con quella della circonferenza, si ottiene un'equazione di secondo grado in $x$: 1) **Secante ($\Delta > 0$)**: La retta taglia la circonferenza in due punti distinti. 2) **Tangente ($\Delta = 0$)**: La retta tocca la circonferenza in un solo punto (punto di tangenza). 3) **Esterna ($\Delta < 0$)**: Non vi sono punti di contatto.
- **Approccio tramite distanza**: Un metodo alternativo (spesso più veloce per i test) consiste nel confrontare la distanza $d$ tra il centro $C$ e la retta con il raggio $r$:
    1. $d < r \implies$ Secante.
    2. $d = r \implies$ Tangente.
    3. $d > r \implies$ Esterna.

---

# Determinare le rette tangenti da un punto $P$
- **Posizione di $P$**:
    1. Se $P$ è **interno**, non esistono rette tangenti reali. 2) Se $P$ appartiene alla **circonferenza**, esiste una sola retta tangente (si può usare la "formula di sdoppiamento"). 3) Se $P$ è **esterno**, esistono sempre due rette tangenti.
- **Metodo del discriminante**: 1) Si scrive l'equazione del fascio proprio di rette passanti per $P(x_P; y_P)$: $y - y_P = m(x - x_P)$. 2) Si sostituisce $y$ nell'equazione della circonferenza per ottenere l'equazione risolvente. 3) Si impone $\Delta = 0$ e si risolve l'equazione di secondo grado nell'incognita $m$.
- **Nota sulle rette verticali**: Se il sistema restituisce un solo valore di $m$ ma il punto è esterno, la seconda retta tangente è verticale (forma $x = x_P$), poiché il coefficiente $m$ sarebbe infinito.

---
# Posizione reciproca di due circonferenze

- **Relazione tra centri e raggi**: Siano $C_1, C_2$ i centri e $r_1, r_2$ i raggi delle due circonferenze: 1) **Esterne**: Distanza $C_1C_2 > r_1 + r_2$. 2) **Tangenti esterne**: Distanza $C_1C_2 = r_1 + r_2$. 3) **Secanti**: $|r_1 - r_2| [cite_start]<$ Distanza $C_1C_2 < r_1 + r_2$. 4) **Tangenti interne**: Distanza $C_1C_2 = |r_1 - r_2|$. 5) **Interne**: Distanza $C_1C_2 < |r_1 - r_2|$.
- **Asse radicale**: Sottraendo le equazioni di due circonferenze $C_1 - C_2 = 0$, i termini $x^2$ e $y^2$ si annullano, lasciando l'equazione di una retta: $(a - a')x + (b - b')y + (c - c') = 0$. Questa retta è perpendicolare alla retta che congiunge i due centri.

---

## Fasci di circonferenze

- **Generatrici**: Un fascio è definito dalla combinazione lineare di due circonferenze base $F_1(x,y) + k F_2(x,y) = 0$.
- **Caratteristiche**: 
1) **Punti base**: Sono i punti comuni a tutte le circonferenze del fascio (ottenuti dall'intersezione delle generatrici). 
2) **Asse radicale**: È la retta che contiene i punti base (o la retta di tangenza comune). 
3) **Circonferenze degeneri**: Nel fascio sono presenti circonferenze particolari, come l'asse radicale stesso (raggio infinito) o i punti base (raggio zero).
 Data: 2025-11-02
[Integral](./README.md)
#Puzzle_Of_Knowledge/Math/Integral
___
# Trapezoide
![[Grafico_integrale]]
$$
\int_b^a f(x) \ dx = S = \lim_{x \to \ + \infty}s_n = \lim_{x \to \ + \infty}S_n
$$

- Data una funzione $f(x)$, continua $[a; b]$,  **l'Integrale definito** esteso all'intervallo $[a;b]$ è il valore del limite per $\Delta x_{\text(max)}$  che tende a $0$ della somma $\overline{S}:$
$$
\int_a^b f(x) \ dx = \lim_{\Delta x_{\text(max)} \to \ 0}\overline{S}
$$

![[Integrale_definito_Indica]]

# Calcolo delle aree
![[Integrale_definito_Aree|600]]

- Per convenzione di pone:
$$
\int_a^a f(x) \ dx = 0 \ \ \ \ \ \ \ \ \\ \ \ \ \ \ \ \ \\ \ \  \ \ \\ \  \ \ \int_a^b f(x)\ dx = -\int_b^a f(x) \ dx  \ \ \ \\ \ se\ a > b
$$
___
# Proprietà Dell'Integrale Definito
## Additività Dell'Integrale Rispetto All'Intervallo Di Intervallo Di Integrazione
Se $f(x)$ è continua in un intervallo e $a, b, c$  sono punti qualunque di tale intervallo, allora:

$$
\int_a^b f(x) \ dx = \int_a^b f(x) dx \ + \int_b^c f(x) \ dx
$$

## Integrale Della Somma Di Funzioni
Se $f(x)$ e $g(x)$ sono funzioni continue in $[a;b]$, allora è continua anche la loro somma $f(x) + g(x)$, risulta:
$$
\int_a^b \left[f(x)\ + \ g(x) \right] \ dx = \int_a^b f(x) \ dx + \int_a^b g(x) \ dx
$$
## Integrale Del Prodotto Di Una Costante Per Uno Funzione
Se $f(x)$ è una funzione continua in $[a;b]$, allora è continua anche la a funzione $k \cdot f(x)$,
con $k \in \mathbb{R}$,  e risulta:
$$
\int_a^b k \cdot f(x) dx = k \ \cdot \int_a^b f(x)
$$
## Confronto Tra Gli Integrali Di Due Funzioni
Se $f(x)$ e $g(x)$ sono funzioni continue e tali che $f(x) \le g(x)$, in ogni punto punto dell'intervallo  $[a;b]$, allora:
$$
\int f(x)\ dx\le \int g(x)\ dx,
$$

## Integrale Del Valore Assoluto Di Una Funzione
Se $f(x)$ è una funzione continua in $[a;b]$, allora:
$$
\left| \int_a^b f(x)\ dx \right| \le \int_a^b \left| f(x) \right| \ dx
$$

## Integrale Di Una Funzione Costante
Se $f(x)$ è una funzione è costante nell'intervallo in $[a;b]$, cioè $f(x) = k$, allora:
$$
\int_a^b k \ dx = k(b-a) \ \ \ \ \ \ \ k \ > 0
$$
___
# Teorema Della Media
- Se $f(x)$ è una funziona continua in un intervallo $[a;b]$, esiste almeno un punto $z$ dell'intervallo tale che:
$$
\int_a^b f(x) \ dx = f(z)\ \cdot \ (b-a) \ \ \ \ \ \ \ \ \ \ con \ z \in [a;b]
$$

**Dimostrazione:**
Poichè la  funzione $f(x)$ è continua nell'intervallo $[a;b]$, allora per il teorema di Weierstrass la funzione assume in $[a;b]$ il suo valore massimo $M$ e il suo valore minimo $m$. Quindi, per ogni $x$ di $[a;b]$, vale la disuguaglianza: 
$$
m \le f(x) \le M
$$
Per la proprietà del confronto tra gli integrali, vale anche la disuguaglianza:
$$
\int_{a}^{b} m \, dx \le \int_{a}^{b} f(x) \, dx \le \int_{a}^{b} M \, dx
$$
Applicando la proprietà dell'integrale di una funzione cosante, otteniamo:
$$
m(b - a) \le \int_{a}^{b} f(x) \, dx \le M(b - a)
$$
Dividiamo tutti i membri per il numero reale positivo $(b-a)$
$$
m \le \frac{\int_{a}^{b} f(x) \, dx}{b - a}  \le M
$$
Per il teorema dei valori intermedi, la funzione $f(x)$ deve assumere almeno una volta tutti i valori compresi fra il suo massimo e il suo minimo, quindi deve esistere almeno un punto $z$  appartenente ad $[a;b]$ tale che:
$$
f(z) = \frac{\int_{a}^{b} f(x) \, dx}{b - a} 
$$
Pertanto esiste almeno un punto $z$ appartenente ad $[a;b]$  tale che:
$$
\int_a^b f(x) \ dx = f(z)\ \cdot \ (b-a)
$$

![[Integrale_definito_Media|200]]

___
# Calcolo Dell'Integrale Definito
Formula di **Leibniz-Newton:**
$$
\int_a^b f(x) \ dx = \varphi (b) - \varphi(a) \ \ \ \ \ \ \ \ \ \varphi(x)\text{ è la primitiva di} \ f(x)
$$

- L'integrale definito di una funzione continua $f(x)$ è uguale alla differenza tra i valori assunti da una qualunque primitiva $\varphi(x)$ di $f(x)$ rispettivamente nell'estremo superiore di integrazione e nell'estremo inferiore

$$
\left[ \varphi(x) \right]_a^b = \varphi (b) - \varphi(a)
$$

___
# Area Comprese Tra Due Curve
**Regola: Area della superficie delimitata dai grafici di due funzioni
- Siano $f(x)$ e $g(x)$ due funzioni continue definite stesso intervallo $[a;b]$, con $f(x) \ge g(x)$ per ogni x in $[a;b]$, i cui grafici delimitano una superficie; allora l'area $S$ della superficie è data da:
$$
S = \int_a^b \left[ f(x) - g(x) \right] \ dx
$$
![[Integrale_definito_aree_curve|200]]

___ 
# Calcolo Dei Volumi
- Dato il trapezoide esteso all'intervallo $[a;b]$, delimitato dal grafico delle funzione $y = f(x)$ (positiva o nulla), dall'asse $x$ e dalle rette $x = a$ e $x = b$, il **volume del solido di rotazione** che si ottiene ruotando il trapezoide intorno all'asse $x$ di un giro completo è:
$$
V = \pi \ \cdot \int_a^b \left[f(x)^2\right] \ dx
$$

___
# Integrali Impropri

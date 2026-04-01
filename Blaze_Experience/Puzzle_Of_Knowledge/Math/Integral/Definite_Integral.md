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
\int_a^c f(x) \ dx = \int_a^b f(x) dx \ + \int_b^c f(x) \ dx
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

# Derivata Della Primitiva
Se:
$$
G(x) = \int_{x_0}^{f(x)} g(t) \ dt
$$
Allora:
$$
G'(x) = g(f(x))\  \cdot f'(x) 
$$
___
# Teorema Fondamentale Del Calcolo Integrale
Se una funzione $f(x)$ è continua in $[a;b]$, allora esiste la derivata della sua funzione integrale
$$
		F(x) = \int_a^x f(t) \ dt
$$
Per ogni punto x dell'intervallo $[a;b]$, ed è uguale a $f(x)$, cioè:
$$
F'(x) = f(x)
$$
Ovvero $F(x)$ è una primitiva $f(x)$.

**Dimostrazione:**
Dimostriamo che esiste la derivata $F(x)$ e calcoliamo tale derivata applicando la definizione.
Incrementiamo la variabile $x$ di un valore $h \neq 0$ tale che $a < x + h < b$ e calcoliamo la differenza $F(x+h)-F(x)$ utilizzando l'espressione della funzione integrale:
$$
F(x+h) - F(x) = \int_a^{x+h} f(t) \ dt \ - \int_a^x f(t) \ dt
$$
Applichiamo la proprietà di additività dell'integrale:

$$
F(x + h) - F(x) =  \int_a^x f(t)dt + \int_x^{x+h} f(t)dt  - \int_a^x f(t)dt = \int_x^{x+h} f(t)dt.
$$

Per il teorema della media, il valore dell’ultimo integrale della formula precedente è uguale al prodotto di $h$ per il valore $f(z)$, dove $z$ è un particolare punto che appartiene all’intervallo $[x, x+h]$, nel caso in cui sia $h > 0$, oppure all’intervallo $[x+h, x]$, se $h < 0$; pertanto possiamo scrivere:
$$
\int_x^{x+h}f(x) = h \cdot f(z) \to F(x + h) - F(x) = h \cdot f(z).
$$
Dividiamo i due membri delle seconda uguaglianza per $h$:
$$
\frac{F(x + h) - F(x)}{h} = f(z).
$$
Analizziamo il comportamento di $f(z)$ al tendere a $0$ di $h$.
Sia $h > 0$; poiché $z$ è compreso fra $x$ e $x+h$, se $h$ tende a $0$ (da destra), allora $z$ tende a $x$ (da destra) e
$$
\lim_{h \to 0^+} f(z) = \lim_{z \to x^+} f(z) = f(x)
$$
perché $f$ è continua per ipotesi.

Con un ragionamento analogo, se $h < 0$, si deduce che
$$
\lim_{h \to 0^-} f(z) = \lim_{z \to x^-} f(z) = f(x).
$$
Dunque:
$$
\lim_{h \to 0} f(z) = \lim_{z \to x} f(z) = f(x).
$$
Possiamo pertanto concludere che esiste anche il limite, per $h$ tendente a $0$, dell’espressione al primo membro, cioè del rapporto incrementale della funzione $F$ nel punto $x$, e:
$$
\lim_{h \to 0} \frac{F(x + h) - F(x)}{h} = \lim_{h \to 0} f(z) = f(x).
$$
La funzione $F$ è dunque derivabile, e quindi anche continua, e risulta:
$$
F'(x) = f(x)
$$

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
1) Consideriamo per primo il caso in cui la funzione $f(x)$ sia continua in tutti i punti dell'intervallo , ma con una singolarità in $b$, cioè $f(x)$ non è definita in $b$ o è definita ma è discontinua in $b$.

	Consideriamo un punto $z$ interno all'intervallo  $[a;b]$: 
	La funzione $f(x)$ è continua nell'intervallo $[a;z]$, quindi esiste l'integrale $\int_a^z f(x) \ dx$, il cui valore è un numero reale.
	
	Questo vale per tutti i punti $z$ dell'intervallo  $[a;b]$, perciò possiamo costruire la funzione integrale
	$$
	F(z) = \int_a^z f(x) \ dx,
	$$
	definita in $[a;b]$.
	
	Se esiste finito il limite fi $F(x)$ quando $z$ tende a $b$ da sinistra, cioè se esiste 
	$$
	\lim_{z \to b^-} F(z),
	$$
	
	Allora si dice che la funzione $f(x)$ è **integrabile in senso improprio** in  $[a;b]$ e si definisce:
	$$
	\int_a^b f(x) \ dx = \lim_{z \to b^-} \int_a^z f(x) \ dx
	$$
	- L'integrale  $\int_a^b f(x)$ è detto **integrabile improprio** della funzione $f(x)$ in  $[a;b]$, e in questo caso si dice anche che tale integrale è **convergente.**
	
	- Se il limite considerato non esiste oppure è infinito, si dice che la funzione **non è integrabile in senso improprio** in  $[a;b]$:
		- Il limite è $\infty \to$ **divergente** 
		- Il limite non esiste $\to$ **Indeterminato**

2) Se la funzione $f(x$) è continua in tutti i punti dell'intervallo $]a;b]$, ma ha una singolarità in $a$, possiamo definire l'integrale $\int_a^b f(x) \ dx$ in modo analogo.

	Considerato $z \in ]a, b]$, se esiste finito il limite della funzione $F(z) = \int_z^b f(x) \ dx$ quando $z$ tende ad $a$ da destra, cioè se esiste $\lim_{z \to a^+} F(z)$, allora si dice che la funzione $f(x)$ è **integrabile in senso improprio** in $[a, b]$ e si definisce:
$$
\int_a^b f(x) \ dx = \lim_{z \to a^+} \int_z^b f(x) \ dx.
$$
3) Se la funzione ha un punto di singolarità di qualunque specie in un punto $c$ interno all’intervallo $[a, b]$, l’integrale $\int_a^b f(x)\ dx$ può essere definito, **in senso improprio**, come la somma degli integrali $\int_a^c f(x) \ dx$ e $\int_c^b f(x) \ dx$, se tali integrali esistono, in base alle definizioni precedenti:
$$
\int_a^b f(x) dx = \lim_{t \to c^-} \int_a^t f(x) dx + \lim_{t \to c^+} \int_t^b f(x) dx.
$$

![[Integrale_definito_3casi|600]]

# Integrale Di Una Funzione In Un Intervallo Illimitato
Consideriamo una funzione $f(x)$ continua in tutti i punti di $[a, +\infty[$. Comunque si scelga un punto $z$ interno all’intervallo $[a, +\infty[$, esiste l’integrale $\int_a^z f(x) dx$ il cui valore è un numero reale, quindi possiamo costruire anche in questo caso la funzione integrale:
$$
F(z) = \int_a^z f(x) dx,
$$
definita in $[a, +\infty[.$

- Se esiste finito il limite della funzione $F(z)$ quando $z$ tende a $+\infty$, cioè se esiste $\lim_{z \to +\infty} F(z)$, 
  allora si dice che la funzione $f(x)$ è **integrabile in senso improprio** in $[a, +\infty[$ e si definisce:
$$
\int_a^{+\infty} f(x) dx = \lim_{z \to +\infty} \int_a^z f(x) dx.
$$
Anche in questo caso si dice che l’integrale $\int_a^{+\infty} f(x)dx$ è **convergente**.

- Se il limite considerato è infinito, si dice che l’integrale $\int_a^{+\infty} f(x)dx$ è **divergente**. 
- Se il limite non esiste, l’integrale $\int_a^{+\infty} f(x)dx$ è **indeterminato**.

  In entrambi i casi diciamo che la funzione $f(x)$ **non è integrabile in senso improprio** in $[a, +\infty[$.

In modo del tutto analogo, se una funzione è continua in $]-\infty, a]$ e se esiste finito il limite $\lim_{z \to -\infty} \int_z^a f(x) dx$, diciamo che la funzione $f(x)$ è integrabile in senso improprio in $]-\infty, a]$ e definiamo:

$$\int_{-\infty}^a f(x) dx = \lim_{z \to -\infty} \int_z^a f(x) dx.$$




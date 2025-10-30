Data: 2025-10-25
[Integral](./README.md)
#Puzzle_Of_Knowledge/Math/Integral
___
# Primitive

- Una Funzione $F(x)$  è una **primitiva** della funzione $f(x)$ definita nell'intervallo reale  $I \subseteq R$ se $F(x)$ è derivabile in tutto $I$ e la sua derivata è $f(x)$:
$$F'(x) = f(x)$$

- Se $F(x)$ è una primitiva di $f(x)$, allora le funzioni $F(x) + c$, con  $c$ numero reale qualsiasi, sono **tutte** e **solo** le primitive di $f(x)$.
$$\mathrm{D} \left[ F(x) \,+c \right] = F'(x) = f(x),\ \forall c \in \mathbb{R} $$

- **L'integrale indefinito** di una funzione $f(x)$ definita in un intervallo reale $I$ è l'intervallo di tutte le primitive $F(x) + c$ di $f(x)$, con $c$ numero reale qualunque. Si indica con: 
$$\int f(x)\,dx$$

-  Una funzione che ammette una primitiva (e quindi infinite primitive) si dice **integrabile**

$$\mathrm{D} \left[ \int f(x) \,dx \right] = f(x)$$
 ![[Schema_Insieme_Primitive_Infinite]]


- Se una funzione è continua in un intervallo reale $I$, allora ammette primitive nello stesso intervallo.
 ![[Insieme_Derivate]]
___

# Metodi Di Risoluzione:
## Integrali immediati 

| **N** | **Integrali Immediati**                         | **Formula di risoluzione **                             |
| ----- | ----------------------------------------------- | ------------------------------------------------------- |
| 1     | $\int [f(x)]^n \cdot f'(x) \, dx$               | $\frac{[f(x)]^{n+1}}{n+1} + c$                          |
| 2     | $\int \dfrac{f'(x)}{f(x)}\,dx$                  | $\ln \mid f(x)\mid + c$                                 |
| 3     | $\int a^{f(x)} \cdot f'(x)\,dx$                 | $\dfrac{a^{f(x)}}{\ln a} + c$                           |
| 4     | $\int e^{f(x)} \cdot f'(x)\,dx$                 | $e^{f(x)} + c$                                          |
| 5     | $\int \sin[f(x)]\,\cdot f'(x)\,dx$              | $-\cos(f(x)) + c$                                       |
| 6     | $\int \cos[f(x)]\,\cdot f'(x)\,dx$              | $\sin(f(x)) + c$                                        |
| 7     | $\int \tan[f(x)] \cdot f'(x) \, dx$             | $-\ln \mid \cos[f(x)] \mid + c$                         |
| 8     | $\int \cot[f(x)] \cdot f'(x) \, dx$             | $\ln \mid \sin[f(x)]\mid + c$                           |
| 9     | $\int \dfrac{f'(x)}{\cos^2 [f(x)]}\,dx$         | $\tan(f(x)) + c$                                        |
| 10    | $\int \dfrac{f'(x)}{\sin^2 [f(x)]}\,dx$         | $-\cot(f(x)) + c$                                       |
| 11    | $\int \dfrac{f'(x)}{\sqrt{1 - [f(x)]^2}}\,dx$   | $\arcsin(f(x)) + c$                                     |
| 12    | $\int \dfrac{f'(x)}{1 + [f(x)]^2}\,dx$          | $\arctan(f(x)) + c$                                     |
| 13    | $\int \dfrac{f'(x)}{\sqrt{a^2 - [f(x)]^2}}\,dx$ | $\arcsin\left(\frac{f(x)}{\mid a \mid}\right) + c$      |
| 14    | $\int \dfrac{f'(x)}{a^2 + [f(x)]^2}\,dx$        | $\dfrac{1}{a}\arctan\!\left(\dfrac{f(x)}{a}\right) + c$ |

___

## Proprietà dell'Integrale Indefinito
### Prima proprietà di linearità
- L'integrale indefinito di una somma di funzioni integrabili è uguali alla somma degli integrali indefiniti delle singole funzioni:
$$
\int \left[ f(x) + g(x) \right] \,dx = \int f(x) \,dx + \int g(x) \,dx
$$

### Seconda proprietà di linearità
- L'integrale del prodotto di una costante per una funzione integrabile è uguale al prodotto della costante per l'integrale della funzione:
$$
\int k \cdot f(x) \,dx = k \cdot \int f(x) \,dx
$$

___
## Integrazione Per Sostituzione
Quando l'integrale non è di risoluzione immediata può essere utile applicare il **metodo di sostituzione,** che consiste nell'effettuare un cambiamento di variabile che consenta di riscrivere l'integrale dato di una forma che sappiamo risolvere

$$
\begin{gather*}
\int  f(x)\ dx = \int f \left[ g(t)\right]\cdot g'(t) \ dt \\ \\
\text{dove abbiamo posto} \\ \\
x = g(t) \\ \\ 
dx = g'(t) \ dt
\end{gather*}
$$

- **Esempio:**
Calcoliamo $\int \frac{1}{1 + \sqrt{x}} \ dx$ 

1) Poniamo  $\sqrt{x} = t$, ossia $x = t^2$
2) Calcoliamo il differenziale: $\mathrm{D} \left[x\right] = \mathrm{D}\left[t^2\right] \to dx = 2t \ dt$
3) Sostituiamo nell'integrale dato e calcoliamo l'integrale e rispetto a $t$.
	1) $\int \frac{1}{1+t} \cdot 2t\ dt$
	2) $2\int \frac{t}{1+t}\ dt$
	3) $2\int \frac{t+1-1}{1+t}\ dt$
	4) $2\int \left[ \frac{t+1}{1+t} \right] - \left[ \frac{1}{1+t} \right]\ dt$
	5) $2\int dt - 2\int \frac{1}{1+t}\ dt$
	6) $2t - 2\ln |t\ +1| + c$.
4) Sostituendo di nuovo $t = \sqrt{x},$  scriviamo il risultato in funzione di  $x:$
	1) $2\sqrt{x} - 2\ln |\sqrt{x}+1| + c$
	2) $2\sqrt{x} - 2\ln (\sqrt{x}+1) + c$


## Integrazione Per  Parti
- Date due funzioni $f(x)$ e $g(x)$ derivabili, con derivata continua, in un intervallo $I \subseteq R$, considerando la derivata del loro prodotto:
$$
\int  f(x) \cdot g'(x) \ dx = f(x) \cdot g(x) \ - \int f'(x) \cdot g(x) \ dx
$$
- **Dimostrazione:**
$$
\begin{gather*}
\mathrm{D} \left[ f(x) \cdot g(x) \,\right] = f'(x) \cdot g(x) + f(x) \cdot g'(x) \\ \\
\int \mathrm{D} \left[ f(x) \cdot g(x) \, \right] \ dx = \int \left[f'(x) \cdot g(x) + f(x) \cdot g'(x) \right] \ dx \\ \\
f(x) \cdot g(x) = \int f'(x) \cdot g(x) \ dx  + \int f(x) \cdot g'(x) \ dx
\end{gather*}
$$
## Aggiungo Tolgo

- **Esempio:**
Calcoliamo $\int \frac{x - 3}{x+4} \ dx$ 

Al numeratore **aggiungiamo** e **togliamo** 4
$$\int \frac{x-3+4-4}{x+4} \ dx$$
$$\int \frac{x+4}{x+4} - \frac{7}{x+4} \ dx$$
$$x - 7 \ln \mid x+4\mid+ \ c$$
## Integrazione di Funzioni Razionali Fratte
### $N$  di grado superiore $D$ 
$$
N(x) = Q(x)\ \cdot \ D(x)\ + \ R(x)
$$
$$
\frac{N(x)}{D(x)} = Q(x)\ + \ \frac{R(x)}{D(x)}
$$
$$
\int \frac{N(x)}{D(x)}dx= \int  \left[ Q(x)\ + \ \frac{R(x)}{D(x)} \right]dx = \int Q(x) dx \ + \ \int \frac{R(x)}{D(x)}dx
$$

Nell' addizione dei due integrali, il primo è calcolabile in quanto è l'integrale di  un **polinomio**; il secondo è l'integrale di una funzione razionale fratta con il **numeratore** di grado **inferiore** al grado del **denominatore**

- **Esempio:**
$$
\int \frac {x^3 + 2x^2 + x + 1} {x^2+1} dx
$$

![[Schema_Divisione_Polinomi|250]]

$$Q(x) = x + 2$$
$$R(x) = -1$$
$$
\int \left( x+2 + \frac {-1} {x^2+1} \right) dx\ = \ \int x\ dx \ + \ 2\int dx\ - \int\frac {-1} {x^2+1} dx\ = \ \frac{x^2}{2} +\ 2x\ +\ \arctan x \ +\ c
$$
### $N$  derivata del $D$
$$
\int \frac{6x-2}{3x^2-2x-1}dx\ =\ \ln \mid 3x^2-2x-1 \mid + \ x
$$

### $D$ è di primo grado
$$
	\int \frac {1}{3x-2}dx\ = \ \frac{1}{3}\int \frac{3}{3x-2}dx\ = \ \frac{1}{3} \ln \mid 3x-2 \mid + \ c
$$
### $D$ è di secondo grado
Per calcolare l'integrale 
$$
\int \frac{px + q} {ax^2+bx+c}dx \ \ \ \ \ \ con \ a \neq 0 \text{ e b, c non entrambi nulli}
$$
si utilizzano metodi **risolutivi** diversi a seconda del **segno** del discriminante del denominatore $\Delta = b^2-4ac$.

#### $\Delta > 0$
- Si scompone il **denominatore**: $ax^2+bx+c = a(x-x_1)(x-x_2)$
- Si scrive la frazione algebrica data com somma di frazioni algebriche con **denominatore** di primo grado:
$$
\frac{px+q}{ax^2+bx+c} = \frac{A}{a(x-x_1)} + \frac{B}{(x-x_2)} 
$$
- Si calcola la **somma** delle due frazioni al secondo membro;
- Si **determinano** i valori $A$ e $B$ risolvendo il **sistema** le cui equazioni si ottengono **uguagliando** fra loro i **coefficienti** della $x$ noti dei polinomi al numeratore dei due membri:
- Si **risolve** l'integrale
$$
\int \left[ \frac{A}{a(x-x_1)} + \frac{B}{(x-x_2)} \right]dx
$$
Questo metodo vale anche se il numeratore è di grado zero, ossia se $p = 0$.
#### $\Delta = 0$
- Si scompone il denominatore: $ax^2+bx+c = a(x-x_1)^2$. dove $x_1 = -\frac{b}{2a}$;
- Si scrive la frazione algebrica data come somma di due frazioni algebriche:
$$
\frac{px+q}{ax^2+bx+c} = \frac{A}{a(x-x_1)} + \frac{B}{(x-x_1)^2} 
$$
- Si calcola la **somma** delle due frazioni al secondo membro;
- Si **determinano** i valori $A$ e $B$ risolvendo il **sistema** le cui equazioni si ottengono **uguagliando** fra loro i **coefficienti** della $x$ noti dei polinomi al numeratore dei due membri:
- Si **risolve** l'integrale
$$
\int \left[ \frac{A}{a(x-x_1)} + \frac{B}{(x-x_1)^2}\right] dx
$$
#### $\Delta < 0$
##### $N$ di grado $0$
$$
\int \frac{1}{ax^2+bx+c}dx, \ \ \ \ con \ a \neq 0
$$
- Si scrive il **denominatore** nella forma $[f(x)]^2 +1$  con il metodo del **completamento del quadrato;**
- Si trasforma il **numeratore** in modo che diventi $f'(x)$;
- Si calcola l'integrale
$$
 \int \dfrac{f'(x)}{1 + [f(x)]^2}\,dx = \arctan(f(x)) + c
$$
##### $N$ è di primo grado
$$
\int \frac{px+q}{ax^2+bx+c}dx, \ \ \ \ con \ a \neq 0 \ e \ p\neq 0
$$
- Si opera del **numeratore** per farvi figurare la derivata del **denominatore**;
- Si scrive l'integrale come **somma di due integrali:**
$$
\int \frac{2ax+b}{ax^2+bx+c}dx \ + s \int \frac{1}{ax^2+bx+c}dx
$$
- Si calcola il primo integrale **ricordando** che $\int \frac{f'(x)} {f(x)} dx = \ln \mid f(x) \mid +\ c,$ quindi:
$$
\int \frac{2ax+b}{ax^2+bx+c}dx = \ln \mid ax^2+bx+c \mid + c_1
$$
- Si calcola il secondo integrale con  il **metodo già visto** ($\Delta < 0$ , $N$ di grado $0$)
- Si sommano i risultati ottenuti
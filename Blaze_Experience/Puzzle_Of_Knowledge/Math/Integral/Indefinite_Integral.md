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
| 1     | $\int k\,f(x)\,dx$                              | $k f(x) + c$                                            |
| 2     | $\int [f(x)]^n \cdot f'(x) \, dx$               | $\frac{[f(x)]^{n+1}}{n+1} + c$                          |
| 3     | $\int \dfrac{f'(x)}{f(x)}\,dx$                  | $\ln \|f(x)\| + c$                                      |
| 4     | $\int a^{f(x)} \cdot f'(x)\,dx$                 | $\dfrac{a^{f(x)}}{\ln a} + c$                           |
| 5     | $\int e^{f(x)} \cdot f'(x)\,dx$                 | $e^{f(x)} + c$                                          |
| 6     | $\int \sin[f(x)]\,\cdot f'(x)\,dx$              | $-\cos(f(x)) + c$                                       |
| 7     | $\int \cos[f(x)]\,\cdot f'(x)\,dx$              | $\sin(f(x)) + c$                                        |
| 8     | $\int \tan[f(x)] \cdot f'(x) \, dx$             | $-\ln\|\cos[f(x)]\| + c$                                |
| 9     | $\int \cot[f(x)] \cdot f'(x) \, dx$             | $\ln\|\sin[f(x)]\| + c$                                 |
| 10    | $\int \dfrac{f'(x)}{\cos^2 [f(x)]}\,dx$         | $\tan(f(x)) + c$                                        |
| 11    | $\int \dfrac{f'(x)}{\sin^2 [f(x)]}\,dx$         | $-\cot(f(x)) + c$                                       |
| 12    | $\int \dfrac{f'(x)}{\sqrt{1 - [f(x)]^2}}\,dx$   | $\arcsin(f(x)) + c$                                     |
| 13    | $\int \dfrac{f'(x)}{1 + [f(x)]^2}\,dx$          | $\arctan(f(x)) + c$                                     |
| 14    | $\int \dfrac{f'(x)}{\sqrt{a^2 - [f(x)]^2}}\,dx$ | $\arcsin\left(\frac{f(x)}{\|a\|}\right) + c$            |
| 15    | $\int \dfrac{f'(x)}{a^2 + [f(x)]^2}\,dx$        | $\dfrac{1}{a}\arctan\!\left(\dfrac{f(x)}{a}\right) + c$ |

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





$\mid 8 \mid$



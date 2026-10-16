Data: 2026-10-14
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___
# Ex per ripasso

# 1
Dimostarzione **Caratterizzazione di $\inf()$**
# 2
$-A := \{x \in \mathbb{R} \mid \exists y \in A \text{ per cui } y = -x\}$  caso in cui $A$ non è inferiormente limitato: dimostrare  $\sup(a) = +\infty \implies \inf(-a) = -\infty$
# 3
> [!NOTE]
> ### Esercizi 𝐴 =(1,2) ∪3
> 
> 1. $2$ è di accumulazione per $A$.
> 2. Ogni $x_0 \in (1,2)$ è di accumulazione per $A$.
> 3. $3$ **non** è di accumulazione per $A$.
> 4. Se $x > 2$ e $x \neq 3$, $x$ **non** è di accumulazione per $A$.
> 
> **Svolgimento del punto 3.** Sia $x_0 = 3$. Dobbiamo trovare $\bar\delta > 0$ tale che $$\big((3 - \bar\delta,\ 3 + \bar\delta) \cap A\big) \setminus {3} = \emptyset$$
> 
> Basta prendere $\bar\delta < 1$ (ad esempio $\bar\delta = \tfrac{1}{2}$): allora $3 - \bar\delta > 2$, quindi l'intervallo $(3-\bar\delta, 3+\bar\delta)$ non incontra $(1,2)$ e $$(3 - \bar\delta,\ 3 + \bar\delta) \cap A = {3}$$ Togliendo $3$ resta l'insieme vuoto, dunque $3$ non è di accumulazione per $A$.
> 
> **Conclusione.** L'insieme dei punti di accumulazione di $A$ è $[1, 2]$.
> 
> Il punto $3$ appartiene ad $A$ ma non è di accumulazione: è un **punto isolato** di $A$.
# 4
## Esercizio: Punti Di Accumulazione Degli Intervalli

Siano $a, b \in \mathbb{R}$ e $$I = (a,b), \qquad J = [a,b), \qquad K = (a,b], \qquad L = [a,b]$$

> [!note] Nota: Esercizio Provare che i punti di accumulazione di $I$, $J$, $K$, $L$ sono tutti e i soli punti di $[a,b]$.

# 5
Sia $A$  inferiormente limitato): è possibile che $-\infty$ sia di accumulazione per $A$? **

# 6
Esercizio Fare tutti i 9 casi della definizione di limite

| #   | Caso $(x_0, l)$                         | Esempio                                                |
| --- | --------------------------------------- | ------------------------------------------------------ |
| 1   | $x_0 \in \mathbb{R},\ l \in \mathbb{R}$ | $\lim_{x \to 2} (3x - 1) = 5$                          |
| 2   | $x_0 \in \mathbb{R},\ l = +\infty$      | $\lim_{x \to 0} \frac{1}{x^2} = +\infty$               |
| 3   | $x_0 \in \mathbb{R},\ l = -\infty$      | $\lim_{x \to 0} \left(-\frac{1}{x^2}\right) = -\infty$ |
| 4   | $x_0 = +\infty,\ l \in \mathbb{R}$      | $\lim_{x \to +\infty} \frac{1}{x} = 0$                 |
| 5   | $x_0 = +\infty,\ l = +\infty$           | $\lim_{x \to +\infty} x^2 = +\infty$                   |
| 6   | $x_0 = +\infty,\ l = -\infty$           | $\lim_{x \to +\infty} (-x) = -\infty$                  |
| 7   | $x_0 = -\infty,\ l \in \mathbb{R}$      | $\lim_{x \to -\infty} \frac{1}{x} = 0$                 |
| 8   | $x_0 = -\infty,\ l = +\infty$           | $\lim_{x \to -\infty} x^2 = +\infty$                   |
| 9   | $x_0 = -\infty,\ l = -\infty$           | $\lim_{x \to -\infty} x = -\infty$                     |
# 7

**2 è di accumulazione per $A = \mathbb{R} \setminus {-2} = (-\infty,-2) \cup (-2,+\infty)$?**

> [!note] Nota: Esercizi
> 
> - Mostrare che $\forall \delta > 0$ si ha $\big((2-\delta,, 2+\delta) \cap A\big) \setminus {2} \neq \emptyset$.
> - Mostrare che i punti di accumulazione per $A$ sono tutti i punti di $\mathbb{R}$.
# 8
$$\lim_{x \to +\infty} \frac{3x-1}{x+2} = 3$$

Da verificare: $-2$ e $+\infty$ sono punti di accumulazione.

 $x < -2$: caso da trattare (non svolto a lezione, non necessario dato che $x \to +\infty$).

# 9
$$\lim_{x \to \infty} \frac{-1}{e^{\frac{2}{x}}} = 0$$


Data: 2026-10-14
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___
# Ex per ripasso

1. Dimostarzione **Caratterizzazione di $\inf()$**
2. $-A := \{x \in \mathbb{R} \mid \exists y \in A \text{ per cui } y = -x\}$  caso in cui $A$ non è inferiormente limitato: dimostrare  $\sup(a) = +\infty \implies \inf(-a) = -\infty$

3. 
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

4.
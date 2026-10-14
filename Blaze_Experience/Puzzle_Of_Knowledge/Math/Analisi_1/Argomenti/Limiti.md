Data: 2026-10-14
[Argomenti](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1/Argomenti
___
# Index

- [[#Topologia euclidea della retta reale]]
	- [[#Intorni]]
	- [[#Punti Di Accumulazione]]
	- [[#4.3 Esempio: $A = (1, 2) \cup \{3\}$|4.3 Esempio: A = (1, 2) ∪ {3}]]
___

# Topologia euclidea della retta reale
## Intorni

> [!Abstract] Definizione: Intorno Circolare
> Sia:
>  $$x_0 \in \mathbb{R},  \quad  \delta > 0$$
> L'**intorno circolare** di centro $x_0$ e raggio $\delta$ è l'intervallo:
> $$D(x_0; \delta) := \{x \in \mathbb{R} \mid |x - x_0| < \delta\} = (x_0 - \delta,\ x_0 + \delta)$$
> > [!Abstract] Definizione: Intorno di $+ \infty$
> > Ogni intervallo del tipo: $$(a, +\infty) = \{x \in \mathbb{R} \mid x > a\} \quad a \in \mathbb{R}$$
> > >[!Info] Info: In Parole
> >> Tutti i numeri reali che si trovano oltre un certo **valore** $a$ verso **destra**, cioè tutti i numeri maggiori di $a$.
> 
> > [!Abstract] Definizione: Intorno di $- \infty$
> > Ogni intervallo del tipo: $$(- \infty, a) = \{x \in \mathbb{R} \mid x < a\} \quad a \in \mathbb{R}$$
> >  
> > >[!Info] Info: In Parole
> > >Tutti i numeri reali che si trovano oltre un certo **valore** $a$ verso **sinistra**, cioè tutti i numeri minori di $a$.
> 
> | Insieme        | $\sup$    | $\inf$    | max / min    |
> | -------------- | --------- | --------- | ------------ |
> | $(a, +\infty)$ | $+\infty$ | $a$       | non esistono |
> | $(-\infty, a)$ | $a$       | $-\infty$ | non esistono |
> 

> [!Abstract] Definizione: Retta Reale Estesa
> $$\widetilde{\mathbb{R}} = \mathbb{R} \cup {-\infty, +\infty}$$
>> [!Info] Info:
> > Quindi $x_0 \in \widetilde{\mathbb{R}}$ se e solo se:
> > 1. $x_0 \in \mathbb{R}$,
> > 2. $x_0 = +\infty$,
> > 3. $x_0 = -\infty$.

#### siamo arrivati fin qua
## Punti Di Accumulazione


> [!Abstract] Definizione: Punti Di Accumulazioni
> Sia:
> $$A \subseteq \mathbb{R} \quad A \neq \emptyset \quad  x_0 \in \mathbb{R}$$
> Si dice che $x_0$ è un **punto di accumulazione** per $A$ se e solo se:
> $$\forall \delta > 0 \quad \big(D(x_0; \delta) \cap A\big) \setminus {x_0} \neq \emptyset$$
> > [!Info] Info: In Parole
> > esistono punti di $A$, **diversi da $x_0$**, arbitrariamente vicini a $x_0$. 
> > ($x_0$ può anche non appartenere ad $A$)



> [!Example] Esempio: $A = (1,2) \cup {3}$ :Punti di accumulazione di $A$
> Contents


## 4.3 Esempio: $A = (1, 2) \cup \{3\}$

> [!Abstract] Esempio: Punti di accumulazione di $A$
> Quali sono i punti di accumulazione di $A = (1, 2) \cup \{3\}$?
> > [!Info] Info: Definizione
> > $x_0$ è di accumulazione per $A$ se e solo se
> > $$\forall\, \delta > 0 \quad \big(D(x_0; \delta) \cap A\big) \setminus \{x_0\} \neq \emptyset$$
>
> > [!Danger] Caso $x < 1$: non sono di accumulazione
> > > [!Success] Dimostrazione:
> > > Basta scegliere $\delta$ tale che $x + \delta < 1$, ad esempio:
> > > $$\delta = \frac{1 - x}{2}$$
> > > Allora:
> > > $$(x - \delta,\ x + \delta) \cap A = \emptyset$$
>
> > [!Success] Caso $x = 1$: è di accumulazione
> > Per ogni $\delta > 0$ si ha:
> > $$(1 - \delta,\ 1 + \delta) \cap A = \begin{cases} (1,\ 1 + \delta) & \text{se } 0 < \delta < 1 \\ (1,\ 2) & \text{se } 1 \le \delta \le 2 \\ (1, 2) \cup \{3\} = A & \text{se } \delta > 2 \end{cases}$$
> > In ogni caso l'insieme è $\neq \emptyset$, e non contiene $1$ (perché $1 \notin A$).
> > Quindi $1$ è di accumulazione per $A$, pur non appartenendo ad $A$.
>
> > [!Info] Esercizi
> > 1. $2$ è di accumulazione per $A$
> > 2. Ogni $x_0 \in (1, 2)$ è di accumulazione per $A$
> > 3. $3$ **non** è di accumulazione per $A$
> > 4. Se $x > 2$ e $x \neq 3$, $x$ **non** è di accumulazione per $A$
> >
> > > [!Success] Svolgimento del punto 3:
> > > Sia $x_0 = 3$. Dobbiamo trovare $\bar\delta > 0$ tale che:
> > > $$\big((3 - \bar\delta,\ 3 + \bar\delta) \cap A\big) \setminus \{3\} = \emptyset$$
> > > Basta prendere $\bar\delta < 1$, ad esempio $\bar\delta = \frac{1}{2}$. Allora $3 - \bar\delta > 2$, quindi l'intervallo non incontra $(1, 2)$:
> > > $$(3 - \bar\delta,\ 3 + \bar\delta) \cap A = \{3\}$$
> > > Togliendo $3$ resta l'insieme vuoto, dunque $3$ non è di accumulazione per $A$.
>
> > [!Info] Conclusione
> > L'insieme dei punti di accumulazione di $A$ è:
> > $$[1, 2]$$
> > Il punto $3$ appartiene ad $A$ ma non è di accumulazione: è un **punto isolato** di $A$.
> > I punti $1$ e $2$ sono di accumulazione ma non appartengono ad $A$.
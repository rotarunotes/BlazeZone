Data: 2026-10-14
[Argomenti](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1/Argomenti
___
# Index

- [[#Topologia euclidea della retta reale]]
	- [[#Intorni]]
	- [[#Punti Di Accumulazione]]
		- [[#$+\infty$ Come Punto Di Accumulazione|+∞ Come Punto Di Accumulazione]]
		- [[#$-\infty$ Come Punto Di Accumulazione|-∞ Come Punto Di Accumulazione]]
	- [[#Punti Isolati]]
- [[#Definizione di Limite]]
	- [[#Definizione di limite Caso: $l \in \mathbb{R}$, $x_0 \in \mathbb{R}$|Definizione di limite Caso: l ∈ ℝ, x₀ ∈ ℝ]]
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

## Punti Di Accumulazione


> [!Abstract] Definizione: Punti Di Accumulazioni
> Sia:
> $$A \subseteq \mathbb{R} \quad A \neq \emptyset \quad  x_0 \in \mathbb{R}$$
> Si dice che $x_0$ è un **punto di accumulazione** per $A$ se e solo se:
> $$\forall \delta > 0 \quad \big(D(x_0; \delta) \cap A\big) \setminus {x_0} \neq \emptyset$$
> $$D(x_0; \delta)= (x_0 - \delta,\, x_0 + \delta)$$
> > [!Info] Info: In Parole
> > esistono punti di $A$, **diversi da $x_0$**, arbitrariamente vicini a $x_0$ di una distanza $\delta$. 
> > ($x_0$ può anche non appartenere ad $A$)
> 
> > [!Example] Esempio: Punti di accumulazione di $A = (1,2) \cup {3}$
> > $1$ è punto di accumulazione di $A$?
> > 
> > > [!Success] Dimostrazione: Caso $x < 1$:
> > >  Basta scegliere $\delta$ tale che $x + \delta < 1$, ad esempio:
> > > $$\delta = \frac{1 - x}{2}$$
> > > Allora:
> > > $$(x - \delta,\ x + \delta) \cap A = \emptyset$$
> > 
> > 
> > > [!success] Dimostrazione: Caso $x = 1$:
> >  Per ogni $\delta > 0$ si ha:
> > > $$(1 - \delta,\ 1 + \delta) \cap A = \begin{cases} (1,\ 1 + \delta) & \text{se } 0 < \delta < 1 \\ (1,\ 2) & \text{se } 1 \le \delta \le 2 \\ (1, 2) \cup \{3\} = A & \text{se } \delta > 2 \end{cases}$$
> > > In ogni caso l'insieme è $\neq \emptyset$, e non contiene $1$ (perché $1 \notin A$).
> > > Quindi $1$ è di accumulazione per $A$, pur non appartenendo ad $A$.
### $+\infty$ Come Punto Di Accumulazione


> [!Abstract] Definizione: $+\infty$ Come Punto Di Accumulazione
> $+\infty$ è di accumulazione per: 
> $$A \subseteq \mathbb{R}, \quad A \neq \emptyset$$ 
> se e solo se ogni intorno di $+\infty$ contiene punti di $A$.
> $$\forall b \in \mathbb{R} \ \text{ si ha che } \ A \cap (b, +\infty) \neq \emptyset$$

> [!Info] Info: Sia $A$ superiormente limitato
> È possibile che $+\infty$ sia di accumulazione per $A$? **NO**.
> > [!Success] Dimostrazione:
> > - $A$ superiormente limitato $\Rightarrow$ $A$ ammette maggiorante
> > - sia $\Lambda$ un maggiorante di $A$, cioè $\Lambda \in \mathbb{R}$, $a \le \Lambda \quad \forall a \in A$
> > - si pone $b = \Lambda+1$
> > Allora: 
> > $$A \subset (-\infty, \Lambda] \qquad A \cap (\Lambda+1, +\infty) = \emptyset$$
> 
### $-\infty$ Come Punto Di Accumulazione

> [!Abstract] Definizione: $-\infty$ Come Punto Di Accumulazione
> $-\infty$ è di accumulazione per: 
> $$A \subseteq \mathbb{R}, \quad A \neq \emptyset$$ 
> se e solo se ogni intorno di $-\infty$ contiene punti di $A$.
> $$\forall b \in \mathbb{R} \ \text{ si ha che } \ A \cap (-\infty, b) \neq \emptyset$$
## Punti Isolati

> [!Abstract] Definizione: Punto Isolato
>  Punto Isolato: 
>  $$x_0 \in \mathbb{R}$$ 
>  È **isolato** dell'insieme: 
>  $$A \subseteq \mathbb{R},\quad A \neq \emptyset$$ 
>  se e solo se $x_0$ **non** è di accumulazione per $A$.

___
# Definizione di Limite

> [!abstract] Definizione: Limite
> Sia $$f: A \subseteq \mathbb{R} \to \mathbb{R}, \quad A \neq \emptyset$$
>  Sia $x_0 \in \widetilde{\mathbb{R}}$ un punto di accumulazione per il dominio di $f$ ($A$). 
>  Diremo che $f$ **ammette limite** $l \in \widetilde{\mathbb{R}}$ per $x$ che tende a $x_0$ $$[\lim_{x\to x_0} f(x) = l]$$ se e solo se per ogni intorno $V_l$ di $l$ esiste un intorno $U_{x_0}$ di $x_0$ tale che $$f(x) \in V_l \qquad \forall x \in (U_{x_0} \cap A) \setminus {x_0}$$
> 
> > [!danger] Attenzione! 
> > $U_{x_0}$ dipende da $V_l$.
>
> > [!Info] Info: $\pm\infty$
> >  Se $x_0 \in {+\infty, -\infty}$ l'ultima intersezione è da leggere come: $$(U_{x_0} \cap A)$$
> >  Perché $\pm\infty$ non sono in $\mathbb{R}$.

## Definizione di limite Caso: $l \in \mathbb{R}$, $x_0 \in \mathbb{R}$

Siano $l \in \mathbb{R}$, $x_0 \in \mathbb{R}$.
$$V_l = (l-\varepsilon, l+\varepsilon) \quad \forall \varepsilon > 0 \qquad [V_l = \text{intorno di } l]$$
$$U_{x_0} = (x_0 - \delta, x_0 + \delta) \quad \forall \delta > 0 \quad \qquad [U_{x_0} = \text{intorno di } x_0]$$

> [!info] Info: Scelta degli intorni
> - $\varepsilon$  permette di scegliere arbitrariamente un punto nell'intorno di $l$.
> - $\delta$ dipende da $V_l$, cioè dipende da $\varepsilon$: si scrive $\delta_\varepsilon$:
> $$U_{x_0} = (x_0 - \delta_\varepsilon, x_0 + \delta_\varepsilon) \quad \forall \delta_\varepsilon > 0 \quad \qquad [U_{x_0} = \text{intorno di } x_0]$$

La definizione diventa: 
$$\forall \varepsilon > 0 \quad \exists \delta_\varepsilon > 0 \ \Big| \ |f(x) - l| < \varepsilon \quad \forall x \in A \ \Big| \ 0 < |x - x_0| < \delta_\varepsilon$$

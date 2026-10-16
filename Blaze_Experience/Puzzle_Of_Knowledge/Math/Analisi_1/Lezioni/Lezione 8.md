Data: 2026-10-15 [Lezioni](https://claude.ai/chat/README.md) #Puzzle_Of_Knowledge/Math/Analisi_1/Lezioni

---

# Index

- [[#Analisi – Lezione 8]]
    - [[#Esercizio: Punti Di Accumulazione Degli Intervalli]]
    - [[#Punto Isolato]]
    - [[#$+\infty$ Come Punto Di Accumulazione]]
    - [[#$-\infty$ Come Punto Di Accumulazione]]
    - [[#Osservazione: Insieme Superiormente Limitato]]
    - [[#Definizione Di Limite]]
    - [[#Esempio: Caso $l \in \mathbb{R}$, $x_0 \in \mathbb{R}$]]
    - [[#Esempio a)]]
    - [[#Esempio b)]]
    - [[#Limite Con La Definizione: $\lim_{x\to -1} \frac{-2}{(x+1)^2}$|Limite Con La Definizione: lim x→-1 di -2/(x+1)²]]

---

# Analisi – Lezione 8

Data: 15/10/26

---

## Esercizio: Punti Di Accumulazione Degli Intervalli

Siano $a, b \in \mathbb{R}$ e $$I = (a,b), \qquad J = [a,b), \qquad K = (a,b], \qquad L = [a,b]$$

> [!note] Nota: Esercizio Provare che i punti di accumulazione di $I$, $J$, $K$, $L$ sono tutti e i soli punti di $[a,b]$.

---

## Punto Isolato

> [!abstract] Definizione: Punto Isolato $x_0 \in \mathbb{R}$ è **isolato** dell'insieme $A \subseteq \mathbb{R}$, $A \neq \emptyset$ se e solo se $x_0$ **non** è di accumulazione per $A$.

---

## $+\infty$ Come Punto Di Accumulazione

> [!abstract] Definizione: $+\infty$ Di Accumulazione $+\infty$ è di accumulazione per $A \subseteq \mathbb{R}$, $A \neq \emptyset$ se e solo se ogni intorno di $+\infty$ contiene punti di $A$. $$\Longleftrightarrow \quad \forall b \in \mathbb{R} \ \text{ si ha che } \ A \cap (b, +\infty) \neq \emptyset$$

---

## $-\infty$ Come Punto Di Accumulazione

> [!abstract] Definizione: $-\infty$ Di Accumulazione $-\infty$ è di accumulazione per $A \subseteq \mathbb{R}$, $A \neq \emptyset$ se e solo se ogni intorno di $-\infty$ contiene punti di $A$. $$\Longleftrightarrow \quad \forall b \in \mathbb{R} \ \text{ si ha che } \ A \cap (-\infty, b) \neq \emptyset$$

---

## Osservazione: Insieme Superiormente Limitato

Sia $A$ superiormente limitato (oppure inferiormente limitato): è possibile che $+\infty$ sia di accumulazione per $A$? **NO**.

> [!note] Nota: Esercizio Eseguire il caso di $A$ inferiormente limitato (e di $-\infty$) come esercizio.

Infatti:

- $A$ superiormente limitato $\Rightarrow$ $A$ ammette maggiorante
- sia $l$ un maggiorante di $A$, cioè $l \in \mathbb{R}$, $a \le l \quad \forall a \in A$
- si pone $b = l+1$

Allora: $$A \subset (-\infty, l] \qquad A \cap (l+1, +\infty) = \emptyset$$

---

## Definizione Di Limite

> [!abstract] Definizione: Limite Sia $f: A \subseteq \mathbb{R} \to \mathbb{R}$, $A \neq \emptyset$. Sia $x_0 \in \widetilde{\mathbb{R}}$ un punto di accumulazione per il dominio di $f$ ($A$). Diremo che $f$ **ammette limite** $l \in \widetilde{\mathbb{R}}$ per $x$ che tende a $x_0$ [scriveremo $\displaystyle\lim_{x\to x_0} f(x) = l$] se e solo se per ogni intorno $V_l$ di $l$ esiste un intorno $U_{x_0}$ di $x_0$ tale che $$f(x) \in V_l \qquad \forall x \in (U_{x_0} \cap A) \setminus {x_0}$$
> 
> > [!danger] Attenzione! $U_{x_0}$ dipende da $V_l$. N.B. Se $x_0 \in {+\infty, -\infty}$ l'ultima intersezione è da leggere come $(U_{x_0} \cap A)$, perché $\pm\infty$ non sono in $\mathbb{R}$.

---

## Esempio: Caso $l \in \mathbb{R}$, $x_0 \in \mathbb{R}$

Siano $l \in \mathbb{R}$, $x_0 \in \mathbb{R}$.

$$V_l = (l-\varepsilon,, l+\varepsilon) \quad \forall \varepsilon > 0 \qquad [V_l = \text{intorno di } l]$$ $$U_{x_0} = (x_0 - \delta,, x_0 + \delta) \quad \forall \delta > 0$$

> [!info] Info: Scelta degli intorni
> 
> - Permette di scegliere arbitrariamente un punto nell'intorno di $l$.
> - $\delta$ dipende da $V_l$, cioè dipende da $\varepsilon$: si scrive $\delta_\varepsilon$.

La definizione diventa: $$\forall \varepsilon > 0 \quad \exists \delta_\varepsilon > 0 \ \mid \ |f(x) - l| < \varepsilon \quad \forall x \in A \ \mid \ 0 < |x - x_0| < \delta_\varepsilon$$

> [!info] Info: Valore assoluto $|x| \neq 0$ ; $|x| = 0 \iff x = 0$. Per questo $0 < |x-x_0|$ equivale a $x \neq x_0$.

> [!note] Nota: Esercizio Fare tutti i 9 casi della definizione di limite.

---

## Esempio a)

$$\exists ? \ \lim_{x \to +\infty} \frac{2x-1}{\sqrt{x+2}}$$

con $f(x) = 2x-1$ (numeratore) e $g(x) = \sqrt{x+2}$ (denominatore).

$$D = (D_f \cap D_g) \setminus Z_g$$

**Calcolo del dominio**: $$\begin{cases} x \in \mathbb{R} \ x+2 \neq 0 \ x+2 \ge 0 \end{cases} \quad \Longrightarrow \quad x > -2$$

$D = (-2, +\infty)$, quindi $-\infty$ **non** è di accumulazione per $D$ ($(-2,+\infty)$ è inferiormente limitato).

---

## Esempio b)

$$\lim_{x \to 2} \frac{2x-1}{x+2} \overset{?}{=} \frac{3}{4}$$

con $f(x) = 2x-1$ e $g(x) = x+2$.

$$D = (D_f \cap D_g) \setminus Z_g$$ $$\begin{cases} x \in \mathbb{R} \ x \in \mathbb{R} \ x+2 \neq 0 \end{cases} \quad \longrightarrow \quad \boxed{x \neq -2}$$

> [!note] Nota: Da rifare Rifare bene tutto l'esercizio.

**2 è di accumulazione per $A = \mathbb{R} \setminus {-2} = (-\infty,-2) \cup (-2,+\infty)$?**

> [!note] Nota: Esercizi
> 
> - Mostrare che $\forall \delta > 0$ si ha $\big((2-\delta,, 2+\delta) \cap A\big) \setminus {2} \neq \emptyset$.
> - Mostrare che i punti di accumulazione per $A$ sono tutti i punti di $\mathbb{R}$.

**Verifica della definizione di limite** — devo studiare: $$\forall \varepsilon > 0 \quad \exists \delta_\varepsilon > 0 \ \mid \ \left|f(x) - \frac{3}{4}\right| < \varepsilon \quad \forall x \in A, \ x \in (2-\delta_\varepsilon,, 2+\delta_\varepsilon) \setminus {2}$$

Ossia, per $\varepsilon > 0$: $$\left|\frac{2x-1}{x+2} - \frac{3}{4}\right| < \varepsilon \iff \underbrace{\frac{3}{4} - \varepsilon < \frac{2x-1}{x+2}}_{\text{I}} \ \land \ \underbrace{\frac{2x-1}{x+2} < \frac{3}{4} + \varepsilon}_{\text{II}}$$

### Risolvo (I)

$$\frac{3}{4} - \varepsilon < \frac{2x-1}{x+2} \iff 3 - 4\varepsilon < \frac{4(2x-1)}{x+2}$$

**Se $x > -2$**: $$(3-4\varepsilon)(x+2) < 8x-4 \iff 3x - 4\varepsilon x + 6 - 8\varepsilon < 8x - 4$$ $$\iff 10 - 8\varepsilon < 5x + 4\varepsilon x = x(5+4\varepsilon) \iff x > \frac{10-8\varepsilon}{5+4\varepsilon} \quad (\text{per } x > -2)$$

**Se $x < -2$** (il verso si inverte): $$(3-4\varepsilon)(x+2) > 8x-4 \iff 3x-4\varepsilon x + 6 - 8\varepsilon > 8x-4 \iff 10 - 8\varepsilon > x(5+4\varepsilon) \iff x < \frac{10-8\varepsilon}{5+4\varepsilon}$$

Quindi per (I):

$$(\alpha) \begin{cases} x > -2 \ x > \dfrac{10-8\varepsilon}{5+4\varepsilon} \end{cases}$$

Se $\dfrac{10-8\varepsilon}{5+4\varepsilon} \le -2 \iff 10 - 8\varepsilon \le -10 - 8\varepsilon$: **falso**. Quindi $\dfrac{10-8\varepsilon}{5+4\varepsilon} > -2 \Longrightarrow (\alpha)$ ha soluzioni $\forall \varepsilon > 0$.

$$(\beta) \begin{cases} x < -2 \ x < \dfrac{10-8\varepsilon}{5+4\varepsilon} \end{cases}$$

> [!note] Nota: Da fare Risolvere $(\beta)$. Notare che $(\beta)$ non può contenere intorni di $2$.

In ogni caso $(\alpha) \cup (\beta) \supseteq (-2,+\infty)$ $\forall \varepsilon > 0$.

### Risolvo (II) ($\varepsilon > 0$)

$$\frac{2x-1}{x+2} < \frac{3}{4} + \varepsilon \iff \frac{8x-4}{x+2} < 3 + 4\varepsilon$$

$$(\alpha) \begin{cases} x > -2 \ 8x-4 < (x+2)(3+4\varepsilon) \end{cases} \qquad (\beta) \begin{cases} x < -2 \ 8x-4 > (x+2)(3+4\varepsilon) \end{cases}$$

**Risolvo $\alpha$**: $$\begin{cases} x > -2 \ 8x - 4 < 3x + 6 + 4\varepsilon x + 8\varepsilon \end{cases} \iff \begin{cases} x > -2 \ (5-4\varepsilon),x < 10 + 8\varepsilon \end{cases}$$

- Se $\varepsilon = \dfrac{5}{4}$: $0 < 10 + 8 \cdot \dfrac{5}{4}$, **OK**.
- Se $\varepsilon \in \left(0, \dfrac{5}{4}\right)$: $\varepsilon < \dfrac{5}{4} \iff 4\varepsilon < 5 \iff 5 - 4\varepsilon > 0$. Quindi: $$x < \frac{10+8\varepsilon}{5-4\varepsilon}$$ Notare che $2 < \dfrac{10+8\varepsilon}{5-4\varepsilon}$ perché $10 - 8\varepsilon < 10 + 8\varepsilon$.
- Se $\varepsilon > \dfrac{5}{4}$: $5 - 4\varepsilon < 0 \Rightarrow x > \dfrac{10+8\varepsilon}{5-4\varepsilon}$ cioè $x > -\dfrac{10+8\varepsilon}{4\varepsilon-5}$, che è (quindi $2 > -\dfrac{10+8\varepsilon}{4\varepsilon-5}$).

**Risolvo $\beta$**: da fare.

---

## Limite Con La Definizione: $\lim_{x\to -1} \frac{-2}{(x+1)^2}$

**1)** $$\lim_{x \to -1} \frac{-2}{(x+1)^2} \qquad f(x) = \frac{-2}{(x+1)^2}$$

**Dominio**: $D_f: (x+1)^2 \neq 0 \to x \neq -1$ $$D_f = (-\infty, -1) \cup (-1, +\infty)$$

**$x_0 = -1$ è di accumulazione per $D_f$?** Sia $\delta > 0$: $(-1-\delta, -1+\delta)$. $$D \cap (-1-\delta, -1+\delta) \setminus D_f = (-1-\delta,-1) \cup (-1, -1+\delta) \neq \emptyset \ ; \ \neq {-1} \quad \forall \delta > 0$$ $\Rightarrow$ $x_0 = -1$ è di accumulazione per $D_f$.

**Prova che** $$\lim_{x \to -1} \frac{-2}{(x+1)^2} = -\infty \overset{\text{definizione}}{\iff} \forall k \in \mathbb{R} \ \ \exists \delta_k > 0 \ \mid \ \frac{-2}{(x+1)^2} < k \quad \forall x \in \big(D \cap (-1-\delta_k, -1+\delta_k) \cap D_f\big) \setminus {-1}$$

Sia $k \in \mathbb{R}$; sia $x \neq -1$: $$\frac{-2}{(x+1)^2} < k \iff \begin{cases} -2 < k(x+1)^2 \ x \neq -1 \end{cases}$$

- **Se $k = 0$**: è vero $\forall x \in \mathbb{R} \setminus {-1}$. Ogni $\delta_k > 0$ va bene.
- **Sia $k \neq 0$**: quanto sopra è equivalente a

$$\text{(A)} \begin{cases} -\dfrac{2}{k} < (x+1)^2 \ k > 0 \ x \neq -1 \end{cases} \qquad \text{oppure} \qquad \text{(B)} \begin{cases} -\dfrac{2}{k} > (x+1)^2 \ k < 0 \ x \neq -1 \end{cases}$$

**Soluzioni A**: Si ha che $-\dfrac{2}{k} < 0 \le (x+1)^2 \quad \forall x \neq -1, \ \forall k > 0$. $\Rightarrow$ le soluzioni di A sono $x \in \mathbb{R} \setminus {-1}$ $\Rightarrow$ per $k > 0$ ogni $\delta_k > 0$ va bene.

**Soluzioni B**: da fare.

---
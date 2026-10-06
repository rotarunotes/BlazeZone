## Enunciato

Sia $A \subseteq \mathbb{R}$, $A \neq \emptyset$, superiormente limitato.

$$ x = \sup(A) ;\Longleftrightarrow; \begin{cases} x \ge a \quad \forall a \in A \ \forall \varepsilon > 0\ \ \exists, \bar a \in A \mid \bar a > x - \varepsilon \end{cases} $$

**Notazione:** $M_A$ = insieme dei maggioranti di $A$, cioè $\alpha \in M_A \iff \alpha \ge a ;; \forall a \in A$ (definizione).

Quindi $x = \sup A$ significa $x = \min(M_A)$.

---

## $(\Rightarrow)$

**Ipotesi:** $A$ superiormente limitato, $x = \sup A \in \mathbb{R}$.

**Tesi:**

1. $x \ge a ;; \forall a \in A$
2. $\forall \varepsilon > 0 ;; \exists, \bar a \in A \mid \bar a > x - \varepsilon$

**Dimostrazione:**

- **Tesi 1.** Poiché $x = \min(M_A)$, si ha $x \in M_A$, quindi $x \ge a ;; \forall a \in A$. ✔
- **Tesi 2.** Sia $\varepsilon > 0$. Dato che $x = \min(M_A)$ e $x - \varepsilon < x$, si ha $x - \varepsilon \notin M_A$. Per definizione, $\alpha \notin M_A$ significa che la proposizione "$\alpha \ge a ;; \forall a \in A$" è **falsa**, cioè:

$$ \exists, \bar a \in A \mid \alpha < \bar a $$

Con $\alpha = x - \varepsilon$ si ottiene:

$$ \exists, \bar a \in A \mid x - \varepsilon < \bar a \qquad ✔ $$

---

## $(\Leftarrow)$

**Ipotesi:**

1. $A$ superiormente limitato
2. $x \ge a ;; \forall a \in A$
3. $\forall \varepsilon > 0 ;; \exists, \bar a \in A \mid \bar a > x - \varepsilon$

**Tesi:** $x = \sup A$, cioè $x = \min(M_A)$.

**Dimostrazione:**

- L'ipotesi 2 significa che $x \in M_A$.
- L'ipotesi 3 significa che $x - \varepsilon \notin M_A ;; \forall \varepsilon > 0$.
- Dalla 3 segue che

$$ \min(M_A) > x - \varepsilon \qquad \forall \varepsilon > 0 \qquad (*) $$

- Sia $y = \min(M_A)$. Per assurdo suppongo $y < x$: allora esiste $\tilde\varepsilon > 0$ tale che $y \le x - \tilde\varepsilon$, che **contraddice $(*)$**.
- Pertanto $y \ge x$. D'altra parte $x \in M_A$ e $y$ è il minimo dei maggioranti, quindi $y \le x$.
- Allora $y = x$, cioè $x = \min(M_A) = \sup(A)$. $\blacksquare$
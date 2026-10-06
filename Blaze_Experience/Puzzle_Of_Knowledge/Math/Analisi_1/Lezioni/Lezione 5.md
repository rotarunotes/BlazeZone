# Analisi – Lezione 5

**Argomenti:** caratterizzazione di estremo superiore/inferiore · disuguaglianza di Bernoulli · binomio di Newton · esercizi su induzione, inclusioni di insiemi e insieme opposto $-A$

---

## 1. Caratterizzazione di sup e inf

### Teorema

Sia $A \neq \emptyset$, $A \subseteq \mathbb{R}$. Allora:

**a)** Se $A$ è **superiormente limitato**:

$$ x = \sup A \iff \begin{cases} x \ge a \quad \forall a \in A \ \forall \varepsilon > 0 ;; \exists \bar a \in A ;:; \bar a > x - \varepsilon \end{cases} $$

_(Figura: sulla retta, $A$ è un intervallo; $x=\sup A$ è l'estremo destro; $x-\varepsilon$ è un punto a sinistra di $x$ e in $A$ c'è un $\bar a$ che lo supera.)_

**b)** Se $A$ è **inferiormente limitato**:

$$ x = \inf A \iff \begin{cases} x \le a \quad \forall a \in A \ \forall \varepsilon > 0 ;; \exists \bar a \in A ;:; \bar a < x + \varepsilon \end{cases} $$

_(Figure: analoghe a quelle di a), con $x=\inf A$ estremo sinistro e il punto $x+\varepsilon$ a destra di $x$; $\bar a$ cade tra $x$ e $x+\varepsilon$.)_

---

### Dimostrazione di a)

Notazione: $M_A$ = insieme dei maggioranti di $A$, cioè $\alpha \in M_A \iff \alpha \ge a ;; \forall a \in A$ (definizione).

#### ($\Rightarrow$)

_Ipotesi:_ $A$ superiormente limitato, $x = \sup A \in \mathbb{R}$.

- Allora $x \in M_A$, quindi $x \ge a ;; \forall a \in A$. ✔ (prima condizione)
- Sia $\varepsilon > 0$. Dato che $x = \min(M_A)$, si ha $x - \varepsilon < x$, quindi $x - \varepsilon \notin M_A$.
- Per definizione, $\alpha \notin M_A$ significa che la proposizione "$\alpha \ge a ;; \forall a \in A$" è **falsa**, cioè:

$$ \exists \bar a \in A ;:; \alpha < \bar a $$

- Quindi, essendo $x - \varepsilon \notin M_A$, posso scrivere:

$$ \exists \bar a \in A ;:; x - \varepsilon < \bar a \qquad ✔ \text{ (seconda condizione)} $$

#### ($\Leftarrow$)

_Ipotesi:_

1. $A$ superiormente limitato
2. $x \ge a ;; \forall a \in A$
3. $\forall \varepsilon > 0 ;; \exists \bar a \in A ;:; \bar a > x - \varepsilon$

_Tesi:_ $x = \sup A$.

- La 2) significa che $x \in M_A$.
- La 3) significa che $x - \varepsilon \notin M_A ;; \forall \varepsilon > 0$.
- Dalla 3) segue che

$$ \min(M_A) > x - \varepsilon \qquad \forall \varepsilon > 0 \qquad (*) $$

- Sia $y = \min(M_A)$. Se potessi avere $y < x$, allora esisterebbe $\tilde\varepsilon > 0$ tale che $y \le x - \tilde\varepsilon$ → **contraddice $(*)$**.
- Pertanto $y = \min(M_A) \ge x$.
- Allora $x = \min(M_A)$, ossia $x = \sup(A)$. $\blacksquare$

> 📝 **Dimostrazione di b) da svolgere con l'insieme inferiormente limitato** (esercizio, procedimento analogo con i minoranti).

---

## 2. Disuguaglianza di Bernoulli (principio di induzione)

### Teorema

Sia $x \in \mathbb{R}$, $x > -1$. Allora

$$ (1+x)^n \ge 1 + nx \qquad \forall n \in \mathbb{N} \qquad (\circledast) $$

### Dimostrazione per induzione

**Passo base** ($n = 0$): $(1+x)^0 = 1 \ge 1 + 0\cdot x = 1$. ✔ Passo base verificato.

**Passo induttivo**

- _Ipotesi induttiva:_ $(1+x)^n \ge 1 + nx$
- _Tesi induttiva:_ $(1+x)^{n+1} \ge 1 + (n+1)x$

$$ (1+x)^{n+1} = (1+x)^n,(1+x) ;\ge; (1+nx)(1+x) $$

(si può moltiplicare la disuguaglianza per $(1+x)$ perché $1 + x > 0$)

$$ (1+nx)(1+x) = 1 + nx + x + \underbrace{nx^2}_{\ge 0} ;\ge; 1 + (n+1)x $$

Quindi il passo induttivo è verificato e, per il principio di induzione,

$$ (1+x)^n \ge 1 + nx \qquad \forall x > -1,;; \forall n \in \mathbb{N}. \qquad \blacksquare $$

---

## 3. Binomio di Newton

$\forall n \in \mathbb{N}$, $n \ge 1$, $\forall a, b \in \mathbb{R}$ si ha che

$$ (a+b)^n = \sum_{k=0}^{n} \binom{n}{k} a^k \cdot b^{n-k} $$

---

## 4. Esercizi

### Esercizio 1 – Provare che $n! > 2^n$ per ogni $n \ge 4$

**Passo base** ($n = 4$): $4! = 4\cdot 3\cdot 2\cdot 1 = 24$, $\quad 2^4 = 16$ $;\Rightarrow; 24 > 16$. ✔

**Passo induttivo:** sia $n! > 2^n$; allora $(n+1)! > 2^{n+1}$.

Ricordando che $(n+1)! = (n+1),n!$:

$$ (n+1),n! ;>; 2^n,(n+1) ;\ge; 2\cdot 2^n = 2^{n+1} $$

(l'ultimo passaggio vale perché $n \ge 4 \Rightarrow n+1 \ge 5 \ge 2$).

Il passo induttivo è verificato; per il principio di induzione $n! > 2^n ;; \forall n \ge 4$. $\blacksquare$

---

### Esercizio 2 – Provare che $n! \ge n^2 ;; \forall n \ge 4$

**Passo base** ($n = 4$): $4! = 24 \ge 4^2 = 16$. ✔

**Passo induttivo:** sia $n! \ge n^2$; allora $(n+1)! \ge (n+1)^2$.

Si ha $(n+1)! = (n+1)\cdot n!$, quindi

$$ (n+1),n! ;\ge; (n+1),n^2 ;\ge; (n+1)(n+1) = (n+1)^2 $$

dove l'ultimo passaggio usa il seguente **lemma**:

#### Lemma: $n^2 \ge n + 1 ;; \forall n \ge 2$

- **Base** ($n = 2$): $4 \ge 3$. ✔
- **Passo induttivo:** se $n^2 \ge n+1$, allora $(n+1)^2 \ge n + 2$:

$$ (n+1)^2 = n^2 + 2n + 1 ;\overset{\text{ip. ind.}}{\ge}; n + 1 + 2n + 1 = 3n + 2 ;\ge; n + 2 $$

L'ultima disuguaglianza equivale a $3n \ge n$, vera $\forall n \ge 0$.

Il lemma è vero per induzione, e quindi lo è anche l'esercizio. $\blacksquare$

---

### Esercizio 3 – Inclusioni e estremi

Siano $A \subseteq B \subseteq \mathbb{R}$.

1. È vero che $\sup A \in B$?
2. Mostrare che $\inf A \ge \inf B$ e $\sup A \le \sup B$.

**Svolgimento**

**1) La prima parte è falsa.** Controesempi:

- $A = \mathbb{N}$, $B = \mathbb{Z}$
- oppure $A = (1,2)$, $B = (0,1] \cup (1,2)$ (qui $\sup A = 2 \notin B$)

**2) $\inf A \ge \inf B$.**

- **Caso 1:** $A$ non inferiormente limitato ($\inf A = -\infty$) $\Rightarrow$ $B$ non è inferiormente limitato $\Rightarrow$ $\inf B = -\infty$.
- **Caso 2:** $A$ inferiormente limitato $\Rightarrow$ $\exists, \lambda_A \in \mathbb{R}$ tale che $\lambda_A = \inf A$.
    - Se $B$ **non** è inferiormente limitato: $\inf B = -\infty \le \lambda_A$ (ovvio).
    - Se $B$ è inferiormente limitato: $\exists, \lambda_B \in \mathbb{R}$ tale che $\lambda_B = \inf B$. Quindi (essendo $\lambda_B$ un minorante di $B$):

$$ \lambda_B \le b ;; \forall b \in B ;\Rightarrow; \lambda_B \le a ;; \forall a \in A \subseteq B $$

$$ \Rightarrow; \lambda_B \in m_A ;\Rightarrow; \lambda_B \le \lambda_A $$

perché $\lambda_A$ è il **massimo** di $m_A$ (insieme dei minoranti di $A$).

**$\sup A \le \sup B$:** 📝 _dimostrazione da fare a casa._

---

### Esercizio 4 – L'insieme opposto $-A$

Sia $A \subseteq \mathbb{R}$, $A \neq \emptyset$, e

$$ -A := {, x \in \mathbb{R} ;|; \exists, y \in A \text{ per cui } y = -x ,} $$

**Provare che:**

$$ \inf(-A) = -\sup A \qquad\qquad \sup(-A) = -\inf A $$

**Svolgimento** (dimostrazione di $\sup(-A) = -\inf A$)

**1) Caso: $A$ non inferiormente limitato**, cioè $\forall k \in \mathbb{R} ;; \exists a \in A ;:; a < k$.

Allora $-A$ **non è superiormente limitato.**

_Se per assurdo lo fosse:_ $\exists H \in \mathbb{R}$ per cui $b \le H ;; \forall b \in -A$. Ma $b \in -A \iff b = -a$ per qualche $a \in A$; quindi

$$ -a \le H ;\Rightarrow; a \ge -H \quad \forall a \in A $$

$\Rightarrow$ $A$ inferiormente limitato: **contraddizione!**

Quindi $-A$ non è superiormente limitato. Abbiamo mostrato che:

- $\inf A = -\infty ;\Rightarrow; \sup(-A) = +\infty$
- $\sup A = +\infty ;\Rightarrow; \inf(-A) = -\infty$ _(da fare a casa)_

**2) Caso: $A$ inferiormente limitato**, cioè $\exists, \lambda_A \in \mathbb{R}$ con $\lambda_A = \inf A$.

Per definizione: $\lambda_A \le a ;; \forall a \in A$, quindi

$$ -\lambda_A \ge -a \quad \forall a \in A $$

$\Rightarrow$ $-\lambda_A$ è un **maggiorante** di $-A$.

Siccome $\sup(-A) = \min M_{(-A)}$, si ha

$$ \sup(-A) \le -\lambda_A $$

_(L'appunto si interrompe qui: per concludere resta da provare la disuguaglianza opposta, $\sup(-A) \ge -\lambda_A$.)_
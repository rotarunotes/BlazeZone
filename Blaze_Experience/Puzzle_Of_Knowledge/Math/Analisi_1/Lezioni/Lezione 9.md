Data: 2026-10-16 [Lezioni](https://claude.ai/chat/README.md) #Puzzle_Of_Knowledge/Math/Analisi_1/Lezioni

---

# Index

- [[#Analisi – Lezione 9]]
    - [[#Completamento Limite 1: $\lim_{x \to -1} \frac{-2}{(x+1)^2} = -\infty$|Completamento Limite 1]]
    - [[#Limite 2: $\lim_{x \to +\infty} \frac{3x-1}{x+2} = 3$|Limite 2]]
    - [[#Limite 3: $\lim_{x \to \infty} \frac{-1}{e^{\frac{2}{x}}} = 0$|Limite 3]]
- [[#Composizione Di Applicazioni]]
    - [[#Definizione Di Applicazione Composta]]
    - [[#Esempi Di Composizione]]
    - [[#Non Commutatività Della Composizione]]
    - [[#Applicazione Identità]]
    - [[#Applicazione Inversa]]

---

# Analisi – Lezione 9

## Completamento Limite 1: $\lim_{x \to -1} \frac{-2}{(x+1)^2} = -\infty$

> [!abstract] Definizione: Enunciato, Limite Uguale A $-\infty$
> 
> |Parte|Contenuto|
> |---|---|
> |**Contesto**|$f(x) = \dfrac{-2}{(x+1)^2}$, $x_0 = -1$|
> |**Ipotesi**|Definizione di limite uguale a $-\infty$|
> |**Tesi**|$\displaystyle\lim_{x \to -1} \frac{-2}{(x+1)^2} = -\infty$|
> 
> $$\lim_{x \to -1} \frac{-2}{(x+1)^2} = -\infty \overset{\text{def}}{\iff} \forall k \in \mathbb{R} \ \ \exists \delta_k > 0 \mid \frac{-2}{(x+1)^2} < k \quad \forall x \in \big(D(-1,\delta_k) \cap D_f\big) \setminus {-1}$$

**1. Si fissa $k$ e si riscrive la disuguaglianza**: sia $k \in \mathbb{R}$, sia $x \neq -1$. $$\frac{-2}{(x+1)^2} < k \iff \begin{cases} -2 < k,(x+1)^2 \ x \neq -1 \end{cases}$$

**2. Caso $k = 0$**:

Se $k = 0$ è vero $\forall x \in \mathbb{R} \setminus {-1}$.

> [!info] Info: In Parole Per $k = 0$ la disuguaglianza $-2 < 0$ è sempre vera, quindi ogni $\delta_k > 0$ va bene.

**3. Caso $k \neq 0$**: la disuguaglianza è equivalente a due sistemi, a seconda del segno di $k$:

$$\text{(A)} \begin{cases} -\dfrac{2}{k} < (x+1)^2 \ k > 0 \ x \neq -1 \end{cases} \qquad\qquad \text{oppure} \qquad\qquad \text{(B)} \begin{cases} -\dfrac{2}{k} > (x+1)^2 \ k < 0 \ x \neq -1 \end{cases}$$

### Soluzioni A ($k > 0$)

Si ha che $-\dfrac{2}{k} < 0 \le (x+1)^2 \quad \forall x \neq -1,\ \forall k > 0$.

> [!success] Dimostrazione: Soluzioni di A Le soluzioni di A sono $x \in \mathbb{R} \setminus {-1}$. Quindi per $k > 0$ ogni $\delta_k > 0$ va bene.

### Soluzioni B ($k < 0$)

Si ha che $-\dfrac{2}{k} > 0 \quad (k < 0)$.

$$(x+1)^2 < -\frac{2}{k} \implies |x+1| < \sqrt{-\frac{2}{k}} \implies -\sqrt{-\frac{2}{k}} < x+1 < \sqrt{-\frac{2}{k}}$$ $$\implies -1 - \sqrt{-\frac{2}{k}} < x < -1 + \underbrace{\sqrt{-\frac{2}{k}}}_{=,\delta_k}$$

> [!info] Info: Proprietà del valore assoluto usata $|a| < \alpha \iff -\alpha < a < \alpha$

Per tanto, per $k < 0$: $\delta_k = \sqrt{-\dfrac{2}{k}}$.

### Conclusione

> [!success] Dimostrazione: Conclusione Abbiamo quindi verificato che: $$\forall k \in \mathbb{R} \quad \exists \delta_k = \begin{cases} \sqrt{-\dfrac{2}{k}} & \text{se } k < 0 \[2mm] \text{ogni reale} > 0 & \text{se } k \ge 0 \end{cases}$$ ossia per definizione: $$\lim_{x \to -1} \frac{-2}{(x+1)^2} = -\infty \qquad \blacksquare$$

---

# Lezione 9 — 16/10/26

## Limite 2: $\lim_{x \to +\infty} \frac{3x-1}{x+2} = 3$

> [!example] Esempio: $f(x) = \dfrac{3x-1}{x+2}$ $$\lim_{x \to +\infty} \frac{3x-1}{x+2}$$

### Dominio e punto di accumulazione

**1. Dominio di $f$**: $$D_f: \ x + 2 \neq 0 \iff x \neq -2$$ $$\implies D_f = \mathbb{R} \setminus {-2} = (-\infty, -2) \cup (-2, +\infty)$$

**2. $+\infty$ è di accumulazione per $D_f$?**

Devo verificare che $\forall k \in \mathbb{R}$ si abbia che: $$(k, +\infty) \cap D_f \neq \emptyset$$

Osserviamo che:

- se $k > -2$ $\implies$ $(k, +\infty) \cap D_f = (k, +\infty) \neq \emptyset$
- se $k \le -2$ $\implies$ $(k, +\infty) \cap D_f = (k, -2) \cup (-2, +\infty) \neq \emptyset$

$\implies$ $+\infty$ è di accumulazione per $D_f$.

> [!danger] Attenzione! Da verificare: $-2$ e $+\infty$ sono punti di accumulazione.

### Verifica del limite

> [!abstract] Definizione: Enunciato, Limite Finito Per $x \to +\infty$
> 
> |Parte|Contenuto|
> |---|---|
> |**Contesto**|$f(x) = \dfrac{3x-1}{x+2}$, $\ell = 3$|
> |**Ipotesi**|$+\infty$ è di accumulazione per $D_f$|
> |**Tesi**|$\displaystyle\frac{3x-1}{x+2} \xrightarrow{x \to +\infty} 3$|
> 
> $$\forall \varepsilon > 0 \ \ \exists k_\varepsilon \in \mathbb{R} \mid \left|\frac{3x-1}{x+2} - 3\right| < \varepsilon \quad \forall x \in D(+\infty, k_\varepsilon) \cap D_f$$

> [!info] Info: Definizione usata $|f(x) - \ell| < \varepsilon$

**1. Si riscrive la disuguaglianza** (con $x \neq -2$): $$\left|\frac{3x-1}{x+2} - 3\right| < \varepsilon \iff -\varepsilon < \frac{3x-1}{x+2} - 3 < \varepsilon \iff 3 - \varepsilon < \frac{3x-1}{x+2} < 3 + \varepsilon$$

**2. Si sceglie $x > -2$**: moltiplicando per $x+2 > 0$: $$(3-\varepsilon)(x+2) < 3x - 1 < (3+\varepsilon)(x+2)$$ $$(3-\varepsilon),x + 6 - 2\varepsilon < 3x - 1 < (3+\varepsilon),x + 6 + 2\varepsilon$$

**3. Sistema**: $$\begin{cases} 3x - \varepsilon x + 6 - 2\varepsilon < 3x - 1 \ 3x - 1 < 3x + \varepsilon x + 6 + 2\varepsilon \end{cases} \qquad \begin{cases} \varepsilon x > 7 - 2\varepsilon \ \varepsilon x > -7 - 2\varepsilon \end{cases}$$

**4. Sia $\varepsilon > 0$**: si divide per $\varepsilon$: $$\begin{cases} x > \dfrac{7 - 2\varepsilon}{\varepsilon} = -2 + \dfrac{7}{\varepsilon} \[2mm] x > \dfrac{-7 - 2\varepsilon}{\varepsilon} = -2 - \dfrac{7}{\varepsilon} \end{cases}$$

$$\iff x \in (-2, +\infty) \cap \left(-2 + \frac{7}{\varepsilon}, +\infty\right) = \left(-2 + \frac{7}{\varepsilon}, +\infty\right) \implies k_\varepsilon = -2 + \frac{7}{\varepsilon} \ \text{ va bene}$$

> [!danger] Attenzione! Sia $x < -2$: caso da trattare (non svolto a lezione, non necessario dato che $x \to +\infty$).

### Conclusione

> [!success] Dimostrazione: Conclusione Pertanto: $$\forall \varepsilon > 0 \ \ \exists k_\varepsilon \in \mathbb{R} \mid \left|\frac{3x-1}{x+2} - 3\right| < \varepsilon \quad \text{per ogni } x \in (k_\varepsilon, +\infty)$$ ossia: $$\lim_{x \to +\infty} \frac{3x-1}{x+2} = 3 \qquad \blacksquare$$

---

## Limite 3: $\lim_{x \to \infty} \frac{-1}{e^{\frac{2}{x}}} = 0$

> [!example] Esempio: Limite Da Verificare $$\lim_{x \to \infty} \frac{-1}{e^{\frac{2}{x}}} = 0$$

---

# Composizione Di Applicazioni

## Definizione Di Applicazione Composta

> [!abstract] Definizione: Applicazione Composta $A, B, C, D \neq \emptyset$ $$\varphi : A \to B, \qquad \psi : C \to D$$ tali che $$\mathrm{Im}(\varphi) \subseteq C = D(\psi)$$ Si definisce **applicazione composta** $\psi \circ \varphi$ ("$\psi$ composto $\varphi$"): $$\psi \circ \varphi : A \to D, \qquad a \longmapsto \psi(\varphi(a))$$
> 
> > [!info] Info: In Parole L'immagine interna ($\varphi$) deve essere contenuta nel dominio della funzione esterna ($\psi$). $$A \xrightarrow{\ \varphi\ } \underbrace{\mathrm{Im}(\varphi)}_{\subseteq B} \subseteq \underbrace{\mathrm{Dom}(\psi)}_{= C} \xrightarrow{\ \psi\ } D$$ $$a \longmapsto \varphi(a) \longmapsto \psi(\varphi(a))$$

---

## Esempi Di Composizione

> [!example] Esempio: $f$ e $g$ su $\mathbb{R}$ $$f : \mathbb{R} \to \mathbb{R}, \ x \mapsto x^2 \qquad\qquad g : \mathbb{R} \to \mathbb{R}, \ x \mapsto x+1$$
> 
> **$g \circ f$**: $$(g \circ f)(x) = g(f(x)) : \mathbb{R} \to \mathbb{R}$$ $$x \longmapsto (g \circ f)(x) = g(f(x)) = x^2 + 1$$ $$x \overset{f}{\longmapsto} f(x) = x^2 \overset{g}{\longmapsto} g(x^2) = x^2 + 1$$
> 
> **$f \circ g$**: $$(f \circ g)(x) = f(g(x)) : \mathbb{R} \to \mathbb{R}$$ $$x \in D(g) = \mathbb{R} \longmapsto g(x) = x + 1 \longmapsto f(x+1) = (x+1)^2$$
> 
> $$\exists x \in \mathbb{R} \mid x^2 + 1 \neq (x+1)^2$$

## Non Commutatività Della Composizione

> [!danger] Attenzione! Non È Valida La Proprietà Commutativa Sulla Composizione Posto che $f, g$ siano entrambe definibili, non è detto che: $$f \circ g = g \circ f$$

> [!example] Esempio: $g \circ f$ Non Esiste $$f : \mathbb{N} \to \mathbb{Q}, \ n \mapsto \frac{n}{2} \qquad\qquad g : \mathbb{N} \to \mathbb{R}, \ n \mapsto n^2$$ $$\mathrm{Cod}(g) = \mathbb{R}, \qquad \mathrm{Im}(g) \subseteq \mathbb{N} = \mathrm{Dom}(f)$$
> 
> **$f \circ g$** esiste: $$(f \circ g)(n) = f(g(n)) = f(n^2) = \frac{n^2}{2}$$
> 
> **$g \circ f$**: $$n \longmapsto \frac{n}{2} \longmapsto \left(\frac{n}{2}\right)^2$$
> 
> > [!danger] Attenzione! **Falso**, perché $\dfrac{n}{2} \in \mathbb{N} \iff n$ è pari.
> 
> Quindi $g \circ f$ **non esiste**, perché non è vero che $\mathrm{Im}(f) \subseteq \mathrm{Dom}(g)$.

---

## Applicazione Identità

> [!abstract] Definizione: Applicazione Identità $A$ insieme, $A \neq \emptyset$ $$\mathrm{id}_A : A \to A, \qquad a \mapsto a$$ $$\text{Per } A = \mathbb{R}: \quad \mathcal{G}(\mathrm{id}_{\mathbb{R}}) = {(a, a) \mid a \in \mathbb{R}} \qquad f(x) = x$$

Sia $\varphi : A \to B$ e $\mathrm{id}_A : A \to A$, con $\mathrm{Im}(\mathrm{id}_A) = A = \mathrm{Dom}(\varphi)$.

**1. Composizione a destra**: $$(\varphi \circ \mathrm{id}_A) : A \longrightarrow B, \qquad a \longmapsto \varphi(\mathrm{id}_A(a)) = \varphi(a)$$ $$\varphi \circ \mathrm{id}_A = \varphi$$

> [!info] Info: Elemento Neutro A Destra $\mathrm{id}_A$ è **elemento neutro a destra** per la composizione.

**2. Composizione a sinistra**:

$$A \xrightarrow{\ \varphi\ } B, \qquad a \longmapsto \varphi(a) \in \mathrm{Im}(\varphi) =: \varphi(A)$$ $$\mathrm{id}_{\varphi(A)} \circ \varphi = \varphi$$

$$A \xrightarrow{\ \varphi\ } \varphi(A) \xrightarrow{\ \mathrm{id}_{\varphi(A)}\ } \varphi(A) \subseteq B$$ $$a \longmapsto \varphi(a) \longmapsto \varphi(a)$$

> [!info] Info: Elemento Neutro A Sinistra $\mathrm{id}_{\varphi(A)}$ è **elemento neutro a sinistra** per la composizione: $$\mathrm{id}_{\varphi(A)} \circ \varphi = \varphi$$

---

## Applicazione Inversa

> [!example] Esempio: Perché Serve L'Iniettività $f(x) = x^2$, con $A \ni -1, 1$ e $B \ni 1$. $f(-1) = f(1) = 1$: volendo definire un'applicazione $f^{-1}$ che torni indietro, $1$ avrebbe due controimmagini ($-1$ e $1$). Ma in questo caso non si può, perché $f^{-1}({1})$ contiene due elementi.

> [!abstract] Definizione: Applicazione Inversa $A, B \neq \emptyset$, $\varphi : A \to B$ **iniettiva**. Si dice **applicazione inversa** di $\varphi$ (notazione $\varphi^{-1}$) l'applicazione: $$\psi : \mathrm{Im}(\varphi) \to A$$ $$b \longmapsto a := \psi(b) \ \text{ t.c. } \ a \text{ è l'unico elemento di } A \text{ per cui } \varphi(a) = b$$

> [!danger] Attenzione! Nota Su Dominio E Codominio $$\mathrm{Cod}(\varphi^{-1}) = \mathrm{Dom}(\varphi)$$ $$B \to A \qquad\qquad A \to B$$

> [!success] Dimostrazione: $\varphi^{-1} \circ \varphi = \mathrm{id}_A$ $$A \xrightarrow{\ \varphi\ } \mathrm{Im}(\varphi) \xrightarrow{\ \psi = \varphi^{-1}\ } A$$ $$\varphi^{-1} \circ \varphi : \ a \longmapsto \varphi(a) =: b \longmapsto \varphi^{-1}(\varphi(a)) = a$$ dove $a$ è l'unico elemento di $A$ t.c. $\varphi(a) = b$.
> 
> $$(\varphi^{-1} \circ \varphi) : A \to A, \ a \mapsto a \ \implies \ \varphi^{-1} \circ \varphi = \mathrm{id}_A \qquad \blacksquare$$

---
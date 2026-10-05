# Analisi – Appunti

## Proprietà della parte intera

$$\forall x \in \mathbb{R}\ \ \exists!, n \in \mathbb{Z} \ \mid\ n \le x < n+1$$

**Nota:** $n$ è detto _parte intera_ di $x$.

### Funzione floor

$$n = \lfloor x \rfloor$$

- $\lfloor x \rfloor = 0$ per ogni $x$ con $0 \le x < 1$
- $\lfloor x \rfloor = -1$ per $-1 \le x < 0$ (es. $-1 \le -0{,}5 < 0$)
- Esempi: $\lfloor 0{,}5 \rfloor = 0$ _(sul manoscritto sembra scritto 1, ma dal grafico dovrebbe essere 0)_, $\lfloor 2{,}5 \rfloor = 2$

Grafico: gradini a tratto orizzontale. Nel grafico, il **punto pieno** indica estremo _compreso_, la **parentesi** indica estremo _escluso_.

### Funzione ceil

$$\lceil x \rceil$$

- Esempi: $\lceil 0 \rceil = 0$, $\lceil \tfrac{3}{2} \rceil = 2$

La relazione $\lceil x \rceil = \lfloor x \rfloor + 1$ è **falsa** $\forall x \in \mathbb{Z}$.

È **vero** che se $x \in \mathbb{R} \setminus \mathbb{Z}$ allora $\lceil x \rceil = \lfloor x \rfloor + 1$.

---

## Proposizione

$$\sqrt{2} \in \mathbb{R} \setminus \mathbb{Q}$$

### Dimostrazione (idea)

$$A = {x \in \mathbb{R} \mid x^2 > 2} \qquad B = {x \in \mathbb{R} \mid x^2 < 2} \qquad (x^2 = 2)$$

Si verifica che i due insiemi sono _separati_:

$$\exists \lambda \in \mathbb{R}\ :\ b \le \lambda \le a \quad \forall a \in A,\ \forall b \in B$$

Perché fa vedere che $\lambda^2 = 2$.

---

## Lezione 4

## Teorema (densità di $\mathbb{Q}$ in $\mathbb{R}$)

$$\forall x \in \mathbb{R}\ \text{e}\ \forall \varepsilon > 0,\ \text{esiste } z \in \mathbb{Q} \ \mid\ z \le x < z + \varepsilon$$

(Schema: sulla retta $z \le x < z+\varepsilon$; esempio $\varepsilon = \tfrac{1}{10}$.)

### Dimostrazione

Sia $x \in \mathbb{R}$, $\varepsilon > 0$. Allora $\dfrac{1}{\varepsilon} > 0$.

→ Uso la **proprietà di Archimede**:

$$\exists q \in \mathbb{N} \ \mid\ q > \frac{1}{\varepsilon} > 0$$

Considero $qx \in \mathbb{R}$.

→ Per la proprietà della parte intera:

$$\exists p \in \mathbb{Z} \ \mid\ p \le qx < p + 1$$

Divido per $q > 0$:

$$\frac{p}{q} \le x < \frac{p+1}{q} = \frac{p}{q} + \frac{1}{q}$$

Ma $q > \dfrac{1}{\varepsilon} \Rightarrow \varepsilon q > 1 \Rightarrow \boxed{\varepsilon > \dfrac{1}{q}}$

Ne segue che

$$\frac{p}{q} \le x < \frac{p}{q} + \varepsilon$$

dove $z = \dfrac{p}{q} \in \mathbb{Q}$. $\qquad\blacksquare$

---

## Teorema



---

## Intervalli di $\mathbb{R}$

$$(a,b) = {x \in \mathbb{R} \mid a < x < b}$$ $$[a,b) = {x \in \mathbb{R} \mid a \le x < b}$$ $$(a,b] = {x \in \mathbb{R} \mid a < x \le b}$$

**Intervallo (proprietà):** $A \subseteq \mathbb{R}$, $A \ne \emptyset$ si dice _intervallo_ se e solo se $\forall x_1, x_2 \in A,\ x_1 < x_2$ si ha che ${x \in \mathbb{R} : x_1 < x < x_2} \subset A$.

### Esempio

$A = (0,1) \cup \left\{2\right\}$

Siano $x_1 = \tfrac{1}{2} \in A$, $x_2 = 2 \in A$, con $x_1 < x_2$.

Se $A$ fosse un intervallo $\Rightarrow \left(\tfrac{1}{2}, 2\right) \subset A$.

Però $\tfrac{3}{2} \in \left(\tfrac{1}{2}, 2\right)$ e $\tfrac{3}{2} \notin A$.

→ Quindi $A$ **non è** un intervallo.

---

## Definizione

$A \subseteq \mathbb{R}$, $A \ne \emptyset$

1. Diremo che $x \in \mathbb{R}$ è **maggiorante** di $A$ se e solo se $a \le x\ \ \forall a \in A$.
2. Diremo che $x \in \mathbb{R}$ è **minorante** di $A$ se e solo se $a \ge x\ \ \forall a \in A$.

## Definizione

$A \subseteq \mathbb{R}$, $A \ne \emptyset$

- Diremo che $A$ è **inferiormente (superiormente) limitato** se e solo se esistono minoranti (maggioranti) di $A$. (Esempio: $A = (0,1) \cup {2}$)
- Diciamo $A$ **limitato** se e solo se $A$ è sia inferiormente che superiormente limitato.

## Proprietà degli insiemi limitati

$A \subseteq \mathbb{R}$, $A \ne \emptyset$

1. Sia $A$ inferiormente limitato. Allora $B \subseteq A$ è inferiormente limitato.
    
    **Dimostrazione.** $A$ inf. limitato $\Rightarrow \exists x \le b\ \ \forall b \in B \subseteq A$. Infatti $x \le a\ \ \forall a \in A \Rightarrow x \le b\ \ \forall b \in B \subseteq A$ $\Rightarrow x$ è minorante di $B \Rightarrow B$ è inf. limitato.
    
2. $A$ superiormente limitato. Allora $B \subseteq A$ è superiormente limitato.
    

---

## Proprietà

- $\mathbb{N}$: $0 \le n\ \ \forall n \in \mathbb{N} \Rightarrow 0$ è minorante $\Rightarrow$ $\mathbb{N}$ è inf. limitato.
    
- $\mathbb{N}$ è sup. limitato? **Falso.** Se fosse vero, $\mathbb{N}$ ammetterebbe maggioranti $\Rightarrow \exists x \in \mathbb{R} \mid n \le x\ \ \forall n \in \mathbb{N}$ (contro Archimede).
    
- $\mathbb{Z}$ sup. limitato? No. Se $\mathbb{Z}$ fosse sup. limitato $\Rightarrow \mathbb{N} \subseteq \mathbb{Z}$ sarebbe sup. limitato (assurdo).
    
- $\mathbb{Z}$ inf. limitato? No.
    
    Suppongo che $\mathbb{Z}$ sia inf. limitato $\Rightarrow \exists b \in \mathbb{R} \mid b \le z,\ \forall z \in \mathbb{Z}$ $\Rightarrow b < 0$ (perché $-1 \in \mathbb{Z}$, $b \le -1 < 0$, $-b > 0$) $\Rightarrow -b \ge (-1)z = -z\ \ \forall z \in \mathbb{Z}$ $\Rightarrow -b \ge -z = w\ \ \forall w \in \mathbb{Z}$ $\Rightarrow \mathbb{Z}$ superiormente limitato. **Falso!** Per contraddizione.
    
- $\mathbb{Q}$: né inf. né sup. limitato.
    
- $\mathbb{R}$: né inf. né sup. limitato.
    

---

## Definizione (massimo e minimo)

$A \subseteq \mathbb{R}$, $A \ne \emptyset$

Diremo che $A$ **ammette massimo (minimo)** se e solo se esiste $x_0 \in A \mid x_0 \ge a$ per ogni $a \in A$ ($x_0 \le a$). $x_0$ è maggiorante (minorante) nell'insieme.

### Esempio

$A = (0,1]$

- $M_A := {x \in \mathbb{R} \mid x \text{ maggiorante di } A} = {x \in \mathbb{R} \mid x \ge 1}$
- $1 = \max A$ (infatti $1 \in M_A$, $1 \in A$)
- $m_A = {x \in \mathbb{R} \mid x \text{ minorante di } A} = {x \in \mathbb{R} \mid x \le 0}$
- $\nexists, \min A$
- $0 = \max(m_A)$

---

## Teorema

$A \subseteq \mathbb{R}$, $A \ne \emptyset$. Allora:

- a) se $A$ è sup. limitato $\Rightarrow M_A$ ammette minimo
- b) se $A$ è inf. limitato $\Rightarrow m_A$ ammette massimo

_Dim. [non serve]_

## Definizioni

$A \subseteq \mathbb{R}$, $A \ne \emptyset$

1. Se $A$ è inf. limitato chiamiamo **estremo inferiore** di $A$ ($\inf(A)$) il $\max(m_A)$.
2. Se $A$ è sup. limitato chiamiamo **estremo superiore** di $A$ ($\sup(A)$) il $\min(M_A)$.
3. Se $A$ non è sup. limitato scriviamo che $\sup(A) = +\infty$. _(Nota: $+\infty \notin A$)_
4. Se $A$ non è inf. limitato scriviamo che $\inf(A) = -\infty$. _(Nota: $-\infty \notin A$)_

## Teorema (assioma di completezza)

$A \subset \mathbb{R}$, $A \ne \emptyset$

- a) se $A$ è sup. limitato $\Rightarrow M_A$ ammette minimo
- b) se $A$ è inf. limitato $\Rightarrow m_A$ ammette massimo

## Osservazione

- a) Se $\sup(A) \in A \Rightarrow \sup(A) = \max(A)$
- b) Se $\inf(A) \in A \Rightarrow \inf(A) = \min(A)$

---

## Teorema (caratterizzazione di sup e inf)

$A \ne \emptyset$, $A \subseteq \mathbb{R}$. Allora:

**a)** Se $A$ è sup. limitato allora

$$x = \sup A \iff \begin{cases} x \ge a \quad \forall a \in A \[4pt] \forall \varepsilon > 0\ \ \exists, \bar a \in A \mid \bar a > x - \varepsilon \end{cases}$$

(Schema: sulla retta $\bar a$ cade tra $x-\varepsilon$ e $x = \sup A$.)

**b)** Se $A$ è inf. limitato allora

$$x = \inf(A) \iff \begin{cases} x \le a \quad \forall a \in A \[4pt] \forall \varepsilon > 0\ \ \exists, \bar a \in A \mid \bar a < x + \varepsilon \end{cases}$$

(Schema: sulla retta $\bar a$ cade tra $x = \inf(A)$ e $x+\varepsilon$.)
# Appunti di Analisi: estremi di insiemi, applicazioni

---

## 1. Esercizio: estremi di $-A$

> _Da rivedere a casa_

Sia $A \subseteq \mathbb{R}$, $A \neq \emptyset$. Definiamo

$$-A := {x \in \mathbb{R} \mid \exists, y \in A \text{ per cui } y = -x}$$

**Provare che:**

$$\inf(-A) = -\sup A \qquad\qquad \sup(-A) = -\inf A$$

### Svolgimento

#### Caso 1: $A$ non inferiormente limitato

Supponiamo che $A$ **non** sia inferiormente limitato, ossia $\forall k \in \mathbb{R}\ \exists a \in A \mid a < k$.

- Allora $-A$ **non** è superiormente limitato.
- Per assurdo, supponiamo che lo sia: $\exists H \in \mathbb{R}$ tale che $b \le H\ \ \forall b \in -A$.
- Ma $b \in -A \iff b = -a$ per qualche $a \in A$, quindi $$-a \le H \implies a \ge -H \quad \forall a \in A$$ cioè $-H$ è un minorante di $A$.
- Quindi $A$ è inferiormente limitato: **contraddizione!**
- Dunque $-A$ non è superiormente limitato.

Abbiamo mostrato che:

- $\inf A = -\infty \implies \sup(-A) = +\infty$
- $\sup A = +\infty \implies \inf(-A) = -\infty$ _(esercizio: stessa dimostrazione, con i versi delle disuguaglianze scambiati)_

In entrambi i casi la formula $\sup(-A) = -\inf A$ (risp. $\inf(-A) = -\sup A$) vale con la convenzione $-(\pm\infty) = \mp\infty$.

#### Caso 2: $A$ inferiormente limitato

Sia ora $A$ inferiormente limitato, ossia $\exists, x_A \in \mathbb{R} \mid x_A = \inf A$.

Per definizione di estremo inferiore:

$$x_A \le a \quad \forall a \in A$$

$$\implies -x_A \ge -a \quad \forall a \in A$$

$\implies -x_A$ è un **maggiorante** di $-A$ (cioè $-x_A \in M_{-A}$, l'insieme dei maggioranti di $-A$).

Poiché il $\sup$ è il **minimo dei maggioranti**:

$$\boxed{\sup(-A) = \min M_{-A} \le -x_A}$$

**Mostriamo che vale l'uguaglianza.** Per assurdo, supponiamo che

$$\lambda_{(-A)} = \sup(-A) < -x_A$$

Allora

$$-a \le \lambda_{(-A)} < -x_A \quad \forall a \in A$$

$$\implies a \ge -\lambda_{(-A)} > x_A \quad \forall a \in A$$

- Quindi $-\lambda_{(-A)}$ è un **minorante** di $A$;
- ed è **più grande** di $x_A = \inf A$.

Questo è in contraddizione con il fatto che $x_A = \inf A = \max m_A$ (l'estremo inferiore è il **massimo dei minoranti**).

Quindi vale l'uguaglianza:

$$\sup(-A) = -\inf A$$

#### Conclusione

$$\sup(-A) = -(\inf A)$$

La seconda formula segue applicando la prima all'insieme $B = -A$ (osservando che $-(-A) = A$):

$$\sup A = \sup(-B) = -\inf B = -\inf(-A) \implies \inf(-A) = -(\sup A)$$

---

## 2. Esercizio: confronto tra $\sup A$ e $\inf B$

Siano $A, B \subseteq \mathbb{R}$, $A, B \neq \emptyset$, tali che

$$a \le b \quad \forall a \in A,\ \forall b \in B$$

**Caso:** $A$ superiormente limitato, $B$ inferiormente limitato. _(Osservazione: in realtà queste ipotesi sono automatiche, perché ogni $b\in B$ maggiora $A$ e ogni $a \in A$ minora $B$.)_

**Allora:** $\sup(A) \le \inf(B)$.

### Svolgimento

- Sia $b \in B$. Allora $b \ge a\ \ \forall a \in A \implies b \in M_A$ (maggioranti di $A$).
- Quindi $B \subseteq M_A$, e dunque $$b \ge \min(M_A) = \sup(A) \quad \forall b \in B$$
- Quindi $\sup(A) \in m_B$ (cioè $\sup A$ è un minorante di $B$).
- Poiché $\inf B$ è il massimo dei minoranti di $B$: $$\sup(A) \le \max(m_B) = \inf(B) \qquad \blacksquare$$

### Esempi

|Caso|$A$|$B$|Risultato|
|---|---|---|---|
|Vale "$<$"|$A = (-2,-1)$|$B = (0,1)$|$\sup A = -1 < 0 = \inf B$|
|Vale "$=$"|$A = (-1,0)$|$B = (0,1)$|$\sup A = 0 = \inf B$|

La disuguaglianza stretta in generale **non** vale: da $a \le b$ si ottiene solo $\sup A \le \inf B$.

---

## 3. Applicazioni (funzioni)

### Definizione insiemistica

Siano $A, B$ insiemi.

$$A \times B = {(a,b) : a \in A,\ b \in B}$$

Diciamo **applicazione** un sottoinsieme $\Phi \subseteq A \times B$ tale che

$$\forall (a_1, b_1), (a_2, b_2) \in \Phi \text{ si ha che: se } a_1 = a_2 \implies b_1 = b_2$$

(in più, perché sia un'applicazione da $A$ in $B$, ogni $a \in A$ deve comparire in qualche coppia di $\Phi$).

Graficamente: un sottoinsieme del piano è il grafico di un'applicazione se ogni retta verticale lo interseca **al più** (qui: **esattamente**) in un punto.

- Una curva "a serpentina" che torna indietro **non** è un'applicazione.
- Una circonferenza **non** è un'applicazione (rette verticali la intersecano in due punti $b_1, b_2$).

### Definizione operativa

Siano $A, B$ insiemi. Diciamo **applicazione** una legge che associa ad ogni elemento di $A$ **un unico** elemento di $B$.

- ✅ Più elementi di $A$ possono avere la stessa immagine (es. $a_1, a_2 \mapsto b_2$).
- ❌ Un elemento di $A$ **non** può essere associato a due elementi diversi di $B$ (es. $a_2 \mapsto b_1$ e $a_2 \mapsto b_2$).

### Notazione

$$\varphi : A \to B \qquad \text{"φ da A in B"}$$

$$a \longmapsto \varphi(a) \in B \qquad \text{"a mappato in φ di a"}$$

- $A = D(\varphi)$ : **dominio** di $\varphi$
- $B = C(\varphi)$ : **codominio** di $\varphi$

### Esempi

$$f: \mathbb{R} \to \mathbb{R},\quad x \mapsto x^2$$

$$g: \mathbb{R} \to [0,+\infty) = {x \in \mathbb{R} : x \ge 0},\quad x \mapsto x^2$$

$$h: [0,+\infty) \to [0,+\infty),\quad x \mapsto x^2$$

Sono tre applicazioni **diverse** (stessa legge, ma dominio/codominio diversi).

### Insieme immagine

$$\mathrm{Im}(\varphi) := {, b \in B \mid \exists, a \in A \text{ per cui } \varphi(a) = b ,} \subseteq B$$

Altro modo: $\mathrm{Im}(\varphi) = \varphi(A)$.

Esempi:

- $f: \mathbb{R} \to \mathbb{R}$, $\mathrm{Im}(f) = [0,+\infty)$, quindi $\mathrm{Im}(f) \subsetneq \mathbb{R}$, mentre $C(f) = \mathbb{R}$.
- $g: \mathbb{R} \to [0,+\infty)$, $\mathrm{Im}(g) = C(g) = [0,+\infty)$.

In generale $\mathrm{Im}(\varphi)$ è un sottoinsieme (anche proprio) del codominio $B$.

### Controimmagine

Sia $S \subseteq B$. Definiamo la **controimmagine** di $S$ secondo $\varphi$ l'insieme

$$\varphi^{-1}(S) := {, a \in A \mid \varphi(a) \in S ,} \subseteq A$$

Quindi $\varphi^{-1}$ agisce sull'insieme delle parti:

$$\mathcal{P}(A) = {B \text{ insieme} \mid B \subseteq A} \quad\text{(insieme delle parti di } A)$$

$$\varphi^{-1} : \mathcal{P}(B) \to \mathcal{P}(A), \qquad S \longmapsto \varphi^{-1}(S)$$

> ⚠️ $\varphi^{-1}$ qui è un'operazione sui **sottoinsiemi**, e ha senso anche se $\varphi$ non è invertibile.

**Osservazione:**

$$\text{se } S \cap \varphi(A) = \emptyset \implies \varphi^{-1}(S) = \emptyset$$

(cioè la parte di $S$ fuori da $\mathrm{Im}(\varphi)$ non contribuisce alla controimmagine).

**Esempi:**

- $f: \mathbb{R} \to \mathbb{R}$, $x \mapsto x^2$, $S = {-1}$: $$f^{-1}(S) = {x \in \mathbb{R} \mid x^2 = -1} = \emptyset$$
- $\ell: \mathbb{C} \to \mathbb{C}$, $x \mapsto x^2$, $S = {-1}$: $$\ell^{-1}(S) = {x \in \mathbb{C} \mid x^2 = -1} = {i, -i}$$

---

## 4. Suriettività e iniettività

### Suriettiva

**Def.** $\varphi: A \to B$ si dice **suriettiva** se e solo se $\mathrm{Im}(\varphi) = B$.

**Osservazione.** Equivalentemente:

$$\varphi \text{ suriettiva} \iff \forall b \in B\ \ \exists, a \in A \mid \varphi(a) = b$$

(l'esistenza di $a$ è proprio $\mathrm{Im}(\varphi) = B$).

### Iniettiva

**Def.** $\varphi: A \to B$ è detta **iniettiva** se e solo se

$$\forall a_1, a_2 \in A,\ a_1 \neq a_2 \text{ si ha che } \varphi(a_1) \neq \varphi(a_2)$$

### ✏️ Da fare e capire

$\varphi: A \to B$ è iniettiva se e solo se

$$\forall a_1, a_2 \in A \mid \varphi(a_1) = \varphi(a_2) \text{ si ha che } a_1 = a_2$$

_Spiegazione:_ è la **contronominale** della definizione. Una implicazione $P \Rightarrow Q$ è equivalente a $\neg Q \Rightarrow \neg P$. Qui $P$ = "$a_1 \ne a_2$", $Q$ = "$\varphi(a_1) \ne \varphi(a_2)$"; la contronominale è "$\varphi(a_1) = \varphi(a_2) \Rightarrow a_1 = a_2$".

Inoltre, in termini di controimmagini:

$$\varphi \text{ iniettiva} \iff \forall b \in B,\ \varphi^{-1}({b}) \text{ ha al più un elemento}$$

$$\varphi \text{ suriettiva} \iff \forall b \in B,\ \varphi^{-1}({b}) \neq \emptyset$$

### Biiettiva

Se $\varphi$ è sia iniettiva che suriettiva si dice **biiettiva**: vale

$$\forall b \in B\ \ \exists!\ a \in A \mid \varphi(a) = b$$

(esiste **uno e un solo** $a$).

---

## 5. Esempi: $f$, $g$, $h$

**$f: \mathbb{R} \to \mathbb{R}$, $x \mapsto x^2$**

- **Non è suriettiva** ($\mathrm{Im}(f) = [0,+\infty) \ne \mathbb{R}$).
- È iniettiva? **No**: $1^2 = 1 = (-1)^2$, ma $1 \ne -1$.

**$g: \mathbb{R} \to [0,+\infty)$, $x \mapsto x^2$**

- È **suriettiva**.
- **Non è iniettiva**: $\forall \alpha > 0$, $$g^{-1}({\alpha}) = {-\sqrt{\alpha},\ \sqrt{\alpha}}$$ ha due elementi.

**$h: [0,+\infty) \to [0,+\infty)$, $x \mapsto x^2$**

- È **suriettiva**.
- È **iniettiva**: $x^2 = \alpha$, $\alpha \ge 0$ ha una sola soluzione in $[0,+\infty)$: $$h^{-1}({\alpha}) = {\sqrt{\alpha}}$$
- Quindi $h$ è **biiettiva**.

|Applicazione|Suriettiva|Iniettiva|
|---|:-:|:-:|
|$f: \mathbb{R} \to \mathbb{R}$|❌|❌|
|$g: \mathbb{R} \to [0,+\infty)$|✅|❌|
|$h: [0,+\infty) \to [0,+\infty)$|✅|✅|
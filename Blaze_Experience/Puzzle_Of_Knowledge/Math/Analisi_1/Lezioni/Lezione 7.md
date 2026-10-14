## 0. Ripasso: iettività e suriettività (esempi)

Tre funzioni costruite a partire da $x \mapsto x^2$:

|Funzione|Dominio → Codominio|Suriettiva|Iniettiva|
|---|---|---|---|
|$f$|$\mathbb{R} \to \mathbb{R}$|NO|NO|
|$g$|$\mathbb{R} \to [0,+\infty)$|SÌ|NO|
|$h$|$[0,+\infty) \to [0,+\infty)$|SÌ|SÌ (quindi biiettiva)|

**$f$ non è iniettiva.** Esempio: $f(1) = 1 = f(-1)$, cioè $-1$ e $1$ hanno la stessa immagine. Non è suriettiva perché i valori negativi non sono mai raggiunti.

**$g$ è suriettiva ma non iniettiva.** Per ogni $\alpha > 0$ la controimmagine ha due elementi: $$g^{-1}({\alpha}) = {-\sqrt{\alpha},\ \sqrt{\alpha}}$$ (per $\alpha = 0$ si ha solo ${0}$).

**$h$ è biiettiva.** Risolvendo $x^2 = \alpha$ con $\alpha \ge 0$ e $x \ge 0$ si ha una sola soluzione: $$h^{-1}({\alpha}) = {\sqrt{\alpha}}$$

---

## 1. Insiemi numerabili

Sia $P = {2m : m \in \mathbb{N}} \subseteq \mathbb{N}$ (i numeri pari).

- $\mathbb{N}$, $\mathbb{Z}$, $\mathbb{Q}$ sono tali che si può costruire tra loro una corrispondenza biunivoca (applicazione biiettiva).
- Gli insiemi in corrispondenza biunivoca con $\mathbb{N}$ si dicono **insiemi numerabili**.
- $\mathbb{R}$ è **non numerabile** (si dimostra con l'argomento diagonale di Cantor).

> Osservazione: $P$ è un sottoinsieme _proprio_ di $\mathbb{N}$ ma ha "tanti elementi quanti" $\mathbb{N}$. Questo è possibile solo per insiemi infiniti.

### Esempio: $\mathbb{N}$ e i numeri pari

$$\psi : \mathbb{N} \to P, \qquad m \mapsto 2m$$

**Tesi:** $\psi$ è biiettiva.

**Suriettività.** Sia $2m \in P$. Si cerca $n \in \mathbb{N}$ tale che $\psi(n) = 2m$. Basta prendere $n = m$: $\psi(m) = 2m$. Quindi $\psi$ è suriettiva.

**Iniettività.** Siano $m_1, m_2 \in \mathbb{N}$ con $m_1 \neq m_2$. Tesi: $\psi(m_1) \neq \psi(m_2)$.

_Per contraddizione_, supponiamo $\psi(m_1) = \psi(m_2)$. Allora:

1. $\psi(m_1) = 2m_1$ e $\psi(m_2) = 2m_2$
2. dunque $2m_1 = 2m_2$
3. cioè $2m_1 - 2m_2 = 0$
4. cioè $2(m_1 - m_2) = 0$
5. da cui $m_1 - m_2 = 0$, cioè $m_1 = m_2$

Questo contraddice l'ipotesi $m_1 \neq m_2$. Quindi $\psi(m_1) \neq \psi(m_2)$ e $\psi$ è iniettiva. $\blacksquare$

### L'albergo di Hilbert

_(Nel quaderno è scritto "Albero di Hilbert": il nome corretto del paradosso è "Albergo/Hotel di Hilbert".)_

Un albergo ha infinite camere numerate $0, 1, 2, 3, \dots$ (cioè indicizzate da $\mathbb{N}$) e **tutte le camere sono occupate**. Arriva un nuovo cliente: si può comunque ospitarlo.

L'idea è la funzione $\psi : \mathbb{N} \to P$, $n \mapsto 2n$. Ogni ospite della camera $n$ si sposta nella camera $2n$:

- le camere pari $0, 2, 4, \dots$ sono tutte occupate dagli ospiti già presenti;
- le camere dispari $1, 3, 5, \dots$ restano **libere**, e possono accogliere nuovi clienti (infiniti, volendo).

Questo è possibile proprio perché $\psi$ è una biiezione tra $\mathbb{N}$ e un suo sottoinsieme proprio.

---

## 2. Operazioni tra funzioni

### 2.1 Somma

**Def.** Date $\varphi : A \to \mathbb{R}$ e $\psi : B \to \mathbb{R}$, si definisce l'**applicazione somma**: $$(\varphi + \psi) : A \cap B \to \mathbb{R}, \qquad a \mapsto \varphi(a) + \psi(a)$$

Il dominio è l'**intersezione dei domini**.

**La somma è commutativa:** $\varphi + \psi = \psi + \varphi$.

_Perché:_ $\varphi(a) + \psi(a) = \psi(a) + \varphi(a)$ per la commutatività della somma in $\mathbb{R}$.

**Esempio.** Siano $$\varphi : [0,+\infty) \to \mathbb{R},\ x \mapsto \sqrt{x} \qquad \psi : \mathbb{R} \to \mathbb{R},\ x \mapsto 2x$$ Allora $$D(\varphi + \psi) = [0,+\infty) \cap \mathbb{R} = [0,+\infty), \qquad (\varphi + \psi)(x) = \sqrt{x} + 2x$$

### 2.2 Prodotto

**Def.** Dati $A, B$ con $A \cap B \neq \emptyset$, $\varphi : A \to \mathbb{R}$, $\psi : B \to \mathbb{R}$: $$(\psi \cdot \varphi) : A \cap B \to \mathbb{R}, \qquad a \mapsto \psi(a) \cdot \varphi(a)$$

Come per la somma, $\psi \cdot \varphi = \varphi \cdot \psi$, perché $\psi(a)\varphi(a) = \varphi(a)\psi(a)$ (commutatività del prodotto in $\mathbb{R}$).

### 2.3 Rapporto (quoziente)

**Def.** Con $A \cap B \neq \emptyset$, $\varphi : A \to \mathbb{R}$, $\psi : B \to \mathbb{R}$, si definisce: $$\frac{\psi}{\varphi} : (A \cap B) \cap {a \in A \mid \varphi(a) \neq 0} \to \mathbb{R}, \qquad a \mapsto \frac{\psi(a)}{\varphi(a)}$$

Si escludono i punti in cui il denominatore si annulla. Detto

$$Z_f = {a \in D(f) \mid f(a) = 0}$$

l'insieme degli **zeri** di $f$, si ha: $$D!\left(\frac{\psi}{\varphi}\right) = (A \cap B) \setminus Z_\varphi \qquad D!\left(\frac{\varphi}{\psi}\right) = (A \cap B) \setminus Z_\psi$$

**Attenzione:** a differenza di somma e prodotto, il rapporto **non è commutativo**: $$\frac{\psi}{\varphi} \neq \frac{\varphi}{\psi}, \qquad D!\left(\frac{\psi}{\varphi}\right) \neq D!\left(\frac{\varphi}{\psi}\right) \text{ in generale}$$

---

## 3. Grafico di una funzione e trasformazioni

**Def.** Il **grafico** di $\varphi : A \to B$ è $$G(\varphi) := {(a, \varphi(a)) : a \in A}$$

### 3.1 Traslazione verticale: $f + c$

**Domanda:** è vero che $G(f + c) = G(f)$?

**Risposta: NO** (per $c \neq 0$, in particolare per $c > 0$).

Sia $f : A \to \mathbb{R}$ e $c : \mathbb{R} \to \mathbb{R}$ la funzione costante $x \mapsto c$. Allora:

- $D(f + c) = D(f) \cap D(c) = A$
- $G(f+c) = {(a, f(a) + c) : a \in A} \subseteq A \times \mathbb{R}$

Se $c > 0$: $f(a) < f(a) + c$, quindi $(a, f(a)) \neq (a, f(a)+c)$. I due grafici sono diversi.

**Interpretazione:** $G(f+c)$ è la **traslazione rigida** di $G(f)$:

- verso l'**alto** se $c > 0$
- verso il **basso** se $c < 0$

(di un tratto di lunghezza $|c|$ lungo l'asse $y$).

### 3.2 Riflessione: $-f$

$$-f : D(f) \to \mathbb{R}, \qquad x \mapsto -f(x)$$ $$G(-f) = {(a, -f(a)) : a \in A}$$

$G(-f)$ è il **ribaltamento** di $G(f)$ rispetto all'asse delle $x$ (cioè rispetto alla retta $y = 0$).

### 3.3 Dilatazione verticale: $b f$

$$b f : D(f) \to \mathbb{R}, \qquad x \mapsto b, f(x), \quad b \in \mathbb{R}$$

- Per $b = -1$ si ottiene il caso precedente ($-f$).
- Per $b > 0$ e $f(x) > 0$: $0 < f(x) < b f(x)$ se $b > 1$ (il grafico si "allunga" in verticale).

In generale le differenze di quota vengono moltiplicate per $b$: $$b f(a_2) - b f(a_1) = b,\big(f(a_2) - f(a_1)\big)$$

**Esempio:** $b = 2$ e $f(a_2) - f(a_1) = 3$. Allora $2 \cdot 3 = 6$.

### 3.4 Traslazione orizzontale: $f(x + c)$

Sia $f : A \subseteq \mathbb{R} \to \mathbb{R}$ e $g : C \subseteq \mathbb{R} \to \mathbb{R}$, $x \mapsto f(x + c)$.

Il dominio di $g$ è $$C = D(g) = {x \in \mathbb{R} \mid x + c \in D(f)}$$

Posto $x + c = a \in A$, cioè $x = a - c$: $$C = {x \in \mathbb{R} \mid \exists, a \in A,\ x = a - c}$$

Effetto sul grafico:

- $c > 0$: traslazione verso **sinistra** di $c$
- $c < 0$: traslazione verso **destra** di $|c|$

**Esempio.** $g(x) = f(x + 2)$ con $A = [-1, 1]$ e $c = 2$: $$C = {x \in \mathbb{R} \mid \exists, a \in [-1,1],\ x = a - 2} = [-3, -1]$$

Con $c = -2$ si ottiene invece $C = [1, 3]$.

---

## 4. Topologia euclidea della retta reale

### 4.1 Intorni

**Def.** Sia $x_0 \in \mathbb{R}$ e $\delta > 0$. L'**intorno (circolare)** di centro $x_0$ e raggio $\delta$ è $$D(x_0; \delta) := {x \in \mathbb{R} \mid |x - x_0| < \delta} = (x_0 - \delta,\ x_0 + \delta)$$

**Def.** **Intorno di $+\infty$**: ogni intervallo del tipo $(a, +\infty) = {x \in \mathbb{R} \mid x > a}$, per $a \in \mathbb{R}$.

**Def.** **Intorno di $-\infty$**: ogni intervallo del tipo $(-\infty, a) = {x \in \mathbb{R} \mid x < a}$, per $a \in \mathbb{R}$.

Estremi di questi intervalli:

| Insieme        | $\sup$    | $\inf$    | max / min    |
| -------------- | --------- | --------- | ------------ |
| $(a, +\infty)$ | $+\infty$ | $a$       | non esistono |
| $(-\infty, a)$ | $a$       | $-\infty$ | non esistono |

**Retta reale estesa:** $$\widetilde{\mathbb{R}} = \mathbb{R} \cup {-\infty, +\infty}$$ Quindi $x_0 \in \widetilde{\mathbb{R}}$ se e solo se $x_0 \in \mathbb{R}$, oppure $x_0 = +\infty$, oppure $x_0 = -\infty$.

### 4.2 Punti di accumulazione

**Def.** Sia $A \subseteq \mathbb{R}$, $A \neq \emptyset$, e $x_0 \in \mathbb{R}$. Si dice che $x_0$ è un **punto di accumulazione** per $A$ se e solo se $$\forall, \delta > 0 \quad \big(D(x_0; \delta) \cap A\big) \setminus {x_0} \neq \emptyset$$

Cioè: esistono punti di $A$, **diversi da $x_0$**, arbitrariamente vicini a $x_0$. ($x_0$ può anche non appartenere ad $A$.)

### 4.3 Esempio: $A = (1,2) \cup {3}$

Quali sono i punti di accumulazione di $A$?

**Caso $x < 1$: non sono di accumulazione.** Basta scegliere $\delta$ tale che $x + \delta < 1$ (ad esempio $\delta = \frac{1-x}{2}$). Allora $(x - \delta, x + \delta) \cap A = \emptyset$.

**Caso $x = 1$: è di accumulazione.** Per ogni $\delta > 0$ si ha:

$$(1-\delta,\ 1+\delta) \cap A = \begin{cases} (1,\ 1+\delta) & \text{se } 0 < \delta < 1 \ (1,\ 2) & \text{se } 1 \le \delta \le 2 \ (1,2) \cup {3} = A & \text{se } \delta > 2 \end{cases}$$

In ogni caso l'insieme è $\neq \emptyset$ (e non contiene $1$, che non sta in $A$). Quindi $1$ è di accumulazione per $A$.

### Esercizi

1. $2$ è di accumulazione per $A$.
2. Ogni $x_0 \in (1,2)$ è di accumulazione per $A$.
3. $3$ **non** è di accumulazione per $A$.
4. Se $x > 2$ e $x \neq 3$, $x$ **non** è di accumulazione per $A$.

**Svolgimento del punto 3.** Sia $x_0 = 3$. Dobbiamo trovare $\bar\delta > 0$ tale che $$\big((3 - \bar\delta,\ 3 + \bar\delta) \cap A\big) \setminus {3} = \emptyset$$

Basta prendere $\bar\delta < 1$ (ad esempio $\bar\delta = \tfrac{1}{2}$): allora $3 - \bar\delta > 2$, quindi l'intervallo $(3-\bar\delta, 3+\bar\delta)$ non incontra $(1,2)$ e $$(3 - \bar\delta,\ 3 + \bar\delta) \cap A = {3}$$ Togliendo $3$ resta l'insieme vuoto, dunque $3$ non è di accumulazione per $A$.

**Conclusione.** L'insieme dei punti di accumulazione di $A$ è $[1, 2]$.

Il punto $3$ appartiene ad $A$ ma non è di accumulazione: è un **punto isolato** di $A$.

---

## Note di revisione (cosa ho sistemato)

- **"Albero di Hilbert"** → "Albergo di Hilbert" (nome corretto del paradosso).
- **Esercizio 4 sui punti di accumulazione**: nel quaderno la trascrizione risulta "sono acc. per A", ma per $x > 2$, $x \ne 3$ la proprietà è falsa. L'ho scritto come "non sono di accumulazione". Controlla sul tuo quaderno.
- **Quoziente**: ho esplicitato i domini $D(\psi/\varphi)$ e $D(\varphi/\psi)$ con l'insieme degli zeri $Z_f$.
- **Dilatazione $bf$**: ho precisato che la disuguaglianza $f(x) < b f(x)$ vale per $b > 1$ e $f(x) > 0$ (nel quaderno è scritto solo $b > 0$).
- **Caso $x = 1$** (punti di accumulazione): ho riordinato i casi in $\delta$ in una tabella completa.
- **Ultima riga** ("I punti di...") e **"$\psi : \mathbb{N} \to$"** erano interrotte: ho completato con la nozione di punto isolato e con l'albergo di Hilbert.
- Alcuni segni nel quaderno erano poco leggibili (es. il verso della traslazione orizzontale): ho riportato la convenzione standard ($f(x+c)$ trasla a sinistra se $c>0$).
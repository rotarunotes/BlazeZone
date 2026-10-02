# Analisi – Appunti

## Lezione 2

Sia $q \in \mathbb{R} \setminus {0, 1}$

$$(**)\quad \sum_{k=0}^{n} q^k = \frac{1 - q^{n+1}}{1 - q} \qquad \forall n \in \mathbb{N}$$

### Dimostrazione per induzione

**Passo base**: $p = 0$: $0$ verifica $(**)$? $\to p = n$

$$\sum_{k=0}^{0} q^k = 1 ; ; \quad \frac{1 - q^{0+1}}{1 - q} = 1$$

Passo base verificato per $p = 0$.

**Passo induttivo**:

- Ipotesi induttiva $\to \displaystyle\sum_{k=0}^{n} q^k = \frac{1 - q^{n+1}}{1 - q}$
- Tesi induttiva $\to \displaystyle\sum_{k=0}^{n+1} q^k = \frac{1 - q^{(n+1)+1}}{1 - q}$

**Dimostrazione**:

$$\sum_{k=0}^{n+1} q^k = \sum_{k=0}^{n} q^k + q^{n+1}$$

(ipotesi induttiva)

$$= \frac{1 - q^{n+1}}{1 - q} + q^{n+1}$$

$$= \frac{1 - q^{n+1} + q^{n+1} - q^{n+2}}{1 - q}$$

$$= \frac{1 - q^{n+2}}{1 - q}$$

> [!Info] Info:
> **N.B.**: Per $q = 0$ si definisce $\displaystyle\sum_{k=0}^{n} q^k = 1$.
> 
> Quindi la formula $\displaystyle\sum_{k=0}^{n} q^k = \frac{1 - q^{n+1}}{1 - q}$ vale:
> 
> $$\frac{1 - 0^{n+1}}{1 - 0} = 1$$

---

## Numeri interi $\mathbb{Z}$

$$\mathbb{Z} = \mathbb{N} \cup (-\mathbb{N})$$

dove $-A := {-a : a \in A}$ (definizione)

**Assioma di esistenza dell'opposto**

$$\forall m \in \mathbb{Z}\ \ \exists, n \in \mathbb{Z} \mid m + n = 0$$

**Compatibilità con l'ordinamento**

Se $a, b, c \in \mathbb{Z}$:

- $a \leq b,\ c > 0 \Rightarrow ac \leq bc$
- $a \leq b,\ c < 0 \Rightarrow ac \geq bc$

---

$\mathbb{Z}$ **problema:** $a \in \mathbb{Z}$, $\exists, b \in \mathbb{Z} \mid ab = 1$ (?)

(Vale solamente per $a \in {-1, 1}$)

$b := a^{-1}$ ($1^{-1} = 1$ ; $-1^{-1} = -1$)

---

## Numeri razionali $\mathbb{Q}$

$$\mathbb{N} \subseteq \mathbb{Z} \subseteq \mathbb{Q}$$

$${ m \cdot n^{-1} : m \in \mathbb{Z},\ n \in \mathbb{Z} \setminus {0},\ \text{M.C.D.}(m,n) = 1 }$$

Rappresentazione canonica dei numeri razionali. ($m, n$: numeri coprimi)

$\frac{1}{3} \sim \frac{2}{6} \sim \frac{3}{9}$, si prende in considerazione solo $\frac{1}{3}$ dove $1$ e $3$ sono coprimi tra loro.

---

L'**inverso** di $m$ è il suo **reciproco** in $\mathbb{Q}$: $\dfrac{1}{m}$ (reciproco).

Inverso e reciproco sono operazioni diverse.

---

In $\mathbb{Q}$ vale l'**assioma dell'inverso moltiplicativo**

$$\forall a \in \mathbb{Q} \setminus {0}\ \ \exists, b \in \mathbb{Q} \mid ab = 1 \quad (b = a^{-1})$$

$p(x) = x^2 - 2$, $p \in \mathbb{Q}[x]$ (tutti i polinomi a coefficiente razionale)

### Teorema: l'equazione $x^2 - 2$ non ha soluzioni razionali

**Dimostrazione per contraddizione:**

Supponiamo che $\exists \frac{m}{n} \in \mathbb{Q} \mid \left(\frac{m}{n}\right)^2 = 2$ ; $\text{M.C.D.}(m,n) = 1$

$$\left(\frac{m}{n}\right)^2 = 2 \Rightarrow m^2 = 2n^2$$

> $(m \cdot n^{-1})^2 = m^2 \cdot (n^{-1})^2$
> 
> 1. $m \cdot n^{-1} \cdot m \cdot n^{-1} = m \cdot m \cdot n^{-1} \cdot n^{-1}$
>     
> 2. $m^2 (n^{-1})^2 = 2 \Rightarrow m^2 (n^{-1})^2 n^2 = 2 \cdot n^2$, dove $(n^{-1})^2 n^2 = 1$
>     

$m^2 = 2n^2$ è pari $\to m^2$ è pari

$\Rightarrow m$ è pari. _Se $m^2$ è pari $\Rightarrow m$ pari._

Se $m$ fosse dispari: $m = 2k+1$, $k \in \mathbb{Z}$

$$\Rightarrow (2k+1)^2 = 4k^2 + 4k + 1 = 4k(k+1) + 1 \text{ è dispari}$$

$\Rightarrow \exists, h \in \mathbb{Z} \mid m = 2h$

Ricordo che $m^2 = 2n^2$; quindi:

$$(2h)^2 = 2n^2$$ $$4h^2 = 2n^2$$ $$2h^2 = n^2 \Rightarrow \text{è pari}$$

$\Rightarrow n$ è pari

**Conclusione:** poiché M.C.D.$(m,n) = 1$, l'implicazione contronominale è vera ossia il teorema è dimostrato. $\square$

---

$A \Rightarrow B$

$\neg B \Rightarrow \neg A$

$\sqrt{2} \in \mathbb{Q}$ ($x^2 - 2 = 0$)

$x^2 - p = 0$ ; $p$ numero primo non ha soluzione razionale: $\sqrt{p} \notin \mathbb{Q}$

---

## Fattoriale di $n \in \mathbb{N}$: $n!$

**Def. induttiva:**

1. $0! := 1$
2. $(n+1)! := (n+1) \cdot (n!) \quad \forall n \geq 1$

Per induzione $n!$ è ben definito $\forall n \in \mathbb{N}$.

$$n! = \prod_{i=1}^{n} i = 1 \cdot 2 \cdot 3 \cdot 4 \cdot \ldots \cdot n \qquad \text{(produttoria)}$$

**Proposizione:** si ha che $n! \geq n \quad \forall n \in \mathbb{N}$

**Dim. per induzione**

- **P1)** "$p = 0$": $0! = 1 \geq 0$ — passo base è vero
- **P2)** [se $n! \geq n$ (ip. induttiva) allora $(n+1)! \geq n+1$ (tesi induttiva)]

$$(n+1)! = (n+1) \cdot (n!) \geq (n+1) \cdot n \geq (n+1) \cdot 1 = n+1$$

(da $n! \geq n$ per ip. induttiva; comp. ordinamento del prodotto; $n \geq 1$)

$\Rightarrow (n+1)! \geq n+1$ — passo induttivo è verificato.

Concludo, per il principio di induzione si ha che $n! \geq n \quad \forall n \in \mathbb{N}$. $\square$

_(Appunto a lato, svolto a mano libera)_

$n! \geq n$, $(n+1)! = (n+1) \cdot n!$

$n! \geq n \Rightarrow n!(n+1) \geq n(n+1)$

$(n+1)! \geq n(n+1)$, $n \geq 1$

$(n+1)! \geq 1 \cdot (n+1)$

$(n+1)! \geq n+1$

---

## Lezione 3

### Coefficiente binomiale

$n, k \in \mathbb{N}$, $k \leq n$

$$\binom{n}{k} := \frac{n!}{k!,(n-k)!} \qquad \text{per } k > n:\ \binom{n}{k} := 0$$

**Proprietà**

1. $\dbinom{n}{0} = \dfrac{n!}{0!,(n-0)!} = 1$
    
2. $\dbinom{n}{n} = \dfrac{n!}{n!,(n-n)!} = 1$ (con $0! = 1$)
    
3. $\dbinom{n}{n-1} = \dfrac{n!}{(n-1)!,(n-(n-1))!} = \dfrac{n!}{(n-1)!} = \dfrac{n,(n-1)!}{(n-1)!} = n$
    
4. $\dbinom{n}{k} = \dbinom{n}{n-k} \quad \forall k \leq n$
    

$$\binom{n}{k} = \frac{n!}{k!,(n-k)!} ; ; \qquad \binom{n}{n-k} = \frac{n!}{(n-k)!,(n-(n-k))!} = \frac{n!}{(n-k)!\cdot k!}$$

5. $\dbinom{n}{k} = \dbinom{n-1}{k-1} + \dbinom{n-1}{k} \quad \forall k,\ 1 \leq k \leq n$

$$= \frac{(n-1)!}{(k-1)!,(n-1-(k-1))!} + \frac{(n-1)!}{k!,(n-1-k)!}$$

con $(n-k)! = (n-k-1)!,(n-k)$ e $k! = k,(k-1)!$

$$= \frac{(n-1)!}{(k-1)!,(n-k-1)!} \cdot \left( \frac{1}{n-k} + \frac{1}{k} \right)$$

$$\frac{1}{n-k} + \frac{1}{k} = \frac{k + n - k}{k(n-k)} = \frac{n}{k(n-k)}$$

$$= \frac{(n-1)!}{(k-1)!,(n-k-1)!} \cdot \frac{n}{k(n-k)} = \frac{n!}{k!,(n-k)!} = \binom{n}{k}$$

6. $\dbinom{n}{k} \in \mathbb{N} \quad \forall k, n \in \mathbb{N}$

---

## Numeri reali $\mathbb{R}$

$$\mathbb{N} \subseteq \mathbb{Z} \subseteq \mathbb{Q} \subseteq \mathbb{R}$$

### Proprietà fondamentali, assioma di separazione

$A, B$ con $A \neq \emptyset \neq B$ $\mid$ $a \leq b \quad \forall a \in A,\ \forall b \in B$ ($A, B$ sono separati)

Allora $\exists, x \in \mathbb{R} \mid a \leq x \leq b \quad \forall a \in A,\ \forall b \in B$

$x$ è detto **separatore** di $A$ e $B$.

- Si può dimostrare che esiste un insieme $\mathbb{R}$ che verifica tali assiomi.
- **N.B.** Altre costruzioni di $\mathbb{R}$: si può dimostrare che sono equivalenti a quella assioma che abbiamo usato.

---

### Proprietà di Archimede

$$\forall x \in \mathbb{R}\ \ \exists, n \in \mathbb{N} \mid n > x$$

**Dimostrazione**

- Sia $x \leq 0$ ; $n = 1$ verifica il fatto che $1 > x$ perché $1 > 0 \geq x$.
    
- Sia $x > 0$ : $A := {n \in \mathbb{N} \mid n \leq x} \subseteq \mathbb{N}$
    
    Tesi $\iff A \neq \mathbb{N}$
    
- **Per contraddizione:** suppongo che $A = \mathbb{N} \neq \emptyset$.
    
    Sia $B := {y \in \mathbb{R} \mid y \geq n \ \ \forall n \in \mathbb{N}}$
    
    Dal fatto che $A = \mathbb{N}$ segue che $x \in B \Rightarrow B \neq \emptyset$.
    
    Notiamo che $\forall y \in B$ si ha che $y \geq n \ \ \forall n \in A\ (= \mathbb{N})$.
    
    Quindi $A$ e $B$ sono separati, per assioma di separazione
    
    $$\exists, \lambda \in \mathbb{R} \mid n \leq \lambda \leq y \quad \forall n \in A,\ \forall y \in B$$
    
    Quindi è anche vero che $\mathbb{N} \ni n+1 \leq \lambda \leq y$
    
    $\Rightarrow n \leq \lambda - 1 \quad \forall n \in A\ (= \mathbb{N})$
    
    $\Rightarrow \lambda - 1 \in B$
    
    Ma $\lambda$ è elemento separatore di $A$ e $B$: $(n \leq)\ \lambda \leq y \quad \forall y \in B,\ \forall n \in A$
    
    Quindi $\lambda \leq \lambda - 1 \Rightarrow 1 \leq 0$
    
- **Contraddizione** ($A = \mathbb{N} \Rightarrow A \subset \mathbb{N}$ falso) $\square$
    

---

### Proprietà della parte intera

$$\forall x \in \mathbb{R}\ \ \exists!, n \in \mathbb{Z} \mid n \leq x < n+1$$

Nota: $n$ è detto parte intera di $x$.

**Funzione floor:** $n = \lfloor x \rfloor$

- $\lfloor x \rfloor = 0 \quad \forall x \mid 0 \leq x < 1$
- $\lfloor 0{,}5 \rfloor = 0$ ; $\lfloor 2{,}5 \rfloor = 2$
- $-1 \leq -0{,}5 < 0 \Rightarrow \lfloor -0{,}5 \rfloor = -1$

_(Grafico: funzione a gradini; punto pieno = compreso, parentesi = escluso.)_

**Funzione ceil:** $\lceil x \rceil$

- $\lceil 0 \rceil = 0$
- $\lceil \tfrac{3}{2} \rceil = 2$

$\lceil x \rceil = \lfloor x \rfloor + 1$ — **falsa** $\forall x \in \mathbb{Z}$

È vero che se $x \in \mathbb{R} \setminus \mathbb{Z}$ allora $\lceil x \rceil = \lfloor x \rfloor + 1$.

---

### Proposizione

$$\sqrt{2} \in \mathbb{R} \setminus \mathbb{Q}$$

**Dimostrazione (idea)**

$A = {x \in \mathbb{R} \mid x^2 > 2}$

$B = {x \in \mathbb{R} \mid x^2 < 2}$

Si verifica che tra i 2 insiemi sono separati: $\exists, \lambda \in \mathbb{R}$, $b \leq \lambda \leq a \quad \forall a \in A,\ \forall b \in B$

Perché fa vedere che $\lambda^2 = 2$.

### Teorema densità di $\mathbb{Q}$ in $\mathbb{R}$

$$\forall x \in \mathbb{R}\ \text{e}\ \forall \varepsilon > 0,\ \text{esiste } z \in \mathbb{Q} \mid z \leq x < z + \varepsilon$$

_(Schema sulla retta: $z$, $x$, $z + \varepsilon$; esempio $\varepsilon = \tfrac{1}{10}$.)_
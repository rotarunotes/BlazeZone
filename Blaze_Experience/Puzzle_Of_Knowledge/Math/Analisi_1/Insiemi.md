Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___

# Operazioni Insiemistiche

## Unione $\cup$

Elementi che stanno in **A oppure in B** (o in entrambi).

$$A \cup B = \{x : x \in A \lor x \in B\}$$



> [!example] Esempio:
> $A = {1, 2, 3}, B = {3, 4} → A ∪ B = {1, 2, 3, 4}$
## Intersezione $\cap$

Elementi che stanno **sia in A sia in B**.

$$A \cap B = \{x : x \in A \land x \in B\}$$

> [!example] Esempio:
> A = {1, 2, 3}, B = {3, 4} → A ∩ B = {3}


> [!info] Info:
Se $A ∩ B = ∅$, i due insiemi si dicono **disgiunti**.
## Differenza $\setminus$

Elementi che stanno **in A ma non in B**.

$$A \setminus B = \{x : x \in A \land x \notin B\}$$
> [!example] Esempio:
>$A = {1, 2, 3}, B = {3, 4} → A ∖ B = {1, 2}$


> [!danger] Attenzione!
> $A \setminus B \neq B \setminus A$


___
# Numeri Naturali $\mathbb{N}$

> [!abstract] Definizione
$$\mathbb{N} = \left\{0, 1, 2, 3, 4, \dots\right\}$$

## Operazioni

Su $\mathbb{N}$ sono definite due operazioni **addizione** e **prodotto**, e vanno interpretate come **mappe**
$$
+ : \mathbb{N}+\mathbb{N} \to \mathbb{N}, \quad (a,b) \mapsto a+b \qquad\qquad \cdot : \mathbb{N}\times\mathbb{N} \to \mathbb{N}, \quad (a,b) \mapsto ab
$$
### Proprietà Delle Operazioni
#### Addizione

$$Assioma: a,b,c \in \mathbb{N}$$

| Proprietà       | Formula                                                               |
| --------------- | --------------------------------------------------------------------- |
| Commutativa     | $a+b=b+a$                                                             |
| Associativa     | $(a+b)+c=a+(b+c)$                                                     |
| Elemento neutro | $\exists, e_0\in\mathbb{N}$ \| $a+e_0=a \quad \forall a\in\mathbb{N}$ |

> [!info] Info: Elemento Neutro
> Il valore di $a$ non cambia grazie all'elemento neutro.
> Inoltre l'elemento neutro è **unico**:
> $$ \exists !, e_0 \in \mathbb{N} \quad\text{e}\quad e_0 = 0 $$

#### Prodotto
$$Assioma: a,b,c \in \mathbb{N}$$

| Proprietà       | Formula                                                                    |
| --------------- | -------------------------------------------------------------------------- |
| Commutativo     | $a\cdot b=b\cdot a \quad$                                                  |
| Associativo     | $(a\cdot b)\cdot c=a\cdot(b\cdot c)$                                       |
| Elemento neutro | $\exists, e_1\in\mathbb{N}$ \| $a\cdot e_1=a \quad \forall a\in\mathbb{N}$ |

> [!info] Info: Elemento Neutro
> Il valore di $a$ non cambia grazie all'elemento neutro.
> Inoltre l'elemento neutro è **unico**:
>$$ \exists !, e_1 \in \mathbb{N} \quad\text{e}\quad e_1 = 1 $$

## Proprietà Dei Numeri Naturali

### Ordinamento Totale

> [!abstract] Definizione
> Per $a,b\in\mathbb{N}$ si **definisce**:
> 
> $$ a \le b \quad\Longleftrightarrow\quad \exists, c \in \mathbb{N} \ \mid\ a + c = b $$
> 
> Cioè $a\le b$ se esiste un naturale $c$ che sommato ad $a$ dà $b$

Questa relazione ha quattro proprietà:

|     | Proprietà          | Quantificatore                | Enunciato                                  |
| --- | ------------------ | ----------------------------- | ------------------------------------------ |
| a)  | **Riflessiva**     | $\forall a\in\mathbb{N}:$     | $a\le a$                                   |
| b)  | **Antisimmetrica** | $\forall a,b\in\mathbb{N}$:   | $a\le b$ e $b\le a$ $\Rightarrow$ $a=b$    |
| c)  | **Transitiva**     | $\forall a,b,c\in\mathbb{N}$: | $a\le b$ e $b\le c$ $\Rightarrow$ $a\le c$ |
| d)  | **Dicotomia**      | $\forall a,b\in\mathbb{N}$:   | $a\le b$ oppure $b\le a$                   |
### Compatibilità

**Compatibilità $(\le,+)$**:

$$ \forall a,b,c\in\mathbb{N}: \quad a\le b \Longrightarrow a+c \le b+c $$
**Compatibilità $(\le,\cdot)$**:

$$ \forall a,b,c\in\mathbb{N}: \quad a\le b \ \text{ e } \ c>0 ;\Longrightarrow; a\cdot c \le b\cdot c $$

> [!info] Info:
> La stessa proprietà vale anche con la disuguaglianza stretta ($a<b$, $c>0 \Rightarrow ac<bc$).

___
# Numeri Interi $\mathbb{Z}$

> [!abstract] Definizione
>$$\mathbb{Z} = \mathbb{N} \cup (-\mathbb{N})$$
>Dove $$-A := {-a : a \in A}$$

## Assioma Di Esistenza Dell'Opposto

> [!Abstract] Definizione: Enunciato
$$\forall m \in \mathbb{Z}\ \ \exists, n \in \mathbb{Z} \mid m + n = 0$$

> [!info] Info: Compatibilità Con L'Ordinamento
> Se $a, b, c \in \mathbb{Z}$:
>- $a \leq b,\ c > 0 \Rightarrow ac \leq bc$
>- $a \leq b,\ c < 0 \Rightarrow ac \geq bc$ 

> [!danger] Attenzione! Problema Nei Numeri Interi
> $$a \in \mathbb{Z}, \exists b \in \mathbb{Z} \mid ab = 1  \space(?)$$
> In $\mathbb{Z}$ Vale solamente per $a \in {-1, 1}$
> 
> $$b := a^{-1}$$ 
> $$1^{-1} = 1 ; -1^{-1} = -1$$

___
# Numeri Razionali $\mathbb{Q}$

> [!abstract] Definizione: Rappresentazione Canonica Dei Numeri Razionali
> $${ m \cdot n^{-1} : m \in \mathbb{Z},\ n \in \mathbb{Z} \setminus {0},\ \text{M.C.D.}(m,n) = 1 }$$
> > [!Info] Info: 
>  $$\text{M.C.D.}(m,n) = 1 \space$$
>  $m, n$ si dicono coprimi tra loro
> 
> > [!Example] Esempio:
> $\frac{1}{3} \sim \frac{2}{6} \sim \frac{3}{9}$, si prende in considerazione solo $\frac{1}{3}$ dove $1$ e $3$ sono coprimi tra loro.
> 

## Inverso e Reciproco

L'**inverso** di $m$ è il suo **reciproco** in $\mathbb{Q}$: $\dfrac{1}{m}$.

> [!Info] Info:
> Inverso e reciproco sono operazioni diverse.

## Assioma Dell'Inverso Moltiplicativo

> [!Abstract] Definizione: Enunciato
> In $\mathbb{Q}$ vale$$\forall a \in \mathbb{Q} \setminus \left\{0\right\}\ \ \exists b \in \mathbb{Q} \mid ab = 1 \quad (b = a^{-1})$$

___
# Numeri Reali $\mathbb{R}$

$$\mathbb{N} \subseteq \mathbb{Z} \subseteq \mathbb{Q} \subseteq \mathbb{R}$$

## Assioma Di Separazione 

> [!abstract] Definizione: Insiemi separati
> Siano $A,B\subseteq\mathbb{R}$ con $A\neq\emptyset\neq B$. Si dicono **separati** se
> $$a\le b \quad \forall a\in A,\ \forall b\in B$$

> [!abstract] Definizione: Assioma di separazione
> Se $A,B$ sono separati, allora
> $$\exists\,x\in\mathbb{R} \mid a\le x\le b \quad \forall a\in A,\ \forall b\in B$$
> $x$ è detto **separatore** di $A$ e $B$.

> [!info] Info:
> - Si può dimostrare che esiste un insieme $\mathbb{R}$ che verifica tali assiomi.
> - Altre costruzioni di $\mathbb{R}$ sono equivalenti a quella assiomatica che usiamo.

## Proprietà Di Archimede

> [!abstract] Definizione: Enunciato
> $$\forall x\in\mathbb{R}\ \ \exists\,n\in\mathbb{N} \mid n>x$$
> > [!info] Info: In parole
> Dato un qualunque reale $x$, c'è sempre un naturale più grande. Quindi $\mathbb{N}$ **non è limitato superiormente** in $\mathbb{R}$.


> [!success] Dimostrazione:
> **Caso $x\le 0$**
> $n=1$ verifica la tesi: $1>0\ge x$.
>
> **Caso $x>0$**
> Sia
> $$A:=\{n\in\mathbb{N}\mid n\le x\}\subseteq\mathbb{N}$$
> Tesi $\iff A\neq\mathbb{N}$ (se $A\neq\mathbb{N}$ esiste un $n\notin A$, cioè $n>x$).
>
> **Per contraddizione**: si suppone $A=\mathbb{N}\neq\emptyset$.
>
> Sia
> $$B:=\{y\in\mathbb{R}\mid y\ge n\ \ \forall n\in\mathbb{N}\}$$
> Poiché $A=\mathbb{N}$, vale $x\ge n$ per ogni $n\in\mathbb{N}$, quindi $x\in B$ e $B\neq\emptyset$.
>
> Per ogni $y\in B$ si ha $y\ge n$ per ogni $n\in A\ (=\mathbb{N})$. Quindi $A$ e $B$ sono **separati**.
>
> Per l'assioma di separazione
> $$\exists\,\lambda\in\mathbb{R}\mid n\le\lambda\le y \quad \forall n\in A,\ \forall y\in B$$
>
> Se $n\in\mathbb{N}$ allora $n+1\in\mathbb{N}=A$, quindi
> $$n+1\le\lambda \;\Rightarrow\; n\le\lambda-1 \quad \forall n\in A\ (=\mathbb{N})$$
> Cioè $\lambda-1\in B$.
>
> Ma $\lambda$ è separatore, quindi $\lambda\le y$ per ogni $y\in B$. In particolare, con $y=\lambda-1$:
> $$\lambda\le\lambda-1 \;\Rightarrow\; 1\le 0$$
>
> **Assurdo.** Quindi $A\neq\mathbb{N}$, cioè esiste $n\in\mathbb{N}$ con $n>x$. $\blacksquare$

___
## Parte Intera

> [!abstract] Proprietà della parte intera
> $$\forall x\in\mathbb{R}\ \ \exists!\,n\in\mathbb{Z}\mid n\le x<n+1$$
> $n$ è detto **parte intera** di $x$.

### Funzione floor $\lfloor x\rfloor$

$$n=\lfloor x\rfloor$$

> [!example] Esempio:
> - $\lfloor x\rfloor=0 \quad \forall x\mid 0\le x<1$
> - $\lfloor 0{,}5\rfloor=0 \qquad \lfloor 2{,}5\rfloor=2$
> - $-1\le -0{,}5<0 \Rightarrow \lfloor -0{,}5\rfloor=-1$

> [!info] Info: Grafico
> È una **funzione a gradini**. Nel grafico:
> - punto pieno = estremo **compreso**
> - parentesi (punto vuoto) = estremo **escluso**

> [!danger] Attenzione!
> Per i numeri negativi la parte intera **non** è "togliere la parte decimale": $\lfloor -0{,}5\rfloor=-1$, non $0$.

### Funzione ceil $\lceil x\rceil$

È l'intero più piccolo che sia $\ge x$.

> [!example] Esempio:
> - $\lceil 0\rceil=0$
> - $\lceil \tfrac{3}{2}\rceil=2$

> [!danger] Attenzione!
> $$\lceil x\rceil=\lfloor x\rfloor+1$$
> è **falsa** $\forall x\in\mathbb{Z}$ (per $x\in\mathbb{Z}$ vale $\lceil x\rceil=\lfloor x\rfloor=x$).
>
> È vera solo se $x\in\mathbb{R}\setminus\mathbb{Z}$.

___
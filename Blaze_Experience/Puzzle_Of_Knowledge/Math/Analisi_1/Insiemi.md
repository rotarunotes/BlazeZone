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

> [!info] Info
> La stessa proprietà vale anche con la disuguaglianza stretta ($a<b$, $c>0 \Rightarrow ac<bc$).

___
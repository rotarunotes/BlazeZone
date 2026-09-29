Data: 2026-09-29
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
- [[#Tabella dei simboli]]
- [[#Enunciato]]
	- [[#Le quattro forme di un'implicazione]]
- [[#Teorema]]
- [[#I Numeri Naturali]]
	- [[#Definizione e operazioni]]
		- [[#Assiomi dell'addizione]]
		- [[#Assiomi del prodotto]]
	- [[#Proprietà Dei Numeri Naturali]]
		- [[#Ordinamento Totale]]
		- [[#Compatibilità]]
- [[#Principio di Induzione]]
	- [[#Enunciato]]
	- [[#Esempio svolto somma dei primi n numeri naturali]]
		- [[#Proposizione]]
		- [[#Impostazione]]
		- [[#Passo base ($p=1$, cioè $1 in A$)]]
		- [[#Passo induttivo ($n in A Rightarrow n+1 in A$)]]
		- [[#Dimostrazione Del Passo Induttivo]]
		- [[#Conclusione]]
___
# Tabella dei simboli

| Simbolo           | Si legge              | Significato                                                                                 |
| ----------------- | --------------------- | ------------------------------------------------------------------------------------------- |
| $\mathbb{N}$      | "enne"                | Insieme dei numeri naturali ${0,1,2,3,\dots}$                                               |
| $\in$             | "appartiene a"        | $a \in \mathbb{N}$: l'elemento $a$ è nell'insieme $\mathbb{N}$                              |
| $\notin$          | "non appartiene a"    | Negazione di $\in$                                                                          |
| $\subseteq$       | "è sottoinsieme di"   | $A \subseteq \mathbb{N}$: ogni elemento di $A$ è anche in $\mathbb{N}$                      |
| $\forall$         | "per ogni"            | Quantificatore universale: $\forall a \in \mathbb{N}$                                       |
| $\exists$         | "esiste"              | Quantificatore esistenziale: $\exists c \in \mathbb{N}$                                     |
| $\exists !$       | "esiste ed è unico"   | Esiste **uno e uno solo** elemento con quella proprietà                                     |
| $\mid$            | "tale che"            | In ${x \mid \dots}$ o $\exists c \mid \dots$ introduce la condizione (anche scritto "t.c.") |
| $\times$          | "prodotto cartesiano" | $\mathbb{N}\times\mathbb{N}$: insieme delle coppie $(a,b)$ con $a,b\in\mathbb{N}$           |
| $\Rightarrow$     | "implica"             | Implicazione logica: $A \Rightarrow B$                                                      |
| $\mapsto$         | "mappa a"             | Dice a cosa viene mandato un elemento: $(a,b)\mapsto a+b$                                   |
| $\Leftrightarrow$ | "se e solo se"        | Doppia implicazione (equivalenza), es. nella definizione di $\le$                           |
| $\neg$            | "non"                 | Negazione: $\neg B$ è vero quando $B$ è falso                                               |
| $\ne$             | "diverso"             | $C \ne A$: $C$ è un'affermazione diversa da $A$                                             |
| $\cap$            | "intersezione"        | $A\cap B={x\in A \ \textbf{e}\ x\in B}$                                                     |
| $\cup$            | "unione"              | $A\cup B={x\in A \ \textbf{o}\ x\in B}$                                                     |
| $\sum_{i=1}^{n}$  | "sommatoria"          | Somma dei termini per $i$ da $1$ a $n$                                                      |
| $e_0,\ e_1$       | "elementi neutri"     | Neutro della somma ($=0$) e del prodotto ($=1$)                                             |

> [!note] Intersezione e unione (diagrammi di Venn)
> 
> - **Intersezione** $A\cap B$: la zona in comune tra i due insiemi (elementi che stanno in $A$ **e** in $B$).
> - **Unione** $A\cup B$: tutta la zona coperta da almeno uno dei due (elementi in $A$ **o** in $B$, o in entrambi).

___
# Enunciato

Un **enunciato** (o proposizione) è un'affermazione che può essere solo **vera** o **falsa**. Di solito ha questa forma:
$$\underbrace{\text{Contesto}}_{\text{"Sia}\ldots\text{"}} \;+\; \underbrace{\text{Ipotesi}}_{\text{premessa}} \;\Longrightarrow\; \underbrace{\text{Tesi}}_{\text{conseguenza}}$$

| Parte                  | Cosa contiene                                                                     | Esempio                    |
| ---------------------- | --------------------------------------------------------------------------------- | -------------------------- |
| **Contesto (dati)**    | Gli oggetti su cui si lavora, con eventuali quantificatori ($\forall$, $\exists$) | $\forall a,b\in\mathbb{N}$ |
| **Ipotesi (premessa)** | Ciò che si assume vero                                                            | $a\le b$ e $b\le a$        |
| **Tesi (conseguenza)** | Ciò che si vuole concludere                                                       | $a=b$                      |
| **Connettivo**         | Il legame logico tra ipotesi e tesi                                               | $\Rightarrow$ opp          |
## Le quattro forme di un'implicazione

| Nome                 | Forma                     | Equivalente a $A\Rightarrow B$?   |
| -------------------- | ------------------------- | --------------------------------- |
| Diretta              | $A\Rightarrow B$          | (è l'originale)                   |
| **Contronominale**   | $\neg B\Rightarrow\neg A$ | **Sì**                            |
| Reciproca (conversa) | $B\Rightarrow A$          | No                                |
| Inversa              | $\neg A\Rightarrow\neg B$ | No (è equivalente alla reciproca) |
___
# Teorema

Un **teorema** è un enunciato **vero** accompagnato dalla sua **dimostrazione**. La struttura standard è:

1. **Etichetta**:  es. *Teorema (Antisimmetria di $\le$)*.
2. **Enunciato**:
    - Contesto: "Sia... / $\forall\dots$"
    - Ipotesi: "Se..."
    - Tesi: "allora..."
3. **Dimostrazione**: dalla verità delle ipotesi si arriva, con passaggi logici giustificati, alla verità della tesi.

___
# I Numeri Naturali

## Definizione e operazioni
$$ \mathbb{N} = {0, 1, 2, 3, \dots} $$

Su $\mathbb{N}$ sono definite due operazioni, viste come **mappe**:

$$

+ : \mathbb{N}+\mathbb{N} \to \mathbb{N}, \quad (a,b) \mapsto a+b \qquad\qquad \cdot : \mathbb{N}\times\mathbb{N} \to \mathbb{N}, \quad (a,b) \mapsto ab $$

Prendono una coppia di naturali e restituiscono ancora un naturale.

### Assiomi dell'addizione
Con $a,b,c \in \mathbb{N}$:

| Proprietà       | Formula                                                                     |
| --------------- | --------------------------------------------------------------------------- |
| Commutativa     | $a+b=b+a$                                                                   |
| Associativa     | $(a+b)+c=a+(b+c)$                                                           |
| Elemento neutro | $\exists, e_0\in\mathbb{N}$ tale che $a+e_0=a \quad \forall a\in\mathbb{N}$ |

Il valore di $a$ non cambia grazie all'elemento neutro. Inoltre l'elemento neutro è **unico**:
$$ \exists !, e_0 \in \mathbb{N} \quad\text{e}\quad e_0 = 0 $$
### Assiomi del prodotto

|Proprietà|Formula|
|---|---|
|Commutativo|$a\cdot b=b\cdot a \quad \forall a,b\in\mathbb{N}$|
|Associativo|$(a\cdot b)\cdot c=a\cdot(b\cdot c)$|
|Elemento neutro|$\exists, e_1\in\mathbb{N}$ tale che $a\cdot e_1=a \quad \forall a\in\mathbb{N}$|

Anche qui l'elemento neutro è unico:

$$ \exists !, e_1 \in \mathbb{N} \quad\text{e}\quad e_1 = 1 $$

## Proprietà Dei Numeri Naturali
### Ordinamento Totale

Per $a,b\in\mathbb{N}$ si **definisce**:

$$ a \le b \quad\Longleftrightarrow\quad \exists, c \in \mathbb{N} \ \mid\ a + c = b $$

(cioè $a\le b$ se esiste un naturale $c$ che sommato ad $a$ dà $b$). Questa relazione ha quattro proprietà:

|Proprietà|Enunciato|
|---|---|---|
|a)|**Riflessiva**|$a\le a \quad \forall a\in\mathbb{N}$|
|b)|**Antisimmetrica**|$\forall a,b\in\mathbb{N}$: se $a\le b$ e $b\le a$ allora $a=b$|
|c)|**Transitiva**|$\forall a,b,c\in\mathbb{N}$: se $a\le b$ e $b\le c$ allora $a\le c$|
|d)|**Dicotomia**|$\forall a,b\in\mathbb{N}$: vale $a\le b$ oppure $b\le a$|

### Compatibilità

**Compatibilità $(\le,+)$:**

$$ \forall a,b,c\in\mathbb{N}: \quad a\le b \Longrightarrow a+c \le b+c $$
**Compatibilità $(\le,\cdot)$:**

$$ \forall a,b,c\in\mathbb{N}: \quad a\le b \ \text{ e } \ c>0 ;\Longrightarrow; a\cdot c \le b\cdot c $$

> [!note] La stessa proprietà vale anche con la disuguaglianza stretta ($a<b$, $c>0 \Rightarrow ac<bc$).

___
# Principio di Induzione
## Enunciato
- Seguendo la struttura vista:
$$
\underbrace{\text{Contesto}}_{\text{"Sia}\ldots\text{"}} \;+\; \underbrace{\text{Ipotesi}}_{\text{premessa}} \;\Longrightarrow\; \underbrace{\text{Tesi}}_{\text{conseguenza}}
$$


**Contesto**
 - Sia $A \subseteq \mathbb{N}$ (un sottoinsieme di $\mathbb{N}$) e sia $p\in\mathbb{N}$.
**Ipotesi**
- Premessa 1 — **passo** **base**: $p \in A$
- Premessa 2 — **passo** **induttivo**: $n \in A ;\Longrightarrow; n+1 \in A$ (è un'implicazione)
**Tesi** $${ n\in\mathbb{N} \mid n \ge p ,} \subseteq A$$ **In parole**: se la proprietà vale per $p$ e, ogni volta che vale per $n$, vale anche per $n+1$, allora vale per tutti i naturali da $p$ in poi.
## Esempio svolto: somma dei primi n numeri naturali

### Proposizione

$$\forall n\in\mathbb{N},\ n\ge 1: \qquad \sum_{i=1}^{n} i = \frac{n(n+1)}{2} \qquad (*)$$

Cioè $1+2+3+\dots+(n-1)+n=\dfrac{n(n+1)}{2}$.

> [!NOTE] Nota a margine
> Nell'appunto compare anche la somma dei quadrati  
> $\sum_{i=1}^{n} i^2 = 1+2^2+3^2+\dots+(n-1)^2+n^2$,  
> scritta come spunto per altre proposizioni dimostrabili per induzione.

### Impostazione

Si applica il principio di induzione (Contesto + Ipotesi ⟹ Tesi).

**Contesto**: Sia  

$$A=\{n\in\mathbb{N}\mid (*)\text{ è vera}\}\subseteq\mathbb{N}, \qquad p=1.$$

**Ipotesi da verificare**:

1. Passo base: $1\in A$
2. Passo induttivo: $n\in A \Rightarrow n+1\in A$

**Tesi che otterremo**: $\{n\in\mathbb{N}\mid n\ge 1\}\subseteq A$, cioè la formula vale per ogni $n\ge 1$.
### Passo base ($p=1$, cioè $1\in A$)
Si controlla la formula per $n=1$.
Primo membro:  
$$\sum_{i=1}^{1} i = 1$$

Secondo membro:  

$$\frac{1\cdot(1+1)}{2} = \frac{2}{2} = 1$$

I due membri coincidono, quindi $1\in A$: il passo base è verificato.
### Passo induttivo ($n\in A \Rightarrow n+1\in A$)

Si tratta di un'implicazione: si **assume** la premessa e si **deduce** la conseguenza.
- **Ipotesi induttiva (IP)**: la formula vale per $n$, cioè  $$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$
- **Tesi induttiva**: la formula vale per $n+1$, cioè  
  
Sostituzione di $n$ con $n+1$ in $(*)$:
$$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$
**Primo membro**:  

$$\sum_{i=1}^{n} i \;\longrightarrow\; \sum_{i=1}^{n+1} i$$

**Secondo membro**:  

$$\frac{n(n+1)}{2} \;\longrightarrow\; \frac{(n+1)\big((n+1)+1\big)}{2}$$ $$(n+1)+1 = n+2$$ $$\frac{(n+1)\big((n+1)+1\big)}{2} = \frac{(n+1)(n+2)}{2}$$
**Risultato**:  
$$\sum_{i=1}^{n+1} i = \frac{(n+1)(n+2)}{2}$$
### Dimostrazione Del Passo Induttivo
Attenzione: si parte dal **primo membro** della tesi induttiva e si arriva al secondo, senza partire dalla tesi stessa.
**Catena completa**:  
$$  
\sum_{i=1}^{n+1} i  
= \sum_{i=1}^{n} i + (n+1)  
\overset{\text{IP}}{=} \frac{n(n+1)}{2} + (n+1)  
= \frac{n(n+1) + 2(n+1)}{2}  
= \frac{(n+1)(n+2)}{2}  
$$

L'ultimo membro è esattamente la tesi induttiva, quindi $n\in A \Rightarrow n+1\in A$: il passo induttivo è verificato.

### Conclusione
Sono verificati sia il **passo base** ($1\in A$) sia il **passo induttivo** ($n\in A\Rightarrow n+1\in A$).
Per il principio di induzione  
$$A=\{n\in\mathbb{N}\mid n\ge 1\},$$
cioè la formula $(*)$ vale per ogni $n\ge 1$.
**Osservazione finale**. Poiché $\sum_{i=1}^{n} i$ è una somma di numeri naturali, è un numero naturale. Per $(*)$ è uguale a $\frac{n(n+1)}{2}$, quindi anche  

$$\frac{n(n+1)}{2}\ \text{è un numero naturale.}$$
(Lo si vede anche direttamente: tra $n$ e $n+1$ uno dei due è pari, quindi il prodotto $n(n+1)$ è divisibile per 2.)

___
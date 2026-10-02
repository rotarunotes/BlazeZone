Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index

- [[#Insiemi numerici]]
- [[#Appartenenza e inclusione]]
- [[#Operazioni tra insiemi]]
- [[#Quantificatori]]
- [[#Logica]]
- [[#Uguaglianza e ordine]]
- [[#Funzioni]]
- [[#Sommatorie e prodotti]]
- [[#Parte intera]]

___
# Insiemi numerici

| Simbolo      | Si legge | Significato                                                                                                 |
| ------------ | -------- | ----------------------------------------------------------------------------------------------------------- |
| $\mathbb{N}$ | "enne"   | Insieme dei numeri naturali ${0,1,2,3,\dots}$                                                               |
| $\mathbb{Z}$ | "zeta"   | Insieme dei numeri interi relativi ${\dots,-2,-1,0,1,2,\dots}$                                              |
| $\mathbb{Q}$ | "cu"     | Insieme dei numeri razionali: $\left\{\frac{m}{n} \mid m\in\mathbb{Z},\ n\in\mathbb{Z}\setminus{0}\right\}$ |
| $\mathbb{R}$ | "erre"   | Insieme dei numeri reali (razionali e irrazionali)                                                          |
| $\mathbb{C}$ | "ci"     | Insieme dei numeri complessi ${a+ib \mid a,b\in\mathbb{R}}$                                                 |
___
# Appartenenza e inclusione

| Simbolo     | Si legge                    | Significato                                                                                        |
| ----------- | --------------------------- | -------------------------------------------------------------------------------------------------- |
| $\in$       | "appartiene a"              | $a \in \mathbb{N}$: l'elemento $a$ è nell'insieme $\mathbb{N}$                                     |
| $\notin$    | "non appartiene a"          | Negazione di $\in$                                                                                 |
| $\subseteq$ | "è sottoinsieme di"         | $A \subseteq \mathbb{N}$: ogni elemento di $A$ è anche in $\mathbb{N}$ (può essere $A=\mathbb{N}$) |
| $\subset$   | "è sottoinsieme proprio di" | $A \subset B$: $A\subseteq B$ e $A \ne B$                                                          |
| $\emptyset$ | "insieme vuoto"             | L'insieme che non contiene alcun elemento                                                          |
___
# Operazioni tra insiemi

|Simbolo|Si legge|Significato|
|---|---|---|
|$\cap$|"intersezione"|$A\cap B={x \mid x\in A \land x\in B}$ (elementi che stanno in $A$ **e** in $B$)|
|$\cup$|"unione"|$A\cup B={x \mid x\in A \lor x\in B}$ (elementi che stanno in $A$ **o** in $B$)|
|$\setminus$|"meno" (differenza)|$A\setminus B={x \in A \mid x\notin B}$|
|$\times$|"prodotto cartesiano"|$\mathbb{N}\times\mathbb{N}$: insieme delle coppie $(a,b)$ con $a,b\in\mathbb{N}$|

___
# Quantificatori

|Simbolo|Si legge|Significato|
|---|---|---|
|$\forall$|"per ogni"|Quantificatore universale: $\forall a \in \mathbb{N}$|
|$\exists$|"esiste"|Quantificatore esistenziale: $\exists c \in \mathbb{N}$|
|$\exists !$|"esiste ed è unico"|Esiste **uno e uno solo** elemento con quella proprietà|
|$\mid$|"tale che"|In ${x \mid \dots}$ o $\exists c \mid \dots$ introduce la condizione (anche "t.c."). Attenzione: $a \mid b$ può anche significare "$a$ divide $b$"|
___
# Logica

|Simbolo|Si legge|Significato|
|---|---|---|
|$\Rightarrow$|"implica"|Implicazione logica: $A \Rightarrow B$|
|$\Leftarrow$|"è implicato da"|$A \Leftarrow B$ equivale a $B \Rightarrow A$|
|$\Leftrightarrow$|"se e solo se"|Doppia implicazione (equivalenza), es. nella definizione di $\le$|
|$\neg$|"non"|Negazione: $\neg B$ è vero quando $B$ è falso|
|$\land$|"e"|Congiunzione: $A \land B$ è vero quando sono veri entrambi (corrisponde a "e" nei testi)|
|$\lor$|"o"|Disgiunzione: $A \lor B$ è vero quando almeno uno dei due è vero (corrisponde a "o" nei testi; è un "o" non esclusivo)|

___
# Uguaglianza e ordine

|Simbolo|Si legge|Significato|
|---|---|---|
|$\ne$|"diverso"|$C \ne A$: $C$ è diverso da $A$|
|$:=$|"è definito come"|$a := b+c$: si pone $a$ uguale a $b+c$ per definizione|
|$\le$|"minore o uguale"|$a \le b \Leftrightarrow \exists c \in \mathbb{N} \mid a + c = b$|
|$<$|"minore (strettamente)"|$a < b \Leftrightarrow a \le b \land a \ne b$|

___
# Funzioni

|Simbolo|Si legge|Significato|
|---|---|---|
|$\to$|"va da … a …"|Dominio e codominio di una funzione: $f:\mathbb{N}\to\mathbb{N}$|
|$\mapsto$|"mappa a"|Dice a cosa viene mandato un elemento: $(a,b)\mapsto a+b$|

___
# Sommatorie e prodotti

|Simbolo|Si legge|Significato|
|---|---|---|
|$\sum_{i=1}^{n}$|"sommatoria"|Somma dei termini per $i$ da $1$ a $n$|
|$\prod_{i=1}^{n}$|"produttoria"|Prodotto dei termini per $i$ da $1$ a $n$|
|$e_0,\ e_1$|"elementi neutri"|Neutro della somma ($=0$) e del prodotto ($=1$)|

___
# Parte intera

| Simbolo            | Si legge                         | Significato                                                                      |
| ------------------ | -------------------------------- | -------------------------------------------------------------------------------- |
| $\lfloor x\rfloor$ | "floor" (parte intera inferiore) | $n=\lfloor x\rfloor$: il più grande intero $\le x$. Es. $\lfloor 2{,}5\rfloor=2$ |
| $\lceil x\rceil$   | "ceil" (parte intera superiore)  | $n=\lceil x\rceil$: il più piccolo intero $\ge x$. Es. $\lceil 2{,}5\rceil=3$    |
___
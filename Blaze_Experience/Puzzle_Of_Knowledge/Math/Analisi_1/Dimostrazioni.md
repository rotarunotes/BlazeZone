Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___

# Per Principio di Induzione

## 1) somma dei primi $n$ naturali

### Enunciato

$$\forall n\in\mathbb{N},\ n\ge 1: \qquad \sum_{i=1}^{n} i = \frac{n(n+1)}{2} \qquad (*)$$

Cioè $1+2+3+\dots+(n-1)+n=\dfrac{n(n+1)}{2}$.

> [!info] Info: Nota a margine
> Altre proposizioni dimostrabili per induzione, ad esempio la somma dei quadrati:
> $$\sum_{i=1}^{n} i^2 = 1+2^2+3^2+\dots+(n-1)^2+n^2$$

### Impostazione

| Parte         | Contenuto                                                                     |
| ------------- | ----------------------------------------------------------------------------- |
| **Contesto**  | Sia $A=\{n\in\mathbb{N}\mid (*)\text{ è vera}\}\subseteq\mathbb{N}$ e $p=1$. |
| **Ipotesi 1** | **Passo base**: $1\in A$                                                      |
| **Ipotesi 2** | **Passo induttivo**: $n\in A \Rightarrow n+1\in A$                            |
| **Tesi**      | $\{n\in\mathbb{N}\mid n\ge 1\}\subseteq A$, cioè la formula vale per ogni $n\ge 1$. |

### Passo base ($p=1$, cioè $1\in A$)

Si controlla la formula per $n=1$.

- Primo membro: $\displaystyle\sum_{i=1}^{1} i = 1$
- Secondo membro: $\displaystyle\frac{1\cdot(1+1)}{2} = \frac{2}{2} = 1$

> [!success] Dimostrazione: Passo base
> I due membri coincidono, quindi $1\in A$: il passo base è verificato.

### Passo induttivo ($n\in A \Rightarrow n+1\in A$)

- **Ipotesi induttiva (IP)**: la formula vale per $n$
  $$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$
- **Tesi induttiva**: la formula vale per $n+1$

> [!info] Info: Come si scrive la tesi induttiva
> Si sostituisce $n$ con $n+1$ in $(*)$.
>
> Primo membro: $\displaystyle\sum_{i=1}^{n} i \;\longrightarrow\; \sum_{i=1}^{n+1} i$
>
> Secondo membro: $\displaystyle\frac{n(n+1)}{2} \;\longrightarrow\; \frac{(n+1)\big((n+1)+1\big)}{2} = \frac{(n+1)(n+2)}{2}$
>
> **Tesi induttiva**:
> $$\sum_{i=1}^{n+1} i = \frac{(n+1)(n+2)}{2}$$

> [!danger] Attenzione!
> Si parte dal **primo membro** della tesi induttiva e si arriva al **secondo**. Non si parte dalla tesi stessa (sarebbe un ragionamento circolare).

> [!success] Dimostrazione: Passo induttivo
> Per dimostrare il passo induttivo partiamo dal primo membro della tesi induttiva:
> $$\sum_{i=1}^{n+1} i = \sum_{i=1}^{n} i + (n+1) \overset{\text{IP}}{=} \frac{n(n+1)}{2} + (n+1) = \frac{n(n+1) + 2(n+1)}{2} = \frac{(n+1)(n+2)}{2}$$
> L'ultimo membro è esattamente la tesi induttiva, quindi $n\in A \Rightarrow n+1\in A$: il passo induttivo è verificato.

### Conclusione

> [!success] Dimostrazione: Conclusione
> Sono verificati sia il passo base ($1\in A$) sia il passo induttivo ($n\in A\Rightarrow n+1\in A$).
> Per il principio di induzione
> $$\{n\in\mathbb{N}\mid n\ge 1\}\subseteq A$$
> cioè la formula $(*)$ vale per ogni $n\ge 1$. $\blacksquare$

## 2) Somma Dei Primi Termini Di Una Progressione Geometrica (Finita)
### Enunciato
Sia $q \in \mathbb{R} \setminus \left\{0, 1\right\}$
$$\quad \sum_{k=0}^{n} q^k = \frac{1 - q^{n+1}}{1 - q} \qquad \forall n \in \mathbb{N} \space \space \space(*)$$
### Impostazione

| Parte         | Contenuto                                                                     |
| ------------- | ----------------------------------------------------------------------------- |
| **Contesto**  | Sia $A=\{n\in\mathbb{N}\mid (*)\text{ è vera}\}\subseteq\mathbb{N}$ e $p=0$.  |
| **Ipotesi 1** | **Passo base**: $0\in A$                                                      |
| **Ipotesi 2** | **Passo induttivo**: $n\in A \Rightarrow n+1\in A$                            |
| **Tesi**      | $\{n\in\mathbb{N}\mid n\ge 0\}\subseteq A$, cioè la formula vale per ogni $n\in\mathbb{N}$. |

### Passo base ($p=0$, cioè $0\in A$)

Si controlla la formula per $n=0$.

- Primo membro: $\displaystyle\sum_{k=0}^{0} q^k = q^0 = 1$
- Secondo membro: $\displaystyle\frac{1-q^{0+1}}{1-q} = \frac{1-q}{1-q} = 1$

> [!success] Dimostrazione: Passo base
> I due membri coincidono, quindi $0\in A$: il passo base è verificato.

### Passo induttivo ($n\in A \Rightarrow n+1\in A$)

- **Ipotesi induttiva (IP)**: la formula vale per $n$$$\sum_{k=0}^{n} q^k = \frac{1-q^{n+1}}{1-q}$$
- **Tesi induttiva**: la formula vale per $n+1$

> [!info] Info: Come si scrive la tesi induttiva
> Si sostituisce $n$ con $n+1$ in $(*)$.
>
> Primo membro: $\displaystyle\sum_{k=0}^{n} q^k \;\longrightarrow\; \sum_{k=0}^{n+1} q^k$
>
> Secondo membro: $\displaystyle\frac{1-q^{n+1}}{1-q} \;\longrightarrow\; \frac{1-q^{(n+1)+1}}{1-q} = \frac{1-q^{n+2}}{1-q}$
>
> **Tesi induttiva**:
> $$\sum_{k=0}^{n+1} q^k = \frac{1-q^{n+2}}{1-q}$$

> [!danger] Attenzione!
> Si parte dal **primo membro** della tesi induttiva e si arriva al **secondo**. Non si parte dalla tesi stessa (sarebbe un ragionamento circolare).

> [!success] Dimostrazione: Passo induttivo
> Per dimostrare il passo induttivo partiamo dal primo membro della tesi induttiva:
> $$\sum_{k=0}^{n+1} q^k = \sum_{k=0}^{n} q^k + q^{n+1} \overset{\text{IP}}{=} \frac{1-q^{n+1}}{1-q} + q^{n+1} = \frac{1-q^{n+1} + q^{n+1}(1-q)}{1-q} = \frac{1-q^{n+1}+q^{n+1}-q^{n+2}}{1-q} = \frac{1-q^{n+2}}{1-q}$$
> L'ultimo membro è esattamente la tesi induttiva, quindi $n\in A \Rightarrow n+1\in A$: il passo induttivo è verificato.

### Conclusione

> [!success] Dimostrazione: Conclusione
> Sono verificati sia il passo base ($0\in A$) sia il passo induttivo ($n\in A\Rightarrow n+1\in A$).
> Per il principio di induzione
> $$\{n\in\mathbb{N}\mid n\ge 0\}\subseteq A$$
> cioè la formula $(*)$ vale per ogni $n\in\mathbb{N}$. $\blacksquare$

> [!info] Info: Il caso $q=0$
> Per $q=0$ si definisce $\sum_{k=0}^{n} q^k = 1$, e la formula vale comunque: $\frac{1-0^{n+1}}{1-0} = 1$.

## 2) $n! \geq n$ per ogni $n\in\mathbb{N}$

### Enunciato

$$\forall n\in\mathbb{N}: \qquad n! \geq n \qquad (*)$$

### Impostazione

| Parte         | Contenuto                                                                   |
| ------------- | --------------------------------------------------------------------------- |
| **Contesto**  | Sia $A=\{n\in\mathbb{N}\mid (*)\text{ è vera}\}\subseteq\mathbb{N}$ e $p=1$ |
| **Ipotesi 1** | **Passo base**: $1\in A$                                                    |
| **Ipotesi 2** | **Passo induttivo**: $n\in A \Rightarrow n+1\in A$                          |
| **Tesi**      | $\{n\in\mathbb{N}\mid n\ge 1\}\subseteq A$, cioè la formula vale per ogni $n\ge 1$ |

> [!danger] Attenzione!
> Il passo induttivo usa $n\ge 1$, quindi la base è $p=1$. Il caso $n=0$ si verifica a parte: $0!=1\ge 0$. 

### Passo base ($p=0$, cioè $0\in A$)

- Primo membro: $0! = 1$
- Secondo membro: $0$

> [!success] Dimostrazione: Passo base
> $0!=1\ge 0$, quindi $1\in A$: il passo base è verificato.

### Passo induttivo ($n\in A \Rightarrow n+1\in A$)

- **Ipotesi induttiva (IP)**: la formula vale per $n$ (con $n\ge 1$)
  $$n! \geq n$$
- **Tesi induttiva**: la formula vale per $n+1$
  $$(n+1)! \geq n+1$$

> [!info] Info: Idea della dimostrazione
> Si usa $(n+1)! = (n+1)\cdot n!$ e si moltiplica l'IP per $(n+1)>0$. Moltiplicare per un numero positivo **conserva** il verso della disuguaglianza.

> [!danger] Attenzione!
> Si parte dal **primo membro** della tesi induttiva, $(n+1)!$, e si arriva al secondo. Non si parte dalla tesi stessa.

> [!success] Dimostrazione: Passo induttivo
> $$(n+1)! = (n+1)\cdot n! \;\overset{\text{IP}}{\geq}\; (n+1)\cdot n \;\geq\; (n+1)\cdot 1 = n+1$$
> Giustificazione dei passaggi:
> - $(n+1)\cdot n! \geq (n+1)\cdot n$: dall'IP $n!\ge n$, moltiplicando per $n+1>0$
> - $(n+1)\cdot n \geq (n+1)\cdot 1$: perché $n\ge 1$, moltiplicando per $n+1>0$
>
> Quindi $(n+1)!\ge n+1$, cioè $n\in A \Rightarrow n+1\in A$: il passo induttivo è verificato.

### Conclusione

> [!success] Dimostrazione: Passo induttivo
> Si assume l'IP: $n! \geq n$, con $n \geq 1$.
> Si parte dal primo membro della tesi induttiva e si costruisce una catena di disuguaglianze.
>
> **1. Si riscrive il fattoriale usando la definizione di fattoriale**
> $$(n+1)! = (n+1)\cdot n!$$
>
> **2. Si usa l'ipotesi induttiva**
> Moltiplicando $n! \geq n$ per $n+1>0$ il verso non cambia:
> $$(n+1)\cdot n! \;\geq\; (n+1)\cdot n$$
>
> **3. Si usa $n \geq 1$**
> Moltiplicando per $n \geq 1$ per $n+1>0$ il verso non cambia:
> $$(n+1)\cdot n \;\geq\; (n+1)\cdot 1 = n+1$$
>
> **Catena completa**
> $$(n+1)! = (n+1)\cdot n! \;\geq\; (n+1)\cdot n \;\geq\; n+1$$
>
> Quindi $(n+1)! \geq n+1$, cioè $n\in A \Rightarrow n+1\in A$: il passo induttivo è verificato.

___
# Per Contraddizione

> [!example] Esempio: $\sqrt{2}$ non è razionale
> 
> **Enunciato**: $\sqrt{2}\notin\mathbb{Q}$.
> 
> **Negazione**: per assurdo, $\sqrt{2}\in\mathbb{Q}$, cioè $\sqrt{2}=\frac{p}{q}$ con $p,q\in\mathbb{N}$ **senza fattori comuni**.
> 
> > [!success] Dimostrazione:
> > 1. Elevando al quadrato: $2q^2=p^2$, quindi $p^2$ è pari, quindi $p$ è pari.
> > 2. Allora $p=2k$ e $2q^2=4k^2$, cioè $q^2=2k^2$, quindi $q$ è pari.
> > 3. Ma $p$ e $q$ sono entrambi pari, contro l'ipotesi che non abbiano fattori comuni. **Assurdo.**
> > 
> > Quindi $\sqrt{2}\notin\mathbb{Q}$. $\blacksquare$
> > 

## 1) L' Equazione $x^2 - 2$ Non Ha Soluzioni Razionali

### Enunciato

| Parte         | Contenuto                                         |
| ------------- | ------------------------------------------------- |
| **Contesto**  | Sia $x\in\mathbb{Q}$                              |
| **Ipotesi**   | $x^2-2=0$ è l'equazione considerata               |
| **Tesi**      | Non esiste $x\in\mathbb{Q}$ tale che $x^2=2$, cioè $\sqrt{2}\notin\mathbb{Q}$ |
### Negazione

Si suppone per assurdo che la tesi sia falsa:

$$\exists\,\frac{m}{n}\in\mathbb{Q}\ \Big|\ \left(\frac{m}{n}\right)^2=2 \quad\text{con}\quad \text{M.C.D.}(m,n)=1$$

> [!info] Info: Perché si può supporre M.C.D.$(m,n)=1$
> Ogni frazione si può ridurre ai minimi termini. Quindi non è una restrizione: è sempre possibile.

### Deduzione

**1. Da frazione a intero**

$$\left(\frac{m}{n}\right)^2=2 \;\Rightarrow\; m^2=2n^2$$

> [!info] Info: Passaggio con l'inverso
> $$\left(m\cdot n^{-1}\right)^2 = m^2\cdot (n^{-1})^2$$
> $$m^2(n^{-1})^2=2$$ 
> Moltiplicando per $n^2$ (con $(n^{-1})^2 n^2=1$), si ottiene $$m^2=2n^2$$

**2. $m$ è pari**
$$m^2=2n^2$$ $2n^2$ è pari, quindi anche $m^2$ è pari, allora si dimostra:

> [!success] Dimostrazione:  $m^2$ pari $\Rightarrow$ $m$ pari (per contrapposizione)
> Si dimostra la contronominale: se $m$ è dispari, allora $m^2$ è dispari.
> Sia $m=2k+1$ con $k\in\mathbb{Z}$.
> Allora:
> $$m^2=(2k+1)^2=4k^2+4k+1=4k(k+1)+1$$
> che è dispari. $\blacksquare$


> [!Abstract] Definizione: Numero Pari
>$$\exists\, h\in\mathbb{Z}\ \Big|\ m=2h$$

**3. $n$ è pari**

Sostituendo in $m = 2h$ in $m^2 = 2n^2$:

$$(2h)^2=2n^2 \;\Rightarrow\; 4h^2=2n^2 \;\Rightarrow\; 2h^2=n^2$$

Quindi $n$ è pari, (Per la stessa dimostrazione di prima).

### Assurdo

> [!danger] Attenzione!
> $m$ e $n$ sono entrambi pari, quindi hanno il fattore comune $2$. Questo contraddice M.C.D.$(m,n)=1$. **Assurdo.**

### Conclusione

> [!success] Dimostrazione: Conclusione
> L'ipotesi che esista $\frac{m}{n}\in\mathbb{Q}$ con $\left(\frac{m}{n}\right)^2=2$ porta a un assurdo, quindi è falsa.
> Dunque $x^2-2=0$ non ha soluzioni razionali, cioè $\sqrt{2}\notin\mathbb{Q}$. $\blacksquare$

> [!info] Info: Generalizzazione
> Con lo stesso procedimento, se $p$ è un numero primo, l'equazione $x^2-p=0$ non ha soluzioni razionali, cioè $\sqrt{p}\notin\mathbb{Q}$.

___
# Per Contrapposizione

## m^2$ pari $\Rightarrow$ $m$ pari

### Enunciato

| Parte         | Contenuto                                          |
| ------------- | -------------------------------------------------- |
| **Contesto**  | Sia $m\in\mathbb{Z}$                               |
| **Ipotesi**   | $A$: $m^2$ è pari                                  |
| **Tesi**      | $B$: $m$ è pari                                    |

Da $m^2=2n^2$ sappiamo che $m^2$ è pari (è $2$ per un intero). Vogliamo concludere che anche $m$ è pari.
### Riscrittura

Si scrive la contronominale $\neg B \Rightarrow \neg A$:

- $\neg B$: $m$ è dispari
- $\neg A$: $m^2$ è dispari

**Contronominale**: se $m$ è dispari, allora $m^2$ è dispari.
### Assunzione
Si assume $\neg B$ vera: $m$ è dispari, cioè
$$m=2k+1 \qquad k\in\mathbb{Z}$$
### Deduzione
Si calcola il quadrato:
$$m^2=(2k+1)^2=4k^2+4k+1=4k(k+1)+1$$

> [!info] Info: Perché è dispari
> $4k(k+1)$ è multiplo di $2$ (è pari), quindi sommando $1$ si ottiene un numero dispari.
### Arrivo

$m^2=4k(k+1)+1$ è dispari, cioè vale $\neg A$.

### Conclusione

> [!success] Dimostrazione: $m^2$ pari $\Rightarrow$ $m$ pari (per contrapposizione)
> Si è dimostrato $\neg B \Rightarrow \neg A$: se $m$ è dispari, allora $m^2$ è dispari.
> Poiché è equivalente a $A \Rightarrow B$, vale anche: se $m^2$ è pari, allora $m$ è pari. $\blacksquare$

___
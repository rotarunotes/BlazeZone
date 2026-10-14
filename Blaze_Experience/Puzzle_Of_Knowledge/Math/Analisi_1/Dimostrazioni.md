Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index

- [[#Per Principio di Induzione]]
	- [[#1) somma dei primi $n$ naturali|1) Somma dei primi n naturali]]
	- [[#2) Somma Dei Primi Termini Di Una Progressione Geometrica (Finita)|2) Somma Dei Primi Termini Di Una Progressione Geometrica (Finita)]]
	- [[#3) $n! \geq n$ per ogni $n \in \mathbb{N}$|3) n! ≥ n per ogni n ∈ ℕ]]
	- [[#4) Disuguaglianza di Bernoulli]]
	- [[#5) $n! \ge 2^n$ $\forall n \ge 4$|5) n! ≥ 2ⁿ ∀ n ≥ 4]]
	- [[#6) $n^2 \ge n+1$ $\forall n\ge 2$|6) n² ≥ n+1 ∀ n ≥ 2]]
	- [[#7) $n! \ge n^2$ $\forall n \ge 4$|7) n! ≥ n² ∀ n ≥ 4]]
- [[#Per Diretta]]
	- [[#1) Teorema di Densità di $\mathbb{Q}$ in $\mathbb{R}$|1) Teorema di Densità di ℚ in ℝ]]
- [[#Per Contraddizione]]
	- [[#1) L' Equazione $x^2 - 2$ Non Ha Soluzioni Razionali|1) L' Equazione x² − 2 Non Ha Soluzioni Razionali]]
	- [[#2) Proprietà Di Archimede]]
	- [[#3) $\mathbb{Z}$ Non È Inferiormente Limitato|3) ℤ Non È Inferiormente Limitato]]
	- [[#4) Biiettività di $\psi : \mathbb{N} \to P$|4) Biiettività di ψ : ℕ → P]]
- [[#Per Contrapposizione]]
	- [[#1) $m^2$ pari $\Rightarrow$ $m$ pari|1) m² pari ⇒ m pari]]
- [[#Per Doppia Implicazione]]
	- [[#1) Caratterizzazione di $\sup()$|1) Caratterizzazione di sup()]]
	- [[#2) Caratterizzazione di $\inf()$: Da Fare|2) Caratterizzazione di inf(): Da Fare]]
___

# Per Principio di Induzione

## 1) somma dei primi $n$ naturali

### Enunciato
$\forall n\in\mathbb{N},\ n\ge 1$
$$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$

Cioè $1+2+3+\dots+(n-1)+n=\dfrac{n(n+1)}{2}$.

> [!info] Info: Nota a margine
> Altre proposizioni dimostrabili per induzione, ad esempio la somma dei quadrati:
> $$\sum_{i=1}^{n} i^2 = 1+2^2+3^2+\dots+(n-1)^2+n^2$$

∑ᵢ₌₁ⁿ i = n(n+1)/2
### Passo base ($p=1$)

Si controlla la formula per $n=1$.

- Primo membro: $\displaystyle\sum_{i=1}^{1} i = 1$
- Secondo membro: $\displaystyle\frac{1\cdot(1+1)}{2} = \frac{2}{2} = 1$

> [!success] Dimostrazione: Passo base
> I due membri coincidono, quindi $1\in A$: il passo base è verificato.

### Passo induttivo

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
> Sono verificati sia il passo base e sia il passo induttivo.
> Per il principio di induzione:
> $$\{n\in\mathbb{N}\mid n\ge 1\}\subseteq A$$
> cioè la formula $\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$ vale per ogni $n\ge 1$. $\blacksquare$

## 2) Somma Dei Primi Termini Di Una Progressione Geometrica (Finita)
### Enunciato
$q \in \mathbb{R} \setminus \left\{0, 1\right\}$
$$\quad \sum_{k=0}^{n} q^k = \frac{1 - q^{n+1}}{1 - q} \qquad \forall n \in \mathbb{N} \space \space \space$$
### Passo base ($p=0$)

Si controlla la formula per $n=0$.

- Primo membro: $\displaystyle\sum_{k=0}^{0} q^k = q^0 = 1$
- Secondo membro: $\displaystyle\frac{1-q^{0+1}}{1-q} = \frac{1-q}{1-q} = 1$

> [!success] Dimostrazione: Passo base
> I due membri coincidono, quindi $0\in A$: il passo base è verificato.

### Passo induttivo

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
> Sono verificati sia il passo base sia il passo induttivo.
> Per il principio di induzione:
> $$\{n\in\mathbb{N}\mid n\ge 0\}\subseteq A$$
> cioè la formula $\quad \sum_{k=0}^{n} q^k = \frac{1 - q^{n+1}}{1 - q}$ vale per ogni $n\in\mathbb{N}$. $\blacksquare$

> [!info] Info: Il caso $q=0$
> Per $q=0$ si definisce $\sum_{k=0}^{n} q^k = 1$, e la formula vale comunque: $\frac{1-0^{n+1}}{1-0} = 1$.

## 3) $n! \geq n$ per ogni $n \in \mathbb{N}$

### Enunciato
$\forall n\in\mathbb{N}$

$$n! \geq n \qquad (*)$$

> [!danger] Attenzione!
> Il passo induttivo usa $n\ge 1$, quindi la base è $p=1$. Il caso $n=0$ si verifica a parte: $0!=1\ge 0$. 

### Passo base ($p=0$, cioè $0\in A$)

- Primo membro: $0! = 1$
- Secondo membro: $0$

> [!success] Dimostrazione: Passo base
> $1\ge 0$, quindi $1\in A$: il passo base è verificato.

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

## 4) Disuguaglianza di Bernoulli
### Enunciato
Sia $x \in \mathbb{R}$ con $x > -1$ fissato.

$$ \forall n\in\mathbb{N}: \qquad (1+x)^n \ge 1 + nx \qquad (\circledast) $$
### Passo base ($p=0$, cioè $0\in A$)

- Primo membro: $(1+x)^0 = 1$
- Secondo membro: $1 + 0\cdot x = 1$

> [!Success] Dimostrazione: Passo base
> Passo base $(1+x)^0 = 1 \ge 1 + 0\cdot x = 1$, quindi $0\in A$: il passo base è verificato.

### Passo induttivo ($n\in A \Rightarrow n+1\in A$)

- **Ipotesi induttiva (IP)**: la formula vale per $n$ (con $n\ge 0$) $$(1+x)^n \ge 1 + nx$$
- **Tesi induttiva**: la formula vale per $n+1$ $$(1+x)^{n+1} \ge 1 + (n+1)x$$

> [!Success] Dimostrazione: Passo induttivo  
> Si parte dal primo membro della tesi induttiva. Per la definizione di potenza:
> 
> $$(1+x)^{n+1} = (1+x)^n\cdot(1+x)$$
> 
> Allora, moltiplicando l'IP $$(1+x)^n \ge 1+nx$$ 
> 
> Per $1+x>0$ (il verso non cambia):
> 
> $$(1+x)^n\cdot(1+x) \ge (1+nx)(1+x)$$
> 
> Si deduce, sviluppando il prodotto:
> 
> $$(1+nx)(1+x) = 1 + x + nx + nx^2$$
> 
> Allora, poiché $nx^2 \ge 0$ (con $n\ge 0$ e $x^2\ge 0$), vale la disequazione:
> 
> $$1 + x + nx + nx^2 \ge 1 + x + nx + 0$$
> 
> E così, raccogliendo $x$:
> 
> $$1 + x + nx = 1 + (n+1)x$$
> 
>Ora si ritorna all'inizio della catena:
> 
> $$(1+x)^{n+1} \ge 1 + (n+1)x$$
> 

### Conclusione

> [!Success] Dimostrazione: Conclusione
> Il passo base e il passo induttivo sono verificati, quindi per il principio di induzione ${n\in\mathbb{N}\mid n\ge 0}\subseteq A$, cioè $$(1+x)^n \ge 1+nx \qquad \forall x>-1, \forall n\in\mathbb{N}. \qquad \blacksquare$$

## 5) $n! \ge 2^n$ $\forall n \ge 4$

### Enunciato
$\forall n \ge 4$
$$n! > 2^n$$
### Passo base ($p=4$)

- Primo membro: $4! = 4\cdot 3\cdot 2\cdot 1 = 24$
- Secondo membro: $2^4 = 16$

> [!Success] Dimostrazione:
> 24 > 16, Passo base verificato

### Passo induttivo

- **Ipotesi induttiva (IP)**:
$$n! > 2^n$$
- **Tesi induttiva**:
$$(n+1)! > 2^{n+1}$$

> [!Success] Dimostrazione: Passo Induttivo
> Ricordo: 
> $$(n+1)! = (n+1)\cdot n!$$
> 
> Moltiplicando per $(n+1)$:
> $$n! > 2^n$$
> Otteniamo:
> $$(n+1) \cdot n! > 2^n \cdot (n+1)$$
> Se $n ≥ 4$, allora $n+1 ≥ 5$, e quindi in particolare $n+1 ≥ 2$
> $$2^n \cdot (n+1) \ge 2 \cdot 2^n$$
> Proprietà delle potenze:
> $$2 \cdot 2^n = 2^{n+1}$$
> 
> 

### Conclusione: 

> [!Success] Dimostrazione: Conclusione
> Il passo induttivo è verificato per il principio di induzione $n! > 2^n$   $\forall n \ge 4$. $\blacksquare$

## 6) $n^2 \ge n+1$ $\forall n\ge 2$
### Enunciato 
$\forall n\ge 2$
 $$n^2 \ge n+1$$
### Passo base ($p = 2$)
- $2^2 \ge 2+1$


> [!Success] Dimostrazione:
> $4 \ge 3$, Passo base verificato.

### Passo Induttivo ($n\in A \Rightarrow n+1\in A$)

- **Ipotesi induttiva (IP)**: 
$$n^2 \ge n+1$$
- **Tesi induttiva**:
$$(n+1)^2 \ge n+2$$


> [!Success] Dimostrazione: Passo induttivo
> $$(n+1)^2 = n^2+2n+1$$ 
> Ricordiamo:
> $$n^2 \ge n+1$$
> Ritroviamo che:
> 
> $$n^2+2n+1 \ge n+1 + 2n+1 $$
> Sommando e riportando $n+2$ della tesi induttiva si ha che:
> $$3n+2 \ge n +2$$
> $$3n \ge n$$

### Conclusione

> [!Success] Dimostrazione: Conclusione
> Entrambi i passi sono stati dimostrati

## 7) $n! \ge n^2$ $\forall n \ge 4$

### Enunciato
$\forall n\in\mathbb{N}, n\ge 4$
$$  
n! \ge n^2 \qquad
$$
### Passo base ($p=4$, cioè $4\in A$)

- Primo membro: $4! = 4\cdot3\cdot2\cdot1 = 24$
- Secondo membro: $4^2 = 16$

> [!Success] Dimostrazione: Passo base  
> $4! = 24 \ge 4^2 = 16$, quindi $4\in A$: il passo base è verificato.

## Passo induttivo ($n\in A \Rightarrow n+1\in A$)

- **Ipotesi induttiva (IP)**: la formula vale per $n$ (con $n\ge 4$)  
    $$n! \ge n^2$$
- **Tesi induttiva**: la formula vale per $n+1$  
    $$(n+1)! \ge (n+1)^2$$

> [!Success] Dimostrazione: Passo induttivo  
> Per la definizione di fattoriale:
> 
> $$(n+1)! = (n+1)\cdot n!$$
> 
> Allora, moltiplicando l'IP:
> $$n! \ge n^2$$ 
> 
> Per $n+1>0$ (il verso non cambia):
> 
> $$(n+1)\cdot n! \ge (n+1)\cdot n^2$$
> 
> > [!Success] Dimostrazione: $n^2 \ge n+1$
> > [[#6) $n^2 \ge n+1$ $\forall n\ge 2$|Dimostrazione]]
> 
> Per ciò si moltiplicando per $n+1>0$:
> 
> $$(n+1)\cdot n^2 \ge (n+1)(n+1) = (n+1)^2$$
> 
> Mettendo insieme i passaggi:
> 
> $$(n+1)! \ge (n+1)^2$$
> 
> cioè $n\in A \Rightarrow n+1\in A$: il passo induttivo è verificato.
### Conclusione

> [!Success] Dimostrazione: Conclusione
> Il passo base e il passo induttivo sono verificati, quindi per il principio di induzione ${n\in\mathbb{N}\mid n\ge 4}\subseteq A$, cioè  
> $$n! \ge n^2 \qquad \forall n\ge 4. \qquad \blacksquare$$

___
# Per Diretta
## 1) Teorema di Densità di $\mathbb{Q}$ in $\mathbb{R}$

### Enunciato

| Parte       | Contenuto                                                 |
| ----------- | --------------------------------------------------------- |
| **Ipotesi** | $x \in \mathbb{R}$ e $\varepsilon > 0$                    |
| **Tesi**    | $\exists z \in \mathbb{Q} \mid z \le x < z + \varepsilon$ |

### Assunzione

Sia $x \in \mathbb{R}$ e sia $\varepsilon > 0$.

Allora: $$\frac{1}{\varepsilon} > 0$$
___
### Deduzione

**1. Scelgo $q$ con Archimede**:

$$\exists q \in \mathbb{N} \ \mid\ q > \frac{1}{\varepsilon} > 0$$
**2. Considero $qx**:

$$qx \in \mathbb{R}$$

**3. Utilizzo la proprietà la parte intera**:

$$\exists p \in \mathbb{Z} \ \mid\ p \le qx < p + 1$$

**4. Divido per $q$**:

$$\frac{p}{q} \le x < \frac{p+1}{q} $$
$$\frac{p}{q} \le x < \frac{p}{q} + \frac{1}{q} $$


**5. Confronto $\frac{1}{q}$ con $\varepsilon$**:

$$q > \frac{1}{\varepsilon} \Longrightarrow \varepsilon q > 1 \Longrightarrow \boxed{\varepsilon > \frac{1}{q}}$$
### Arrivo

Dal passo 4 e dal passo 5: 
$$\frac{p}{q} \le x < \frac{p}{q} + \varepsilon$$

Pongo $z = \dfrac{p}{q}$

> [!Info] Info:
> Poiché $p \in \mathbb{Z}$ e $q \in \mathbb{N}$, $q > 0$, si ha $z \in \mathbb{Q}$.

### Conclusione

Abbiamo trovato $z \in \mathbb{Q}$ con $z \le x < z + \varepsilon$.

Quindi, per ogni $x \in \mathbb{R}$ e $\varepsilon > 0$, vale la tesi. 

> [!Success] Dimostrazione: 
> Conseguenza Tra due reali $a < b$ esiste sempre sia un razionale sia un irrazionale.

___
# Per Contraddizione

## 1) L' Equazione $x^2 - 2$ Non Ha Soluzioni Razionali

### Assunzione

> [!Abstract] Definizione: Enunciato
>| Parte        | Contenuto                                                                     |
| ------------ | ----------------------------------------------------------------------------- |
| **Contesto** | Sia $x\in\mathbb{Q}$                                                          |
| **Ipotesi**  | $x^2-2=0$ è l'equazione considerata                                           |
| **Tesi**     | Non esiste $x\in\mathbb{Q}$ tale che $x^2=2$, cioè $\sqrt{2}\notin\mathbb{Q}$ |

### Negazione

Si suppone per assurdo che la tesi sia falsa:

$$\exists\,\frac{m}{n}\in\mathbb{Q}\ \Big|\ \left(\frac{m}{n}\right)^2=2 \quad\text{con}\quad \text{M.C.D.}(m,n)=1$$

> [!info] Info: Perché si può supporre M.C.D.$(m,n)=1$
> Ogni frazione si può ridurre ai minimi termini. Quindi non è una restrizione: è sempre possibile.

### Deduzione

**1. Da frazione a intero**:

$$\left(\frac{m}{n}\right)^2=2 \;\Rightarrow\; m^2=2n^2$$

> [!info] Info: Passaggio con l'inverso
> $$\left(m\cdot n^{-1}\right)^2 = m^2\cdot (n^{-1})^2$$
> $$m^2(n^{-1})^2=2$$ 
> Moltiplicando per $n^2$ (con $(n^{-1})^2 n^2=1$), si ottiene $$m^2=2n^2$$

**2. $m$ è pari**:
$$m^2=2n^2$$ $2n^2$ è pari, quindi anche $m^2$ è pari, allora si dimostra:

> [!success] Dimostrazione:  $m^2$ pari $\Rightarrow$ $m$ pari (per contrapposizione)
> [[#1) $m^2$ pari $\Rightarrow$ $m$ pari|Dimostrazione]]


> [!Abstract] Definizione: Numero Pari
>$$\exists\, h\in\mathbb{Z}\ \Big|\ m=2h$$

**3. $n$ è pari**

Sostituendo in $m = 2h$ in $m^2 = 2n^2$:

$$(2h)^2=2n^2 \;\Rightarrow\; 4h^2=2n^2 \;\Rightarrow\; 2h^2=n^2$$

Quindi $n$ è pari, (Per la stessa dimostrazione di prima).

### Assurdo

> [!danger] Attenzione!
> $m$ e $n$ sono entrambi pari, quindi hanno il fattore comune $2$. Questo contraddice M.C.D.$(m,n)=1$. **Assurdo**.

### Conclusione

> [!success] Dimostrazione: Conclusione
> L'ipotesi che esista $\frac{m}{n}\in\mathbb{Q}$ con $\left(\frac{m}{n}\right)^2=2$ porta a un assurdo, quindi è falsa.
> Dunque $x^2-2=0$ non ha soluzioni razionali, cioè $\sqrt{2}\notin\mathbb{Q}$. $\blacksquare$

> [!info] Info: Generalizzazione
> Con lo stesso procedimento, se $p$ è un numero primo, l'equazione $x^2-p=0$ non ha soluzioni razionali, cioè $\sqrt{p}\notin\mathbb{Q}$.

## 2) Proprietà Di Archimede

> [!abstract] Definizione: Proprietà Di Archimede
>  $$\forall x\in\mathbb{R}\ \ \exists n\in\mathbb{N}\ \Big|\ n>x$$
> 
> Per ogni numero reale $x$ esiste un numero naturale $n$ maggiore di $x$

### Assunzione

> [!Abstract] Definizione: Enunciato
> 
> |Parte|Contenuto|
> |---|---|
> |**Contesto**|Sia $x\in\mathbb{R}$|
> |**Ipotesi**|$\mathbb{N}\subseteq\mathbb{R}$ e vale l'assioma di separazione|
> |**Tesi**|Esiste $n\in\mathbb{N}$ tale che $n>x$|

**Caso $x\le 0$**

$n=1$ verifica la tesi: $1>0\ge x$.

**Caso $x>0$**

Si considera l'insieme dei naturali che non superano $x$, che Definiamo con $A$:

$$A:=\left\{n\in\mathbb{N}\mid n\le x\right\}\subseteq\mathbb{N}$$

> [!info] Info: Riformulazione della tesi 
> La tesi è "esiste $n$ con $n>x$". Se $A\neq\mathbb{N}$, c'è un naturale fuori da $A$, cioè un naturale che non soddisfa $n\le x$, quindi é $n>x$. 
> Dunque:  
$$\text{tesi}\iff A\neq\mathbb{N}$$
### Negazione

Si suppone per assurdo che la tesi sia falsa:

$$A=\mathbb{N}\ \ (\neq\emptyset)$$

cioè $n\le x$ per ogni $n\in\mathbb{N}$: 
- $x$ sarebbe un maggiorante di $\mathbb{N}$.
### Deduzione

**1. Si costruisce l'insieme dei maggioranti**:
$$B:=\left\{y\in\mathbb{R}\mid y\ge n\ \ \forall n\in\mathbb{N}\right\}$$

> [!Info] Info: A parole
> Abbiamo l'insieme $B$ che comprende tutti i numeri reale maggiori dei numeri naturali

Poiché $A=\mathbb{N}$, vale $x\ge n$ per ogni $n\in\mathbb{N}$, quindi $x\in B$ e $B\neq\emptyset$.

**2. $A$ e $B$ sono separati**:

Se $y\in B$, per definizione $y\ge n$ per ogni $n\in A$, $(A=\mathbb{N})$. 
Quindi:  
$$n\le y\quad\forall n\in A,\ \forall y\in B$$

Ogni elemento di $A$ sta a sinistra di ogni elemento di $B$.

**3. Esiste un elemento separatore**:

Per l'assioma di separazione:

$$\exists \lambda\in\mathbb{R}\ \Big|\ n\le\lambda\le y\quad \forall n\in A,\ \forall y\in B$$

**4. $\lambda-1$ è un maggiorante di $\mathbb{N}$**:

Se $n\in\mathbb{N}$ allora $n+1\in\mathbb{N}=A$, quindi, essendo $\lambda$ separatore:

$$n+1\le\lambda\Rightarrow n\le\lambda-1\quad \forall n\in A\ (=\mathbb{N})$$

Cioè $\lambda-1\in B$.

> [!info] Info: 
> Perché $n+1\in A$, $\mathbb{N}$ è chiuso rispetto alla somma di $1$.
>>[!Info] : Dire che $\mathbb{N}$ è chiuso rispetto a $+1$ vuol dire che dopo ogni naturale ce n'è un altro.
>
> Poiché $A=\mathbb{N}$ per ipotesi assurda, anche $n+1$ appartiene ad $A$ e quindi vale $n+1\le\lambda$.

### Assurdo

> [!danger] Attenzione! 
> $\lambda$ è separatore, quindi $\lambda\le y$ per ogni $y\in B$. In particolare, con $y=\lambda-1\in B$: $$\lambda\le\lambda-1\Rightarrow 1\le 0$$ Questo è falso. **Assurdo**.

### Conclusione

> [!success] Dimostrazione: 
> Conclusione L'ipotesi $A=\mathbb{N}$ porta a un assurdo, quindi è falsa: $A\neq\mathbb{N}$. Dunque esiste $n\in\mathbb{N}$ con $n>x$. $\blacksquare$

## 3) $\mathbb{Z}$ Non È Inferiormente Limitato

### Assunzione

> [!Abstract] Definizione: Enunciato
> | Parte        | Contenuto                                                |
> | ------------ | -------------------------------------------------------- |
> | **Contesto** | Sia $\mathbb{Z}\subseteq\mathbb{R}$                      |
> | **Ipotesi**  | $\mathbb{Z}=\{\dots,-2,-1,0,1,2,\dots\}$                 |
> | **Tesi**     | $\mathbb{Z}$ non è inferiormente limitato                |

### Negazione

Si suppone per assurdo che la tesi sia falsa, cioè che $\mathbb{Z}$ sia inferiormente limitato:

$$\exists\, b\in\mathbb{R}\ \Big|\ b\le z\quad\forall z\in\mathbb{Z}$$

> [!info] Info: In parole
> $b$ è un **minorante** di $\mathbb{Z}$: sta a sinistra (o coincide con) tutti gli interi.

### Deduzione

**1. $b$ è negativo**:

Poiché $-1\in\mathbb{Z}$, b deve essere negativo, quindi:
$$b<0$$

**2. Moltiplico per $-1$**:

$$b\le z\quad\forall z\in\mathbb{Z} $$ $$\Rightarrow\ -b\ge -z\quad\forall z\in\mathbb{Z}$$

**3. Pongo $w=-z$**:

$$-b\ge w\quad\forall w\in\mathbb{Z}$$

> [!info] Info: Perché $w$ varia su tutto $\mathbb{Z}$
> Al variare di $z$ in $\mathbb{Z}$, anche $w=-z$ percorre tutti gli interi (l'opposto di un intero è un intero, e ogni intero è l'opposto di un altro).

**4. $\mathbb{Z}$ è superiormente limitato**:

$-b$ è maggiore o uguale a ogni elemento di $\mathbb{Z}$, quindi $-b$ è un **maggiorante** di $\mathbb{Z}$:
$$\mathbb{Z}\ \text{è superiormente limitato}$$

### Assurdo

> [!danger] Attenzione!
> Ma $\mathbb{Z}$ **non** è superiormente limitato: se lo fosse, lo sarebbe anche $\mathbb{N}\subseteq\mathbb{Z}$, che invece non lo è (per Archimede). **Assurdo**.

### Conclusione

> [!success] Dimostrazione: Conclusione
> L'ipotesi che $\mathbb{Z}$ sia inferiormente limitato porta a un assurdo, quindi è falsa.
> Dunque $\mathbb{Z}$ non è inferiormente limitato. $\blacksquare$

___
## 4) Biiettività di $\psi : \mathbb{N} \to P$

> [!abstract] Definizione: Enunciato
> $$\psi : \mathbb{N} \to P, \qquad m \mapsto 2m$$
>
> |Parte|Contenuto|
> |---|---|
> |**Contesto**|$P=\{\,2m : m\in\mathbb{N}\,\}\subseteq\mathbb{N}$ (numeri pari)|
> |**Ipotesi**|$\psi(m)=2m$|
> |**Tesi**|$\psi$ è biiettiva|

> [!info] Info: Riformulazione della tesi
> Una funzione è biiettiva se è sia suriettiva sia iniettiva.
> $$\text{tesi}\iff \psi \text{ suriettiva} \ \land\ \psi \text{ iniettiva}$$
> Si dimostrano le due proprietà separatamente.

### Suriettività

> [!abstract] Definizione: Suriettività
> $$\forall\, 2m\in P\ \ \exists\, n\in\mathbb{N}\ \Big|\ \psi(n)=2m$$

**Dimostrazione (diretta)**:

Sia $2m\in P$. Si cerca $n\in\mathbb{N}$ tale che $\psi(n)=2m$.

Basta prendere $n=m$:
$$\psi(m)=2m$$

> [!success] Dimostrazione:
> Ogni elemento di $P$ è immagine di un naturale, quindi $\psi$ è **suriettiva**. $\blacksquare$

### Iniettività

> [!abstract] Definizione: Iniettività
> $$\forall\, m_1,m_2\in\mathbb{N},\quad m_1\neq m_2\ \Rightarrow\ \psi(m_1)\neq\psi(m_2)$$
> Elementi distinti hanno immagini distinte.

#### Assunzione

> [!Abstract] Definizione: Enunciato
>
> |Parte|Contenuto|
> |---|---|
> |**Contesto**|Siano $m_1,m_2\in\mathbb{N}$|
> |**Ipotesi**|$m_1\neq m_2$|
> |**Tesi**|$\psi(m_1)\neq\psi(m_2)$|

#### Negazione

Si suppone per assurdo che la tesi sia falsa:

$$\psi(m_1)=\psi(m_2)$$

#### Deduzione

**1. Si applica la definizione di $\psi$**:
$$\psi(m_1)=2m_1,\qquad \psi(m_2)=2m_2$$

**2. Dall'ipotesi assurda**:
$$2m_1=2m_2$$

**3. Si porta tutto a sinistra**:
$$2m_1-2m_2=0$$

**4. Si raccoglie il fattore comune**:
$$2(m_1-m_2)=0$$

**5. Si divide per $2$**:
$$m_1-m_2=0\ \Rightarrow\ m_1=m_2$$
#### Assurdo

> [!danger] Attenzione!
> Si è ottenuto $m_1=m_2$, ma per ipotesi $m_1\neq m_2$. **Assurdo**.

#### Conclusione

> [!success] Dimostrazione: Conclusione
> L'ipotesi $\psi(m_1)=\psi(m_2)$ porta a un assurdo, quindi è falsa: $\psi(m_1)\neq\psi(m_2)$. Dunque $\psi$ è **iniettiva**. $\blacksquare$

### Conclusione finale

> [!success] Dimostrazione: $\psi$ è biiettiva
> $\psi$ è suriettiva e iniettiva, quindi è **biiettiva**. $\blacksquare$
>
> Di conseguenza $\mathbb{N}$ e $P$ sono in corrispondenza biunivoca: $P$ è **numerabile**.

___
# Per Contrapposizione

## 1) $m^2$ pari $\Rightarrow$ $m$ pari


> [!Abstract] Definizione: Enunciato
>| Parte        | Contenuto            |
| ------------ | -------------------- |
| **Contesto** | Sia $m\in\mathbb{Z}$ |
| **Ipotesi**  | $A$: $m^2$ è pari    |
| **Tesi**     | $B$: $m$ è pari      |

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
# Per Doppia Implicazione

## 1) Caratterizzazione di $\sup()$

### Enunciato

$$
 x = \sup(A)\Leftrightarrow
\begin{cases}
x \ge a \quad \forall a \in A \\
\forall \varepsilon > 0\ \ \exists\, \bar a \in A \mid \bar a > x -\varepsilon
\end{cases}
$$
### ($\Rightarrow$)

**Ipotesi**: $A$ è superiormente limitato

$$x = \sup(A) \space \space A\in \mathbb{R}$$
**Tesi**:

1. $x \ge a \quad \forall a \in A$
2. $\forall \varepsilon > 0\ \ \exists\, \bar a \in A \mid \bar a > x -\varepsilon$

**Dimostrazione**:

> [!Success] Dimostrazione: Tesi 1
> Poiché:
> $$x = \min(M_A)$$
> Si ha $x \in M_A$, quindi $x \ge a$ $\forall a \in A$.

> [!Success] Dimostrazione: Tesi 2
> Sia:
> $$\varepsilon > 0$$
> Dato che $x = \min(M_A)$ e $x - \varepsilon < x$
> Si ha:
> $$x - \varepsilon \notin M_A$$
> Poniamo:
> $$x - \varepsilon = \alpha$$
> 
> Per definizione quando $\alpha \notin M_A$ significa che la proposizione "$\alpha \ge a$  $\forall a \in A$" è **falsa**
> cioè:
> $$\exists \bar a \in A \mid \alpha < \bar a$$
> Sostituendo:
> $$\exists \bar a \in A \mid x - \varepsilon < \bar a \qquad$$

### ($\Leftarrow$)

**Ipotesi**:

1. $A$ superiormente limitato
2. $x \ge a$ $\forall a \in A$
3. $\forall \varepsilon > 0$ $\exists \bar a \in A \mid \bar a > x - \varepsilon$

**Tesi**:
$$x = \sup(A)$$
2. Significa che $x \in M_A$
3. Significa che $x - \varepsilon \notin M_A$ $\forall \varepsilon > 0$

Dal terzo punto segue che:
$$ \min(M_A) > x - \varepsilon \qquad \forall \varepsilon > 0 \qquad$$
**Dimostrazione**:

> [!Success] Dimostrazione:
> Sia:
> $$y = \min(M_A)$$
> Se potessi avere:
> $$y < x$$
> Allora esisterebbe:
> $$\tilde\varepsilon > 0 \space | \space y \le x - \tilde\varepsilon$$Che Contraddice:
>  $$\min(M_A) > x - \varepsilon \qquad \forall \varepsilon > 0 \qquad$$
>  Pertanto:
>  $$y = \min(M_A) \ge x$$
>  Allora
>  $$x = \min(M_A)$$
>  $$x = \sup(A)$$

### Conclusione

Abbiamo verificato entrambe le implicazioni $A \Rightarrow B$ e $B \Rightarrow A$

## 2) Caratterizzazione di $\inf()$: Da Fare
___
Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___

# Per Principio di Induzione

## Esempio: somma dei primi $n$ naturali

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
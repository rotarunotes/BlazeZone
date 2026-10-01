Data: 2026-10-01
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___

# Fattoriale di $n \in \mathbb{N}$: $n!$


> [!abstract] Definizione: Induttiva
> 1. $0! := 1$
> 2. $(n+1)! := (n+1)\cdot n! \qquad \forall n\in\mathbb{N}$
>
> > [!info] Info:
> > Per induzione $n!$ è ben definito $\forall n\in\mathbb{N}$.
>
> **Conseguenza** (riga 2 con $n$ al posto di $n+1$):
> $$n! = n\,(n-1)! \qquad \forall n\ge 1$$


> [!Info] Info:
> $$n! = \prod_{i=1}^{n} i = 1 \cdot 2 \cdot 3 \cdot 4 \cdot \ldots \cdot n \qquad \text{(produttoria)}$$

___
# Coefficiente Binomiale


> [!Abstract] Definizione:
> $n, k \in \mathbb{N}$, $k \leq n$
> $$\binom{n}{k} := \frac{n!}{k!,(n-k)!} \qquad$$ $\text{per } k > n:$ $$\ \binom{n}{k} := 0$$
## Proprietà

# Coefficiente Binomiale

> [!abstract] Definizione:
> Per $n,k\in\mathbb{N}$ con $k\le n$, il **coefficiente binomiale** è
> $$\binom{n}{k}=\frac{n!}{k!\,(n-k)!}$$
> con la convenzione $0!=1$.

___
# Proprietà

## 1) $\dbinom{n}{0}=1$

$$\binom{n}{0}=1$$

> [!success] Dimostrazione:
> $$\binom{n}{0}=\frac{n!}{0!\,(n-0)!}=\frac{n!}{1\cdot n!}=1$$
> $\blacksquare$

## 2) $\dbinom{n}{n}=1$

$$\binom{n}{n}=1$$

> [!success] Dimostrazione:
> $$\binom{n}{n}=\frac{n!}{n!\,(n-n)!}=\frac{n!}{n!\cdot 0!}=1 \qquad (\text{con } 0!=1)$$
> $\blacksquare$

## 3) $\dbinom{n}{n-1}=n$

$$\binom{n}{n-1}=n \qquad (n\ge 1)$$

> [!success] Dimostrazione:
> $$\binom{n}{n-1}=\frac{n!}{(n-1)!\,\big(n-(n-1)\big)!}=\frac{n!}{(n-1)!\cdot 1!}=\frac{n\,(n-1)!}{(n-1)!}=n$$
> $\blacksquare$

## 4) Simmetria

$$\binom{n}{k}=\binom{n}{n-k} \qquad \forall k\le n$$

> [!success] Dimostrazione:
> Si scrivono i due membri:
> $$\binom{n}{k}=\frac{n!}{k!\,(n-k)!} \qquad\qquad \binom{n}{n-k}=\frac{n!}{(n-k)!\,\big(n-(n-k)\big)!}=\frac{n!}{(n-k)!\cdot k!}$$
> Il denominatore è lo stesso (il prodotto è commutativo), quindi i due coefficienti coincidono. $\blacksquare$

## 5) Formula di Stifel

$$\binom{n}{k}=\binom{n-1}{k-1}+\binom{n-1}{k} \qquad \forall k,\ 1\le k\le n$$
> [!success] Dimostrazione:
> Si parte dal **secondo membro** e si arriva al primo.
> $$\binom{n-1}{k-1}+\binom{n-1}{k}=\frac{(n-1)!}{(k-1)!\,\big(n-1-(k-1)\big)!}+\frac{(n-1)!}{k!\,(n-1-k)!}$$
> Poiché $n-1-(k-1)=n-k$, il primo denominatore contiene $(k-1)!(n-k)!$.
>
> Si usano le due identità:
> - $(n-k)!=(n-k-1)!\,(n-k)$
> - $k!=k\,(k-1)!$
>
> Si ottiene:
> $$=\frac{(n-1)!}{(k-1)!\,(n-k-1)!}\cdot\left(\frac{1}{n-k}+\frac{1}{k}\right)$$
> Si calcola la somma tra parentesi:
> $$\frac{1}{n-k}+\frac{1}{k}=\frac{k+(n-k)}{k\,(n-k)}=\frac{n}{k\,(n-k)}$$
> Quindi:
> $$=\frac{(n-1)!}{(k-1)!\,(n-k-1)!}\cdot\frac{n}{k\,(n-k)}=\frac{n\,(n-1)!}{k\,(k-1)!\,(n-k)\,(n-k-1)!}=\frac{n!}{k!\,(n-k)!}=\binom{n}{k}$$
> $\blacksquare$

## 6) Il coefficiente binomiale è un numero naturale

$$\binom{n}{k}\in\mathbb{N} \qquad \forall n,k\in\mathbb{N},\ k\le n$$

> [!info] Info: Perché non è ovvio
> Dalla definizione $\binom{n}{k}$ è una **frazione**. Non è evidente che il risultato sia intero.


___
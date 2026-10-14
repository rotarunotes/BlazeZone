# Riflessione e Dilatazione Verticale

Analisi – Lezione 7 · trasformazioni del grafico, §3.2 e §3.3

## Riflessione: $-f$

### Definizione: Riflessione

Sia:

$$f : A \\to \\mathbb{R}$$

La funzione riflessione è:

$$-f : A \\to \\mathbb{R}, \\qquad x \\mapsto -f(x)$$

### Info:

Come per $f + c$, il numero $-1$ diventa la funzione costante

$$c : \\mathbb{R} \\to \\mathbb{R}, \\qquad x \\mapsto -1$$

e si usa il prodotto tra funzioni: $-f = c \\cdot f$, con $D(-f) = D(f) \\cap D(c) = A$.

Allora:

$$G(-f) = \\{(a, -f(a)) \\mid a \\in A\\} \\subseteq A \\times \\mathbb{R}$$

### Attenzione: È vero che $G(-f) = G(f)$?

NO (in generale, cioè se $f$ non è la funzione nulla):

### Dimostrazione:

Sia $a \\in A$ con $f(a) \\neq 0$. Allora:

$$f(a) \\neq -f(a)$$

Quindi:

$$(a, -f(a)) \\neq (a, f(a))$$

Il punto $(a, -f(a))$ sta in $G(-f)$ ma non in $G(f)$, perché $f$ associa ad $a$ un solo valore. I due grafici sono diversi.

Se invece $f(x) = 0$ per ogni $x \\in A$, i due grafici coincidono.

### Info: Ribaltamento

$G(-f)$ è il ribaltamento di $G(f)$ rispetto all'asse delle $x$, cioè rispetto alla retta $y = 0$:

- il punto $(a, y)$ va in $(a, -y)$: l'ascissa non cambia, quindi il dominio resta $A$
- dove $f(x) > 0$ si ha $-f(x) \< 0$, e viceversa
- i punti con $f(a) = 0$, cioè gli zeri $Z_f$, restano fermi
- ribaltare due volte restituisce il grafico di partenza: $-(-f) = f$

### Esempio

Sia $f(x) = x^2$ con $A = \[-2, 2\]$. Allora $-f(x) = -x^2$ e, ad esempio:

$$f(1) = 1 \\ \\to\\ (-f)(1) = -1, \\qquad f(2) = 4 \\ \\to\\ (-f)(2) = -4$$

f(x) = x² −f(x) = −x²

L'origine $(0, 0)$ è uno zero di $f$: appartiene a entrambi i grafici.

## Dilatazione Verticale: $b f$

### Definizione: Dilatazione Verticale

Sia:

$$f : A \\to \\mathbb{R}, \\qquad b \\in \\mathbb{R}$$

La funzione dilatazione verticale è:

$$b f : A \\to \\mathbb{R}, \\qquad x \\mapsto b\\, f(x)$$

### Info:

Anche qui $b$ è un numero e diventa la funzione costante

$$c : \\mathbb{R} \\to \\mathbb{R}, \\qquad x \\mapsto b$$

Si usa il prodotto tra funzioni: $b f = c \\cdot f$, con $D(b f) = D(f) \\cap D(c) = A$.

Allora:

$$G(b f) = \\{(a, b f(a)) \\mid a \\in A\\} \\subseteq A \\times \\mathbb{R}$$

### Info: Casi di $b$

- $b = 1$: $1 \\cdot f = f$, il grafico non cambia
- $b > 1$: il grafico si allunga in verticale, i punti si allontanano dall'asse $x$
- $0 \< b \< 1$: il grafico si schiaccia, i punti si avvicinano all'asse $x$
- $b = 0$: $0 \\cdot f$ è la funzione nulla e $G(0 \\cdot f) = A \\times \\{0\\}$ sta tutto sull'asse $x$
- $b = -1$: si ottiene la riflessione $-f$
- $b \< 0$: ribaltamento e dilatazione insieme, $b f = -(|b| f)$

### Attenzione: È vero che $G(b f) = G(f)$?

NO (per $b \\neq 1$, se $f$ non è la funzione nulla):

### Dimostrazione:

I due grafici coincidono se e solo se $b f(a) = f(a)$ per ogni $a \\in A$, cioè:

$$(b - 1)\\, f(a) = 0 \\quad \\forall\\, a \\in A$$

Se $b \\neq 1$, questo accade solo quando $f(a) = 0$ per ogni $a$. Quindi, se $f$ non è nulla, i grafici sono diversi.

Esempio con $b > 1$ e $f(a) > 0$:

$$0 \< f(a) \< b f(a) \\quad \\Rightarrow \\quad (a, f(a)) \\neq (a, b f(a))$$

### Info: Differenze di quota

Le differenze di quota vengono moltiplicate per $b$:

$$b f(a_2) - b f(a_1) = b\\,\\big(f(a_2) - f(a_1)\\big)$$

Se $b \< 0$ la differenza cambia anche segno. Esempio: $b = 2$ e $f(a_2) - f(a_1) = 3$, quindi $2 \\cdot 3 = 6$.

### Esempio

Sia $f(x) = x^2$ con $A = \[-2, 2\]$, e siano $b = 2$ e $b = \\tfrac{1}{2}$.

2f(x) = 2x² f(x) = x² ½f(x) = ½x²

Differenza di quota tra $x = 1$ e $x = 2$:

- $f$: $f(2) - f(1) = 4 - 1 = 3$
- $2f$: $8 - 2 = 6 = 2 \\cdot 3$
- $\\tfrac{1}{2} f$: $2 - \\tfrac{1}{2} = \\tfrac{3}{2} = \\tfrac{1}{2} \\cdot 3$

### Riepilogo: effetto di $b$ su un punto

Il punto $(a, f(a))$, con $f(a) = 3$, diventa $(a, 3b)$:

| $b$ | Effetto su $G(f)$ | Punto |
| --- | --- | --- |
| $2$ | allungamento | $(a, 6)$ |
| $\\tfrac{1}{2}$ | schiacciamento | $(a, 1{,}5)$ |
| $1$ | nessuno | $(a, 3)$ |
| $0$ | appiattito sull'asse $x$ | $(a, 0)$ |
| $-1$ | riflessione | $(a, -3)$ |
| $-2$ | riflessione e allungamento | $(a, -6)$ |
Data: 2026-10-06
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index

- [[#Esercizi con i sup e inf limitati]]
	- [[#Esercizio 3 – Inclusioni ed Estremi|Esercizio 3 – Inclusioni ed Estremi]]
		- [[#1) Domanda: È vero che $\sup A \in B$?|1) Domanda: È vero che sup A ∈ B?]]
		- [[#2) Dimostrazione: $\inf A \ge \inf B$ e $\sup A \le \sup B$|2) Dimostrazione: inf A ≥ inf B e sup A ≤ sup B]]
	- [[#Esercizio 4 – Insieme Opposto $-A$|Esercizio 4 – Insieme Opposto -A]]
		- [[#Definizione di Insieme Opposto|Definizione di Insieme Opposto]]
		- [[#1) Dimostrazione: $\sup(-A) = -\inf A$|1) Dimostrazione: sup(-A) = -inf A]]
		- [[#2) Dimostrazione: $\inf(-A) = -\sup A$|2) Dimostrazione: inf(-A) = -sup A]]
		- [[#3) Caso degli Insiemi Illimitati|3) Caso degli Insiemi Illimitati]]
___

# Esercizi con i sup e inf limitati

## Esercizio 3 – Inclusioni ed Estremi

> [!abstract] Definizione: Enunciato Esercizio 3
> Siano $A, B \subseteq \mathbb{R}$ due insiemi non vuoti tali che $A \subseteq B$.
> 1. È vero che $\sup A \in B$?
> 2. Dimostrare che:
>    $$\inf A \ge \inf B \qquad\land\qquad \sup A \le \sup B$$

---

### 1) Domanda: È vero che $\sup A \in B$?

> [!danger] Attenzione! L'affermazione è FALSA
> L'inclusione $A \subseteq B$ garantisce soltanto che ogni elemento di $A$ appartiene a $B$. 
> Tuttavia, l'estremo superiore $\sup A$ **non appartiene necessariamente ad $A$**, e di conseguenza può non appartenere nemmeno a $B$.

> [!example] Controesempi
> 
> **Controesempio 1 (Intervalli limitati disgiunti al bordo)**:
> Siano:
> $$A = (1, 2), \qquad B = (0, 1] \cup (1, 2)$$
> - Chiaramente $A \subseteq B$ poiché $(1,2)$ è contenuto nell'unione che definisce $B$.
> - L'estremo superiore di $A$ è:
>   $$\sup A = 2$$
> - Tuttavia $2 \notin B$ (il punto $2$ è escluso da entrambi i tratti di $B$).
> 
> **Controesempio 2 (Insieme aperto contenuto in sé stesso)**:
> Ponendo $A = (0, 1)$ e $B = (0, 1)$, si ha banalmente $A \subseteq B$, ma:
> $$\sup A = 1 \notin B$$
> 
> **Controesempio 3 (Insiemi numerici discreti illimitati)**:
> Siano $A = \mathbb{N}$ e $B = \mathbb{Z}$.
> Si ha $\mathbb{N} \subseteq \mathbb{Z}$, ma in $\overline{\mathbb{R}}$:
> $$\sup A = +\infty \notin \mathbb{Z}$$

---

### 2) Dimostrazione: $\inf A \ge \inf B$ e $\sup A \le \sup B$

| Parte | Contenuto |
| --- | --- |
| **Contesto** | $A, B \subseteq \mathbb{R}$, con $A \neq \emptyset$, $B \neq \emptyset$ |
| **Ipotesi** | $A \subseteq B$, con $A$ e $B$ limitati |
| **Tesi** | $\inf A \ge \inf B \quad\land\quad \sup A \le \sup B$ |

> [!info] Info: Idea Intuitiva
> Se un insieme si **allarga** ($A \subseteq B$), i suoi estremi possono solo "allargarsi" (dilatarsi) o al massimo rimanere invariati:
> - L'insieme dei minoranti si restringe o resta uguale $\Rightarrow$ il massimo dei minoranti scende o resta invariato: $\inf B \le \inf A$.
> - L'insieme dei maggioranti si restringe o resta uguale $\Rightarrow$ il minimo dei maggioranti sale o resta invariato: $\sup A \le \sup B$.

#### Dimostrazione: $\inf A \ge \inf B$

> [!success] Dimostrazione: $\inf A \ge \inf B$
> Siano $A, B$ inferiormente limitati con $A \subseteq B$.
> Poniamo:
> - $\lambda_B := \inf B = \max(m_B)$
> - $\lambda_A := \inf A = \max(m_A)$
> 
> dove $m_A$ e $m_B$ indicano gli insiemi dei minoranti di $A$ e $B$.
> 
> **1. Definizione di minorante per $B$**:
> Poiché $\lambda_B = \inf B$, per definizione di estremo inferiore $\lambda_B$ è un minorante di $B$:
> $$\lambda_B \le b \quad \forall b \in B$$
> 
> **2. Sfruttamento dell'inclusione $A \subseteq B$**:
> Poiché ogni elemento $a \in A$ appartiene anche a $B$ ($a \in B$), la disuguaglianza precedente vale in particolare per ogni $a \in A$:
> $$\lambda_B \le a \quad \forall a \in A$$
> 
> **3. Appartenenza ai minoranti di $A$**:
> Dalla riga precedente segue che $\lambda_B$ è un minorante per l'insieme $A$:
> $$\lambda_B \in m_A$$
> 
> **4. Proprietà di massimo**:
> Per definizione, $\lambda_A = \inf A = \max(m_A)$ è il **massimo** dei minoranti di $A$.
> Quindi qualsiasi elemento di $m_A$ è minore o uguale al massimo:
> $$\lambda_B \le \lambda_A$$
> 
> **Conclusione**:
> Sostituendo $\lambda_B = \inf B$ e $\lambda_A = \inf A$:
> $$\inf B \le \inf A \quad\Longleftrightarrow\quad \inf A \ge \inf B \qquad \blacksquare$$

---

#### Dimostrazione: $\sup A \le \sup B$

> [!success] Dimostrazione: $\sup A \le \sup B$
> Siano $A, B$ superiormente limitati con $A \subseteq B$.
> Poniamo:
> - $\mu_B := \sup B = \min(M_B)$
> - $\mu_A := \sup A = \min(M_A)$
> 
> dove $M_A$ e $M_B$ indicano gli insiemi dei maggioranti di $A$ e $B$.
> 
> **1. Definizione di maggiorante per $B$**:
> Poiché $\mu_B = \sup B$, per definizione di estremo superiore $\mu_B$ è un maggiorante di $B$:
> $$\mu_B \ge b \quad \forall b \in B$$
> 
> **2. Sfruttamento dell'inclusione $A \subseteq B$**:
> Poiché ogni elemento $a \in A$ appartiene anche a $B$ ($a \in B$), la disuguaglianza vale per ogni elemento di $A$:
> $$\mu_B \ge a \quad \forall a \in A$$
> 
> **3. Appartenenza ai maggioranti di $A$**:
> Dalla riga precedente segue che $\mu_B$ è un maggiorante per l'insieme $A$:
> $$\mu_B \in M_A$$
> 
> **4. Proprietà di minimo**:
> Per definizione, $\mu_A = \sup A = \min(M_A)$ è il **minimo** dei maggioranti di $A$.
> Quindi il minimo è minore o uguale a qualsiasi elemento di $M_A$:
> $$\mu_A \le \mu_B$$
> 
> **Conclusione**:
> Sostituendo $\mu_A = \sup A$ e $\mu_B = \sup B$:
> $$\sup A \le \sup B \qquad \blacksquare$$

> [!info] Info: Estensione al caso generale (insiemi illimitati)
> Se gli insiemi non sono limitati, le disuguaglianze rimangono valide nella retta reale estesa $\overline{\mathbb{R}}$:
> - Se $B$ non è inferiormente limitato $\Rightarrow \inf B = -\infty \le \inf A$ (sempre vera).
> - Se $A$ non è inferiormente limitato $\Rightarrow \inf A = -\infty$. Poiché per ogni $k \in \mathbb{R}$ esiste $a \in A \subseteq B$ con $a < k$, anche $B$ non è inferiormente limitato, quindi $\inf B = -\infty = \inf A$.
> - Analogamente per il sup: se $B$ non è superiormente limitato $\Rightarrow \sup B = +\infty \ge \sup A$; se $A$ non è superiormente limitato $\Rightarrow \sup A = +\infty \Rightarrow \sup B = +\infty$.

___

## Esercizio 4 – Insieme Opposto $-A$

### Definizione di Insieme Opposto

> [!abstract] Definizione: Insieme Opposto $-A$
> Sia $A \subseteq \mathbb{R}$, $A \neq \emptyset$.
> L'**insieme opposto** $-A$ è l'insieme formato da tutti gli opposti degli elementi di $A$:
> $$-A := \{-a \mid a \in A\} = \{x \in \mathbb{R} \mid \exists a \in A \text{ per cui } x = -a\} = \{x \in \mathbb{R} \mid -x \in A\}$$
> 
> In sintesi:
> $$x \in -A \quad\Longleftrightarrow\quad -x \in A$$

> [!info] Info: Interpretazione Geometrica
> L'operazione $A \mapsto -A$ corrisponde geometricamente a una **riflessione (simmetria centrale)** della retta reale rispetto all'origine $0$:
> - I punti positivi diventano negativi e viceversa.
> - L'ordinamento si inverte: se $x < y$, allora $-y < -x$.
> - Di conseguenza l'estremo inferiore di $A$ si riflette nell'estremo superiore di $-A$, e l'estremo superiore di $A$ nell'estremo inferiore di $-A$.

> [!abstract] Definizione: Enunciato Esercizio 4
> | Parte | Contenuto |
> | --- | --- |
> | **Contesto** | Sia $A \subseteq \mathbb{R}$, $A \neq \emptyset$, con $A$ limitato |
> | **Ipotesi** | $A$ è inferiormente e superiormente limitato |
> | **Tesi** | $$\sup(-A) = -\inf A \qquad\land\qquad \inf(-A) = -\sup A$$ |

---

### 1) Dimostrazione: $\sup(-A) = -\inf A$

Sia $A$ inferiormente limitato, e poniamo:
$$\lambda := \inf A = \max(m_A) \in \mathbb{R}$$

Vogliamo dimostrare che $\sup(-A) = -\lambda$, mostrando la doppia disuguaglianza:
1. $\sup(-A) \le -\lambda$ (cioè $-\lambda$ è un maggiorante di $-A$)
2. $\sup(-A) \ge -\lambda$ (cioè $-\lambda$ è il minimo dei maggioranti di $-A$)

#### Metodo 1: Tramite la Definizione di Maggioranti e Minoranti

> [!success] Dimostrazione: Passo 1 – $-\lambda$ è un maggiorante di $-A$
> Per definizione di estremo inferiore, $\lambda = \inf A$ è un minorante di $A$:
> $$\lambda \le a \quad \forall a \in A$$
> 
> Moltiplicando ambo i membri per $-1$ (la disuguaglianza inverte il verso):
> $$-\lambda \ge -a \quad \forall a \in A$$
> 
> Poiché ogni elemento $x \in -A$ è della forma $x = -a$ per qualche $a \in A$, possiamo riscrivere:
> $$x \le -\lambda \quad \forall x \in -A$$
> 
> Quindi $-\lambda$ è un **maggiorante** per l'insieme $-A$, cioè:
> $$-\lambda \in M_{-A}$$
> 
> Poiché $\sup(-A) = \min(M_{-A})$ è il **minimo** dei maggioranti di $-A$, deve essere minore o uguale a qualsiasi maggiorante:
> $$\sup(-A) \le -\lambda = -\inf A \qquad (1)$$

> [!success] Dimostrazione: Passo 2 – $-\lambda$ è il minimo dei maggioranti di $-A$
> Sia $M \in \mathbb{R}$ un generico maggiorante di $-A$, cioè $M \in M_{-A}$.
> 
> Per definizione di maggiorante:
> $$x \le M \quad \forall x \in -A$$
> 
> Poiché ogni $x \in -A$ è $x = -a$ con $a \in A$:
> $$-a \le M \quad \forall a \in A$$
> 
> Moltiplicando per $-1$:
> $$a \ge -M \quad \forall a \in A$$
> 
> Questo dimostra che $-M$ è un **minorante** per l'insieme $A$, ossia:
> $$-M \in m_A$$
> 
> Ricordando che $\lambda = \inf A = \max(m_A)$ è il **massimo** dei minoranti di $A$, qualsiasi minorante di $A$ deve essere minore o uguale a $\lambda$:
> $$-M \le \lambda \quad\Longleftrightarrow\quad M \ge -\lambda$$
> 
> Poiché questa disuguaglianza vale per **ogni** maggiorante $M \in M_{-A}$, e in particolare per $M = \sup(-A)$ (che appartiene a $M_{-A}$):
> $$\sup(-A) \ge -\lambda = -\inf A \qquad (2)$$

> [!success] Dimostrazione: Conclusione
> Dalle relazioni $(1)$ e $(2)$, per la proprietà antisimmetrica dell'ordinamento:
> $$\sup(-A) = -\lambda = -\inf A \qquad \blacksquare$$

#### Metodo 2: Dimostrazione tramite Caratterizzazione con $\varepsilon$

> [!info] Info: Richiamo Teorema di Caratterizzazione
> Dalla caratterizzazione di estremo superiore, un numero reale $S$ è $\sup(-A)$ se e solo se:
> $$
> \begin{cases}
> 1)\ S \ge x \quad \forall x \in -A \\
> 2)\ \forall \varepsilon > 0\ \ \exists \bar{x} \in -A \mid \bar{x} > S - \varepsilon
> \end{cases}
> $$

> [!success] Dimostrazione: Verifica delle due condizioni con $S = -\inf A$
> Poniamo $S = -\lambda$, dove $\lambda = \inf A$.
> 
> **Verifica della Condizione 1 (Maggiorante)**:
> Per ogni $x \in -A$, esiste $a \in A$ tale che $x = -a$.
> Poiché $\lambda = \inf A \le a$, moltiplicando per $-1$ si ha:
> $$x = -a \le -\lambda = S$$
> Quindi $S \ge x$ per ogni $x \in -A$. ✔
> 
> **Verifica della Condizione 2 (Epsilon)**:
> Fissiamo un arbitrario $\varepsilon > 0$.
> Poiché $\lambda = \inf A$, per la caratterizzazione dell'estremo inferiore di $A$ sappiamo che:
> $$\exists \bar{a} \in A \mid \bar{a} < \lambda + \varepsilon$$
> Moltiplichiamo entrambi i membri per $-1$:
> $$-\bar{a} > -\lambda - \varepsilon$$
> Poniamo $\bar{x} := -\bar{a}$. Poiché $\bar{a} \in A$, si ha $\bar{x} \in -A$. Sostituendo $S = -\lambda$:
> $$\bar{x} > S - \varepsilon$$
> Abbiamo così trovato un elemento $\bar{x} \in -A$ strettamente maggiore di $S - \varepsilon$. ✔
> 
> Essendo verificate entrambe le condizioni, per il Teorema di Caratterizzazione:
> $$\sup(-A) = S = -\inf A \qquad \blacksquare$$

---

### 2) Dimostrazione: $\inf(-A) = -\sup A$

Sia $A$ superiormente limitato, e poniamo:
$$\mu := \sup A = \min(M_A) \in \mathbb{R}$$

Vogliamo dimostrare che $\inf(-A) = -\mu$, mostrando la doppia disuguaglianza:
1. $\inf(-A) \ge -\mu$ (cioè $-\mu$ è un minorante di $-A$)
2. $\inf(-A) \le -\mu$ (cioè $-\mu$ è il massimo dei minoranti di $-A$)

#### Metodo 1: Tramite la Definizione di Maggioranti e Minoranti

> [!success] Dimostrazione: Passo 1 – $-\mu$ è un minorante di $-A$
> Per definizione di estremo superiore, $\mu = \sup A$ è un maggiorante di $A$:
> $$a \le \mu \quad \forall a \in A$$
> 
> Moltiplicando ambo i membri per $-1$ (la disuguaglianza inverte il verso):
> $$-a \ge -\mu \quad \forall a \in A$$
> 
> Poiché ogni elemento $x \in -A$ è della forma $x = -a$ con $a \in A$:
> $$x \ge -\mu \quad \forall x \in -A$$
> 
> Quindi $-\mu$ è un **minorante** per l'insieme $-A$, cioè:
> $$-\mu \in m_{-A}$$
> 
> Poiché $\inf(-A) = \max(m_{-A})$ è il **massimo** dei minoranti di $-A$, deve essere maggiore o uguale a qualsiasi minorante:
> $$\inf(-A) \ge -\mu = -\sup A \qquad (1)$$

> [!success] Dimostrazione: Passo 2 – $-\mu$ è il massimo dei minoranti di $-A$
> Sia $m \in \mathbb{R}$ un generico minorante di $-A$, cioè $m \in m_{-A}$.
> 
> Per definizione di minorante:
> $$x \ge m \quad \forall x \in -A$$
> 
> Poiché ogni $x \in -A$ è della forma $x = -a$ con $a \in A$:
> $$-a \ge m \quad \forall a \in A$$
> 
> Moltiplicando per $-1$:
> $$a \le -m \quad \forall a \in A$$
> 
> Questo dimostra che $-m$ è un **maggiorante** per l'insieme $A$, ossia:
> $$-m \in M_A$$
> 
> Ricordando che $\mu = \sup A = \min(M_A)$ è il **minimo** dei maggioranti di $A$, deve essere minore o uguale a qualsiasi maggiorante di $A$:
> $$\mu \le -m \quad\Longleftrightarrow\quad m \le -\mu$$
> 
> Poiché questa disuguaglianza vale per **ogni** minorante $m \in m_{-A}$, e in particolare per $m = \inf(-A)$ (che appartiene a $m_{-A}$):
> $$\inf(-A) \le -\mu = -\sup A \qquad (2)$$

> [!success] Dimostrazione: Conclusione
> Dalle relazioni $(1)$ e $(2)$, per la proprietà antisimmetrica dell'ordinamento:
> $$\inf(-A) = -\mu = -\sup A \qquad \blacksquare$$

#### Metodo 2: Dimostrazione tramite Caratterizzazione con $\varepsilon$

> [!info] Info: Richiamo Teorema di Caratterizzazione
> Dalla caratterizzazione di estremo inferiore, un numero reale $I$ è $\inf(-A)$ se e solo se:
> $$
> \begin{cases}
> 1)\ I \le x \quad \forall x \in -A \\
> 2)\ \forall \varepsilon > 0\ \ \exists \bar{x} \in -A \mid \bar{x} < I + \varepsilon
> \end{cases}
> $$

> [!success] Dimostrazione: Verifica delle due condizioni con $I = -\sup A$
> Poniamo $I = -\mu$, dove $\mu = \sup A$.
> 
> **Verifica della Condizione 1 (Minorante)**:
> Per ogni $x \in -A$, esiste $a \in A$ tale che $x = -a$.
> Poiché $a \le \mu = \sup A$, moltiplicando per $-1$:
> $$x = -a \ge -\mu = I$$
> Quindi $I \le x$ per ogni $x \in -A$. ✔
> 
> **Verifica della Condizione 2 (Epsilon)**:
> Fissiamo un arbitrario $\varepsilon > 0$.
> Poiché $\mu = \sup A$, per la caratterizzazione dell'estremo superiore di $A$ sappiamo che:
> $$\exists \bar{a} \in A \mid \bar{a} > \mu - \varepsilon$$
> Moltiplichiamo entrambi i membri per $-1$:
> $$-\bar{a} < -\mu + \varepsilon$$
> Poniamo $\bar{x} := -\bar{a} \in -A$. Sostituendo $I = -\mu$:
> $$\bar{x} < I + \varepsilon$$
> Abbiamo trovato un elemento $\bar{x} \in -A$ strettamente minore di $I + \varepsilon$. ✔
> 
> Essendo verificate entrambe le condizioni, per il Teorema di Caratterizzazione:
> $$\inf(-A) = I = -\sup A \qquad \blacksquare$$

---

### 3) Caso degli Insiemi Illimitati

> [!info] Info: Estensione a $\overline{\mathbb{R}}$
> Le relazioni continuano a valere anche se l'insieme non è limitato, con le consuete convenzioni $-(-\infty) = +\infty$ e $-(+\infty) = -\infty$:
> $$\inf A = -\infty \quad\Longrightarrow\quad \sup(-A) = +\infty$$
> $$\sup A = +\infty \quad\Longrightarrow\quad \inf(-A) = -\infty$$

> [!success] Dimostrazione per Assurdo: $\inf A = -\infty \Longrightarrow \sup(-A) = +\infty$
> **Ipotesi**: $A$ non è inferiormente limitato, cioè:
> $$\forall k \in \mathbb{R}\ \ \exists a \in A \mid a < k$$
> 
> **Tesi**: $-A$ non è superiormente limitato, cioè $\sup(-A) = +\infty$.
> 
> **Dimostrazione per assurdo**:
> Supponiamo per assurdo che la tesi sia falsa, cioè che $-A$ **sia superiormente limitato**.
> Allora esisterebbe un maggiorante $H \in \mathbb{R}$ per $-A$:
> $$x \le H \quad \forall x \in -A$$
> Poiché ogni $x \in -A$ è del tipo $x = -a$ con $a \in A$:
> $$-a \le H \quad \forall a \in A \quad\Longleftrightarrow\quad a \ge -H \quad \forall a \in A$$
> Ma questo significherebbe che $-H$ è un **minorante** per l'insieme $A$, e quindi che $A$ è inferiormente limitato!
> Questo è in palese **contraddizione** con l'ipotesi $\inf A = -\infty$.
> 
> Dunque $-A$ non può essere superiormente limitato, cioè:
> $$\sup(-A) = +\infty \qquad \blacksquare$$

> [!success] Dimostrazione per Assurdo: $\sup A = +\infty \Longrightarrow \inf(-A) = -\infty$
> **Ipotesi**: $A$ non è superiormente limitato, cioè:
> $$\forall k \in \mathbb{R}\ \ \exists a \in A \mid a > k$$
> 
> **Tesi**: $-A$ non è inferiormente limitato, cioè $\inf(-A) = -\infty$.
> 
> **Dimostrazione per assurdo**:
> Supponiamo per assurdo che $-A$ **sia inferiormente limitato**.
> Allora esisterebbe un minorante $K \in \mathbb{R}$ per $-A$:
> $$x \ge K \quad \forall x \in -A$$
> Poiché $x = -a$ con $a \in A$:
> $$-a \ge K \quad \forall a \in A \quad\Longleftrightarrow\quad a \le -K \quad \forall a \in A$$
> Questo significherebbe che $-K$ è un **maggiorante** per $A$, e quindi che $A$ è superiormente limitato!
> Questo è in **contraddizione** con l'ipotesi $\sup A = +\infty$.
> 
> Dunque $-A$ non può essere inferiormente limitato, cioè:
> $$\inf(-A) = -\infty \qquad \blacksquare$$

___

Data: 2026-02-04
[](./README.md)
#Puzzle_Of_Knowledge/Math
___
###### parte non fatta che non chiede 4b
p1400 probabilità e calcolo combinatorio
p1401-1404 tutto
p1415 in poi
___

# Index
- [[#Eventi]]
- [[#Definizione Di Probabilità]]
	- [[#Evento Contrario]]
- [[#Definizione Assiomatica Di Probabilità]]
	- [[#Proprietà]] 
  [[#Somma Logica Di Eventi]]
	- [[#Eventi Compatibili E Incompatibili]]
	- [[#Probabilità Della Somma Logica o Unione Di Due Eventi]]
- [[#Probabilità Condizionata]]
- [[#Prodotto Logico Di Eventi]]
	- [[#Eventi Dipendenti ed Eventi Indipendenti]]
- [[#Schema Delle Prove Ripetute (o di Bernoulli)]]
- [[#Formulario]]

___
# Eventi
- Un **esperimento aleatorio** è un fenomeno di cui non riusciamo a prevedere il risultato con certezza.

> [!Esempio]
> Lancio di un dado

- L'insieme $U$ di tutti i possibili risultati di un esperimento aleatorio si chiama **spazio campionario**.
- Un **evento** è un qualunque sottoinsieme dello **spazio campionario**; un evento formato da un singolo risultato dell'esperimento è detto **evento elementare**.
![[Eventi_Elementari|300]]


Possiamo rappresentare esperimenti aleatori **complessi** (Il lancio di una moneta per più volte consecutive, attraverso), attraverso un diagramma ad albero.

![[Albero_Di_Esempi]]

___
# Definizione Di Probabilità
- La probabilità di un evento $E$ è il rapporto fra il numero di **casi favorevoli** $f$ e quello dei **casi possibili** $u$ quando sono tutti ugualmente possibili
$$
p(E) = \frac{f}{u}
$$

> [!Esempio]
> Lancio di un dado
>  $E = esce\ un \ numero \ dispari$
>  
>  $U = \{1, 2, 3, 4, 5 ,6\}$
>  $E = \{1, 3, 5\}$
> $p(E) = \frac{3}{6}= \frac{1}{2} = 50\%$ 
> 
> Possiamo fare le seguenti osservazioni:

Dato che $f \le u$, allora:

$$
0 \le p(E) \le 1
$$
Se $f = u$, $E$ è un evento **certo**:
$$
p(E) = 1
$$
Se $f = 0$, $E$ è un evento **impossibile**:
$$
p(E) = 0
$$
## Evento Contrario
- Consideriamo un evento $E$. Il suo **evento contrario** $\overline{E}$ è  l'evento che si verifica se e solo se non si verifica  $E$.
$$
p(\overline{E}) = \frac{u - f}{u} = 1 - \frac{f}{u} =
$$
$$
p(\overline{E})= 1 - p(E)
$$

> [!Esempio]
> Lancio di un dado
> $E$ =$\ numero \ maggiore \ di \ 3$
> $E = \{4, 5, 6\}$
> $\overline{E} = \{1, 2, 3\}$
> $p(\overline{E})= 1 - p(E) = 1 - \frac{3}{6} = 1 - \frac{1}{2} = \frac{1}{2}$

Per quanto abbiamo detto, la **somma** delle probabilità di un evento e di quella del suo evento contrario è 1.

$$p(E) + p(\overline{E}) = 1$$

___
# Definizione Assiomatica Di Probabilità

- Dato uno spazio campionario $U$, una funzione $p$ che associa a ogni evento $E$ dello spazio degli eventi un **numero reale** viene detta probabilità se soddisfa i seguenti **assiomi**:
$$
p(E) \ge 0;
$$
$$
p(U) = 1;
$$
$$
\text{se } E_1 \cap E_2 = \emptyset; 
$$
$$
\text{ allora } p(E_1 \cup E_2) = p(E_1) + p(E_2)
$$

> [!Esempio]
> Lancio di un dado
> $E_1 = \ numero \ maggiore \ di \ 4$
> $E_2 = \ numero \ minore \ di \ 2$
> $E_1 = \{5, 6\}$
> $E_2 = \{1\}$
> $p(E_1 \cup E_2) = \frac{2}{6} + \frac{1}{6} = \frac{1}{2}$

![[Schema_Assioma_Probabilità]]

## Proprietà
Dalla definizione assiomatica si **deducono** le seguenti proprietà.
**a.** $p(\emptyset) = 0;$
**b.** $0 \le p(E) \le 1$;
**c.** $p(\overline{E}) = 1 - p(E);$
**d.** se gli eventi $E_1, E_2, \dots, E_n$ sono una partizione di $U$, allora
$$
p(E_1) + p(E_2) + \dots + p(E_n) = 1
$$
**e.** $p(E_2 - E_1) = p(E_2) - p(E_1 \cap E_2);$ in particolare, se $E_1 \subseteq E_2$, allora
$$
p(E_2 - E_1) = p(E_2) - p(E_1)
$$
Se l'evento $E_1$ è **interamente contenuto** dentro $E_2$ (**sottoinsieme**), allora la loro intersezione coincide esattamente con $E_1 = E_1 \cap E_2$.

> [!Esempio]
> L'insieme di tutti i risultati possibili (lo spazio campionario) è $\{1, 2, 3, 4, 5, 6\}$.
> Definiamo due eventi in modo che uno sia contenuto nell'altro:
> - **Evento $E_2$ (Il "contenitore"):** Esce un numero pari.
>     $E_2 = \{2, 4, 6\}$
>     La probabilità è $p(E_2) = \frac{3}{6} = 0,5$.
> - **Evento $E_1$ (Il "sottoinsieme"):** Esce il numero 2.
>     $E_1 = \{2\}$
>     La probabilità è $p(E_1) = \frac{1}{6} \approx 0,16$.
>___
> Siccome il numero 2 è un numero pari, è ovvio che $E_1 \subseteq E_2$. In questo caso, l'intersezione $E_1 \cap E_2$ è proprio $\{2\}$, ovvero $E_1$ stesso.
> La Differenza
> Ora calcoliamo l'evento **$E_2 - E_1$**. Questo rappresenta l'evento: "Esce un numero pari, ma **non** il 2"
> 1. Sottraendo gli elementi: $\{2, 4, 6\} - \{2\} = \{4, 6\}$.
> 2. La probabilità di questo nuovo evento è $\frac{2}{6}$.
> Usando la formula:
> $$p(E_2 - E_1) = p(E_2) - p(E_1) = \frac{3}{6} - \frac{1}{6} = \frac{2}{6}$$

___
# Somma Logica Di Eventi

- Dati due eventi $E_1$ ed $E_2$ di uno stesso spazio campionario:
	1) l'**evento unione** o **somma logica** è l'evento $E_1 \cup E_2$ che si verifica quando è verificato almeno uno degli eventi $E_1$ || $E_2$;
	2) l'**evento intersezione** o **prodotto logico** è l'evento $E_1 \cap E_2$ che si verifica quando sono verificati entrambi gli eventi $E_1$ && $E_2$.

- L'evento unione $\cup$ viene anche detto **evento totale**

> [!Esempio]
> $E_1$: "Esce un numero pari" $\rightarrow \{2, 4, 6\}$
> $E_2$: "Esce il numero 5" $\rightarrow \{5\}$
> L'**evento unione** $E_1 \cup E_2$ è l'evento "Esce un numero pari **o** esce il 5".
> In questo caso, l'insieme risultante è $\{2, 4, 5, 6\}$.

- mentre l'evento intersezione $\cap$ è anche detto **evento composto**

> [!Esempio]
>$E_1$: "Esce un numero maggiore di 3" $\rightarrow \{4, 5, 6\}$
> $E_2$: "Esce un numero pari" $\rightarrow \{2, 4, 6\}$
> L'**evento intersezione** $E_1 \cap E_2$ è l'evento "Esce un numero che è sia maggiore di 3 **che** pari".
> In questo caso, l'insieme risultante è $\{4, 6\}$.

## Eventi Compatibili E Incompatibili

- Due eventi $E_1$ ed $E_2$, relativi allo stesso spazio campionario:
	1) **Incompatibili** se il verificarsi di uno esclude il verificarsi contemporaneo dell'altro: $E_1 \cap E_2 = \emptyset$
		- $E_1$: "Esce il numero 2" $\rightarrow \{2\}$
		- $E_2$: "Esce un numero dispari" $\rightarrow \{1, 3, 5\}$
		   Se lanciamo un dado è impossibile che avvenga sia $E_1$ e $E_2$

	2) **Compatibili** è il caso contrario: $E_1 \cap E_2 \neq \emptyset$.
		1) $E_1$: "Esce un numero pari" $\rightarrow \{2, 4, 6\}$
		2) $E_2$: "Esce un numero maggiore di 3" $\rightarrow \{4, 5, 6\}$
		   Se lanciamo un dado è possibile che avvenga sia $E_1$ e $E_2$ $\{4, 6\}$

![[Eventi_Compatibili_Incompatibili]]

## Probabilità Della Somma Logica o Unione Di Due Eventi

- La **probabilità dell'unione di due eventi** $E_1$ ed $E_2$ è uguale alla somma delle loro probabilità diminuita della probabilità della loro intersezione:
$$p(E_1 \cup E_2) = p(E_1) + p(E_2) - p(E_1 \cap E_2)$$
	Se gli eventi sono **incompatibili** allora si può omettere $p(E_1 \cap E_2)$, dato che sarebbe $E_1 \cap E_2 = \emptyset$:
$$p(E_1 \cup E_2) = p(E_1) + p(E_2)$$


> [!Esempio]
> eventi **Compatibili**
> - $E_1$: "Esce un numero pari" $\{2, 4, 6\} \rightarrow p(E_1) = \frac{3}{6}$
> - $E_2$: "Esce un numero $> 3$" $\{4, 5, 6\} \rightarrow p(E_2) = \frac{3}{6}$
> - $E_1 \cap E_2$: "Esce un numero pari E $> 3$" $\{4, 6\} \rightarrow p(E_1 \cap E_2) = \frac{2}{6}$
> Applicando la formula completa:
> $$p(E_1 \cup E_2) = \frac{3}{6} + \frac{3}{6} - \frac{2}{6} = \frac{4}{6} = \frac{2}{3}$$
> Se non sottraessimo $\frac{2}{6}$, conteremmo il 4 e il 6 due volte!

> [!Esempio]
> Caso di eventi **Incompatibili**
> - $E_1$: "Esce il numero 1" $\{1\} \rightarrow p(E_1) = \frac{1}{6}$
> - $E_2$: "Esce un numero pari" $\{2, 4, 6\} \rightarrow p(E_2) = \frac{3}{6}$
> Poiché un numero non può essere contemporaneamente 1 e pari, $E_1 \cap E_2 = \emptyset$. La probabilità dell'intersezione è 0.
> Applicando la formula semplificata:
> $$p(E_1 \cup E_2) = \frac{1}{6} + \frac{3}{6} = \frac{4}{6} = \frac{2}{3}$$

___

# Probabilità Condizionata

- La probabilità condizionata di un evento $E_2$ rispetto a un evento $E_1$, non impossibile, ma non è detto che si verifichi:
$$
p(E_2 | E_1) = \frac{p(E_2 \cap E_1)}{p(E_1)}, \quad \text{con } p(E_1) \neq 0
$$
La | si legge: "dato che"
In parole povere: La probabilità che avvenga $E_2$ se $E_1$ è avvenuto

> [!Esempio]
> Immagina un'urna con 3 palline rosse (R) e 2 nere (N).
> - $E_1$: "La prima pallina estratta è rossa". $p(E_1) = 3/5$.
> - $E_2$: "La seconda pallina estratta è rossa".
> 
> Se $E_1$ si è verificato, nell'urna restano 4 palline, di cui 2 rosse. Quindi:
> $$
> p(E_1 \cap E_2) = \frac{3}{5} \cdot \frac{1}{2} = \frac{3 \cdot 1}{5 \cdot 2} = \frac{3}{10}
> $$
> $$
> p(E_2 | E_1) = \frac{p(E_2 \cap E_1)}{p(E_1)} = \frac{3/10}{3/5} = \frac{3}{10} \cdot \frac{5}{3} = \frac{5}{10} = \frac{1}{2}
> $$

___
# Prodotto Logico Di Eventi

- La **probabilità del prodotto logico di due eventi** $E_1$ ed $E_2$ è uguale al prodotto della probabilità dell'evento $E_1$ per la probabilità dell'evento $E_2$ nell'ipotesi che $E_1$ si sia verificato:
$$p(E_1 \cap E_2) = p(E_1) \cdot p(E_2 | E_1)$$
	In particolare, nel caso di eventi **indipendenti**:
$$p(E_1 \cap E_2) = p(E_1) \cdot p(E_2)$$
In parole povere: La probabilità che $E_1$ e $E_2$ di verifichino **entrambi**

> [!Esempio]
> Eventi **Dipendenti** (Senza reinserimento)
> 
> In questo caso, la prima pallina estratta **non viene rimessa** nell'urna. Il verificarsi di $E_1$ influenza la probabilità di $E_2$.
> - $E_1$: "La prima pallina è rossa" $\rightarrow p(E_1) = \frac{6}{10}$.
> - $E_2 | E_1$: "La seconda è rossa, dato che la prima era rossa". Ora nell'urna ci sono solo 9 palline totali e solo 5 sono rosse. $p(E_2 | E_1) = \frac{5}{9}$.
> **Calcolo del prodotto logico:**
> $$
> p(E_1 \cap E_2) = p(E_1) \cdot p(E_2 | E_1) = \frac{6}{10} \cdot \frac{5}{9} = \frac{30}{90} = \frac{1}{3} \approx 33,3\%
> $$

> [!Esempio]
> Eventi **Indipendenti** (Con reinserimento)
> 
> Immagina un'urna che contiene **10 palline**: 6 rosse (R) e 4 nere (N).
> In questo caso, dopo la prima estrazione, guardi il colore della pallina e la **rimetti nell'urna**.
> - $E_1$: "La prima pallina è rossa" $\rightarrow p(E_1) = \frac{6}{10}$.
> - $E_2$: "La seconda pallina è rossa". Poiché hai rimesso la prima pallina dentro, la probabilità non cambia: $p(E_2) = \frac{6}{10}$.
> **Calcolo del prodotto logico:**
> $$p(E_1 \cap E_2) = p(E_1) \cdot p(E_2) = \frac{6}{10} \cdot \frac{6}{10} = \frac{36}{100} = 36\%$$

## Eventi Dipendenti ed Eventi Indipendenti

- Due eventi $E_1$ ed $E_2$ sono:
	- **Indipendenti** se il verificarsi di uno non influenza la probabilità di verificarsi dell'altro (Lancio di una moneta)
	- **Dipendenti** in caso contrario, (In un sacco estrarre più biglie senza rimetterle nel sacco)

___
# Schema Delle Prove Ripetute (o di Bernoulli)

- Dato un esperimento **aleatorio** ripetuto nelle stesse condizioni $n$ volte e indicato con $E$ un evento che rappresenta il successo dell'esperimento e ha probabilità costante $p$ di verificarsi e probabilità $q = 1 - p$ di non verificarsi, la probabilità di ottenere $k$ successi su $n$ prove è:
$$p_{(k, n)} = \binom{n}{k} p^k \cdot q^{n-k}$$
In parole povere:
La **probabilità** $p_{(k, n)}$ che su $n$ **prove** esca $k$ volte il **successo** $p$ tenendo conto dell' **insuccesso** $q$

Coefficiente binomiale
$$
\binom{n}{k} = \frac{n!}{k! \ \cdot \ (n-k)!}
$$

> [!Esempio]
> Immagina di avere 4 amici ($n=4$) e di doverne scegliere 2 ($k=2$) per formare una squadra. In quanti modi diversi puoi farlo?
> Applichiamo la formula:
> $$\binom{4}{2} = \frac{4!}{2! \cdot (4-2)!} = \frac{4!}{2! \cdot 2!}$$
> Sviluppiamo i calcoli:
> $$\frac{4 \cdot 3 \cdot 2 \cdot 1}{(2 \cdot 1) \cdot (2 \cdot 1)} = \frac{24}{4} = 6$$
> Ci sono **6 modi** possibili per scegliere la coppia.

> [!Esempio]
> Immaginiamo che un giocatore di basket abbia una percentuale di realizzazione dei tiri liberi del **60%**. Se decide di tirare **5 volte**, qual è la probabilità che faccia centro esattamente **3 volte**?
> **Identifichiamo i dati:**
> **$n = 5$** (numero totale di prove/tiri).
> **$k = 3$** (numero di successi desiderati).
> **$p = 0,6$** (probabilità di successo in un singolo tiro).
> **$q = 1 - 0,6 = 0,4$** (probabilità di insuccesso).
> 
> Sostituiamo i valori nella formula:
> $$p_{(k, n)} = \binom{n}{k} p^k \cdot q^{n-k}$$
> $$p_{(3, 5)} = \binom{5}{3} \cdot (0,6)^3 \cdot (0,4)^{5-3}$$
> 
> **Passaggio 1: Il coefficiente binomiale**
> Il termine $\binom{5}{3}$ indica in quanti modi diversi i 3 canestri possono essere distribuiti sui 5 tiri totali (ad esempio: i primi tre, gli ultimi tre, il primo, il terzo e il quinto, ecc.).
> 
> $$\binom{5}{3} = \frac{5!}{3!(5-3)!} = 10$$
> **Passaggio 2: Calcolo delle potenze**
> - $(0,6)^3 = 0,216$ (probabilità dei 3 successi)
> - $(0,4)^2 = 0,16$ (probabilità dei 2 fallimenti)
> **Passaggio 3: Risultato finale**
> $$p_{(3, 5)} = 10 \cdot 0,216 \cdot 0,16 = 0,3456$$La probabilità che il giocatore segni esattamente 3 canestri su 5 è del **34,56%**.

___

# Formulario

| **Concetto**                     | **Formula**                                           | **Note**                                                                                                 |
| -------------------------------- | ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Definizione Classica**         | $p(E) = \frac{f}{u}$                                  | $f$: casi favorevoli; $u$: casi possibili.                                                               |
| **Evento Contrario**             | $p(\overline{E}) = 1 - p(E)$                          | La somma $p(E) + p(\overline{E})$ è sempre 1.                                                            |
| **Assiomi di Base**              | $0 \le p(E) \le 1$                                    | $0$ (impossibile), $1$ (certo).                                                                          |
| **Differenza tra eventi in cui** | $p(E_2 - E_1) = p(E_2) - p(E_1)$                      | $E_1$ è sottoinsieme di $E_2$                                                                            |
| **Somma Logica, compatibile**    | $p(E_1 \cup E_2) = p(E_1) + p(E_2) - p(E_1 \cap E_2)$ | Sottrai l'intersezione se sono **compatibili**.                                                          |
| **Eventi Incompatibili**         | $p(E_1 \cup E_2) = p(E_1) + p(E_2)$                   | Quando $E_1 \cap E_2 = \emptyset$.                                                                       |
| **Probabilità Condizionata**     | $p(E_2 \vert E_1) = \frac{p(E_1 \cap E_2)}{p(E_1)}$   | Probabilità di $E_2$ sapendo che $E_1$ è **avvenuto**, non necessariamente che sia stato **verificato**. |
| **Prodotto Logico, dipendenti**  | $p(E_1 \cap E_2) = p(E_1) \cdot p(E_2 \vert E_1)$     | Usata per eventi **dipendenti**.                                                                         |
| **Eventi Indipendenti**          | $p(E_1 \cap E_2) = p(E_1) \cdot p(E_2)$               | Il verificarsi di uno non influenza l'altro.                                                             |
| **Coefficiente Binomiale**       | $\binom{n}{k} = \frac{n!}{k!(n-k)!}$                  | Modi di scegliere $k$ successi in $n$ prove.                                                             |
| **Prove Ripetute (Bernoulli)**   | $p_{(k,n)} = \binom{n}{k} p^k \cdot q^{n-k}$          | $p$: successo; $q = 1-p$: insuccesso.                                                                    |





Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
- [[#Principio Di Induzione]]
- [[#Dimostrazione Diretta]]
- [[#Dimostrazione per Contraddizione]]
- [[#Dimostrazione per Contrapposizione]]
- [[#Dimostrazione Per Doppia Implicazione]]
___
# Principio Di Induzione

> [!abstract] Definizione: Principio Di Induzione
> Il **principio di induzione** è uno strumento per dimostrare che una proprietà vale per **tutti i naturali da $p$ in poi**, verificandola solo su due cose: il primo caso e il passaggio da $n$ a $n+1$.

## Struttura (Enunciato)

| Parte         | Contenuto                                                                             |
| ------------- | ------------------------------------------------------------------------------------- |
| **Contesto**  | Sia $A \subseteq \mathbb{N}$ (un sottoinsieme di $\mathbb{N}$) e sia $p\in\mathbb{N}$ |
| **Ipotesi 1** | **Passo base**: $p \in A$                                                             |
| **Ipotesi 2** | **Passo induttivo**: $n \in A \;\Longrightarrow\; n+1 \in A$ (è un'implicazione)      |
| **Tesi**      | $\{n\in\mathbb{N} \mid n \ge p\} \subseteq A$                                         |

> [!info] Info: In Parole, Passo Induttivo
> Se la proprietà vale per $p$ e, **ogni volta** che vale per $n$, vale anche per $n+1$, allora vale per **tutti** i naturali da $p$ in poi.

> [!danger] Attenzione! Condizione $\land$ Su Entrambe Le Ipotesi Dell Principio Di Induzione
> Servono **entrambe** le ipotesi. Senza passo base o senza passo induttivo la tesi può essere falsa.

___
# Dimostrazione Diretta

> [!abstract] Definizione: Dimostrazione Diretta
> La **dimostrazione diretta** dimostra $A \Rightarrow B$ partendo dalle ipotesi $A$ e, con una catena di passaggi logici, arrivando **direttamente** alla tesi $B$. Non si nega nulla e non si usano casi particolari: si costruisce il percorso da $A$ a $B$.

## Struttura Diretta

Per dimostrare $A \Rightarrow B$:

|Passo|Cosa si fa|
|---|---|---|
|1.|**Assunzione**|Si assume $A$ vera (le ipotesi)|
|2.|**Deduzione**|Da $A$ si ricavano passaggi logici, usando definizioni e teoremi noti|
|3.|**Arrivo**|Si arriva a $B$ (la tesi)|
|4.|**Conclusione**|Quando $A$ è vera lo è anche $B$, quindi $A \Rightarrow B$ è vera|

> [!info] Info: Funzionamento Della Implicazione Diretta
> Perché funziona L'implicazione $A \Rightarrow B$ è falsa solo se $A$ è vera e $B$ è falsa. Mostrando che da $A$ vera segue sempre $B$ vera, quel caso non può verificarsi.

> [!danger] Attenzione! Punto Di Partenza Della Dimostrazione Diretta
> Si parte da $A$, **mai da $B$**. 
> Partire dalla tesi e "arrivare a qualcosa di vero" è un errore classico:
> - Non dimostra niente, perché da un'affermazione falsa si può dedurre anche una vera.

___
# Dimostrazione per Contraddizione

> [!abstract] Definizione: Dimostrazione per Contraddizione
> La **dimostrazione per contraddizione** (o per assurdo) dimostra una tesi supponendo che sia **falsa** e mostrando che questo porta a un **assurdo**. Quindi la tesi deve essere vera.
## Struttura Contraddizione

Per dimostrare $A \Rightarrow B$:

|     | Passo           | Cosa si fa                                                  |
| --- | --------------- | ----------------------------------------------------------- |
| 1.  | **Assunzione**  | Si assume $A$ vera                                          |
| 2.  | **Negazione**   | Si suppone per assurdo che $B$ sia **falsa**, cioè $\neg B$ |
| 3.  | **Deduzione**   | Da $A$ e $\neg B$ si ricavano passaggi logici               |
| 4.  | **Assurdo**     | Si arriva a una contraddizione (es. $C \land \neg C$)       |
| 5.  | **Conclusione** | $\neg B$ è impossibile, quindi $B$ è vera                   |

> [!info] Info: Funzionamento Della Implicazione Per Contraddizione
> L'implicazione $A \Rightarrow B$ è falsa solo se $A$ è vera e $B$ è falsa. Se supporre $A \land \neg B$ porta a un assurdo, quel caso non può verificarsi, quindi l'implicazione è vera.

___
# Dimostrazione per Contrapposizione

> [!abstract] Definizione: Dimostrazione per Contrapposizione
> La **dimostrazione per contrapposizione** dimostra $A \Rightarrow B$ dimostrando invece la sua **contronominale** $\neg B \Rightarrow \neg A$, che è logicamente equivalente.

## Struttura

Per dimostrare $A \Rightarrow B$:

|     | Passo             | Cosa si fa                                                      |
| --- | ----------------- | --------------------------------------------------------------- |
| 1.  | **Riscrittura**   | Si scrive la contronominale $\neg B \Rightarrow \neg A$         |
| 2.  | **Assunzione**    | Si assume $\neg B$ vera                                         |
| 3.  | **Deduzione**     | Da $\neg B$ si ricavano passaggi logici                         |
| 4.  | **Arrivo**        | Si arriva a $\neg A$                                            |
| 5.  | **Conclusione**   | $\neg B \Rightarrow \neg A$ è vera, quindi anche $A \Rightarrow B$ |

> [!info] Info: Funzionamento Della Implicazione Per Contrapposizione
> $A \Rightarrow B$ e $\neg B \Rightarrow \neg A$ hanno sempre lo stesso valore di verità (sono equivalenti). Dimostrare una equivale a dimostrare l'altra.

> [!danger] Attenzione! Confuzione Con Implicazione Contrapposizione e Reciproca
> Non confonderla con la **reciproca** ($B \Rightarrow A$), che **non** è equivalente all'originale.

___

# Dimostrazione Per Doppia Implicazione

> [!abstract] Definizione: Dimostrazione per Doppia Implicazione
>  $A \iff B$ dimostrando **due implicazioni**: $A \Rightarrow B$ e $B \Rightarrow A$.

## Struttura Doppia Implicazione

Per dimostrare $A \iff B$:

|Passo|Cosa si fa|
|---|---|---|
|1.|**Direzione $(\Rightarrow)$**|Si assume $A$ e si dimostra $B$|
|2.|**Direzione $(\Leftarrow)$**|Si assume $B$ e si dimostra $A$|
|3.|**Conclusione**|Valgono entrambe, quindi $A \iff B$ è vera|
___
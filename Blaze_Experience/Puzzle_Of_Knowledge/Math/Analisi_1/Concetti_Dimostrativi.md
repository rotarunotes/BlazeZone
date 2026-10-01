Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
___
# Principio Di Induzione

> [!abstract] Definizione:
> Il **principio di induzione** è uno strumento per dimostrare che una proprietà vale per **tutti i naturali da $p$ in poi**, verificandola solo su due cose: il primo caso e il passaggio da $n$ a $n+1$.

## Struttura (Enunciato)

| Parte         | Contenuto                                                                             |
| ------------- | ------------------------------------------------------------------------------------- |
| **Contesto**  | Sia $A \subseteq \mathbb{N}$ (un sottoinsieme di $\mathbb{N}$) e sia $p\in\mathbb{N}$ |
| **Ipotesi 1** | **Passo base**: $p \in A$                                                             |
| **Ipotesi 2** | **Passo induttivo**: $n \in A \;\Longrightarrow\; n+1 \in A$ (è un'implicazione)      |
| **Tesi**      | $\{n\in\mathbb{N} \mid n \ge p\} \subseteq A$                                         |

> [!info] Info: In parole
> Se la proprietà vale per $p$ e, **ogni volta** che vale per $n$, vale anche per $n+1$, allora vale per **tutti** i naturali da $p$ in poi.

> [!danger] Attenzione!
> Servono **entrambe** le ipotesi. Senza passo base o senza passo induttivo la tesi può essere falsa.

___
# Dimostrazione per Contraddizione

> [!abstract] Definizione:
> La **dimostrazione per contraddizione** (o per assurdo) dimostra una tesi supponendo che sia **falsa** e mostrando che questo porta a un **assurdo**. Quindi la tesi deve essere vera.
## Struttura

Per dimostrare $A \Rightarrow B$:

|     | Passo           | Cosa si fa                                                  |
| --- | --------------- | ----------------------------------------------------------- |
| 1.  | **Assunzione**  | Si assume $A$ vera                                          |
| 2.  | **Negazione**   | Si suppone per assurdo che $B$ sia **falsa**, cioè $\neg B$ |
| 3.  | **Deduzione**   | Da $A$ e $\neg B$ si ricavano passaggi logici               |
| 4.  | **Assurdo**     | Si arriva a una contraddizione (es. $C \land \neg C$)       |
| 5.  | **Conclusione** | $\neg B$ è impossibile, quindi $B$ è vera                   |

> [!info] Info: Perché funziona
> L'implicazione $A \Rightarrow B$ è falsa solo se $A$ è vera e $B$ è falsa. Se supporre $A \land \neg B$ porta a un assurdo, quel caso non può verificarsi, quindi l'implicazione è vera.

___
# Dimostrazione per Contrapposizione

> [!abstract] Definizione:
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

> [!info] Info: Perché funziona
> $A \Rightarrow B$ e $\neg B \Rightarrow \neg A$ hanno sempre lo stesso valore di verità (sono equivalenti). Dimostrare una equivale a dimostrare l'altra.

> [!danger] Attenzione!
> Non confonderla con la **reciproca** ($B \Rightarrow A$), che **non** è equivalente all'originale.

___
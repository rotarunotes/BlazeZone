Data: 2026-09-30
[Analisi_1](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
# Index
- [[#Assioma]]
- [[#Preposizione Logica]]
- [[#Enunciato]]
	- [[#Implicazioni]]
- [[#Teorema]]
___

# Assioma

Una assioma è un'affermazione o una regola fondamentale che viene **accettata come vera per definizione**, senza bisogno (o possibilità) di essere dimostrata.

___
# Preposizione Logica

Una **proposizione** è un'affermazione o un enunciato di cui si può stabilire con certezza assoluta il **valore di verità**: 
- o è **vera (V)** o è **falsa (F)**, senza alcuna via di mezzo o ambiguità.
  
> [!example] Esempio
> $$\pi > 3$$

___
# Enunciato

Un **enunciato** è un'affermazione che può essere solo **vera** o **falsa**. Di solito ha questa forma:

$$\underbrace{\text{Contesto}}_{\text{"Sia}\ldots\text{"}} \;+\; \underbrace{\text{Ipotesi}}_{\text{premessa}} \;\Longrightarrow\; \underbrace{\text{Tesi}}_{\text{conseguenza}}$$

| Parte                     | Cosa contiene                                                                     | Esempio                    |
| ------------------------- | --------------------------------------------------------------------------------- | -------------------------- |
| **Contesto**<br>(Dati)    | Gli oggetti su cui si lavora, con eventuali quantificatori ($\forall$, $\exists$) | $\forall a,b\in\mathbb{N}$ |
| **Ipotesi** (premessa)    | Ciò che si assume vero                                                            | $a\le b$ e $b\le a$        |
| **Tesi**<br>(conseguenza) | Ciò che si vuole concludere                                                       | $a=b$                      |
| **Connettivo**            | Il legame logico tra ipotesi e tesi                                               | $\Rightarrow$ opp          |


> [!info] Info: Differenza tra preposizione ed enunciato
> Il termine **proposizione** arriva dritto dalla logica matematica a differenza di **enunciato** che si riferisce più alla **formulazione linguistica o simbolica** di un concetto.

## Implicazioni

Un'**implicazione** è un enunciato composto della forma_
$$A ⇒ B$$Questo implica che: A (antecedente, cioè l'ipotesi) e B (conseguente, cioè la tesi), allora **non** può succedere che A sia vera e B falsa.

| A   | B   | $A ⇒ B$ |
| --- | --- | ------- |
| V   | V   | V       |
| V   | F   | **F**   |
| F   | V   | V       |
| F   | F   | V       |
> [!example] Esempio: $A: x = 2, B: x² = 4$
> Enunciato: se x = 2, allora x² = 4.
> 
> |A|B|A ⇒ B|Esempio|
> |---|---|---|---|
> |V|V|V|x = 2: A vera, x² = 4 vera → implicazione vera|
> |V|F|**F**|caso impossibile: con x = 2 non si può avere x² ≠ 4|
> | F|V|V|x = −2: A falsa, ma x² = 4 vera → implicazione vera|
> | F|F|V|x = 3: A falsa, x² = 9 ≠ 4 falsa → implicazione vera|

> [!info] Info: 4 forme di implicazione
> | Nome                 | Forma                     | Equivalente a $A\Rightarrow B$?   |
> | -------------------- | ------------------------- | --------------------------------- |
>| Diretta              | $A\Rightarrow B$          | (è l'originale)                   |
>| **Contronominale**   | $\neg B\Rightarrow\neg A$ | **Sì**                            |
>| Reciproca (conversa) | $B\Rightarrow A$          | No                                |
>| Inversa              | $\neg A\Rightarrow\neg B$ | No (è equivalente alla reciproca) |
>
>> [!example] Esempio: $A: x = 2, B: x² = 4$
>> Enunciato originale: se x = 2, allora x² = 4.
>> 
>> |Forma|Scrittura|Con A e B|Vera o falsa?|
>>|---|---|---|---|
>>|Diretta|A ⇒ B|se x = 2, allora x² = 4|**Vera**|
>>|Contronominale|¬B ⇒ ¬A|se x² ≠ 4, allora x ≠ 2|**Vera**|
>>|Reciproca|B ⇒ A|se x² = 4, allora x = 2|**Falsa**|
>>|Inversa|¬A ⇒ ¬B|se x ≠ 2, allora x² ≠ 4|**Falsa**|

___
# Teorema

Un **teorema** è un'affermazione (un enunciato) che **è stata logicamente dimostrata essere vera** partendo da basi certe.

- Struttura standard di un teorema:
	1. **Etichetta
	2. **Enunciato**:
	    - Contesto
	    - Ipotesi
	    - Tesi
	3. **Dimostrazione**: dalla verità delle ipotesi si arriva, con passaggi logici giustificati, alla verità della tesi.
___
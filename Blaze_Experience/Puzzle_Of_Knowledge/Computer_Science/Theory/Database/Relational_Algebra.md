Data: 2025-10-27
[Database](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database
___

# Indice
##### Operatori Relazionali
- [[#Selezione]]
- [[#Proiezione]]
- [[#Unione]]
- [[#Intersezione]]
- [[#Sottrazione]]
- [[#Piano Cartesiano]]
- [[#Giunzione Naturale]]
- [[#Theta Junction]]
- [[#Ridenominazione]]
##### Grado e Cardinalità
-[[#Grado e Cardinalita]]

___
# **Relazione $R_1$**

| Nome     | Cognome | Età | Città |
| :------- | :------ | :-- | :---- |
| Mattia   | Barina  | 23  | Mira  |
| Giuseppe | Maugeri | 12  | Dolo  |
# **Relazione $R_2$**
| Nome    | Cognome | Età | Città  |
| :------ | :------ | :-- | :----- |
| Giacomo | Sacco   | 21  | Mestre |
| Mattia  | Scatto  | 42  | Mestre |
| Mattia  | Barina  | 23  | Mira   |

# Operatori
## Selezione
- **Filtro orizzontale:** seleziona le tuple (righe) che soddisfano una condizione booleana.
- Non modifica le colonne.
$$
\sigma_{\text{<espressione booleana>}}(Relazione)
$$

**Esempio:** 
$$
\sigma_{\text{<Cognome = Barina>}}(R_1)
$$

| Nome   | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
## Proiezione
- **Filtro verticale:** seleziona solo alcune colonne (attributi).
- Rimuove i duplicati (nel modello teorico).
$$
\pi_{\text{<espressione booleana>}}(Relazione)
$$

**Esempio:**
$$
\pi_{\text{<Nome>}}(R_1)
$$

| Nome     |
| :------- |
| Mattia   |
| Giuseppe |
## Unione
- Combina le tuple di due relazioni **compatibili** (stesso grado e attributi).
- Elimina i duplicati.
- Le relazioni devono essere compatibili.
$$
Reralazione1 \cup Reralazione2
$$

**Esempio:**
$$
R_1 \cup R_2
$$

| Nome     | Cognome | Età | Città  |
| :------- | :------ | :-- | :----- |
| Mattia   | Barina  | 23  | Mira   |
| Giuseppe | Maugeri | 12  | Dolo   |
| Giacomo  | Sacco   | 21  | Mestre |
| Mattia   | Scatto  | 42  | Mestre |
## Intersezione
- Elementi in comune
$$
Relazioen1 \cap Relazione2
$$

**Esempio:**
$$
R_1 \cap R_2
$$

| Nome   | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |

## Sottrazione
- Restituisce le tuple presenti in \( R_1 \) ma **non** in \( R_2 \).
- Le relazioni devono essere compatibili.
$$
Relazione1 \backslash Relazione2
$$

**Esempio:**
$$
R_1 \backslash R_2
$$

| Nome     | Cognome | Età | Città |
| :------- | :------ | :-- | :---- |
| Giuseppe | Maugeri | 12  | Dolo  |
## Piano Cartesiano
-  Combina **ogni** tupla di  $R_1$  **con ogni** tupla di $R_2$**.
$$
Relazione1 \times Relazione2
$$

**Esempio:**
$$
R_1 \times R_2
$$

| Nome_R1 | Cognome_R1 | Età_R1 | Città_R1 | Nome_R2 | Cognome_R2 | Età_R2 | Città_R2 |
| :------ | :--------- | :----- | :------- | :------ | :--------- | :----- | :------- |
| Mattia  | Barina     | 23     | Mira     | Giacomo | Sacco      | 21     | Mestre   |
| Mattia  | Barina     | 23     | Mira     | Mattia  | Scatto     | 42     | Mestre   |
| Mattia  | Barina     | 23     | Mira     | Mattia  | Barina     | 23     | Mira     |
| Giuseppe| Maugeri    | 12     | Dolo     | Giacomo | Sacco      | 21     | Mestre   |
| Giuseppe| Maugeri    | 12     | Dolo     | Mattia  | Scatto     | 42     | Mestre   |
| Giuseppe| Maugeri    | 12     | Dolo     | Mattia  | Barina     | 23     | Mira     |

## Giunzione Naturale
- Combina due relazioni **sulla base degli attributi comuni**.
$$
Relazione1 \bowtie Relazione2
$$

**Esempio:**
$$
R \bowtie R_2
$$

| Nome   | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
## Theta Junction
- Permette confronti diversi da “uguaglianza” degli attributi di 2 relazioni.
$$
R_1 \bowtie_{\text{<condizione>}} R_2
$$

**Esempio:**
$$
R_1 \bowtie_{Eta_1 > Eta_2} R_2
$$
- Mattia (23) confronta con R2:
    - 23 > 21 
    - 23 > 42 
    - 23 > 23 
- Giuseppe (12) confronta con R2:
    - 12 > 21 
    - 12 > 42 
    - 12 > 23 

| Nome_R1 | Cognome_R1 | Età_R1 | Città_R1 | Nome_R2 | Cognome_R2 | Età_R2 | Città_R2 |
| :------ | :--------- | :----- | :------- | :------ | :--------- | :----- | :------- |
| Mattia  | Barina     | 23     | Mira     | Giacomo | Sacco      | 21     | Mestre   |

## Ridenominazione
- Cambia gli attributi della relazione.
$$
\rho_{\ <NuovoNome \leftarrow VecchioNome>}(Relazione)
$$
**Esempio:**
$$
\rho_{\ <Nome1 \leftarrow Nome>}(R_1)
$$

| Nome1  | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
| Giuseppe | Maugeri | 12  | Dolo  

---
# Grado e Cardinalita

| Operatore           | Simbolo          | Grado (n° attributi)                                   | Cardinalità (n° tuple)                                      |
| :------------------ | :--------------- | :----------------------------------------------------- | :---------------------------------------------------------- |
| Selezione           | $\sigma$         | Stesso grado della relazione originale                 | ≤ cardinalità della relazione originale                     |
| Proiezione          | $\pi$            | Minore o uguale al grado originale (seleziona colonne) | ≤ cardinalità della relazione originale (rimuove duplicati) |
| Unione              | $\cup$           | Stesso grado delle relazioni unite                     | ≤ somma delle cardinalità delle relazioni                   |
| Intersezione        | $\cap$           | Stesso grado delle relazioni                           | ≤ cardinalità della relazione più piccola                   |
| Sottrazione         | $\backslash$     | Stesso grado delle relazioni                           | ≤ cardinalità della prima relazione                         |
| Prodotto Cartesiano | $\times$         | Somma dei gradi delle due relazioni                    | Prodotto delle cardinalità delle due relazioni              |
| Giunzione Naturale  | $\bowtie$        | Somma dei gradi meno gli attributi comuni              | ≤ prodotto delle cardinalità delle due relazioni            |
| Theta Join          | $\bowtie_\theta$ | Somma dei gradi delle due relazioni                    | ≤ prodotto delle cardinalità delle due relazioni            |
| Rinomina            | $\rho$           | Stesso grado della relazione                           | Stessa cardinalità della relazione                          |

---
 
Data: 2025-10-27
[Database](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database
___
# Index

##### Teoria
- [[#Definizione Di Relazione]]
	- [[#Caratteristiche]]
	- [[#Chiavi]]
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
- [[#Grado e Cardinalita]]
##### Esercizio
- [[#Cinema (Ex Verifica)]]
___
# Definizione Di Relazione
In informatica e nei database, una **relazione** è il termine tecnico e formale per definire una **tabella**.
È composta da due parti principali:
- **Intestazione (Schema):** insieme degli **attributi** (nomi delle colonne).  
- **Corpo (Istanza):** insieme delle **tuple** (righe).

Ogni **tupla** rappresenta un record e contiene un valore specifico per ogni attributo.

**Struttura:**
- Composta da valori **atomici** (non divisibili)
- **Non** hanno **ordine** tra le righe e colonne
- È per definizione un **insieme**, quindi ogni tupla deve essere **unica** all'interno della relazione 

| Attributo | Attributo | Attributo | Attributo |
| --------- | --------- | --------- | --------- |
| Tupla     |           |           |           |
| Tupla     |           |           |           |

**Esempio**:

| Nome     | Cognome | Età | Città |
| -------- | ------- | --- | ----- |
| Mattia   | Barina  | 23  | Mira  |
| Giuseppe | Maugeri | 12  | Dolo  |
## Caratteristiche
- **Grado**: Numero di attributi (colonne).
- **Cardinalità**: Numero di tuple (righe).
## Chiavi
**Chiave primaria**: è una chiave che identifica univocamente una tupla dento a una relazione

| ID  | Nome     | Cognome |
| --- | -------- | ------- |
| 1   | Mattia   | Barina  |
| 2   | Giuseppe | Maugeri |
| 3   | Daniele  | Dentico |
La colonna **ID** è la chiave primaria perchè identifica con:
- 1 -> La riga di Mattia Barina
- 2 -> La riga di Giuseppe Maugeri
- 3 -> La riga di Daniele Dentico

**Chiave esterna**: è una chiave che punta a una chiave primaria di un'altra relazione

| ID  | ID_Persona | Età | Città  |
| --- | ---------- | --- | ------ |
| 100 | 1          | 23  | Mira   |
| 200 | 2          | 12  | Dolo   |
| 300 | 3          | 90  | Torino |
La colonna ID_Persona è la chiave esterna, ogni cella punta alla chiave primaria della tabella precedente.
___

# **Relazioni Usate Nelle Spiegazioni**:

$R_1$

| Nome     | Cognome | Età | Città |
| :------- | :------ | :-- | :---- |
| Mattia   | Barina  | 23  | Mira  |
| Giuseppe | Maugeri | 12  | Dolo  |
$R_2$

| Nome    | Cognome | Età | Città  |
| :------ | :------ | :-- | :----- |
| Giacomo | Sacco   | 21  | Mestre |
| Mattia  | Scatto  | 42  | Mestre |
| Mattia  | Barina  | 23  | Mira   |
___
# Selezione
- **Filtro orizzontale**: seleziona le tuple (righe) che soddisfano una condizione booleana.
- Non modifica le colonne.
$$
\sigma_{\text{<espressione booleana>}}(Relazione)
$$

**Esempio**: 
$$
\sigma_{\text{<Cognome = Barina>}}(R_1)
$$

| Nome   | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
___
# Proiezione
- **Filtro orizzontale**: seleziona solo alcune colonne (attributi).
- Rimuove i duplicati (nel modello teorico).
$$
\pi_{\text{<espressione booleana>}}(Relazione)
$$

**Esempio**: 
$$
\pi_{\text{<Nome>}}(R_1)
$$

| Nome     |
| :------- |
| Mattia   |
| Giuseppe |
___
# Unione
- Combina le tuple di due relazioni **compatibili** (stesso grado e attributi).
- Elimina i duplicati.
- Le relazioni devono essere compatibili.
$$
Reralazione1 \cup Reralazione2
$$

**Esempio**: 
$$
R_1 \cup R_2
$$

| Nome     | Cognome | Età | Città  |
| :------- | :------ | :-- | :----- |
| Mattia   | Barina  | 23  | Mira   |
| Giuseppe | Maugeri | 12  | Dolo   |
| Giacomo  | Sacco   | 21  | Mestre |
| Mattia   | Scatto  | 42  | Mestre |
___
# Intersezione
- Elementi in comune
$$
Relazioen1 \cap Relazione2
$$

**Esempio**: 
$$
R_1 \cap R_2
$$

| Nome   | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
___
# Sottrazione
- Restituisce le tuple presenti in \( R_1 \) ma **non** in \( R_2 \).
- Le relazioni devono essere compatibili.
$$
Relazione1 \backslash Relazione2
$$

**Esempio**: 
$$
R_1 \backslash R_2
$$

| Nome     | Cognome | Età | Città |
| :------- | :------ | :-- | :---- |
| Giuseppe | Maugeri | 12  | Dolo  |
___
# Piano Cartesiano
-  Combina **ogni** tupla di  $R_1$  **con ogni** tupla di $R_2$**.
$$
Relazione1 \times Relazione2
$$

**Esempio**: 
$$
R_1 \times R_2
$$

| Nome_R1  | Cognome_R1 | Età_R1 | Città_R1 | Nome_R2 | Cognome_R2 | Età_R2 | Città_R2 |
| :------- | :--------- | :----- | :------- | :------ | :--------- | :----- | :------- |
| Mattia   | Barina     | 23     | Mira     | Giacomo | Sacco      | 21     | Mestre   |
| Mattia   | Barina     | 23     | Mira     | Mattia  | Scatto     | 42     | Mestre   |
| Mattia   | Barina     | 23     | Mira     | Mattia  | Barina     | 23     | Mira     |
| Giuseppe | Maugeri    | 12     | Dolo     | Giacomo | Sacco      | 21     | Mestre   |
| Giuseppe | Maugeri    | 12     | Dolo     | Mattia  | Scatto     | 42     | Mestre   |
| Giuseppe | Maugeri    | 12     | Dolo     | Mattia  | Barina     | 23     | Mira     |
___
# Giunzione Naturale
- Combina due relazioni **sulla base degli attributi comuni**.
$$
Relazione1 \bowtie Relazione2
$$

**Esempio**: 
$$
R \bowtie R_2
$$

| Nome   | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
___
# Theta Junction
- Permette confronti diversi da “uguaglianza” degli attributi di 2 relazioni.
$$
R_1 \bowtie_{\text{<condizione>}} R_2
$$

**Esempio**: 
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
___
# Ridenominazione
- Cambia gli attributi della relazione.
$$
\rho_{\ <NuovoNome \leftarrow VecchioNome>}(Relazione)
$$
**Esempio**: 
$$
\rho_{\ <Nome1 \leftarrow Nome>}(R_1)
$$

| Nome1  | Cognome | Età | Città |
| :----- | :------ | :-- | :---- |
| Mattia | Barina  | 23  | Mira  |
| Giuseppe | Maugeri | 12  | Dolo  

___
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

___
# Cinema (Ex Verifica)

| Entità         | Attributi                                       | Note Chiavi Esterne (FK)                                                                                     |
| -------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| PERSONA        | (**id**, nome, cognome)                         |                                                                                                              |
| FILM           | (**id_film**, id_regista, titolo, genere, anno) | $\text{id\_regista} \to \text{PERSONA}(\text{id})$                                                           |
| PARTECIPAZIONE | (**id_persona**, **id_film**, **ruolo**)        | $\text{id\_persona} \to \text{PERSONA}(\text{id})$, $\text{id\_film} \to \text{FILM}(\text{id\_film})$       |
| PROIEZIONE     | (**id_film**, **id_cinema**, giorno)            | $\text{id\_film} \to \text{FILM}(\text{id\_film})$, $\text{id\_cinema} \to \text{CINEMA}(\text{id\_cinema})$ |
| CINEMA         | (**id_cinema**, nome, indirizzo)                |                                                                                                              |
**Consegna**:
1. Elencare nome e cognome di ogni regista presente nella base di dati.
2. Quali sono i nominativi (nome e cognome) degli artisti che sono tanto attori quanto registi.
3. Quali film sono stati proiettati prima del 2002?
4. Elencare gli attori presenti nei film diretti da Lars von Trier.
5. Definire la lista dei registi che hanno diretto sia film drammatici che commedie.
6. Elencare i film interpretati da Nicole Kidman e proiettati al cinema Zenith.
7. Elencare gli attori che non hanno mai interpretato ruoli in film drammatici.
8. Elencare gli attori che hanno interpretato qualche film proiettato al cinema Zenith dopo l'anno 2002.
9. Individuare i film che sono stati proiettati per ultimi (giorno).

**Svolgimento**:
###### EX 1
$$\pi_{Nome, Cognome} (Film \bowtie_{ID\_Regista = ID\_Persona} Persona)$$
###### EX 2

$$R_{Registi} = \rho_{ID\_Persona \leftarrow ID\_Regista} (\pi_{ID\_Regista}(Film))$$
$$R_{Attori} = \rho_{ID\_Persona \leftarrow ID\_Attore} (\pi_{ID\_Attore}(Partecipazione))$$
$$R_{Entrambi} = R_{Registi} \cap R_{Attori}$$
$$\text{Output: } \pi_{Nome, Cognome} (R_{Entrambi} \bowtie Persona)$$

###### EX 3
$$\sigma_{Anno < 2002} (Film)$$

###### EX 4

$$R_{LarsID} = \pi_{ID\_Persona} (\sigma_{Nome='Lars' \land Cognome='Von Trier'} (Persona))$$
$$R_{LarsFilms} = \pi_{ID\_Film} (R_{LarsID} \bowtie_{ID\_Persona = ID\_Regista} Film)$$
$$R_{AttoriID} = \pi_{ID\_Attore} (R_{LarsFilms} \bowtie Partecipazione)$$
$$\text{Output: } \pi_{Nome, Cognome} (R_{AttoriID} \bowtie_{ID\_Attore = ID\_Persona} Persona)$$

###### EX 5

$$R_{Drama} = \pi_{ID\_Regista} (\sigma_{Genere='Drammatico'} (Film))$$
$$R_{Commedia} = \pi_{ID\_Regista} (\sigma_{Genere='Commedia'} (Film))$$
$$R_{EntrambiID} = R_{Drama} \cap R_{Commedia}$$
$$\text{Output: } \pi_{Nome, Cognome} (R_{EntrambiID} \bowtie_{ID\_Regista = ID\_Persona} Persona)$$

###### EX 6

$$R_{NicoleID} = \pi_{ID\_Persona} (\sigma_{Nome='Nicole' \land Cognome='Kidman'} (Persona))$$
$$R_{NicoleFilms} = \pi_{ID\_Film} (R_{NicoleID} \bowtie_{ID\_Persona = ID\_Attore} Partecipazione)$$
$$R_{ZenithID} = \pi_{ID\_Cinema} (\sigma_{Nome='Zenith'} (Cinema))$$
$$R_{ZenithFilms} = \pi_{ID\_Film} (R_{ZenithID} \bowtie Proiezione)$$
$$R_{FinalID} = R_{NicoleFilms} \cap R_{ZenithFilms}$$
$$\text{Output: } \pi_{Titolo} (R_{FinalID} \bowtie Film)$$

###### EX 7

$$R_{AttoriID} = \pi_{ID\_Attore} (Partecipazione)$$
$$R_{FilmDrammatici} = \pi_{ID\_Film} (\sigma_{Genere='Drammatico'} (Film))$$
$$R_{AttoriDrammatici} = \pi_{ID\_Attore} (R_{FilmDrammatici} \bowtie Partecipazione)$$
$$R_{NoDrama} = R_{AttoriID} \setminus R_{AttoriDrammatici}$$
$$\text{Output: } \pi_{Nome, Cognome} (R_{NoDrama} \bowtie_{ID\_Attore = ID\_Persona} Persona)$$

###### EX 8

$$R_{ZenithID} = \pi_{ID\_Cinema} (\sigma_{Nome='Zenith'} (Cinema))$$
$$R_{Proiezioni} = \sigma_{Giorno > '2002-12-31'} (Proiezione \bowtie R_{ZenithID})$$
$$R_{FilmsID} = \pi_{ID\_Film} (R_{Proiezioni})$$
$$R_{AttoriID} = \pi_{ID\_Attore} (R_{FilmsID} \bowtie Partecipazione)$$
$$\text{Output: } \pi_{Nome, Cognome} (R_{AttoriID} \bowtie_{ID\_Attore = ID\_Persona} Persona)$$

###### EX 9

$$R_{TuttiCinema} = \pi_{ID\_Cinema} (Cinema)$$
$$R_{TuttiAttori} = \pi_{ID\_Attore} (Partecipazione)$$
$$R_{TutteCoppie} = R_{TuttiCinema} \times R_{TuttiAttori}$$
$$R_{CoppieEsistenti} = \pi_{ID\_Cinema, ID\_Attore} (Proiezione \bowtie Partecipazione)$$
$$R_{CoppieMancanti} = R_{TutteCoppie} \setminus R_{CoppieEsistenti}$$
$$R_{AttoriNonInComune} = \pi_{ID\_Attore} (R_{CoppieMancanti})$$
$$R_{Finale} = R_{TuttiAttori} \setminus R_{AttoriNonInComune}$$
$$\text{Output: } \pi_{Nome, Cognome} (R_{Finale} \bowtie_{ID\_Attore = ID\_Persona} Persona)$$

###### EX 10
$$R_{Giorni1} = \pi_{Giorno} (Proiezione)$$
$$R_{Giorni2} = \rho_{Giorno\_2 \leftarrow Giorno} (R_{Giorni1})$$
$$R_{NonUltimoGiorno} = R_{Giorni1} \bowtie_{Giorno < Giorno\_2} R_{Giorni2}$$
$$R_{UltimoGiorno} = R_{Giorni1} \setminus R_{NonUltimoGiorno}$$
$$R_{FilmID} = \pi_{ID\_Film} (R_{UltimoGiorno} \bowtie Proiezione)$$
$$\text{Output: } \pi_{Titolo} (R_{FilmID} \bowtie Film)$$

___

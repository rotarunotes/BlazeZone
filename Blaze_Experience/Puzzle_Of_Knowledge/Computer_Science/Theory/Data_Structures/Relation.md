Data: 2025-10-27
[Data_Structures](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Data_Structures
___
# Index
- [[#Definizione]]]]
- [[#Caratteristiche]]
- [[#Chiavi]]
___
# Definizione
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

___
# Caratteristiche
- **Grado**: Numero di attributi (colonne).
- **Cardinalità**: Numero di tuple (righe).
___
# Chiavi
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
Data: 2025-10-27
[Data_Structures](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Data_Structures
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

**Esempio:**

| Nome     | Cognome | Età | Città |
| -------- | ------- | --- | ----- |
| Mattia   | Barina  | 23  | Mira  |
| Giuseppe | Maugeri | 12  | Dolo  |

___
# Caratteristiche
- **Grado** di una relazione sono il numero di attributi
- **Cardinalità** di una relazione sono il numero delle tuple
___
# Chiavi
- **Chiave primaria:** è una chiave che identifica univocamente una tupla dento a una relazione
- **Chiave esterna:** è una chiave che punta a una chiave primaria di un'altra relazione
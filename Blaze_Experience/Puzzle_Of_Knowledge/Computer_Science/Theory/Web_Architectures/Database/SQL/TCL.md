Data: 2025-10-29
[SQL](Puzzle_Of_Knowledge/Computer_Science/Theory/Web_Architectures/Database/SQL/README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Index
- [[#Transaction Control Language]]
- [[#Transazione]]
	- [[#ACID]]
		- [[#Atomicità (Atomicity)]]
		- [[#Consistenza (Consistency)]]
		- [[#Isolamento (Isolation)]]
		- [[#Durabilità (Durability)]]
- [[#COMMIT]]
- [[#ROLLBACK]]
- [[#SAVEPOINT]]
- [[#Riepilogo]]
![[#Riepilogo]]
___
# Transaction Control Language

Il **TCL** è la parte del linguaggio SQL utilizzata per **gestire le transazioni**, ovvero gruppi di operazioni che devono essere eseguite come un'unica unità logica.

![Schema_Transazione.png](../../../../../../Setup_Archive/Viewable/Image/Computer_Science/Theory/Schema_Transazione.png)

___
# Transazione

Una **transazione** è una sequenza di operazioni SQL (INSERT, UPDATE, DELETE) che vengono trattate come un **blocco unico**: 
* Vanno a buon fine tutte insieme.
* Vengono annullate tutte insieme.
  
**Esempio**: Bonifico Bancario

**Query**:

```sql
-- Operazione 1: sottrai 500€ dal conto di Luca
UPDATE Conti SET Saldo = Saldo - 500 WHERE Titolare = 'Luca';

-- Operazione 2: aggiungi 500€ al conto di Anna
UPDATE Conti SET Saldo = Saldo + 500 WHERE Titolare = 'Anna';
```

**Spiegazione**:
Se la prima operazione va a buon fine ma la seconda fallisce (per un errore, un crash, ecc.), Luca perderebbe 500€ nel nulla.
La transazione garantisce che **entrambe le operazioni avvengano, o nessuna**.
___
## ACID
Ogni transazione deve rispettare le quattro proprietà **ACID**, che garantiscono l'affidabilità del database.
### Atomicità *(Atomicity)*
La transazione è **indivisibile**: o tutte le operazioni vengono eseguite, o nessuna viene applicata. Non esistono stati intermedi.
Se avvengono transazioni concorrenti vengono eseguite serialmente


> [!Example] Nota
> Tornando al bonifico: se il sistema crasha dopo la prima UPDATE, il DBMS annulla automaticamente anche quella già eseguita.
### Consistenza *(Consistency)*

La transazione porta il database da uno **stato valido** a un altro **stato valido**, rispettando tutti i vincoli definiti (constraints, regole di integrità, ecc.).

> [!Example] Nota
> Il saldo di un conto non può diventare negativo se esiste un CHECK che lo impedisce. La transazione viene annullata se violerebbe un vincolo.
### Isolamento *(Isolation)*

Le transazioni eseguite **in parallelo** non si influenzano a vicenda. Ogni transazione vede il database come se fosse l'unica in esecuzione.

> [!Example] Nota
> Se Luca e Anna fanno un bonifico contemporaneamente, le loro transazioni non si interferiscono.

### Durabilità *(Durability)*

Una volta che una transazione è stata confermata con `COMMIT`, le modifiche sono **permanenti**, anche in caso di crash o interruzione di corrente.

> [!Example] Nota
> Dopo il COMMIT del bonifico, i nuovi saldi sono salvati definitivamente.

___
# COMMIT

Salva **definitivamente** tutte le modifiche effettuate dall'inizio della transazione. Una volta eseguito, non è possibile annullare le operazioni.

```sql
BEGIN TRANSACTION;

UPDATE Conti SET Saldo = Saldo - 500 WHERE Titolare = 'Luca';
UPDATE Conti SET Saldo = Saldo + 500 WHERE Titolare = 'Anna';

COMMIT;
-- ✅ Le modifiche sono salvate definitivamente.
```

___
# ROLLBACK

Annulla **tutte le modifiche** effettuate dall'inizio della transazione (o dall'ultimo SAVEPOINT), riportando il database allo stato precedente.

```sql
BEGIN TRANSACTION;

UPDATE Conti SET Saldo = Saldo - 500 WHERE Titolare = 'Luca';
-- ❌ Si verifica un errore nella seconda operazione

ROLLBACK;
-- ✅ La prima UPDATE viene annullata. Il saldo di Luca è invariato.
```

___
# SAVEPOINT

Crea un **punto di salvataggio intermedio** all'interno di una transazione. Permette di fare un `ROLLBACK` parziale, tornando solo fino a quel punto invece di annullare tutto.

```sql
BEGIN TRANSACTION;

UPDATE Conti SET Saldo = Saldo - 500 WHERE Titolare = 'Luca';

SAVEPOINT dopo_luca;  -- Punto di salvataggio

UPDATE Conti SET Saldo = Saldo + 500 WHERE Titolare = 'Anna';
-- ❌ Qualcosa va storto con Anna

ROLLBACK TO dopo_luca;
-- ✅ Si torna al savepoint: la modifica su Luca rimane,
--    quella su Anna viene annullata.

COMMIT;
```

**Eliminare un savepoint:**

```sql
RELEASE SAVEPOINT dopo_luca;
```

___
# Riepilogo
**ACID**

| Proprietà       | Garanzia                                       |
| :-------------- | :--------------------------------------------- |
| **Atomicità**   | Tutto o niente: non esistono stati intermedi   |
| **Consistenza** | Il database resta sempre in uno stato valido   |
| **Isolamento**  | Le transazioni parallele non si interferiscono |
| **Durabilità**  | Dopo il COMMIT, le modifiche sono permanenti   |
**Query**:

| Comando                    | Effetto                                                  |
| :------------------------- | :------------------------------------------------------- |
| `BEGIN TRANSACTION`        | Avvia una nuova transazione                              |
| `COMMIT`                   | Salva definitivamente tutte le modifiche                 |
| `ROLLBACK`                 | Annulla tutte le modifiche dall'inizio della transazione |
| `SAVEPOINT <nome>`         | Crea un punto di salvataggio intermedio                  |
| `ROLLBACK TO <nome>`       | Annulla le modifiche fino al savepoint indicato          |
| `RELEASE SAVEPOINT <nome>` | Elimina un savepoint                                     |
___
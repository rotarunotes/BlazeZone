Data: 2025-10-29
[SQL](Puzzle_Of_Knowledge/Computer_Science/Theory/Web_Architectures/Database/SQL/README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Index
- [[#Data Control Language]]
- [[#GRANT]]
	- [[#WITH GRANT OPTION]]
- [[#REVOKE]]
- [[#Tipi di Privilegi]]

| Comando             | Effetto                                                |
| :------------------ | :----------------------------------------------------- |
| `GRANT`             | Dà il permesso a un utente di eseguire un'operazione   |
| `REVOKE`            | Toglie il permesso a un utente                         |
| `PUBLIC`            | Keyword per riferirsi a tutti gli utenti del database  |
| `WITH GRANT OPTION` | Permette all'utente di delegare il privilegio ad altri |
___
# Data Control Language

Il **DCL** è la parte del linguaggio SQL utilizzata per **gestire i permessi e gli accessi** al database. Controlla chi **può** fare **cosa** sugli oggetti del database (tabelle, viste, ecc.).

I due comandi principali sono:

| Comando  | Descrizione                     |
| :------- | :------------------------------ |
| `GRANT`  | Concede un permesso a un utente |
| `REVOKE` | Revoca un permesso da un utente |

___
# GRANT

Concede uno o più privilegi a un utente su un oggetto del database.

```sql
-- Struttura base
GRANT <privilegio>
ON <oggetto>
TO <utente>;
```

```sql
-- Permesso di sola lettura
GRANT SELECT
ON Studenti
TO mario;
```

```sql
-- Più permessi insieme
GRANT SELECT, INSERT, UPDATE
ON Studenti
TO mario;
```

```sql
-- Permesso a tutti gli utenti
GRANT SELECT
ON Studenti
TO PUBLIC;
```

## WITH GRANT OPTION
Permette all'utente ricevente di **concedere a sua volta** lo stesso privilegio ad altri utenti.

```sql
GRANT SELECT
ON Studenti
TO mario
WITH GRANT OPTION;
```

___
# REVOKE

Revoca uno o più privilegi precedentemente concessi a un utente.


```sql
-- Struttura
REVOKE <privilegio>
ON <oggetto>
FROM <utente>;
```


```sql
-- Revoca il permesso di select a mario
REVOKE SELECT
ON Studenti
FROM mario;
```

```sql
-- Revocare più permessi insieme
REVOKE SELECT, INSERT, UPDATE
ON Studenti
FROM mario;
```

___
# Tipi di Privilegi

| Privilegio | Descrizione                           |
| :--------- | :------------------------------------ |
| `SELECT`   | Leggere i dati di una tabella         |
| `INSERT`   | Inserire nuovi record                 |
| `UPDATE`   | Modificare record esistenti           |
| `DELETE`   | Eliminare record                      |
| `ALTER`    | Modificare la struttura della tabella |
| `DROP`     | Eliminare la tabella                  |
| `ALL`      | Tutti i privilegi sopra elencati      |

```sql
-- Esempio con ALL
GRANT ALL
ON Studenti
TO mario;
```

---
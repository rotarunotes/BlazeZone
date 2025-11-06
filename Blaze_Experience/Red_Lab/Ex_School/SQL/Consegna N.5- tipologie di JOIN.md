Data: 2025-11-06
[](./README.md)
#Red_Lab/Ex_School/SQL
___
# Consegna
Scrivi ed esegui con PHPmyAdmin di XAMPP le query relative alle operazioni di algebra relazionare:  
-equi-join  
-natural-join  
N.B. per realizzare il natural-join crearsi precedentemente una nuova tabella che abbia l'attributo in comune.  
-theta-join con condizione semplice  (con solo operazione di confronto)  
-theta-join con condizione complessa (con anche un operatore booleano es. OR o AND)  
partendo dalle tabelle dell'esercizio svolto in Java sull'algebra relazionale.  
Crea precedentemente le stesse tabelle con gli stessi attributi.  
Aggiungi alcune righe alle tabelle.  
  
Consegna un PDF contenente:  
-l'indicazione delle tabelle con attributi  ES.  Impiegati(id, nome, cognome)  
-per ogni attributo indica il tipo e la precisione (lunghezza)  
-il codice SQL che realizza le query
___
# Esecuzione

| IMPIEGATI | Attributo      | Tipo          |
| --------- | -------------- | ------------- |
|           | `id_impiegato` | INT(5)        |
|           | `nome`         | VARCHAR(30)   |
|           | `cognome`      | VARCHAR(30)   |
|           | `stipendio`    | DECIMAL(10,2) |
|           | `id_reparto`   | INT(5)        |

| REPARTI | Attributo      | Tipo        |
| ------- | -------------- | ----------- |
|         | `id_reparto`   | INT(5)      |
|         | `nome_reparto` | VARCHAR(30) |
|         | `sede`         | VARCHAR(30) |

| PROGETTI | Attributo       | Tipo        |
| -------- | --------------- | ----------- |
|          | `id_progetto`   | INT(5)      |
|          | `nome_progetto` | VARCHAR(30) |
|          | `id_reparto`    | INT(5)      |

``` SQL
-- SELEZIONE
SELECT *
FROM country
WHERE Continent = 'Europe';

-- PROIEZIONE
SELECT Name
FROM city
WHERE CountryCode = 'FRA';

-- PRODOTTO CARTESIANO
SELECT *
FROM country, countrylanguage;

-- JOIN (GIUNZIONE)
SELECT city.Name AS cityName, country.Name AS countryName
FROM city, country
WHERE city.CountryCode = country.Code;

-- UNIONE
(SELECT * FROM persone) UNION (SELECT * FROM persone2);

-- INTERSEZIONE
(SELECT * FROM persone) INTERSECT (SELECT * FROM persone2);

-- DIFFERENZA
(SELECT * FROM persone) EXCEPT (SELECT * FROM persone2);

-- INSERIMENTO DI RIGHE IN OGNI TABELLA DEL DATABASE
INSERT INTO city
VALUES (1, "Kabul", "AFG", "Kabol", 1780000),
	   (2, "Qandahar", "AFG", "Qandahar", 23);

INSERT INTO countrylanguage
VALUES ("ABW", "Aruba", "North America", "Caribbean", 193.00, null, 103000, 78.0, 828.00, 793.00, "Aruba", "Nonmetropolitan Territory of The Netherlands", "Beatrix", 129, "AW");

INSERT INTO countrylanguage
VALUES ("ABW", "Dutch", T, 5.3),
	   ("ABW", "English", F, 9.5);
       
INSERT INTO persone
VALUES (2, "Giacomo", "Sacco"),
	   (3, "Cristian", "Rotaru");

-- AGGIORNAMENTO DI ALMENO UNA RIGA PER OGNI TABELLA DEL DATABASE
UPDATE city
SET population = 129000
WHERE id = 1;

UPDATE country
SET name = "Barcellona"
WHERE code = "FRA";

UPDATE countrylanguage
SET isOfficial = "F"
WHERE countryCode = "ABW";

UPDATE persone
SET nome = "BLAZE"
WHERE nome = "Cristian";

-- ELIMINAZIONE DI ALMENO UNA RIGA IN OGNI TABELLA
DELETE FROM city
WHERE id = 1;

DELETE FROM country
WHERE code = "FRA";

DELETE FROM countrylanguage
WHERE countryCode = "ABW";

DELETE FROM persone
WHERE id = 3;

-- EQUI-JOIN
SELECT city.*, countrylanguage.*
FROM city, countrylanguage
WHERE city.CountryCode = countrylanguage.CountryCode;

-- NATURAL-JOIN
SELECT country.*, countrylanguage.*
FROM country, countrylanguage
WHERE country.Code = countrylanguage.CountryCode;

-- THETA-JOIN
SELECT city.*, country.*
FROM city, country
WHERE city.Population = country.Population;

SELECT city.*, country.*
FROM city, country
WHERE city.Population > country.Population;
```

___
 
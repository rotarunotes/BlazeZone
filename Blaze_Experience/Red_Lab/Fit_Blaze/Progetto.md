8)Data: 2026-03-22
[](./README.md)
#Red_Lab/Fit_Blaze
___
Inizio lavoro: 20/03/2026

# Progettazione concettuale:
```
User: (`id` (PK), `username`, `first_name`, `last_name`, `password_hash`, 'created_at')
Workout_Plan: (`id` (PK), `user_id` (FK), `plan_name`, `is_active`, 'created_at')
Daily_Workout: (`id` (PK), `plan_id` (FK), `day_name`, 'day_order', 'created_at')
Exercise: (`id` (PK), `exercise_name` (FK), `muscle_group`, `video_url`, `type`, 'created_at')
Set: (`id` (PK), `day_id` (FK), `exercise_id` (FK), `set_number`, `reps_count`, `rest_time`, `weight`, `notes`, 'created_at')
```

Sito modelli dart: https://javiercbk.github.io/json_to_dart/

#### 22/03
1) Ho fatto le funzioni di fetch che mi restituiscono le liste di:
	- Utenti
	- Schede
	- Allenamento_quotidiano
	- Esercizio
	- Serie
Ma in questo modo prendo tutti i dati di tutto, invece che prendere i dati dell'utente specifico, vabbè, farò in modo che sia il server a restituirmi i dati di quello specifico utente

2)  Ho fatto le query di create table del db locale
   
#### 23/03
1) Metodi di inserimento
	1) Ho finito il processo che carica il db server nel db locale

#### 30/03
1) Ho capito l'archittettura server db locale db
	1) non ho capito gli endpoiint
2) ho creato il db e ho fatto gli insert

#### 02/04
1) ho fatto il server rest parte get, e sono riuscito a testare tutto come si deve con flutter

#### 03/04
1) ho fatto tutti gli altri verbi, post put patch delete
#### 04/04
1) ho finito parte api server e client, manca user
___
# README
1) `PRAGMA` usato quando istanziamo il databese
2) Metodo getter, usato per il singleton del database
	- **Senza get:** `await DatabaseHelper.database();` (Sembra una chiamata a un comando).
	- **Con get:** `await DatabaseHelper.database;` (Sembra di leggere una variabile).
3) batch 
```
// Iniziamo un batch (una serie di operazioni raggruppate)  
Batch batch = db.batch();
// Eseguiamo tutto in un'unica transazione atomica await batch.commit(noResult: true);
```
1) nella funzione di insert, ritorna l'id dell'utente appena creato
___

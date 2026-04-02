
Data: 2026-03-30
[](./README.md)
#Red_Lab/Fit_Blaze
___
```
Utente:(id (PK), nome_utente, nome, cognome, password_hash)

Scheda: (id (PK), utente_id (FK), nome_scheda, data_creazione, is_active)

Allenamento_quotidiano: (id (PK), scheda_id (FK), nome_giorno)

Esercizio: (id (PK), nome_esercizio (FK), fascio_muscolare, video_url, tipologia)

Serie: (id (PK), giorno_id, esercizio_id, numero_serie, numero_ripetizioni, tempo_recupero, peso, note)
```

```
User: (`id` (PK), `username`, `first_name`, `last_name`, `password_hash`)

Workout_Plan: (`id` (PK), `user_id` (FK), `plan_name`, `creation_date`, `is_active`)

Daily_Workout: (`id` (PK), `plan_id` (FK), `day_name`)
 
Exercise: (`id` (PK), `exercise_name` (FK), `muscle_group`, `video_url`, `type`)

Set: (`id` (PK), `day_id` (FK), `exercise_id` (FK), `set_number`, `reps_count`, `rest_time`, `weight`, `notes`)
```
___
# EndPoint Server

**User**

| Richiesta | URL            | Parametri           | Spiegazione              |
| --------- | -------------- | ------------------- | ------------------------ |
| GET       | /user/{id}     |                     | Specifico utente         |
| GET       | /user          |                     | Tutti gli utenti         |
| POST      | /user/register | username + password | Registra                 |
| POST      | /user/login    | username + password | Logga                    |
| DELETE    | /user/{id}     |                     | Elimina specifico utente |
| DELETE    | /user          |                     | Elimina tutti gli utenti |

**Workout_Plan**

| Richiesta | EndPoint                                  | Parametri                                                                    | Spiegazione                                       |
| --------- | ----------------------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------- |
| GET       | /index.php/workoutplan/listByUser?user_id | `user_id`                                                                    | Schede dato l'utente                              |
| POST      |                                           | `user_id` (FK)<br>`plan_name`<br>`creation_date`<br>`is_active`              | Crea una singola scheda                           |
| PUT       |                                           | `id` (PK)<br>`user_id` (FK)<br>`plan_name`<br>`creation_date`<br>`is_active` | Aggiorna la specifica scheda                      |
| PATCH     |                                           | -`user_id` (FK)<br>-`plan_name`<br>-`creation_date`<br>-`is_active`          | Aggiorno solo i parametri che sono dentro al body |
| DELETE    | /workout_plan/{id}                        |                                                                              | Elimina una specifica scheda                      |

**Daily_Workout**

| Richiesta | EndPoint                                    | Parametri                                    | Spiegazione                                       |
| --------- | ------------------------------------------- | -------------------------------------------- | ------------------------------------------------- |
| GET       | /index.php/dailyworkout/listByPlan?plan_id= | `plan_id`                                    | Giorni di allenamento data la scheda              |
| POST      |                                             | `plan_id`  (FK)<br>`day_name`                | Crea un singolo giorno di allenamento             |
| PUT       |                                             | `id` (PK)<br>`plan_id` (FK) `day_name`       | Aggiorna il giorno di allenamento                 |
| PATCH     |                                             | -`id` (PK)<br>-`plan_id` (FK)<br>-`day_name` | Aggiorno solo i parametri che sono dentro al body |
| DELETE    | /workout_plan/{id}                          |                                              | Elimina un specifico giorno di allenamento        |

**Sets**

| Richiesta | EndPoint                         | Parametri                                                                                                                   | Spiegazione                                                       |
| --------- | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| GET       | /index.php/set/listByDay?day_id= | `day_id`                                                                                                                    | Sets più i parametri di `esercizio` dato il giorno di allenamento |
| POST      |                                  | `day_id` (FK)<br>`exercise_id` (FK) <br>`set_number` <br>`reps_count` <br>`rest_time` <br>`weight` <br>`notes`              | Crea una singola serie                                            |
| PUT       |                                  | `id` (PK)<br>`day_id` (FK)<br>`exercise_id` (FK) <br>`set_number` <br>`reps_count` <br>`rest_time` <br>`weight` <br>`notes` | Aggiorna la singola serie                                         |
| PATCH     |                                  | `id` (PK)<br>`day_id` (FK)<br>`exercise_id` (FK) <br>`set_number` <br>`reps_count` <br>`rest_time` <br>`weight` <br>`notes` | Aggiorno solo i parametri che sono dentro al body                 |
| DELETE    | /workout_plan/{id}               |                                                                                                                             | Elimina una singola serie                                         |

```

-- ============================================
-- QUERY DI VERIFICA
-- ============================================

-- Verifica numero record inseriti
SELECT 'Users' AS tabella, COUNT(*) AS totale FROM User
UNION ALL
SELECT 'Exercises', COUNT(*) FROM Exercise
UNION ALL
SELECT 'Workout Plans', COUNT(*) FROM Workout_Plan
UNION ALL
SELECT 'Daily Workouts', COUNT(*) FROM Daily_Workout
UNION ALL
SELECT 'Sets', COUNT(*) FROM `Set`;

-- Mostra tutte le schede attive con i loro utenti
SELECT 
    u.username,
    u.first_name,
    u.last_name,
    wp.plan_name,
    wp.creation_date,
    wp.is_active
FROM Workout_Plan wp
JOIN User u ON wp.user_id = u.id
WHERE wp.is_active = TRUE
ORDER BY u.username, wp.creation_date DESC;

-- Mostra un allenamento completo (esempio: Lunedì di Mario)
SELECT 
    dw.day_name,
    e.exercise_name,
    e.muscle_group,
    s.set_number,
    s.reps_count,
    s.weight,
    s.rest_time,
    s.notes
FROM `Set` s
JOIN Daily_Workout dw ON s.day_id = dw.id
JOIN Exercise e ON s.exercise_id = e.id
WHERE dw.id = 501
ORDER BY s.id;

-- ============================================
-- QUERY UTILI PER L'APPLICAZIONE
-- ============================================

-- Query 1: Ottieni tutte le schede attive di un utente
-- SELECT * FROM Workout_Plan WHERE user_id = 1 AND is_active = TRUE;

-- Query 2: Ottieni tutti i giorni di una scheda
-- SELECT * FROM Daily_Workout WHERE plan_id = 101 ORDER BY day_order;

-- Query 3: Ottieni tutti gli esercizi di un giorno con dettagli
-- SELECT s.*, e.exercise_name, e.muscle_group, e.video_url, e.type
-- FROM `Set` s
-- JOIN Exercise e ON s.exercise_id = e.id
-- WHERE s.day_id = 501
-- ORDER BY s.id;

-- Query 4: Cerca esercizi per gruppo muscolare
-- SELECT * FROM Exercise WHERE muscle_group LIKE '%Pettorali%';

-- Query 5: Statistiche utente (totale schede, schede attive)
-- SELECT 
--     u.username,
--     COUNT(wp.id) AS total_plans,
--     SUM(CASE WHEN wp.is_active = TRUE THEN 1 ELSE 0 END) AS active_plans
-- FROM User u
-- LEFT JOIN Workout_Plan wp ON u.id = wp.user_id
-- GROUP BY u.id, u.username;

-- ============================================
-- FINE SETUP
-- ============================================

SELECT '✅ Database FitBlaze setup completato con successo!' AS status;
```


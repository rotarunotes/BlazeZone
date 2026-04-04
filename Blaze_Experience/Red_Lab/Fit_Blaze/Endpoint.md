
Data: 2026-03-30
[](./README.md)
#Red_Lab/Fit_Blaze
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

## Workout_Plan

| **Metodo** | **Endpoint**                  | **Body JSON**                                    | **Descrizione**            |
| ---------- | ----------------------------- | ------------------------------------------------ | -------------------------- |
| `GET`      | /workoutplan/listByUser       | `?user_id={id}`                                  | Tutti i piani di un utente |
| `GET`      | /workoutplan/get              | `?id={id}`                                       | Singolo piano              |
| `POST`     | /index.php/workoutplan/create | `{user_id, plan_name, creation_date, is_active}` | Crea piano                 |
| `PUT`      | /workoutplan/update           | `{id, plan_name, creation_date, is_active}`      | Aggiorna tutto             |
| `PATCH`    | /workoutplan/patch            | `{id, ...campi}`                                 | Aggiorna solo alcuni campi |
| `DELETE`   | /workoutplan/delete           | `{id}`                                           | Elimina piano              |

## DaylyWorkout

| **Metodo** | **Endpoint**             | **Parametri / Body JSON**       | **Descrizione**                     |
| ---------- | ------------------------ | ------------------------------- | ----------------------------------- |
| `GET`      | /dailyworkout/listByPlan | `?plan_id={id}`                 | Lista di tutti i giorni di un piano |
| `GET`      | /dailyworkout/get        | `?id={id}`                      | Dettagli di un singolo giorno       |
| `POST`     | /dailyworkout/create     | `{"plan_id", "day_name"}`       | Crea un nuovo giorno di allenamento |
| `PUT`      | /dailyworkout/update     | `{"id", "plan_id", "day_name"}` | Aggiorna tutti i campi di un giorno |
| `PATCH`    | /dailyworkout/patch      | `{"id", ...campi}`              | Aggiorna solo il nome o il piano    |
| `DELETE`   | /dailyworkout/delete     | `{"id"}`                        | Elimina un giorno                   |

## Sets

| **Metodo** | **Endpoint**   | **Parametri / Body JSON**                                                                     | **Descrizione**                                 |
| ---------- | -------------- | --------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| `GET`      | /set/listByDay | `?day_id={id}`                                                                                | Tutti i set di un giorno (+ dettagli esercizio) |
| `GET`      | /set/get       | `?id={id}`                                                                                    | Dettagli di un singolo set specifico            |
| `POST`     | /set/create    | `{"day_id", "exercise_id", "set_number", "reps_count", "rest_time", "weight", "notes"}`       | Aggiunge una serie a un esercizio               |
| `PUT`      | /set/update    | `{"id", "day_id", "exercise_id", "set_number", "reps_count", "rest_time", "weight", "notes"}` | Sostituisce integralmente i dati di un set      |
| `PATCH`    | /set/patch     | `{"id", ...campi}`                                                                            | Modifica solo peso, ripetizioni o note          |
| `DELETE`   | /set/delete    | `{"id"}`                                                                                      | Rimuove una serie specifica                     |


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


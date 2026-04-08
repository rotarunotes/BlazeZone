
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

Per rendere i tuoi endpoint coerenti con il codice PHP che hai scritto (che usa il sistema JWT per la sicurezza) e seguire le migliori pratiche delle API REST, dobbiamo apportare alcune correzioni fondamentali.

Il cambiamento principale riguarda la **rimozione di `user_id` dagli URL**: dato che usi i JWT, il server sa già chi sei. Passare l'ID nell'URL è ridondante e pericoloso per la sicurezza.

Ecco la tabella degli endpoint corretta e ottimizzata:

---

### 🔐 Modulo: Auth (Pubblico)

Questi endpoint non richiedono il token e servono per entrare nel sistema.

|**Metodo**|**URL**|**Body JSON**|**Descrizione**|
|---|---|---|---|
|**POST**|`/auth/register`|`{username, password, first_name, last_name}`|Registra un nuovo account.|
|**POST**|`/auth/login`|`{username, password}`|Effettua il login e restituisce il **Token JWT**.|

---

### 📋 Modulo: Workout Plan (Protetto)

_Nota: Il server filtrerà automaticamente i piani in base all'utente loggato tramite il token._

|**Metodo**|**URL**|**Body JSON**|**Descrizione**|
|---|---|---|---|
|**GET**|`/workoutplan/list`|-|Lista di tutti i piani dell'utente loggato.|
|**GET**|`/workoutplan/get/{id}`|-|Dettagli di un singolo piano (solo se tuo).|
|**POST**|`/workoutplan/create`|`{"plan_name", "is_active"}`|Crea un nuovo piano per l'utente loggato.|
|**PUT**|`/workoutplan/update/{id}`|`{"plan_name", "is_active"}`|Sovrascrive i dati del piano.|
|**PATCH**|`/workoutplan/patch/{id}`|`{"plan_name"}` o `{"is_active"}`|Modifica solo i campi inviati.|
|**DELETE**|`/workoutplan/delete/{id}`|-|Elimina il piano specificato.|

---

### 📅 Modulo: Daily Workout (Protetto)

|**Metodo**|**URL**|**Body JSON**|**Descrizione**|
|---|---|---|---|
|**GET**|`/dailyworkout/listByPlan/{plan_id}`|-|Tutti i giorni di un determinato piano.|
|**GET**|`/dailyworkout/get/{id}`|-|Dettagli di un singolo giorno.|
|**POST**|`/dailyworkout/create`|`{"plan_id", "day_name", "day_order"}`|Crea un giorno all'interno di un piano.|
|**PUT**|`/dailyworkout/update/{id}`|`{"plan_id", "day_name", "day_order"}`|Aggiorna completamente il giorno.|
|**PATCH**|`/dailyworkout/patch/{id}`|`{...campi da cambiare...}`|Aggiorna parzialmente il giorno.|
|**DELETE**|`/dailyworkout/delete/{id}`|-|Elimina il giorno di allenamento.|

---

### 🏋️ Modulo: Sets (Protetto)

|**Metodo**|**URL**|**Body JSON**|**Descrizione**|
|---|---|---|---|
|**GET**|`/set/listByDay/{day_id}`|-|Tutti i set e gli esercizi di un giorno.|
|**GET**|`/set/get/{id}`|-|Dettagli di un singolo set.|
|**POST**|`/set/create`|`{"day_id", "exercise_id", "reps_count", ...}`|Aggiunge un set a un esercizio.|
|**PUT**|`/set/update/{id}`|`{"day_id", "exercise_id", "reps_count", ...}`|Sostituisce i dati del set.|
|**PATCH**|`/set/patch/{id}`|`{"weight"}` o `{"reps_count"}` ecc.|Modifica solo i valori specificati.|
|**DELETE**|`/set/delete/{id}`|-|Rimuove il set.|

---

### 🛠 Cosa è cambiato rispetto alla tua versione?

1. **Restful URL Style:** Ho rimosso i parametri query string (es. `?id=1`) a favore dei parametri nel percorso (es. `/get/1`). È lo standard moderno per le API.
    
2. **Rimozione di `user_id` dal Body:** Nelle richieste `POST /workoutplan/create`, il `user_id` non deve essere inviato dal client. Il tuo controller lo prenderà dal token JWT con `JWT_PAYLOAD['user_id']`. Questo impedisce a un utente di creare piani per conto di qualcun altro.
    
3. **Consistenza dei nomi:** Ho uniformato i nomi (es. `listByPlan` invece di nomi misti) per rendere l'integrazione con il frontend più semplice.
    
4. **Sicurezza Utenti:** Ho rimosso l'endpoint `DELETE /user` (elimina tutti gli utenti). È un'operazione troppo pericolosa da lasciare esposta in un'API, anche se protetta.
    

Con questi endpoint, la tua API FitBlaze è coerente con la logica dei controller che hai sviluppato e segue gli standard di sicurezza.
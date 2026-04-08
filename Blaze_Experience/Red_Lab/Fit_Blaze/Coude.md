
[[#Secondo promt]]

Ottimo, ho letto il modello dell'articolo. Ecco la struttura completa del tuo progetto REST API adattata alle tue 5 entità.

---

## 📁 Struttura del Progetto

```
workout-rest-api/
│
├── index.php                          ← Punto di ingresso, routing
│
├── inc/
│   ├── config.php                     ← Credenziali DB e costanti
│   └── bootstrap.php                  ← Autoload di config, controller, model
│
├── Model/
│   ├── Database.php                   ← Connessione MySQL + metodi generici
│   ├── WorkoutPlanModel.php           ← Query sui Workout_Plan
│   ├── DailyWorkoutModel.php          ← Query sui Daily_Workout
│   └── SetModel.php                   ← Query sui Set (con Exercise)
│
└── Controller/
    └── Api/
        ├── BaseController.php         ← Metodi condivisi (output, URI, params)
        ├── WorkoutPlanController.php  ← Endpoint /workoutplan/...
        ├── DailyWorkoutController.php ← Endpoint /dailyworkout/...
        └── SetController.php          ← Endpoint /set/...
```

---

## 🔧 File per file

### `inc/config.php`

Contiene le costanti di connessione al database. Da modificare con le proprie credenziali.

```php
<?php
define("DB_HOST", "localhost");
define("DB_USERNAME", "root");
define("DB_PASSWORD", "");
define("DB_DATABASE_NAME", "workout_db");
```

---

### `inc/bootstrap.php`

Carica in sequenza config, i controller base e tutti i model. È il file "collante" incluso da `index.php`.

```php
<?php
define("PROJECT_ROOT_PATH", __DIR__ . "/../");

require_once PROJECT_ROOT_PATH . "/inc/config.php";
require_once PROJECT_ROOT_PATH . "/Controller/Api/BaseController.php";
require_once PROJECT_ROOT_PATH . "/Model/Database.php";
require_once PROJECT_ROOT_PATH . "/Model/WorkoutPlanModel.php";
require_once PROJECT_ROOT_PATH . "/Model/DailyWorkoutModel.php";
require_once PROJECT_ROOT_PATH . "/Model/SetModel.php";
```

---

### `Model/Database.php`

Layer di accesso al DB. Gestisce la connessione MySQL e offre il metodo `select()` generico con prepared statements. Non viene usata direttamente: i Model la estendono.

```php
<?php
class Database
{
    protected $connection = null;

    public function __construct()
    {
        try {
            $this->connection = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_DATABASE_NAME);
            if (mysqli_connect_errno()) {
                throw new Exception("Impossibile connettersi al database.");
            }
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }

    public function select($query = "", $params = [])
    {
        try {
            $stmt = $this->executeStatement($query, $params);
            $result = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $result;
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }

    private function executeStatement($query = "", $params = [])
    {
        try {
            $stmt = $this->connection->prepare($query);
            if ($stmt === false) {
                throw new Exception("Prepared statement fallito: " . $query);
            }
            if ($params) {
                $stmt->bind_param($params[0], $params[1]);
            }
            $stmt->execute();
            return $stmt;
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }
}
```

---

### `Model/WorkoutPlanModel.php`

Estende `Database`. Contiene la query per ottenere tutti i piani di allenamento di un determinato utente tramite `user_id`.

```php
<?php
require_once PROJECT_ROOT_PATH . "/Model/Database.php";

class WorkoutPlanModel extends Database
{
    // Ritorna tutti i Workout_Plan di un utente dato il suo user_id
    public function getPlansByUser(int $userId): array
    {
        return $this->select(
            "SELECT * FROM Workout_Plan WHERE user_id = ? ORDER BY creation_date DESC",
            ["i", $userId]
        );
    }
}
```

---

### `Model/DailyWorkoutModel.php`

Estende `Database`. Contiene la query per ottenere tutti i Daily_Workout appartenenti a un certo `plan_id`.

```php
<?php
require_once PROJECT_ROOT_PATH . "/Model/Database.php";

class DailyWorkoutModel extends Database
{
    // Ritorna tutti i Daily_Workout di un Workout_Plan dato il plan_id
    public function getDailyWorkoutsByPlan(int $planId): array
    {
        return $this->select(
            "SELECT * FROM Daily_Workout WHERE plan_id = ? ORDER BY id ASC",
            ["i", $planId]
        );
    }
}
```

---

### `Model/SetModel.php`

Estende `Database`. Fa una JOIN tra `Set` ed `Exercise` per restituire i set di un `Daily_Workout` con i dettagli dell'esercizio inclusi.

```php
<?php
require_once PROJECT_ROOT_PATH . "/Model/Database.php";

class SetModel extends Database
{
    // Ritorna tutti i Set di un Daily_Workout, con i dettagli dell'esercizio (JOIN)
    public function getSetsByDailyWorkout(int $dayId): array
    {
        return $this->select(
            "SELECT 
                s.id, s.set_number, s.reps_count, s.rest_time, s.weight, s.notes,
                e.exercise_name, e.muscle_group, e.video_url, e.type
             FROM `Set` s
             JOIN Exercise e ON s.exercise_id = e.id
             WHERE s.day_id = ?
             ORDER BY s.set_number ASC",
            ["i", $dayId]
        );
    }
}
```

---

### `Controller/Api/BaseController.php`

Classe base condivisa da tutti i controller. Fornisce: lettura dei segmenti URI, lettura dei query params e invio dell'output JSON con gli header HTTP corretti.

```php
<?php
class BaseController
{
    public function __call($name, $arguments)
    {
        $this->sendOutput('', ['HTTP/1.1 404 Not Found']);
    }

    protected function getUriSegments(): array
    {
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
        return explode('/', $uri);
    }

    protected function getQueryStringParams(): array
    {
        parse_str($_SERVER['QUERY_STRING'] ?? '', $query);
        return $query;
    }

    protected function sendOutput($data, array $httpHeaders = []): void
    {
        header_remove('Set-Cookie');
        foreach ($httpHeaders as $header) {
            header($header);
        }
        echo $data;
        exit;
    }
}
```

---

### `Controller/Api/WorkoutPlanController.php`

Gestisce l'endpoint `/workoutplan/listByUser?user_id=X`. Legge `user_id` dai query params, chiama il model e ritorna il JSON.

```php
<?php
class WorkoutPlanController extends BaseController
{
    /**
     * GET /index.php/workoutplan/listByUser?user_id=1
     * Ritorna tutti i Workout_Plan di un utente
     */
    public function listByUserAction(): void
    {
        $strErrorDesc = '';
        $strErrorHeader = '';

        if (strtoupper($_SERVER["REQUEST_METHOD"]) === 'GET') {
            try {
                $params = $this->getQueryStringParams();

                if (empty($params['user_id'])) {
                    throw new Exception("Parametro user_id mancante.");
                }

                $model = new WorkoutPlanModel();
                $data = $model->getPlansByUser((int)$params['user_id']);
                $responseData = json_encode($data);

            } catch (Exception $e) {
                $strErrorDesc = $e->getMessage();
                $strErrorHeader = 'HTTP/1.1 400 Bad Request';
            }
        } else {
            $strErrorDesc = 'Metodo non supportato';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        if (!$strErrorDesc) {
            $this->sendOutput($responseData, ['Content-Type: application/json', 'HTTP/1.1 200 OK']);
        } else {
            $this->sendOutput(
                json_encode(['error' => $strErrorDesc]),
                ['Content-Type: application/json', $strErrorHeader]
            );
        }
    }
}
```

---

### `Controller/Api/DailyWorkoutController.php`

Gestisce l'endpoint `/dailyworkout/listByPlan?plan_id=X`.

```php
<?php
class DailyWorkoutController extends BaseController
{
    /**
     * GET /index.php/dailyworkout/listByPlan?plan_id=3
     * Ritorna tutti i Daily_Workout di un Workout_Plan
     */
    public function listByPlanAction(): void
    {
        $strErrorDesc = '';
        $strErrorHeader = '';

        if (strtoupper($_SERVER["REQUEST_METHOD"]) === 'GET') {
            try {
                $params = $this->getQueryStringParams();

                if (empty($params['plan_id'])) {
                    throw new Exception("Parametro plan_id mancante.");
                }

                $model = new DailyWorkoutModel();
                $data = $model->getDailyWorkoutsByPlan((int)$params['plan_id']);
                $responseData = json_encode($data);

            } catch (Exception $e) {
                $strErrorDesc = $e->getMessage();
                $strErrorHeader = 'HTTP/1.1 400 Bad Request';
            }
        } else {
            $strErrorDesc = 'Metodo non supportato';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        if (!$strErrorDesc) {
            $this->sendOutput($responseData, ['Content-Type: application/json', 'HTTP/1.1 200 OK']);
        } else {
            $this->sendOutput(
                json_encode(['error' => $strErrorDesc]),
                ['Content-Type: application/json', $strErrorHeader]
            );
        }
    }
}
```

---

### `Controller/Api/SetController.php`

Gestisce l'endpoint `/set/listByDay?day_id=X`. Ritorna i set con i dati dell'esercizio grazie alla JOIN nel model.

```php
<?php
class SetController extends BaseController
{
    /**
     * GET /index.php/set/listByDay?day_id=5
     * Ritorna tutti i Set di un Daily_Workout (con dettagli esercizio)
     */
    public function listByDayAction(): void
    {
        $strErrorDesc = '';
        $strErrorHeader = '';

        if (strtoupper($_SERVER["REQUEST_METHOD"]) === 'GET') {
            try {
                $params = $this->getQueryStringParams();

                if (empty($params['day_id'])) {
                    throw new Exception("Parametro day_id mancante.");
                }

                $model = new SetModel();
                $data = $model->getSetsByDailyWorkout((int)$params['day_id']);
                $responseData = json_encode($data);

            } catch (Exception $e) {
                $strErrorDesc = $e->getMessage();
                $strErrorHeader = 'HTTP/1.1 400 Bad Request';
            }
        } else {
            $strErrorDesc = 'Metodo non supportato';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        if (!$strErrorDesc) {
            $this->sendOutput($responseData, ['Content-Type: application/json', 'HTTP/1.1 200 OK']);
        } else {
            $this->sendOutput(
                json_encode(['error' => $strErrorDesc]),
                ['Content-Type: application/json', $strErrorHeader]
            );
        }
    }
}
```

---

### `index.php`

Il routing centrale. Legge l'URI, capisce quale controller e quale action chiamare, include i file necessari e li invoca.

```php
<?php
require __DIR__ . "/inc/bootstrap.php";

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = explode('/', $uri);

// $uri[1] = nome del modulo (workoutplan, dailyworkout, set)
// $uri[2] = nome dell'azione (listByUser, listByPlan, listByDay)

$module = $uri[1] ?? '';
$action = $uri[2] ?? '';

$controllerMap = [
    'workoutplan'   => 'WorkoutPlanController',
    'dailyworkout'  => 'DailyWorkoutController',
    'set'           => 'SetController',
];

if (!isset($controllerMap[$module]) || empty($action)) {
    header("HTTP/1.1 404 Not Found");
    exit();
}

$controllerName = $controllerMap[$module];
require PROJECT_ROOT_PATH . "/Controller/Api/{$controllerName}.php";

$controller = new $controllerName();
$methodName = $action . 'Action';
$controller->{$methodName}();
```

---

## 🌐 Riepilogo degli endpoint

| Endpoint                                           | Parametro | Descrizione                                   |
| -------------------------------------------------- | --------- | --------------------------------------------- |
| `GET /index.php/workoutplan/listByUser?user_id=1`  | `user_id` | Tutti i piani di un utente                    |
| `GET /index.php/dailyworkout/listByPlan?plan_id=3` | `plan_id` | Tutti i giorni di un piano                    |
| `GET /index.php/set/listByDay?day_id=5`            | `day_id`  | Tutti i set di un giorno (con dati esercizio) |

Il pattern è sempre lo stesso: **module → controller → action**, rendendo facile aggiungere nuovi endpoint in futuro semplicemente creando nuovi model e controller.



# Secondo promt
Perfetto, ho letto entrambi gli articoli. Ora ti mostro come estendere il progetto con tutti i metodi HTTP. Ti mostro il pattern completo su **WorkoutPlan** come esempio, poi lo stesso schema si replica identico per gli altri.

---

## Cosa cambia e dove

Bisogna modificare/estendere **3 livelli** per ogni entità: `Database.php`, il `Model`, e il `Controller`.

---

## `Model/Database.php` — aggiungere insert, update, delete

Oltre al `select()` già esistente, aggiungiamo i metodi generici per le altre operazioni. Questo è l'**unico file** che gestisce il database, tutti i Model lo ereditano.

```php
<?php
class Database
{
    protected $connection = null;

    public function __construct()
    {
        try {
            $this->connection = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_DATABASE_NAME);
            if (mysqli_connect_errno()) {
                throw new Exception("Impossibile connettersi al database.");
            }
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }

    // SELECT → ritorna array di righe
    public function select($query = "", $params = [])
    {
        try {
            $stmt = $this->executeStatement($query, $params);
            $result = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $result;
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }

    // INSERT → ritorna l'id dell'elemento appena creato
    public function insert($query = "", $params = [])
    {
        try {
            $stmt = $this->executeStatement($query, $params);
            $insertId = $this->connection->insert_id;
            $stmt->close();
            return $insertId;
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }

    // UPDATE e DELETE → ritorna il numero di righe modificate/cancellate
    public function execute($query = "", $params = [])
    {
        try {
            $stmt = $this->executeStatement($query, $params);
            $affectedRows = $stmt->affected_rows;
            $stmt->close();
            return $affectedRows;
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }

    private function executeStatement($query = "", $params = [])
    {
        try {
            $stmt = $this->connection->prepare($query);
            if ($stmt === false) {
                throw new Exception("Prepared statement fallito: " . $query);
            }
            if ($params) {
                $stmt->bind_param($params[0], ...$params[1]);
            }
            $stmt->execute();
            return $stmt;
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
    }
}
```

> **Nota:** `bind_param` ora usa `...$params[1]` (spread operator) perché con più parametri passeremo un array di valori, ad esempio `["si", [$nome, $id]]`.

---

## `Model/WorkoutPlanModel.php` — tutti i metodi CRUD

```php
<?php
require_once PROJECT_ROOT_PATH . "/Model/Database.php";

class WorkoutPlanModel extends Database
{
    // GET — tutti i piani di un utente
    public function getPlansByUser(int $userId): array
    {
        return $this->select(
            "SELECT * FROM Workout_Plan WHERE user_id = ? ORDER BY creation_date DESC",
            ["i", [$userId]]
        );
    }

    // GET — singolo piano per id
    public function getPlanById(int $id): array
    {
        return $this->select(
            "SELECT * FROM Workout_Plan WHERE id = ?",
            ["i", [$id]]
        );
    } 

    // POST — crea un nuovo piano
    public function createPlan(int $userId, string $planName, string $creationDate, int $isActive): int S
    {
        return $this->insert(
            "INSERT INTO Workout_Plan (user_id, plan_name, creation_date, is_active) VALUES (?, ?, ?, ?)",
            ["isis", [$userId, $planName, $creationDate, $isActive]]
        );
    }

    // PUT — aggiorna tutti i campi di un piano
    public function updatePlan(int $id, string $planName, string $creationDate, int $isActive): int
    {
        return $this->execute(
            "UPDATE Workout_Plan SET plan_name = ?, creation_date = ?, is_active = ? WHERE id = ?",
            ["ssii", [$planName, $creationDate, $isActive, $id]]
        );
    }

    // PATCH — aggiorna solo i campi forniti
    public function patchPlan(int $id, array $fields): int
    {
        $allowed = ['plan_name', 'creation_date', 'is_active'];
        $setClauses = [];
        $types = "";
        $values = [];

        foreach ($fields as $key => $value) {
            if (in_array($key, $allowed)) {
                $setClauses[] = "$key = ?";
                $types .= is_int($value) ? "i" : "s";
                $values[] = $value;
            }
        }

        if (empty($setClauses)) {
            throw new Exception("Nessun campo valido da aggiornare.");
        }

        $types .= "i"; // per il WHERE id = ?
        $values[] = $id;

        $query = "UPDATE Workout_Plan SET " . implode(", ", $setClauses) . " WHERE id = ?";
        return $this->execute($query, [$types, $values]);
    }

    // DELETE — elimina un piano
    public function deletePlan(int $id): int
    {
        return $this->execute(
            "DELETE FROM Workout_Plan WHERE id = ?",
            ["i", [$id]]
        );
    }
}
```

---

## `Controller/Api/WorkoutPlanController.php` — tutti i metodi HTTP

```php
<?php
class WorkoutPlanController extends BaseController
{
    /**
     * GET /index.php/workoutplan/listByUser?user_id=1
     */
    public function listByUserAction(): void
    {
        $this->handleRequest('GET', function () {
            $params = $this->getQueryStringParams();
            if (empty($params['user_id'])) throw new Exception("Parametro user_id mancante.");

            $model = new WorkoutPlanModel();
            return $model->getPlansByUser((int)$params['user_id']);
        });
    }

    /**
     * GET /index.php/workoutplan/get?id=1
     */
    public function getAction(): void
    {
        $this->handleRequest('GET', function () {
            $params = $this->getQueryStringParams();
            if (empty($params['id'])) throw new Exception("Parametro id mancante.");

            $model = new WorkoutPlanModel();
            $data = $model->getPlanById((int)$params['id']);
            if (empty($data)) throw new Exception("Piano non trovato.");
            return $data[0];
        });
    }

    /**
     * POST /index.php/workoutplan/create
     * Body JSON: { "user_id": 1, "plan_name": "Massa", "creation_date": "2024-01-01", "is_active": 1 }
     */
    public function createAction(): void
    {
        $this->handleRequest('POST', function () {
            $data = json_decode(file_get_contents("php://input"), true);

            if (empty($data['user_id']) || empty($data['plan_name']) || empty($data['creation_date'])) {
                throw new Exception("Campi obbligatori mancanti: user_id, plan_name, creation_date.");
            }

            $model = new WorkoutPlanModel();
            $newId = $model->createPlan(
                (int)$data['user_id'],
                $data['plan_name'],
                $data['creation_date'],
                isset($data['is_active']) ? (int)$data['is_active'] : 1
            );

            return ["id" => $newId, "message" => "Piano creato con successo."];
        }, 201);
    }

    /**
     * PUT /index.php/workoutplan/update
     * Body JSON: { "id": 1, "plan_name": "Forza", "creation_date": "2024-01-01", "is_active": 0 }
     */
    public function updateAction(): void
    {
        $this->handleRequest('PUT', function () {
            $data = json_decode(file_get_contents("php://input"), true);

            if (empty($data['id']) || empty($data['plan_name']) || empty($data['creation_date'])) {
                throw new Exception("Campi obbligatori mancanti: id, plan_name, creation_date.");
            }

            $model = new WorkoutPlanModel();
            $rows = $model->updatePlan(
                (int)$data['id'],
                $data['plan_name'],
                $data['creation_date'],
                isset($data['is_active']) ? (int)$data['is_active'] : 1
            );

            if ($rows === 0) throw new Exception("Piano non trovato.");
            return ["message" => "Piano aggiornato con successo."];
        });
    }

    /**
     * PATCH /index.php/workoutplan/patch
     * Body JSON: { "id": 1, "is_active": 0 }   ← solo i campi da modificare
     */
    public function patchAction(): void
    {
        $this->handleRequest('PATCH', function () {
            $data = json_decode(file_get_contents("php://input"), true);

            if (empty($data['id'])) throw new Exception("Parametro id mancante.");
            $id = (int)$data['id'];
            unset($data['id']);

            $model = new WorkoutPlanModel();
            $rows = $model->patchPlan($id, $data);

            if ($rows === 0) throw new Exception("Piano non trovato o nessuna modifica.");
            return ["message" => "Piano aggiornato parzialmente con successo."];
        });
    }

    /**
     * DELETE /index.php/workoutplan/delete
     * Body JSON: { "id": 1 }
     */
    public function deleteAction(): void
    {
        $this->handleRequest('DELETE', function () {
            $data = json_decode(file_get_contents("php://input"), true);
            if (empty($data['id'])) throw new Exception("Parametro id mancante.");

            $model = new WorkoutPlanModel();
            $rows = $model->deletePlan((int)$data['id']);

            if ($rows === 0) throw new Exception("Piano non trovato.");
            return ["message" => "Piano eliminato con successo."];
        });
    }
}
```

---

## `Controller/Api/BaseController.php` — aggiungere `handleRequest()`

Per evitare di ripetere la gestione degli errori in ogni action, aggiungiamo un metodo `handleRequest()` nel BaseController che tutti i controller ereditano.

```php
<?php
class BaseController
{
    public function __call($name, $arguments)
    {
        $this->sendOutput('', ['HTTP/1.1 404 Not Found']);
    }

    protected function getUriSegments(): array
    {
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
        return explode('/', $uri);
    }

    protected function getQueryStringParams(): array
    {
        parse_str($_SERVER['QUERY_STRING'] ?? '', $query);
        return $query;
    }

    protected function sendOutput($data, array $httpHeaders = []): void
    {
        header_remove('Set-Cookie');
        foreach ($httpHeaders as $header) {
            header($header);
        }
        echo $data;
        exit;
    }

    /**
     * Metodo helper: gestisce il metodo HTTP atteso, esegue la logica
     * e si occupa di tutta la gestione degli errori in modo centralizzato.
     *
     * @param string   $expectedMethod  Il metodo HTTP atteso (GET, POST, PUT, PATCH, DELETE)
     * @param callable $logic           La funzione con la logica dell'endpoint, deve ritornare i dati
     * @param int      $successCode     Il codice HTTP di successo (default 200, usa 201 per creazione)
     */
    protected function handleRequest(string $expectedMethod, callable $logic, int $successCode = 200): void
    {
        $requestMethod = strtoupper($_SERVER["REQUEST_METHOD"]);

        if ($requestMethod !== $expectedMethod) {
            $this->sendOutput(
                json_encode(['error' => 'Metodo non supportato']),
                ['Content-Type: application/json', 'HTTP/1.1 422 Unprocessable Entity']
            );
        }

        try {
            $result = $logic();
            $this->sendOutput(
                json_encode($result),
                ['Content-Type: application/json', "HTTP/1.1 $successCode OK"]
            );
        } catch (Exception $e) {
            $this->sendOutput(
                json_encode(['error' => $e->getMessage()]),
                ['Content-Type: application/json', 'HTTP/1.1 400 Bad Request']
            );
        }
    }
}
```

---

## Riepilogo completo degli endpoint di WorkoutPlan

| Metodo   | Endpoint                                      | Body JSON                                        | Descrizione                |
| -------- | --------------------------------------------- | ------------------------------------------------ | -------------------------- |
| `GET`    | `/index.php/workoutplan/listByUser?user_id=1` | —                                                | Tutti i piani di un utente |
| `GET`    | `/index.php/workoutplan/get?id=1`             | —                                                | Singolo piano              |
| `POST`   | `/index.php/workoutplan/create`               | `{user_id, plan_name, creation_date, is_active}` | Crea piano                 |
| `PUT`    | `/index.php/workoutplan/update`               | `{id, plan_name, creation_date, is_active}`      | Aggiorna tutto             |
| `PATCH`  | `/index.php/workoutplan/patch`                | `{id, ...campi}`                                 | Aggiorna solo alcuni campi |
| `DELETE` | `/index.php/workoutplan/delete`               | `{id}`                                           | Elimina piano              |

---

## Differenza PUT vs PATCH

Questa è la distinzione fondamentale:

- **PUT** → mandi **tutti** i campi, sostituisce l'intera risorsa. Se dimentichi un campo, viene sovrascritto.
- **PATCH** → mandi **solo i campi che vuoi modificare**. Gli altri restano invariati.

```json
// PUT — devi mandare tutto
{ "id": 1, "plan_name": "Nuovo nome", "creation_date": "2024-01-01", "is_active": 1 }

// PATCH — mandi solo ciò che cambia
{ "id": 1, "is_active": 0 }
```

---

Lo stesso schema (Model + Controller) si replica identico per `DailyWorkout` e `Set`, cambiando solo i campi delle tabelle e le query SQL.
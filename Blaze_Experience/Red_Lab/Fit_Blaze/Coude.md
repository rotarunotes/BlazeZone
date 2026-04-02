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
# 🔥 FITBLAZE: Documentazione Tecnica Estesa

**Progettazione**

![[Pasted image 20260412201243.png]]

**Applicazione Flutter per la gestione di schede di allenamento**

1. Architettura, Pattern e Sicurezza

1.1 Pattern Architetturale: MVVM + Provider

FitBlaze adotta il pattern **MVVM (Model–View–ViewModel)** implementato tramite il package `Provider`. La separazione delle responsabilità è così definita:

- **Model**: Classi dati (`WorkoutPlanModel`, `DailyWorkoutModel`, `SetModel`) che rappresentano il dominio e gestiscono la serializzazione/deserializzazione JSON.
    
- **View**: Widget Flutter che si occupano esclusivamente della presentazione, delegando la logica ai Provider.
    
- **ViewModel (Provider)**: Classi (`AuthProvider`, `WorkoutPlanProvider`, ecc.) che estendono `ChangeNotifier`. Gestiscono lo stato, effettuano chiamate ai servizi e notificano la UI tramite `notifyListeners()`.
    

1.2 Layer dei Servizi

L'applicazione utilizza due motori distinti per l'accesso ai dati:

1. **ServerDbHelper**: Gestisce la comunicazione HTTP con il backend REST PHP tramite JWT Bearer Token. Implementa operazioni CRUD complete.
    
2. **DatabaseHelper (LocalDbHelper)**: Gestisce il database SQLite locale tramite `sqflite` per la modalità offline. Sincronizza i dati al login e li cancella al logout.
    

1.3 Flusso Dati

Il flusso segue un percorso unidirezionale: 1) **UI → Provider**: L'utente interagisce con un Widget che chiama un metodo sul Provider. 2) **Provider → Service**: Il Provider invoca il servizio corrispondente (Server o Locale). 3) **Service → Backend/DB**: Il servizio esegue la richiesta e ritorna i dati deserializzati. 4) **Provider → UI**: Il Provider aggiorna lo stato e chiama `notifyListeners()`, scatenando il re-rendering dei Widget.

1.4 Sicurezza e Integrità

- **Autenticazione**: Gestita tramite **JWT**. Il token è salvato in `SharedPreferences` e inviato nell'header di ogni richiesta protetta.
    
- **Gestione Sessione**: In caso di errore 401 (sessione scaduta), viene lanciata un'eccezione specifica.
    
- **Privacy Locale**: Al logout, il token e l'intero database SQLite vengono svuotati.
    
- **Integrità Referenziale**: Database locale con foreign key e `CASCADE` attivi.
    
- **Deserializzazione Difensiva**: Il `SetModel` gestisce la conversione sicura di tipi numerici che il backend PHP potrebbe restituire come stringhe.
    

---

2. Albero del Progetto e Struttura Cartelle

|**Percorso**|**Responsabilità**|
|---|---|
|`lib/main.dart`|Entry point. Inizializza SQLite, tema dark/red e Provider.|
|`lib/models/`|Contiene i modelli dati (`WorkoutPlan`, `DailyWorkout`, `Set`) e relativi mapping JSON.|
|`lib/providers/`|Gestione dello stato e logica di business (Auth, Plans, Days, Sets).|
|`lib/services/`|Helper per database remoto (PHP/REST) e locale (SQLite).|
|`lib/screens/`|Tutte le schermate dell'app (Auth, Home, Days, Sets, Offline).|
|`lib/ex.dart`|Dataset statico di 300 esercizi per il selettore in SetsScreen.|

---

3. Stack Tecnologico

- **Framework**: Flutter SDK (UI cross-platform).
    
- **State Management**: Provider ^6.x (ufficialmente raccomandato).
    
- **Networking**: http ^1.x (richieste REST).
    
- **Database**: sqflite ^2.x (mobile) e sqflite_common_ffi (supporto desktop).
    
- **Persistence**: shared_preferences ^2.x (per il token JWT).
    

---

4. Documentazione API (Endpoint)

**Base URL**: `http://localhost/PHP/Server` (Configurabile). Tutti gli endpoint richiedono `Authorization: Bearer <JWT_TOKEN>` tranne quelli di autenticazione.

4.1 Autenticazione

- **POST** `/auth/register`: Registrazione nuovo utente.
    
- **POST** `/auth/login`: Login e ricezione token JWT.
    

4.2 Risorse Protette

Vengono implementati i metodi standard per tutte le risorse (**Workout Plans**, **Daily Workouts**, **Sets**):

- **GET**: Lista (es. `listByUser`, `listByPlan`, `listByDay`) o singolo elemento per ID.
    
- **POST**: Creazione risorsa.
    
- **PUT / PATCH**: Aggiornamento completo o parziale.
    
- **DELETE**: Rimozione risorsa.
    

---

5. Catalogo dei Widget

5.1 Schermate (Screen)

1. **AuthScreen**: Form di login/registrazione animato.
    
2. **HomeScreen**: Lista piani con `ReorderableListView` e accesso alla modalità offline.
    
3. **DaysScreen**: Gestione dei giorni di allenamento per un piano specifico.
    
4. **SetsScreen**: Gestione delle serie con selettore esercizi via `Autocomplete`.
    
5. **OfflineDashboardScreen**: Vista read-only della gerarchia dati salvata in SQLite.
    

5.2 Componenti UI Privati

- **_PlanCard / _DayCard / _SetCard**: Card stilizzate con badge, azioni e supporto al trascinamento.
    
- **_ExercisePicker**: Componente di ricerca esercizi dal dataset statico.
    
- **_RootNavigator**: Gestisce il routing radice in base allo stato di autenticazione.
    

---

6. Funzioni Core

6.1 AuthProvider

- `checkAuthStatus()`: Verifica la presenza del token all'avvio.
    
- `login()` / `register()`: Gestiscono l'autenticazione e avviano la sincronizzazione del DB locale in background.
    
- `logout()`: Pulisce token e dati locali.
    

6.2 Pattern CRUD (Provider)

Tutti i provider seguono una logica uniforme per `fetch`, `create`, `update` e `delete`.

- **Nota per SetProvider**: Effettua un refetch automatico dopo creazione/modifica per ottenere i dati denormalizzati degli esercizi.
    
- **Reorder**: Calcola i nuovi ordinamenti e invia richieste PATCH "fire-and-forget" al server.
    

6.3 DatabaseHelper (SQLite)

- `init()`: Configura il database e abilita le foreign key.
    
- `saveLogin()`: Scarica l'intera gerarchia dati dalle API e popola il DB locale.
    
- `getAllWorkoutsHierarchy()`: Ricostruisce la struttura annidata Piano → Giorno → Set per la visualizzazione offline.
    

---

7. Setup e Installazione

7.1 Prerequisiti

- Flutter & Dart SDK >= 3.0.
    
- Server PHP locale (XAMPP, Laragon, etc.) con MySQL.
    

7.2 Configurazione

Configurare il `baseUrl` in `lib/services/server_db_helper.dart`:

- **Emulatore Android**: `http://10.0.2.2/PHP/Server`.
    
- **Desktop/iOS**: `http://localhost/PHP/Server`.
    

7.3 Installazione

1) `flutter pub get`. 2) Assicurarsi che il backend PHP sia attivo. 3) `flutter run`.

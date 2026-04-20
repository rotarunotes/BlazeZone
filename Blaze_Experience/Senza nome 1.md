# MMA Manager

**Applicazione Flutter per la gestione di lottatori e scontri MMA**

MMA Manager è una soluzione mobile completa progettata per gestire profili di atleti e risultati di combattimenti. L'app integra una logica di sincronizzazione tra un server **REST remoto** e un database **SQLite locale**, garantendo la continuità operativa tramite una modalità offline intelligente.

## 📋 Informazioni Progetto

- **Sviluppatore:** Leone Formenton (5ID)
    
- **Materia:** TPSIT
    
- **Tecnologie:** Flutter & Dart
    
- **Gestione Stato:** Provider (ChangeNotifier)
    

---

## 🚀 Funzionalità Principali

- **Gestione Atleti:** Operazioni CRUD (Create, Read, Update, Delete) sui profili dei lottatori.
    
- **Registro Scontri:** Tracking dei round, durata ed esito (vittoria/pareggio) dei match.
    
- **Offline First:** Se il server non risponde entro **5 secondi**, l'app carica automaticamente i dati salvati localmente.
    
- **Sistema Preferiti:** Selezione manuale dei record (tramite icona ⭐) da sincronizzare nel database SQLite per la consultazione offline.
    
- **Validazione Form:** Controllo integrato della coerenza dei dati in fase di inserimento.
    

---

## 🌐 Specifiche API (Endpoints)

L'app si interfaccia con un server REST (default: `http://localhost:3000`) tramite il servizio `ApiService`.

### Lottatori

|**Metodo**|**Endpoint**|**Descrizione**|
|---|---|---|
|`GET`|`/lottatori`|Recupera la lista completa degli atleti.|
|`POST`|`/lottatori`|Crea un nuovo profilo lottatore.|
|`PUT`|`/lottatori/:id`|Aggiorna i dati di un lottatore esistente.|
|`DELETE`|`/lottatori/:id`|Rimuove un lottatore dal server.|

### Scontri

|**Metodo**|**Endpoint**|**Descrizione**|
|---|---|---|
|`GET`|`/scontri`|Recupera la cronologia di tutti gli scontri.|
|`POST`|`/scontri`|Registra un nuovo scontro.|
|`PUT`|`/scontri/:id`|Modifica i dettagli di un match registrato.|
|`DELETE`|`/scontri/:id`|Elimina un record dalla cronologia scontri.|

---

## 🛠 Architettura Tecnica

L'applicazione segue una separazione delle responsabilità rigorosa suddivisa in 4 livelli:

1. **Models:** Definizione delle entità `Lottatore` e `Scontro` con logica di serializzazione JSON.
    
2. **Services & Repository:** `ApiService` per il networking HTTP e `DatabaseHelper` (Singleton) per la persistenza SQLite locale.
    
3. **Providers:** Orchestrazione della logica di business e notifica dei cambiamenti alla UI tramite `notifyListeners()`.
    
4. **Screens:** Widget Flutter ottimizzati per la visualizzazione (es. `ListView.builder` per performance elevate).
    

---

## 📦 Dipendenze

Le librerie principali utilizzate nel progetto (definite in `pubspec.yaml`) includono:

- `provider`: Gestione dello stato reattivo.
    
- `http`: Comunicazione con le API REST.
    
- `sqflite` & `path`: Gestione del database relazionale locale.
    
- `sqflite_common_ffi`: Supporto SQLite per ambienti desktop.
    

---

## 🛠 Installazione e Setup

1. Assicurarsi di avere il server REST attivo sulla porta `3000`.
    
2. Eseguire `flutter pub get` per installare le dipendenze.
    
3. Avviare l'app con `flutter run`.
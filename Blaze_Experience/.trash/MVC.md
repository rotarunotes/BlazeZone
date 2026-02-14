## MVC (Model-View-Controller)

### Introduzione al Pattern MVC

Il **pattern architetturale MVC** è un approccio di design che separa un'applicazione in tre componenti interconnesse ma distinte. Questa separazione permette di organizzare il codice in modo modulare, facilitando la manutenzione, il testing e la scalabilità del software. MVC è particolarmente utile nello sviluppo di applicazioni web e desktop, dove l'interfaccia utente deve essere disaccoppiata dalla logica di business e dalla gestione dei dati.

### I Tre Componenti

**MODEL (Modello)**

- Rappresenta la **logica di business** e i **dati** dell'applicazione
- Gestisce l'accesso al database e le operazioni CRUD (Create, Read, Update, Delete)
- Contiene le regole di validazione e la logica di elaborazione
- È indipendente dall'interfaccia utente
- **Esempio**: classi che rappresentano entità come `Utente`, `Prodotto`, `Ordine` con metodi per salvarli/recuperarli dal database

**VIEW (Vista)**

- Rappresenta l'**interfaccia utente** (UI)
- Mostra i dati all'utente in modo visuale
- Riceve input dall'utente (click, form, ecc.)
- **Non contiene logica di business**, solo logica di presentazione
- **Esempio**: pagine HTML, form, dashboard, widget grafici

**CONTROLLER (Controllore)**

- Funge da **intermediario** tra Model e View
- Riceve input dall'utente tramite la View
- Elabora le richieste e decide quale logica del Model invocare
- Aggiorna la View con i risultati
- Coordina il flusso dell'applicazione
- **Esempio**: gestisce il login utente, processa form, coordina operazioni complesse

### Flusso di funzionamento

```
1. L'utente interagisce con la VIEW (es. clicca "Salva")
2. La VIEW invia la richiesta al CONTROLLER
3. Il CONTROLLER elabora la richiesta e chiama il MODEL
4. Il MODEL esegue operazioni sul DATABASE
5. Il MODEL restituisce i risultati al CONTROLLER
6. Il CONTROLLER aggiorna la VIEW con i nuovi dati
7. La VIEW mostra i risultati all'utente
```

### Vantaggi del pattern MVC

- **Separazione delle responsabilità**: ogni componente ha un ruolo specifico
- **Manutenibilità**: modifiche a una componente non impattano le altre
- **Riutilizzabilità**: il Model può essere usato con diverse View
- **Testing facilitato**: ogni componente può essere testata separatamente
- **Lavoro parallelo**: team diversi possono lavorare su componenti diverse contemporaneamente
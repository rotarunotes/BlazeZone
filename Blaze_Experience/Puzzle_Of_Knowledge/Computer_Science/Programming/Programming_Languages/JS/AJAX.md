Data: 2026-02-12
[JS](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/JS
___
# Index

- [[#AJAX e Asincronia]]
- [[#Fetch]]
    - [[#Cosa succede tecnicamente nel codice?]]
	    - [[#I punti chiave per non confondersi]]
	    - [[#Esempio pratico (Menu a schede)]]
    - [[#Gestione della Risposta (Response)]]
- [[#SPA (Single Page Application)]]
    - [[#Caricamento Dinamico del Contenuto]]
- [[#Gestione degli Errori]]

---
# AJAX e Asincronia

**AJAX** (Asynchronous JavaScript and XML) permette di scambiare dati con un server e aggiornare parti di una pagina web senza ricaricarla completamente.
1. **Asincrono**: La chiamata al server è **non bloccante**. Lo script invia la richiesta e prosegue immediatamente con le istruzioni successive.
2. **Esperienza Utente**: La pagina rimane interattiva mentre i dati vengono scaricati in "background".
3. **Formati**: Anche se nato per XML, oggi si usa quasi esclusivamente **JSON** o testo semplice (HTML/TXT).

---
# Fetch

Immagina che la tua pagina HTML sia come una **scrivania**.
- **Senza AJAX (Navigazione classica):** Se vuoi leggere un nuovo documento, devi alzarti, buttare via tutto quello che c'è sulla scrivania e metterne una nuova da zero. La pagina "lampeggia" e si ricarica.
- **Con AJAX / Fetch:** Tu rimani seduto alla tua scrivania. Chiedi a un assistente (la `fetch`) di andarti a prendere un foglio in un'altra stanza. Quando l'assistente torna, tu prendi quel foglio e lo appoggi sulla scrivania che hai già davanti.
## Cosa succede tecnicamente nel codice?
Quando scrivi `fetch("pagina1.txt")`, JavaScript va a leggere il **contenuto testuale** di quel file, ma lo tiene "in memoria" sotto forma di stringa. Non dice al browser di andare a quell'indirizzo.

``` JavaScript
fetch("pagina1.txt") 
	// Risposta Es. status 200
    .then(res => res.text()) 
    //È il nome che diamo alla variabile che contiene effettivamente le parole 
    //scritte dentro `pagina1.txt`
    .then(testoDelloScript => {
        // Ora decidi TU dove metterlo nella pagina attuale
        document.getElementById("contenuto").innerHTML = testoDelloScript;
    });
```
### I punti chiave per non confondersi:
1. **L'URL nel browser**: Se guardi la barra degli indirizzi in alto, vedrai che **non cambia mai**. Resti sempre su `index.html`.
2. **Stato della pagina**: Se avevi scritto qualcosa in un `input` o avevi una musica in sottofondo, queste cose **non si interrompono**, perché la pagina non è stata ricaricata.
3. **Il file caricato**: Il file che vai a chiamare (`pagina1.txt`, `dati.json`, ecc.) non deve essere per forza una pagina intera, ma spesso è solo un "pezzetto" di codice o di testo che ti serve in quel momento.
### Esempio pratico (Il "Menu a schede")
Se hai tre pulsanti "Home", "Prodotti", "Contatti":
- Invece di avere 3 file HTML diversi, hai un unico `index.html` con un `div` vuoto al centro.
- Al click su ogni pulsante, fai una `fetch` del file corrispondente e "inietti" il testo dentro il `div`.

``` javaScript
function carica(nomeFile) {
    // 1) Richiedo il file al server
    fetch(nomeFile)
        // 2) Quando risponde, estraggo il testo dal "pacco"
        .then(res => res.text())
        // 3) Quando il testo è pronto, lo inietto nel div
        .then(dati => {
            document.getElementById("contenuto").innerHTML = dati;
        })
        // 4) (Opzionale) Gestisco se il file non esiste
        .catch(err => {
            document.getElementById("contenuto").innerHTML = "pagina non trovata.";
        });
}
```
## Gestione della Risposta (Response)
L'oggetto che arriva nel primo `.then` contiene metadati sulla risposta:
- `.status`: Codice numerico (es. 200 = OK, 404 = Non trovato).
- `.text()`: Metodo per leggere la risposta come stringa.
- `.json()`: Metodo per leggere la risposta come oggetto JavaScript (se i dati sono in formato JSON).

``` JavaScript
function funz1(risposta) {
    if (risposta.status === 200) {
        return risposta.text(); // Restituisce una nuova Promise
    }
}
```

---
# SPA (Single Page Application)

Le **SPA** sono siti web che caricano un'unica pagina HTML e aggiornano il contenuto dinamicamente tramite AJAX.
## Caricamento Dinamico del Contenuto
Invece di navigare tra file `.html` diversi, si caricano frammenti di testo o HTML dentro un contenitore (es. un `div`).

``` JavaScript
let contenuto = document.getElementById("contenuto");

function caricaPagina(nomeFile) {
    fetch(nomeFile)
        .then(res => res.text())
        .then(html => {
            // Sostituisco il contenuto del div con i nuovi dati
            contenuto.innerHTML = html; 
        });
}

// Evento: cliccando su un link, cambio solo il div centrale
document.getElementById("btn-home").addEventListener("click", () => caricaPagina("home.txt"));
```

---
# Gestione degli Errori

Cosa succede se il file non esiste o il server è offline? È fondamentale gestire i fallimenti con `.catch()`.

``` JavaScript
fetch("file_inesistente.txt")
    .then(res => {
        if (!res.ok) throw new Error("File non trovato!");
        return res.text();
    })
    .then(dati => console.log(dati))
    .catch(errore => {
        console.error("Si è verificato un problema:", errore.message);
        document.getElementById("errore-box").innerHTML = "Errore nel caricamento dati.";
    });
```

---
 
Data: 2026-03-05
[PHP](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/PHP
___
# Index

- [[#Cookie (Client-side)]]
	- [[#Gestione dei Cookie]]
- [[#Sessioni (Server-side)]]
	- [[#Ciclo di vita della Sessione]]
- [[#Confronto Rapido]]

---
# Cookie (Client-side)

I cookie sono piccoli file di testo salvati sul **browser dell'utente**. Vengono inviati dal server al client tramite gli header HTTP.

## Gestione dei Cookie
- **Creazione**: Si usa `setcookie(chiave, valore, scadenza)`.
- **Lettura**: Si usa l'array superglobale `$_COOKIE`.
- **Scadenza**:
    - `0`: Il cookie scade quando si chiude il browser (Cookie di sessione).    
    - `time() + secondi`: Il cookie scade dopo un tempo prefissato (es. 30 giorni).   
- **Cancellazione**: Si imposta una scadenza nel passato (es. `time() - 1`).


``` PHP
// Impostazione di un cookie
setcookie("utente1", "aaaa");
setcookie("eta", "25", time() + (60*60*24*30)); // Scade tra 30 giorni

// Modifica
setcookie("nome", "Laura"); // Sovrascrive il valore precedente

// Lettura
echo $_COOKIE["utente1"];
```

**Nota importante:** Le funzioni `setcookie()` devono essere chiamate **prima** di qualsiasi output (`echo` o HTML), poiché vengono inviate nell'intestazione (header) della risposta HTTP.

---
# Sessioni (Server-side)

Le sessioni memorizzano i dati sul **server**, rendendole più sicure rispetto ai cookie. 
Ogni client è identificato da un ID sessione univoco (spesso scambiato tramite un cookie tecnico chiamato `PHPSESSID`).

## Ciclo di vita della Sessione
1. **Avvio**: `session_start()` deve essere richiamato all'inizio di ogni script che necessita di accedere alla sessione.
2. **Scrittura**: Si salvano i dati nell'array superglobale `$_SESSION`.
3. **Rimozione singola**: Si usa `unset()`.
4. **Chiusura totale**: `session_unset()` svuota le variabili, `session_destroy()` elimina la sessione dal server.

``` PHP
	session_start(); // Inizializza o riprende la sessione

// Salvataggio dati
$_SESSION["utente"] = "aaaa";
$_SESSION["ruolo"] = "admin";

// Rimozione di un singolo dato
unset($_SESSION["ruolo"]);

// Pulizia completa
session_unset();   // Rimuove i valori dall'array
session_destroy(); // Distrugge la sessione sul server
```

---
# Confronto Rapido

|**Caratteristica**|**Cookie**|**Sessione**|
|---|---|---|
|**Posizione**|Browser (Client)|Server|
|**Sicurezza**|Bassa (modificabili dall'utente)|Alta (gestite dal server)|
|**Capacità**|Limitata (circa 4KB)|Molto elevata|
|**Durata**|Decidibile (anche mesi/anni)|Tipicamente scade alla chiusura del browser|
|**Variabile PHP**|`$_COOKIE`|`$_SESSION`|

---
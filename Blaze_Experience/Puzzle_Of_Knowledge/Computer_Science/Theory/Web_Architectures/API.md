Data: 2026-05-05
[Web_Architectures](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Web_Architectures
___
# Index
- [[#Database]]
- [[#Application Programming Interface]]
- [[#REST]]
	- [[#Vantaggio]]
- [[#Vincoli Fondamentali]]
- [[#Risorse e Identificazione]]
- [[#Metodi HTTP (Le Azioni)]]
- [[#Rappresentazione delle Risorse]]
- [[#Codici di Stato (Status Codes)]]
___
# Application Programming Interface 

**API** è un intermediario software che permette a più applicazioni di **parlarsi** tra loro.

![Schema_API.png](../../../../Setup_Archive/Viewable/Image/Computer_Science/Theory/Schema_API.png)
___
# REST

 Il paradigma **REST** *Representational State Transfer* è uno **stile architetturale** per sistemi distribuiti.
 Si basa sull'idea di trattare ogni elemento del sistema come una **risorsa** accessibile tramite URL _Uniform Resource Locator_ standard, (End Point)

## Vantaggio
È **scalabile**, **flessibile** e **indipendente dalla piattaforma**: Un server scritto in Python può servire dati a un'app Android, un sito web in React e un software gestionale in Java senza dover cambiare la logica di comunicazione.
___
# Vincoli Fondamentali

Un'API deve rispettare questi principi per essere **RestFUL** se non le rispetta tutte l'API è definita solo **REST**

|  N  | Vincolo                  | Scopo                                                                                                                                             |
| :-: | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
|  1  | **Client-Server**        | Separazione netta tra l'interfaccia utente (client) e la gestione dei dati (server).                                                              |
|  2  | **Stateless**            | Ogni richiesta dal client deve contenere **tutte** le informazioni necessarie per essere elaborata. Il server non ricorda le sessioni precedenti. |
|  3  | **Cacheable**            | Le risposte devono definire se possono essere memorizzate nella cache per migliorare le prestazioni.                                              |
|  4  | **Sistema a livelli**    | Il client non sa se è collegato direttamente al server finale o a un intermediario (bilanciatore di carico, proxy).                               |
|  5  | **Interfaccia Uniforme** | È il cuore di REST e si basa sull'uso standard di URL e metodi HTTP.                                                                              |
|  6  | **Code on Demand**       | (Opzionale) Il server può inviare codice eseguibile (es. script JS) al client.                                                                    |

___
# Risorse e Identificazione

In REST, tutto è una **risorsa** identificata da un **URI** (_Uniform Resource Identifier_).
```
https://api.esempio.it/v1/utenti/123
```

- **utenti**: Collezione (il tipo di risorsa).
- **123**: Identificativo univoco della risorsa specifica.
___
# Metodi HTTP (Le Azioni)

REST utilizza i metodi standard del protocollo HTTP per eseguire operazioni.

| Metodo     | Operazione CRUD | Descrizione                                             |
| ---------- | --------------- | ------------------------------------------------------- |
| **GET**    | Read            | Recupera una risorsa o una collezione.                  |
| **POST**   | Create          | Crea una nuova risorsa.                                 |
| **PUT**    | Update          | Aggiorna una risorsa esistente (sostituzione completa). |
| **PATCH**  | Update          | Aggiorna parzialmente una risorsa.                      |
| **DELETE** | Delete          | Rimuove una risorsa.                                    |
___
# Rappresentazione delle Risorse

Il server non invia la risorsa fisica (il record del database), ma una sua **rappresentazione**:

- **JSON** (il più diffuso per la sua leggerezza).
``` JSON
{
  "id": 1,
  "nome": "Mario Rossi",
  "eta": 30
}
```
- **XML**
``` XML
<utente>
  <id>1</id>
  <nome>Mario Rossi</nome>
  <eta>30</eta>
</utente>
```
- **HTML**
``` HTML
<div>
  <h1>Profilo Utente</h1>
  <p>Nome: Mario Rossi</p>
  <p>Età: 30</p>
</div>
```

___
# Codici di Stato (Status Codes)

Il server comunica l'esito dell'operazione tramite codici numerici standard (Protocollo HTTP):

- **2xx (Successo)**:
    - `200 OK`: Operazione riuscita.
    - `201 Created`: Risorsa creata con successo.
- **4xx (Errore Client)**:
    - `400 Bad Request`: Richiesta malformata.
    - `401 Unauthorized`: Autenticazione mancante.
    - `404 Not Found`: Risorsa non trovata.
- **5xx (Errore Server)**:
    - `500 Internal Server Error`: Problema generico sul server.
___



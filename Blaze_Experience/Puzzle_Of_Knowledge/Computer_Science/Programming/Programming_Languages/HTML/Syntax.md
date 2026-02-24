Data: 2026-01-22
[HTML](README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/HTML
___


da fare:
tag:  button select(option)

# Index
- [[#Formattazione]]
- [[#Contenitore]]
- [[#Liste]]
- [[#Link]]
- [[#Immagini]]
- [[#Video]]
- [[#Embed]]
- [[#Tabelle]]
- [[#Inputs]]
- [[#Form]]

- [[#Attributi]]
___
# Formattazione
- **Titoli**: Vanno da `<h1>` il più Grande a `<h6>` il più Piccolo.
- **Paragrafi**: Il tag `<p>` definisce un blocco di testo.
- **Andare a capo**: `<br>` interruzione di riga.
- **Linea orizzontale separatrice**: `<hr>` linea orizzontale separatrice.
- **Stili del carattere**:
    - `<b>` o `<strong>`: Per il **grassetto**.
    - `<i>` o `<em>`: Per il _corsivo_.
    - `<u>`: Per la <u>sottolineatura</u>.
    - `<span>`: Un contenitore **"inline"** (Un **contenitore inline** è un elemento che **non va a capo** e **occupa solo lo spazio necessario al suo contenuto**, invece di estendersi per tutta la larghezza disponibile.) usato per formattare solo una piccola parte di testo dentro un paragrafo.

``` HTML
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
</head>
<body>
    <h1>Titolo 1</h1>
    <h2>Titolo 2</h2>
    <h3>Titolo 3</h3>
    <h4>Titolo 4</h4>
    <h5>Titolo 5</h5>
    <h6>Titolo 6</h6>
    <br>
    <p>Esempi di testo</p>
    <hr>
    <p><b>Grassetto</b></p>
    <hr>
    <p><i>Corsivo</i></p>
    <hr>
    <p><u>Sottolineato</u></p>
    <hr>
    <p>Questo:<span>contenuto è isolato</span></p>
</body>
</html>
```

![[Formattazione_HTML|200]]

___
# Contenitore 
- Il `<div>` è un contenitore "a blocchi". Immaginalo come una scatola che occupa **tutta la larghezza disponibile** della pagina, mandando a capo gli elementi che vengono dopo di lui.
	- **Utilizzo:** Raggruppare intere sezioni di una pagina, creare colonne o contenere liste e paragrafi.

``` HTML
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
</head>
<body>
    <div>contenitore 1</div>
    <div>contenitore 2</div>
    <div>contenitore 3</div>
</body>
</html>
```

___
# Liste
- **Liste**:
    - `<ul>`: Lista puntata.
    - `<ol>`: Lista numerata.
	- `<li>`: Singolo elemento della lista.
[[#Attributi]]
``` HTML
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
</head>
<body>
    <ol type="1">
        <li>Elemento 1</li>
        <li>Elemento 2</li>
      </ol>
      <ol type="A">
        <li>Elemento A</li>
        <li>Elemento B</li>
      </ol>
      <ol type="a">
        <li>Elemento a</li>
        <li>Elemento b</li>
      </ol>
      <ol type="I">
        <li>Elemento I</li>
        <li>Elemento II</li>
      </ol>
      <ol type="i">
        <li>Elemento i</li>
        <li>Elemento ii</li>
        <li>Elemento iii</li>
      </ol>
      <ul style="list-style-type: circle;">
        <li>Punto a cerchio</li>
      </ul>
      <ul style="list-style-type: square;">
        <li>Punto a quadrato</li>
      </ul>
      <ul style="list-style-type: none;">
        <li>Nessun simbolo (utile per i menu di navigazione)</li>
      </ul>
</body>
</html>
```

![[LIste_HTML]]

___
# Link
Un link che ti porta a un'altra pagina web/html.
- `<a>`: è la parte cliccabile che l'utente vedrà sulla pagina.
[[#Attributi]]
```HTML
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
</head>
<body>
    <a href="https://www.youtube.com/">questo è un link</a>
    <a target="_blank" href="https://www.youtube.com/">
	    questo è un link che apre in un'altra finestra
    </a>
</body>
</html>
```

___
# Immagini
Tag: `<img>`
Inserire una immagine all'interno della pagina:
- **Nota**: Il tag `<img>` non richiede chiusura.
[[#Attributi]]
``` HTML
<img src="foto.jpg" width="100px" height="100px">
<img src="cartella/foto.jpg" width="100px" height="100px">
<img src="indirizzo universale della cartella" width="100px" height="100px">
<img src="link della immagine nel web" width="100PX" height="100px">
```
___
# Video
Tag: `<video>`
- **Sintassi**: Richiede il tag di apertura e chiusura. All'interno si usa `<source>`.
- **Fallback**: Il testo dentro i tag `<video>` appare solo se il browser è troppo vecchio. 
[[#Attributi]]
``` HTML
<!DOCTYPE html>
<html>
<head>
    <title>Solo Video</title>
</head>
<body>
    <h2>Video</h2>
    <video width="300px" controls>
        <source src="video.mp4" type="video/mp4">
        Il browser non supporta i video.
    </video>
    <video width="300px" controls autoplay muted>
        <source src="video.mp4" type="video/mp4">
        <source src="video.ogg" type="video/ogg">
        Spiacenti, browser non supportato!
    </video>
</body>
</html>
```

___
# Embed
 Tag: `<iframe>`
- **Scopo**: Permette di visualizzare contenuti provenienti da un altro sito (come video di YouTube, mappe di Google Maps o post di social) direttamente nella tua pagina.
- **Sintassi**: È un tag che richiede la chiusura: `<iframe> </iframe>`.
[[#Attributi]]
``` HTML
<iframe
    width="560"
    height="315"
    src="https://www.youtube.com/embed/JRJNvxoh844"
    title="YouTube video player"
    frameborder="0"                             
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture">                     <!--sito web  condividi  incorpora -->
</iframe>
```

___
# Tabelle
Le tabelle organizzano i dati in righe e colonne:
- `<table>`: Contenitore della tabella.
- `<tr>`: Definizione di una riga (Table Row). 
- `<th>`: Cella di intestazione (Table Header, testo in grassetto).
- `<td>`: Cella di dati (Table Data).

``` HTML
<style>
    table {
        width: 100%; 
        border-collapse: collapse; /*Fa si che il bordo sia uno e non sdoppiato*/
    }
    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #eee;
    }
</style>

<table>
  <tr>
    <th>Articolo</th>
    <th>Quantità</th>
  </tr>
  <tr>
    <td>Pane</td>
    <td>2</td>
  </tr>
  <tr>
    <td>Latte</td>
    <td>1</td>
  </tr>
</table>
```

![[Tabella_HTML|1000]]

___
# Inputs
``` HTML
<input type="text" placeholder="Nome">
<input type="password" placeholder="Password">
<input type="email" placeholder="Email">
<input type="number" min="1" max="10">
<input type="date">
<input type="color">
<input type="checkbox"> Accetto i termini
```
[[#Attributi]]
![[Tipi_Di_Input|300]]

___
# Form
Tag: `<form>`
I form permettono agli utenti di inviare dati a un server. 
**Tag principali**:
- `<form>`: Definisce l'inizio e la fine del modulo,
- `<label>`: Definisce un'etichetta per un elemento di input.
- `<input>`: Il suo comportamento cambia in base all'attributo `type`.
[[#Attributi]]
``` HTML
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
</head>
<body>
    <style>
        form {
            max-width: 400px;
            margin: 20px 0;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-family: Arial, sans-serif;
        }
        div {
            margin-bottom: 10px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 5px;
            box-sizing: border-box; /* Garantisce che il padding non sballi la larghezza */
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
        }
    </style>
    <form action="/salva-dati" method="GET">
        <div>
            <label>Nome Articolo:</label>
            <input type="text" id="articolo" name="articolo" placeholder="Es. Mele">
        </div>
        <div>
            <label>Quantità:</label>
            <input type="number" id="quantita" name="quantita" min="1">
        </div>
        <button type="submit">Aggiungi alla Tabella</button>
    </form>
</body>
</html>
```

![[form_html|500]]

___
# Attributi
## Index:
- [[#Struttura e Metadati]]
- [[#Liste]]
- [[#Media e Link]]
- [[#Embed (Iframe)]]
- [[#Input]]
- [[#Form (Moduli)]]

## Classi e ID
``` CSS
<div id="header-principale"> 
	<p>Questo è il contenuto dell header unico.</p> 
</div>
<button class="btn">Bottone 1</button> 
```
## Struttura e Metadati
- **\<html\>**
    1. `lang`: (Consigliato) Indica la lingua della pagina (es. `lang="it"`).
- **\<meta>**
    1. `charset`: Definisce la codifica dei caratteri (quasi sempre `"UTF-8"`).
    2. `name` e `content`: Usati insieme per i metadati (es. per il `viewport` o la descrizione SEO).
- **\<link>**
    1. `rel`: Specifica la relazione (per i CSS è sempre `"stylesheet"`).
    2. `href`: Il percorso del file esterno da collegare.
## Liste
- **\<ul>** (Liste puntate)
    1. `style`: Usato per cambiare il simbolo (es. `list-style-type: square\circle\none;`).
- **\<ol>** (Liste numerata)
    1. `type`: Definisce lo stile della numerazione (`1`, `A`, `a`, `I`, `i`).
    2. `start`: (Opzionale) Il numero da cui far partire il conteggio.
## Media e Link
- **\<a>** (Link)
    1. `href`: Specifica l'indirizzo (URL) della pagina verso cui punta il link.
    2. `target`: Se impostato a `"_blank"`, apre il link in una nuova scheda.
- **\<img>** (Immagini)
    1. `src`: Il percorso dell'immagine.
    2. `alt`: (Fondamentale) Testo alternativo per l'accessibilità se l'immagine non carica.
    3. `width` / `height`: Dimensioni dell'immagine.
- **\<video>**
    1. `controls`: Mostra i tasti di riproduzione.
    2. `autoplay`: Fa partire il video da solo.
    3. `muted`: Toglie l'audio (spesso necessario per l'autoplay).
    4. `poster`: (Opzionale) Un'immagine da mostrare prima che il video parta.
    5. `type`: Formato (es. `video/mp4`).
	- **\<source>** (Dentro Video/Audio)
	    1. `src`: Percorso del file multimediale.
	    2. `type`: Formato del file (es. `video/mp4`).
## Embed (Iframe)
- **\<iframe>**
    1. `src`: L'indirizzo del sito o video da incorporare.
    2. `width` / `height`: Dimensioni della finestra.
    3. `allow`: Permessi speciali:
		1. `accelerometer`: permette al video di capire se stai ruotando il telefono (per passare a schermo intero).
		2. `autoplay`: permette al video di partire in automatico (spesso richiede il video muto).
		3. `clipboard-write`: permette al video di copiare link o testi negli appunti del tuo computer/telefono.
		4. `encrypted-media`: necessario per riprodurre contenuti protetti da copyright (come film su Netflix o video musicali ufficiali).
		5. `gyroscope`: serve per i video a 360° (permette di "guardarsi intorno" muovendo il dispositivo).
		6. `picture-in-picture`: permette di rimpicciolire il video in un angolo dello schermo mentre continui a navigare.
    4. `title`: Descrizione del contenuto per gli screen reader.
    5. `allowfullscreen`: Schermo intero
## Input
- **\<input>**
	- `type`: Determina il tipo di campo:
		1. `text`: Il campo standard per inserire una riga di testo (es. Nome o Cognome).
		2. `password`: Simile al testo, ma i caratteri vengono mascherati con dei puntini per sicurezza.
		3. `email`: Verifica automaticamente che il testo inserito abbia il formato di un indirizzo email (presenza della `@` e del punto).
		4. `number`: Accetta solo numeri e spesso mostra delle freccette per aumentare o diminuire il valore. Si possono usare gli attributi `min` e `max`.
		5. `date`: Apre un mini-calendario nativo del browser per selezionare giorno, mese e anno.
		6. `color`: Apre un selettore di colori (color picker) che restituisce il codice esadecimale del colore scelto.
		7. `checkbox`: Una casella da spuntare, usata per scelte multiple o per accettare termini e condizioni.
	- `placeholder`: Testo visualizzato nell'input
## Form (Moduli)
- **\<form>**
    1. `action`: L'URL a cui inviare i dati.
    2. `method`: Il modo in cui i dati vengono spediti (`GET` o `POST`).
- **\<label>**
    1. `for`: Deve corrispondere all' `id` dell'input per collegarli logicamente.
- **\<input>**
    1. `type`: Determina il tipo di campo:
			1. `password`
			2. `text`
			3. `email`
			4. `number`
			5. `date`
			6. `color`
			7. `checkbox`
			8. `submit`: Pulsante per inviare il modulo
			9. `hidden`: Nasconde il campo (utile per passare informazioni nell'url)
    2. `name`: (Critico) Il nome del dato che arriverà al server, stampato nell'ulr
    3. `placeholder`: Testo di suggerimento nel campo.
    4. `required`: Impedisce l'invio se il campo è vuoto.
    5. `value`: (Opzionale) Imposta un valore predefinito:
    6. `min`: impedisce all'utente di inserire campi vuoti a un numero stabilito
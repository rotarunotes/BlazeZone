Data: 2026-01-22
[](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/HTML
___
# Index
- [[#Struttura Della Pagina e Metadati]]
- [[#Formattazione]]
- [[#Contenitore]]
- [[#Liste]]
- [[#Link]]
- [[#Immagini]]
- [[#Video]]
- [[#Embed]]
- [[#Tabelle]]

___
# Struttura Della Pagina e Metadati
Ogni documento HTML segue una gerarchia precisa:
- `<!DOCTYPE html>`: Indica al browser che si tratta di un file **HTML5**.
- `<html>`: Il contenitore principale di **tutto** il codice.
- `<head>`: Contiene informazioni "**invisibili**" all'utente (metadati, titolo della scheda, collegamenti a file esterni).
    - `<title>`: Il testo che appare sulla **scheda** del browser.
    - `<link rel="stylesheet" href="...">`: Serve per collegare un file **CSS** esterno.
- `<body>`: Contiene tutto ciò che è visibile nella pagina (testo, immagini, video).

``` HTML
<!DOCTYPE html>
<html>
	<!--Tutto il codice-->
	<head>
		<!--Informazioni invisibili-->
		
		<!--Metadati-->
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    
	    <title>Titolo della scheda della pagina</title>
	    
	    <!--Link al file CSS-->
	    <link rel="stylesheet" href="...">
	</head>
	
	<body>
		<!--Contenuto della pagina-->
	</body>
</html>
```

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
	    - `style="list-style-type: circle;"`: Punto a cerchio
	    - `style="list-style-type: square;"`: Punto a quadrato
	    - `style="list-style-type: none;"`: Nessun simbolo
    - `<ol>`: Lista numerata.
	    - `type="1"`
	    - `type="A"`
	    - `type="a"`
	    - `type="I"`
	    - `type="i"`
	
	- `<li>`: Singolo elemento della lista.

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
- `href="..."`: Specifica l'indirizzo (URL) della pagina verso cui punta il link.
- `target="_blank"`: Se inserito, dice al browser di aprire il link in una **nuova scheda** o finestra, invece di sovrascrivere quella attuale.
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
- **Sintassi**: `<img src="percorso" width="px" height="px">`
- **Percorsi**:
    1. **Stessa cartella**: `src="foto.jpg"`
    2. **Sottocartella**: `src="cartella/foto.jpg"`
    3. **Indirizzo assoluto**: `src="C:\cartella\cartella\cartella\cartella\foto.jpg"`
    4. **Internet**: `src="https://link-immagine.com/foto.png"`
- **Nota**: Il tag `<img>` non richiede chiusura.
``` HTML
<img src="foto.jpg" width="100px" height="100px"></img>
<img src="cartella/foto.jpg" width="100px" height="100px"></img> 
<img src="indirizzo universale della cartella" width="100px" height="100px"></img> 
<img src="link della immagine nel web" width="100PX" height="100px"></img>
```
___
# Video
Tag: `<video>`
- **Sintassi**: Richiede il tag di apertura e chiusura. All'interno si usa `<source>`.
- **Attributi principali**:
    1. **`controls`**: Aggiunge i tasti **Play**, Volume e Schermo intero.
    2. **`autoplay`**: Avvia il video appena carica la pagina.
    3. **`muted`**: Toglie l'audio (obbligatorio su molti browser per far funzionare l'autoplay).
    4. **`type`**: Specifica il formato (es. `video/mp4`).
- **Fallback**: Il testo dentro i tag `<video>` appare solo se il browser è troppo vecchio. 
	
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
**Gli Attributi principali:**
1. `src`: L'URL del contenuto. Attenzione: Per YouTube deve essere il link di tipo `/embed/` (quello che trovi facendo Condividi > Incorpora), **non** il link normale del video.
2. `width` & `height`: Definiscono le dimensioni della "finestra" in pixel.
3. `title`: Fondamentale per l'accessibilità (spiega cosa contiene il riquadro).
4. `allow`: Una lista di permessi che dai al contenuto esterno (es. `autoplay` per farlo partire subito o `fullscreen` per permettere lo schermo intero).
	- `accelerometer`: permette al video di capire se stai ruotando il telefono (per passare a schermo intero).
	- `autoplay`: permette al video di partire in automatico (spesso richiede il video muto).
	- `clipboard-write`: permette al video di copiare link o testi negli appunti del tuo computer/telefono.
	- `encrypted-media`: necessario per riprodurre contenuti protetti da copyright (come film su Netflix o video musicali ufficiali).
	- `gyroscope`: serve per i video a 360° (permette di "guardarsi intorno" muovendo il dispositivo).
	- `picture-in-picture`: permette di rimpicciolire il video in un angolo dello schermo mentre continui a navigare.
5. `allowfullscreen`: Schermo intero
6. `frameborder="0"`: (Oggi spesso gestito via CSS) Serve a togliere il bordo attorno al riquadro.

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


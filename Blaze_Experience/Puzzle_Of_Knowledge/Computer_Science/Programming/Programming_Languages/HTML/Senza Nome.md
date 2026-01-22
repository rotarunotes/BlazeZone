riEcco un riepilogo strutturato e chiaro dei tuoi appunti di HTML e CSS. Ho organizzato i contenuti in una scaletta logica per aiutarti a studiare o a consultare rapidamente i tag.

---

## 📝 Scaletta Appunti HTML e CSS

1. **Struttura della Pagina e Metadati**
2. **Testo e Formattazione**
3. **Organizzazione dei Contenuti (Contenitori e Liste)**
4. **Elementi Multimediali (Immagini, Video, Embed)**
5. **Collegamenti (Link)**
6. **Tabelle**
7. **Stile e Attributi (ID, Class e CSS)**
### 1) Struttura della Pagina e Metadati
Ogni documento HTML segue una gerarchia precisa:
- `<!DOCTYPE html>`: Dichiarazione che indica al browser che si tratta di un file HTML5.
- `<html>`: Il contenitore principale di tutto il codice.
- `<head>`: Contiene informazioni "invisibili" all'utente (metadati, titolo della scheda, collegamenti a file esterni).
    - `<title>`: Il testo che appare sulla scheda del browser.
    - `<link rel="stylesheet" href="...">`: Serve per collegare un file CSS esterno.
- `<body>`: Contiene tutto ciò che è visibile nella pagina (testo, immagini, video).
### 2) Testo e Formattazione
Per gestire i testi utilizziamo titoli, paragrafi e tag di enfasi:
- **Titoli**: Vanno da `<h1>` (il più importante) a `<h6>` (il più piccolo).
- **Paragrafi**: Il tag `<p>` definisce un blocco di testo.
- **Andare a capo**: `<br>` (interruzione di riga) e `<hr>` (linea orizzontale separatrice).
- **Stili del carattere**:
    - `<b>` o `<strong>`: Per il **grassetto**.
    - `<i>` o `<em>`: Per il _corsivo_.
    - `<u>`: Per la <u>sottolineatura</u>.
    - `<span>`: Un contenitore "inline" usato per formattare solo una piccola parte di testo dentro un paragrafo.
### 3) Organizzazione dei Contenuti
- **DIV (`<div>`)**: Il contenitore generico "block-level". Serve a raggruppare elementi per applicare stili o layout.
- **Liste**:
    - `<ul>`: Lista non ordinata (elenco puntato).
    - `<ol>`: Lista ordinata (elenco numerato).
    - `<li>`: Singolo elemento della lista.
### 4) Elementi Multimediali
- **Immagini (`<img>`)**: Richiede l'attributo `src` (percorso del file) e `alt` (testo alternativo se l'immagine non carica).
    - _Percorsi_: Possono essere locali (stessa cartella o sottocartelle) o URL assoluti (link da internet).
- **Video (`<video>`)**: Utilizza il tag `<source>` per specificare il file.
    - Attributi: `controls` (mostra i tasti play/volume), `autoplay` (parte da solo), `muted` (senza audio).
- **Embed (`<iframe>`)**: Usato per incorporare contenuti esterni, come i video di YouTube.

### 5) Collegamenti (Link)
Il tag `<a>` (anchor) permette di navigare tra le pagine:
- `href`: L'indirizzo di destinazione.
- `target="_blank"`: Attributo per aprire il link in una nuova scheda del browser.
### 6) Tabelle
Le tabelle organizzano i dati in righe e colonne:
- `<table>`: Contenitore della tabella.
- `<tr>`: Definizione di una riga (Table Row).
- `<th>`: Cella di intestazione (Table Header, testo in grassetto).
- `<td>`: Cella di dati (Table Data).
### 7) Stile e Attributi (ID, Class e CSS)
Per dare un aspetto grafico (colori, margini) si usa il CSS:
- **Style Inline**: Scritto direttamente nel tag (es. `<p style="color: red;">`).
- **Selettori CSS**:
    - **Tag**: Applica lo stile a tutti i tag di quel tipo (es. `p { ... }`).
    - **ID (`#`)**: Identificativo univoco per un solo elemento (es. `#titolo-1`).
    - **Class (`.`)**: Riutilizzabile su più elementi (es. `.text-red`). Si possono applicare più classi allo stesso tag separandole con uno spazio.
- **Box Model**:
    - `padding`: Spazio interno tra il contenuto e il bordo.
    - `margin`: Spazio esterno tra il bordo e gli altri elementi.
    - `width`/`height`: Larghezza e altezza dell'elemento.

Data: 2026-02-12
[JS](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/JS
___
# Index

- [[#DOM (Document Object Model)]]
- [[#Selezione degli Elementi]]
- [[#Manipolazione Elementi]]
	- [[#Differenza Tra Nascondere E Rimuovere]]
- [[#Gestione dei Form (Input e Valori)]]
    - [[#Input di testo e Password]]
    - [[#Checkbox e Radio Button]]
	    - [[#Menu a tendina (Select)]]
- [[#Gestione Eventi]]
    - [[#Eventi comuni]]

---
# DOM (Document Object Model)

Il DOM rappresenta la struttura della pagina HTML come un **albero di oggetti** che JavaScript può leggere e modificare in tempo reale.

___
# Selezione degli Elementi

Per interagire con un elemento, dobbiamo prima "selezionarlo" dal documento:
1. `document.getElementById("id")`: Seleziona un **singolo** elemento tramite il suo ID unico.
2. `document.getElementsByClassName("classe")`: Restituisce una **collezione** (simile a un array) di tutti gli elementi con quella classe.
3. `document.getElementsByTagName("tag")`: Restituisce una collezione di tutti gli elementi di un certo tipo (es. `body`, `div`).
4. `document.querySelectorAll(".classe")`:
	 - **Cosa accetta**: Una stringa con qualsiasi selettore CSS (es. `.classe`, `#id`, `div > p`, `input[type="text"]`).
	- **Cosa restituisce**: Una **NodeList**, ovvero una collezione di tutti gli elementi che corrispondono a quel selettore.
	- **Caratteristica unica**: A differenza di altre collezioni, la `NodeList` permette di usare direttamente il metodo `.forEach()` per scorrere gli elementi.

``` javaScript
// 1) getElementById -> Ritorna: Singolo Oggetto (Element)
let logo = document.getElementById("main-logo");
logo.style.width = "200px"; 

// 2) getElementsByClassName -> Ritorna: HTMLCollection (Simile a Array)
let schede = document.getElementsByClassName("card");
if (schede.length > 0) {
    schede[0].style.border = "1px solid red"; 
}

// 3) getElementsByTagName -> Ritorna: HTMLCollection
let paragrafi = document.getElementsByTagName("p");
// Per scorrere una HTMLCollection serve un ciclo for classico
for (let i = 0; i < paragrafi.length; i++) {
    paragrafi[i].style.fontSize = "18px";
}

// 4) querySelector -> Ritorna: Singolo Oggetto (il primo che trova)
let primoBottone = document.querySelector(".btn-submit");
if (primoBottone) primoBottone.disabled = true;

// 5) querySelectorAll -> Ritorna: NodeList (Supporta il .forEach)
let links = document.querySelectorAll("nav a.active");
links.forEach(link => {
    link.style.fontWeight = "bold";
});
```

# Manipolazione Elementi

Una volta ottenuto l'oggetto, possiamo modificarne le proprietà:
- **Stile**: `elemento.style.background = "red";` (modifica il CSS inline).
- **Contenuto**: `elemento.innerHTML = "Nuovo testo";` 
	- A differenza di altre proprietà che gestiscono solo il testo, `innerHTML` permette di inserire o manipolare veri e propri tag (come `<b>`, `<div>`, `<span>`, ecc.), che vengono interpretati dal browser e renderizzati correttamente.).
- **Attributi**:
    - `elemento.setAttribute("src", "img.png")`: Imposta un attributo.
    - `elemento.getAttribute("src")`: Legge il valore di un attributo.
- **Rimozione**:
    - `elemento.remove()`: Elimina l'elemento dal DOM.
    - `elemento.removeAttribute("src")`: Elimina solo l'attributo.

``` javaScript
// 1. Selezione
let box = document.querySelector("#myBox");

if (box) {
    // 2. Modifica Stile e Contenuto
    box.style.background = "red";           // CSS inline
    box.innerHTML = "<strong>Aggiornato!</strong>"; // Testo + HTML

    // 3. Gestione Attributi (Scrittura e Lettura)
    box.setAttribute("data-status", "active"); // Imposta attributo personalizzato
    let valore = box.getAttribute("data-status"); // Legge l'attributo
    console.log("Stato attuale:", valore);

    // 4. Rimozione (Esempi commentati per non far sparire tutto subito)
    box.removeAttribute("data-status");  // Elimina solo l'attributo
    box.remove();                        // Elimina l'intero elemento dal DOM
}
```

## Differenza Tra Nascondere E Rimuovere
1. `style.visibility = "hidden"`: L'elemento è invisibile ma occupa ancora il suo spazio.  
2. `style.display = "none"`: L'elemento sparisce completamente dal layout.    
3. `innerHTML = ""`: Svuota tutto il contenuto interno dell'elemento.

---

# Gestione dei Form (Input e Valori)

I form richiedono proprietà specifiche per leggere cosa ha inserito o selezionato l'utente.
## Input di testo e Password
Si usa la proprietà `.value` per leggere il contenuto.

``` JavaScript
let psw = document.getElementById("psw1").value;
let area = document.getElementById("area1").value;
```

## Checkbox e Radio Button

Per questi elementi è fondamentale la proprietà `.checked` (restituisce `true` o `false`).

``` JavaScript
let isChecked = document.getElementById("check1").checked;

// I Radio Button sono spesso gestiti come array tramite classe
let radio = document.getElementsByClassName("radio1");
console.log(radio[0].checked); // Verifica il primo bottone del gruppo
```

### Menu a tendina (Select)

Si può gestire l'intero menu o le singole opzioni:
1. `menu.value`: Restituisce il valore dell'opzione attualmente selezionata.
2. `menu.selectedIndex`: Restituisce l'indice numerico (0, 1, 2...) della selezione.
3. `opzione.selected`: Proprietà booleana della singola `<option>` per verificare se è attiva.

---
# Gestione Eventi

Gli eventi collegano le azioni dell'utente a funzioni JavaScript.
1. **Proprietà diretta**: `elemento.onclick = function() { ... };`
2. **AddEventListener (Consigliato)**: Permette di aggiungere più funzioni allo stesso evento senza sovrascriverle.

``` JavaScript
let pulsante1 = document.getElementById("pulsante1");

function fun1() {
    console.log("Dati inviati!");
    // Disabilita il pulsante per evitare click multipli
    pulsante1.disabled = true; 
}

// Aggiunta dell'evento
pulsante1.addEventListener("click", fun1);

// Rimozione dell'evento
pulsante1.removeEventListener("click", fun1);
```

## Eventi comuni:
- `click`: Al click del mouse.
- `mouseover`: Quando il mouse passa sopra l'elemento.
- `load` / `unload`: Al caricamento o chiusura della pagina.
- `input`: Mentre l'utente scrive in un campo di testo.

---
 
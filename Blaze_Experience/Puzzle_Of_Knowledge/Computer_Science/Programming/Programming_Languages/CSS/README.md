Data: 2026-01-22
[Programming_Languages](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/CSS
___
# CSS

Il **CSS** (Cascading Style Sheets) è il linguaggio utilizzato per definire il design e il layout delle pagine web. Se l'HTML è lo scheletro, il CSS è l'**estetica**: definisce colori, font, spaziature e posizioni degli elementi.

Viene chiamato "a cascata" perché le regole vengono applicate seguendo un **ordine di priorità:** se due regole contrastano, l'ultima letta (o la più specifica) vince.

___
# Sintassi e Selettori

La struttura di una regola CSS è composta da un **selettore** e un **blocco di dichiarazioni** racchiuso tra parentesi graffe.
- **Selettore**: Indica quale elemento HTML vuoi modificare (es. `h1`, `p`, `.classe`, `#id`).
	- **Proprietà**: L'aspetto che vuoi cambiare (es. `color`, `font-size`).
		- **Valore**: L'impostazione specifica (es. `red`, `20px`).

``` CSS
/* Esempio di sintassi */
p {
    color: blue;
    font-size: 16px;
    text-align: center;
}
```

___
# Collegare il CSS

Esistono tre modi per collegare il CSS all'HTML:
1. **Esterno (Consigliato)**: Si scrive il codice in un file separato `.css` e si collega nel `<head>` dell'HTML.
    `<link rel="stylesheet" href="style.css">`
2. **Interno**: Si scrive il codice dentro il tag `<style>` direttamente nel `<head>`.
3. **In-line**: Si usa l'attributo `style="..."` direttamente dentro un tag HTML (poco pratico per progetti grandi).

___
# Indice

[[Semantic]]

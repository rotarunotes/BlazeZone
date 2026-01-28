Data: 2026-01-22
[Programming_Languages](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/HTML
___
# HTML
L'**HTML** (HyperText Markup Language) è il linguaggio fondamentale del web. Non è un linguaggio di programmazione, ma un **linguaggio di markup**, ovvero un sistema per etichettare i contenuti in modo che il browser (Chrome, Safari, Firefox) sappia cosa sta leggendo.

Immagina l'HTML come lo **scheletro** di una casa: definisce dove vanno i muri, le finestre e le porte, ma non specifica ancora il colore delle pareti (che spetta al CSS) o come funzionano gli interruttori (che spetta a JavaScript).

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
# Indice
- [Syntax](Syntax.md)
___

 
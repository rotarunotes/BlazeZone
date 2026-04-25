Data: 2026-02-14
[Programming_Languages](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/PHP
___
# PHP

PHP *Hypertext Preprocessor*.è una parte di Apache. Si tratta di un linguaggio **interpretato** ad **oggetti** e **non tipizzato**
___
# Rapporto con HTML

PHP è un linguaggio **embedded**, il che significa che puoi alternare blocchi di logica a blocchi di presentazione.

- **Separazione**: Anche se puoi scriverli insieme, la buona pratica suggerisce di tenere la logica (PHP) separata dalla visualizzazione (HTML).


``` PHP
//questo file dato che contiene del php, anche se c'è html l'estensione del file è .php
<!DOCTYPE html>
<html lang="it">
	<head>
	</head>
	<body>
	    <?php
			//si possono aprire e chiudere tag php all'interno del codice html a                 piacimento 
	    ?>
	    <?php
	
	    ?>
	</body>
</html>
```

- **Output**: Il comando `echo` è il ponte che trasforma le variabili PHP in testo leggibile dal browser.
___
# Indice

- [Language](Language.md)
- [Functions](Functions.md)
- [Cookie_Session](Cookie_Session.md)
- [MYSQLI](MYSQLI.md)

___
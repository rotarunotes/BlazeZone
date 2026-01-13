**Giochi da Tavolo**   
Si realizzi il diagramma Entità-Relazione per rappresentare la realtà operativa di una comunità di appassionati che collezionano giochi da tavolo. 
Ciascun **gioco da tavolo** è identificato da una **denominazione**, l'annata della **pubblicazione originale**, uno o più **creatori** e dalla **modalità di gioco**: individuale oppure multigiocatore. 
I giochi multigiocatore sono definiti dal range di **partecipanti** (minimo e massimo) e dalla natura delle **dinamiche ludiche** (collaborativa, antagonista o mista). 
Per ciascun **creatore** vengono registrati **nome** **completo** e **cognome**, il **conteggio** delle opere pubblicate e il **numero complessivo** di riconoscimenti ottenuti. Ogni appassionato **collezionista**, identificato attraverso nome **anagrafico** e **pseudonimo**, è proprietario di diversi **titoli**; per ciascuna proprietà va registrata la **data di acquisizione**. Inoltre, ogni collezionista può stilare una lista di giochi che desidera aggiungere alla propria **collezione**.

Entità:
1. Gioco da tavolo
	1. denominazione
	2. pubblicazione originale
	3. creatori
	4. modalità di gioco (individuale/ multigiocatore(partecipanti dinamiche ludiche))
2. Creatore
	1. nome
	2. cognome
	3. numero opere pubblicate
	4. numero riconoscimenti ottenuti
3. Collezionista
	1. nome anagrafico
	2. pseudonimo
	3. giochi da tavolo posseduti
	4. data di acquisizione
4. lista collezione
	1. Giochi da tavolo
Attributi:
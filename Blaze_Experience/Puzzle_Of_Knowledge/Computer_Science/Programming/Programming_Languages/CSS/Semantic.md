Data: 2026-01-28
[CSS](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/CSS
___
# Index

[[#Selettori]]
[[#Il Box Model]]
[[#Grandezze]]
[[#Colori e Sistemi]]
[[#Distanze]]
[[#Conflitti e Specificità]]

___
# Selettori 
Per applicare lo stile al contenuto html possiamo usare i selettori
1. **Selettore universale**`*`: Applica lo stile a ogni elemento
2. **Tag html**
3. **ID (`#`)**: Seleziona un elemento unico. Ha la priorità massima tra i selettori semplici.
4. **Classi (`.`)**: Seleziona un gruppo di elementi.
5. **Combinatori**:
    - **Annidamento (Spazio)**: `.padre .figlio` seleziona gli elementi "figlio" solo se dentro "padre".
    - **Multipli (Senza spazio)**: `.classe1.classe2` seleziona l'elemento che possiede **entrambe** le classi contemporaneamente.
    - **Unione (Virgola)**: `h1, p` applica la stessa regola a entrambi.
6. **Pseudo-classi`:`**:  Seleziona l'elemento in base al suo **stato** o alla sua **posizione**.
	1. **Stato/Interazione**:
		- `:hover` → Quando il mouse passa sopra l'elemento.
		- `:active` → Nel momento esatto in cui l'elemento viene cliccato.
		- `:focus` → Quando l'elemento è selezionato (es. un campo di testo dove stai scrivendo).
	2. **Posizione/Struttura**:
		- **`:first-child`**: Seleziona l'elemento solo se è il **primo figlio** del suo contenitore.
		- **`:last-child`**: Seleziona l'elemento solo se è l'**ultimo figlio** del suo contenitore.
		- **`:nth-child(n)`**: Seleziona il figlio in base a un numero o a una formula:
			1. **Numero specifico**: `:nth-child(3)` seleziona esattamente il terzo elemento.
			2. **Parole chiave**:
			    - `even`: seleziona tutti gli elementi **pari** (2, 4, 6...).
			    - `odd`: seleziona tutti gli elementi **dispari** (1, 3, 5...).
			3. **Formule matematiche (`an + b`)**:
			    - `3n`: seleziona ogni 3 elementi (3, 6, 9...).
			    - `n+3`: seleziona tutti gli elementi **dal terzo in poi**.
			    - `-n+3`: seleziona solo i **primi tre** elementi.
7. **Pseudo-elementi**`::`: serve per creare o stilizzare una **parte specifica** del contenuto
	- `::first-letter`: Colpisce solo la **prima lettera** di un blocco di testo. Tipico per l'effetto "capolettera".
	- `::first-line`: Colpisce solo la **prima riga** di un paragrafo. Se ridimensioni la finestra, la riga cambia ma lo stile resta solo sulla prima riga visibile.
	- `::selection`: Cambia l'aspetto del testo quando viene **evidenziato** (selezionato) dall'utente con il mouse.
	- `::before`: Permette di inserire contenuto (testo, icone) rispettivamente **prima**.
	- `::after`: Permette di inserire contenuto (testo, icone) rispettivamente **dopo**.
   
| **Tipo**        | **Simbolo** | **Cosa fa?**                       | **Esempio**                           |
| --------------- | ----------- | ---------------------------------- | ------------------------------------- |
| Pseudo-classe   | `:`         | Filtra l'**elemento** intero       | `:hover` (tutto il bottone cambia)    |
| Pseudo-elemento | `::`        | Filtra una **parte** dell'elemento | `::first-letter` (solo la 'B' cambia) |

``` CSS
/* 1) Tag html: stile applicato a tutti i tag di quel tipo */
h1{
}
/* 2) ID (#): priorità alta, per un elemento specifico */
#header-principale {
}
/* 3) Classi (.): stile riutilizzabile */
.btn {
}
/* 4) Combinatori: */
/* Annidamento (Spazio): seleziona il <p> solo se dentro .padre */
.padre p {
}
/* Multipli (Senza spazio): deve avere sia .alert che .success */
.alert.success {
}
/* Unione (Virgola): già visto sopra con h1, h2 */
h1, h2 {
}
li:first-child {
/*Se scrivi solo `li:first-child`, stai dicendo al browser:"Cerca ogni elemento `li` che sia il primo figlio di un qualsiasi genitore"*/
}

li:last-child {
}
```

Esempio con **Pseudo-classi**`:`
![[Selettore_css|200]]

---
# Il Box Model

Ogni elemento HTML è considerato come una **scatola rettangolare**. Il Box Model è il concetto fondamentale per gestire gli spazi:
- **Content**: Il contenuto vero e proprio (testo o immagine).
- **Padding**: Lo spazio vuoto **dentro** il bordo (distanza tra contenuto e bordo).
- **Border**: La linea che circonda il padding e il contenuto.
- **Margin**: Lo spazio vuoto **fuori** dal bordo (distanza tra questo elemento e gli altri).
  


``` CSS
.box {
    width: 300px;
    padding: 20px;
    border: 5px solid black;
    margin: 10px;
}
```

___
# Grandezze

 - **Unità Assolute**: 
	 - **px (Pixel)**: Non cambia mai, indipendentemente dal resto della pagina.
 - **Unità Relative al Testo**:
	- **rem**: Dimensione del font principale (root) della pagina.
	- **em**: Dimensione del font dell'elemento genitore. Se il genitore ingrandisce, ingrandisce anche l'elemento figlio.
 - **Unità Relative al Layout**:
	- **% (Percentuale)**: Si riferisce allo spazio occupato rispetto al contenitore che lo ospita. Se un box è al 50%, sarà largo la metà del suo genitore.
- **Unità Relative allo Schermo**:
	- **vw (Viewport Width)**: 1vw è l'1% della larghezza totale dello schermo.
	- **vh (Viewport Height)**: 1vh è l'1% dell'altezza totale dello schermo (molto usato per creare sezioni che occupano l'intera pagina in verticale).

___
# Colori e Sistemi

Nel CSS i colori possono essere espressi in vari modi: oltre al nome semplice (come `red` o `blue`):
- **Nome semplice**: `red`, `blue`
- **Sistema Esadecimale**: `color: #ff7f50;` (Utilizza base 16: 0-9 e A-F).
- **Sistema RGB**: `color: rgb(0, 255, 0);` (Indica i livelli di Red, Green e Blue da 0 a 255).

``` CSS
h1 {
    color: Tomato;       /* Un rosso aranciato */
    color: #FF7F50;
    color: rgb(128, 0, 128);
}
```

---
# Distanze

La logica segue il senso orario (partendo dall'alto):

1. **Quattro valori**: top, right, bottom, left.
	- `margin: 10px 20px 30px 40px;` 
2. **Tre valori**: top, left/right, bottom.
	- `margin: 10px auto 30px;`
3. **Due valori**: top/bottom, right/left.
	- `margin: 10px 20px;`
4. **Un valore**: Stesso spazio su tutte e 4 le direzione.
	- `margin: 10px;`

___

# Conflitti

Quando due o più regole CSS si applicano allo stesso elemento, il browser decide quale vincere seguendo una scala di potere (dal più debole al più forte):
1. **L'ordine di scrittura**: Se due regole hanno lo stesso peso, vince l'**ultima** indicata nel codice.
2. **Specificità dei selettori**: Più il selettore è preciso, più è forte.
    - `elemento` (es. `p`) → **Debole**
    - `.classe` → **Medio**
    - `#id` → **Forte**
    - `elemento.classe` o `elemento#id` → **Molto forte**
3. **CSS in linea**: Lo stile scritto direttamente nel tag HTML (`style="..."`) vince su quasi tutto il foglio CSS esterno.
4. **Il comando `!important`**: Vince su tutto, indipendentemente dalla posizione o dalla specificità.

``` CSS
h1 {
    color: orange !important;
}
```

---


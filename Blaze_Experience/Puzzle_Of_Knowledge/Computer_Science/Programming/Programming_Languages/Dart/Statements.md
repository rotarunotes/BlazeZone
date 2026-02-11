Data: 2025-10-21
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Index
- [[#If]]
    - [[#If Operatore Ternario]]
    - [[#if Collection (Per Liste/Widget)]]
- [[#For]]
- [[#For-In]]
- [[#While]]
- [[#Try-Catch]]
- [[#Switch]]

___
# If
Prende decisioni

``` Dart
int voto = 7;
if (voto > 8) {
print("Risultato: Ottimo!");
} else if (voto >= 6) {
print("Risultato: Sufficiente.");
} else {
print("Risultato: Insufficiente.");
}
```

## If Operatore Ternario

``` Dart
String stato = eta >= 18 ? "Maggiorenne" : "Minorenne";
```

## if Collection (Per Liste/Widget)

``` Dart
bool includiAdmin = true;
// Aggiungi 'Admin' alla lista SOLO SE includiAdmin è true
var utenti = [
  'Mario',
  'Luigi',
  if (includiAdmin) 'Admin'
];
print(utenti); // Output: [Mario, Luigi, Admin]
```
___
# For
Ripete un blocco per un numero N di volte

``` Dart
for (int i = 1; i <= 3; i++) { 
	print("Conto: $i"); 
}
```

___
# For-In
Scorre ogni elemento in una collezione

``` Dart
var frutti = ['Mela', 'Banana', 'Arancia'];
for (var frutto in frutti) {
	print("Frutto: $frutto");
}
```

___
# While 
Ripete un blocco FINCHÉ una condizione è vera

``` Dart
int contatore = 3;
while (contatore > 0) {
	print("Contatore while: $contatore");
	contatore--; // Riduci il contatore per evitare un loop infinito
}
print("Partenza!");
```

___

# Try-Catch
Gestisce errori senza bloccare il programma

``` Dart
try {
// Codice che potrebbe generare un errore
print("Provo a dividere 10 per 0...");
int risultato = 10 ~/ 0; // Divisione intera per zero
print("Risultato: $risultato"); // Questa riga non sarà eseguita
} catch (e) {
// Blocco eseguito in caso di errore
print("Errore catturato! Non puoi dividere per zero.");
// 'e' contiene i dettagli dell'errore
// print(e); 
} finally {
// Blocco opzionale, eseguito SEMPRE (con o senza errore)
print("Controllo eccezioni terminato.");
}
```

___
# Switch
Controlla un valore contro diversi "casi" 

``` Dart
switch (stato) {
case "running":
  print("Il sistema è in esecuzione.");
  break; // Esce dallo switch
case "stopped":
  print("Il sistema è fermo.");
  break;
default: // Se nessun caso corrisponde
  print("Stato sconosciuto.");
}
```

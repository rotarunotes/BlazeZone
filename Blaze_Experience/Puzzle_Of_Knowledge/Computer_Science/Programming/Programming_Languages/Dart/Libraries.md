Data: 2025-10-21
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# 'darty:math'
## Classi:
### Random
- seve a generare numeri o valori **pseudo-casuali**
	- **.nextInt(int max)**: È la funzione più usata. Restituisce un numero intero casuale compreso tra **0 (incluso)** e **max (escluso)**.
	- **.nextDouble():** Restituisce un numero decimale double tra 0,0 (incluso) e 1,0(escluso).
	- **.nextBool()**: Restituisce true o false con la stessa probabilità.

``` Dart
import 'dart:math';

void main() {
  var rng = Random();
  
  int dadoDieciFacce = rng.nextInt(10); 
  print(dadoDieciFacce); // Es: 7
  
  double percentuale = rng.nextDouble(); 
  print(percentuale); // Es: 0.813...
  
  bool testaOCroce = rng.nextBool(); 
  print(testaOCroce); // Es: true
}
```
## Funzioni:
### sqrt()
- calcola la radice **quadrata** di un numero

``` Dart
double mysqrt = sqrt(number);
```

___
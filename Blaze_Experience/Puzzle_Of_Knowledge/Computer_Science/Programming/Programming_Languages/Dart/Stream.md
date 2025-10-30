Data: 2025-10-30
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Stream \<T\>
uno stream è una **sequenza di risultati.** È possibile rimanere in **ascolto** su uno stream per ricevere **notifiche** sui risultati (sia dati che errori) e sulla sua **chiusura**. È anche possibile mettere in **pausa** l'ascolto o **interromperlo** prima che sia completato.

Uno **stream** lo otteniamo mediante una **async* function**, detta anche **generator**, perché tale funzione **emetta** eventi usiamo **yield** (una sorta di **return** che non termina la funzione).
___
# Teoria
Il concetto è analogo a quello di **coroutine**,con **await for** loop consumiamo tali eventi, ovvero con Uno **stream** lo otteniamo mediante una **async* function**, li mandiamo ad altro **stream**. In alternativa, e più di frequente, uno **stream** viene ascoltato con **listen(),** i due approcci non sono però esattamente equivalenti (vedi esempi).

Uno **stream** lo otteniamo in vari modi

- mediante **generator**,
- mediante un costruttore della classe **Stream\<T>**,
- mediante **StreamController\<T>** e
- fornito dal pacchetto o libreria che stiamo usando.
## Costruttore Stream.periodic
Il costruttore **Stream.periodic** è un modo semplice e molto comune per creare uno stream che "ticchetta" a intervalli regolari, simile a un metronomo.

È ideale per simulare eventi che accadono nel tempo (es. un timer, un orologio, o un "tick" di gioco).

### Argomenti:
#### Duration period (Obbligatorio)

Questo è l'argomento più importante. È un oggetto Duration che definisce **quanto tempo aspettare tra un'emissione e l'altra**.
- Duration(seconds: 1): Emette un valore ogni **secondo**.
- Duration(milliseconds: 500): Emette un valore ogni mezzo **secondo**.
- Duration(minutes: 5): Emette un valore ogni 5 **minuti**.

**Nota importante:** Lo stream **aspetta** per questo **periodo** prima di emettere il **primo** valore.

[[#es001 Da Named Constructor|Esempio:]]

#### \[Funzione di Callback] (Opzionale)

Questo è il secondo argomento, indicato dalle parentesi quadre `[...]` come **opzionale**. È una **funzione di callback** che "calcola" quale valore emettere a ogni tick.

- Lo stream tiene un contatore interno  che parte da 0 e si incrementa a ogni intervallo (0, 1, 2, 3, 4...).

Quello che la tua funzione  **restituisce** (return) è il valore che viene **emesso** dallo stream.

[[#es001 Da Named Constructor|Esempio:]]

## Gestione Asincrona 
### await for(int value in stream) { ... }

- Questo è il **consumo** dello stream usando il loop **await for** (il metodo "bloccante" asincrono).
- Il programma ora si **"ferma"** su questa riga e aspetta.
- Ogni volta che lo **stream** (creato sopra) emette un valore, quel valore viene messo nella variabile **value** e il codice all'**interno** del loop viene eseguito.

[[#es001 Da Named Constructor|Esempio:]]

## Funzioni
### .listen
**.listen()** come a **iscriversi alle notifiche** di un canale.

1) **È il "Pulsante di Avvio":** È il metodo che "accende" la maggior parte degli stream. Senza .listen() (o **await for**), lo stream non parte e non produce dati.
2) **È Non-Bloccante:** Quando chiami **.listen()**, il codice **non si ferma** ad aspettare. Attacca l'ascoltatore e il resto del programma (il codice dopo **.listen()**) continua a essere eseguito immediatamente. Le stampe avverranno in background, non appena i dati arrivano.
3) **Gestisce Eventi:** Il suo scopo principale è gestire 3 tipi di "notifiche" (eventi) che uno stream può inviare, fornendo una funzione (callback) per ciascuno:
    - **onData** (l'unico che hai usato tu): "Cosa fare quando arriva un dato".
    - **onError**: "Cosa fare se lo stream ha un errore".
	- **onDone**: "Cosa fare quando lo stream si chiude e finisce".

In sintesi, **.listen()** è il metodo fondamentale per "agganciarsi" a uno stream e **reagire** ai suoi eventi (dati, errori, chiusura) in modo asincrono.

[[#es002 Da (function) Generator|Esempio:]]

___

# Dimostrazione
## es001 Da Named Constructor
``` Dart
main() async {
  Stream<int> stream 
    = Stream<int>.periodic(const Duration(seconds: 1), (i) => i * i);
  await for(int value in stream) {
    print(value);
    if (value > 100) break;
  }
}
```

**Output:**
```
0
1
4
9
16
25
36
49
64
81
100
121
```
 
 **Esecuzione:**
1) Crea uno stream che **emette il quadrato di un numero** (0, 1, 4, 9, 16...) **ogni secondo**.
2) Si mette in ascolto di questo stream.
3) Stampa ogni numero che riceve.
4) **Si ferma** (esce dal loop e termina) non appena riceve un numero maggiore di 100.

___
## es002 Da (function) Generator

``` Dart
void main() {
  Stream<int> stream = timedCounter(Duration(seconds: 1), 10);
  stream.listen((data) => print('yeld: $data'));
}

Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}
```

**Output:**
```
yeld: 0 
yeld: 1 
yeld: 2 
yeld: 3 
yeld: 4 
yeld: 5 
yeld: 6 
yeld: 7 
yeld: 8 
yeld: 9
```

**Esecuzione:**
1) **timedCounter (Funzione async)**: È un **generatore di Stream**. Il suo compito è **emettere (yield)** un numero (i) ogni secondo (await Future.delayed). Si ferma da solo (break) quando il contatore raggiunge maxCount (10).
2) **main (Funzione consumatore)**: Avvia (**.listen()**) lo stream e **stampa** ogni numero (yeld: 0, yeld: 1, ...) non appena lo riceve.
In pratica: il codice stampa i numeri da 0 a 9, uno al secondo, e poi termina.

**Alternativa await for**
``` Dart
// Aggiungiamo 'async' qui
void main() async {
  Stream<int> stream = timedCounter(Duration(seconds: 1), 10);

  print("Sto per entrare nel loop 'await for' (bloccante)...");

  // 2. Sostituiamo .listen() con il loop await for
  await for (int data in stream) {
    print('Ricevuto: $data');
  }
  
  // 3. Questa riga ora aspetta che lo stream sia finito!
  print("Loop 'await for' completato. Programma terminato.");
}
```
(Data: 2025-10-30
[Dart](README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Stream \<T\>
uno stream è una **sequenza di risultati.** È possibile rimanere in **ascolto** su uno stream per ricevere **notifiche** sui risultati (sia dati che errori) e sulla sua **chiusura**. È anche possibile mettere in **pausa** l'ascolto o **interromperlo** prima che sia completato.

Uno **stream** lo otteniamo mediante una **async* function**, detta anche **generator**, perché tale funzione **emetta** eventi usiamo **yield** (una sorta di **return** che non termina la funzione).

## Gestione dello Stream
| **Caratteristica**         | [[#.listen]]                      | [[#await for() { ... }]]                 | [[#.forEach]]                                                 |
| -------------------------- | --------------------------------- | ---------------------------------------- | ------------------------------------------------------------- |
| **Cosa restituisce?**      | StreamSubscription                | N/A (è un costrutto di loop)             | Future\<void>                                                 |
| **Flusso del codice**      | **Non Bloccante**                 | **Bloccante Asincrono**                  | **Non Bloccante** (a meno che non si usi await)               |
| **Controllo (Pausa/Stop)** | **Sì** (.pause(),     .cancel())  | **Parziale** (puoi usare break e return) | **No**                                                        |
| **Gestione Eventi**        | onData, onError, onDone           | Solo onData (il corpo del loop)          | Solo onData (la callback)                                     |
| **Gestione Errori**        | Parametro onError                 | Blocco try...catch                       | Sul Future restituito (es. .catchError o try..catch se await) |
| **Uso ideale**             | Stream infiniti, controllo totale | Stream finiti, logica sequenziale        | Stream finiti, processare tutto                               |

___
# Teoria
Il concetto è analogo a quello di **coroutine**,con **await for** loop consumiamo tali eventi, ovvero con Uno **stream** lo otteniamo mediante una **async* function**, li mandiamo ad altro **stream**. In alternativa, e più di frequente, uno **stream** viene ascoltato con **listen(),** i due approcci non sono però esattamente equivalenti (vedi esempi).

Uno **stream** lo otteniamo in vari modi

- mediante **generator**,
- mediante un costruttore della classe **Stream\<T>**,
- mediante **StreamController\<T>** e
- fornito dal pacchetto o libreria che stiamo usando.

## Yield
È come un return che **non esce dalla funzione**. Emette un singolo valore e mette in pausa la funzione fino a quando non viene richiesto il valore successivo.
**yield*:** È un modo per dire di prendere tutti i valori di quest' stream (o Iterable) e mettili nel mio, uno alla volta, finché non ha finito.

## Costruttore col Nome:
### Stream.periodic
Il costruttore **Stream.periodic** è un modo semplice e molto comune per creare uno stream che "ticchetta" a intervalli regolari, simile a un metronomo.

È ideale per simulare eventi che accadono nel tempo (es. un timer, un orologio, o un "tick" di gioco).

**Argomenti:**
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

### Stream.fromIterable
è un **costruttore con nome** (named constructor) della classe Stream.

Il suo scopo è creare un nuovo stream che emette **ciascun elemento** della collezione (tecnicamente, un Iterable, come la List) che gli passi come argomento, uno dopo l'altro, e **poi si chiude**.

Lo stream rilascia **immediatamente**, ciascun elemento della **collezione** ,senza alcuna pausa temporale **predefinita**.

[[#es003 Named Constructor|Esempio:]]

## StreamController
È l'oggetto che ti permette di **creare e controllare manualmente** uno stream. Ti dà due cose:

1) **Il sink (L'INPUT):** È l'imbuto. Il .sink è un oggetto (chiamato EventSink) che ha i metodi per "nutrire" lo stream.
	- **.sink.add(123);** (Versa il dato 123 nell'imbuto)
	- **.sink.addError('ops');** (Versa un errore nell'imbuto
	- **.sink.close();** (Chiude il rubinetto. Lo stream invierà onDone)
    
2) **Lo stream (L'OUTPUT):** È il tubo. È la parte che "dai" agli altri, che la useranno per ascoltare i dati (controller.stream.listen(...)).

In pratica: tu controlli il rubinetto (sink), gli altri ricevono l'acqua (stream).

``` Dart
final streamController = StreamController(
  onPause: () => print('Paused'),
  onResume: () => print('Resumed'),
  onCancel: () => print('Cancelled'),
  onListen: () => print('Listens'),
);

streamController.stream.listen(
  (event) => print('Event: $event'),
  onDone: () => print('Done'),
  onError: (error) => print(error),
);
```

[[#es010 StreamController|Esempio:]]

## Broadcast Stream
Quando creiamo uno Stream, **di default è unicast**: È un flusso che può essere ascoltato da un solo **listener** alla volta.  

Invece uno **stream broadcast** in Dart è uno stream che può avere **più**  listener **contemporaneamente**:
- ogni evento emesso dallo stream viene **inviato a tutti i listener** attivi;
- i listener che si iscrivono **dopo** l’emissione di un evento **non ricevono** gli eventi passati (solo i successivi).

[[#es014 Broadcast Stream|Esempio:]]

## Streamsubscription
Una StreamSubscription (sottoscrizione a uno stream) è l'oggetto che ottieni quando chiami il metodo **.listen()** su uno stream.

Non rappresenta i dati, ma la connessione che hai stabilito con lo stream. Ti permette di:

1) **Mettere in pausa:** subscription.pause()
    - Smette temporaneamente di ricevere dati.    
2) **Riprendere:** subscription.resume()
    - Ricomincia a ricevere dati da dove avevi interrotto.    
3) **Annullare:** subscription.cancel()
    - **Fondamentale:** Chiude permanentemente la connessione e smette di ascoltare. Questo è essenziale per liberare la memoria ed evitare memory leak quando non ti servono più i dati (ad esempio, quando un widget viene distrutto).

[[#es016 Lo Streamsubscription|Esempio:]]
## Gestione Asincrona 
### await for() { ... }

È un costrutto del linguaggio Dart che ti permette di **consumare uno Stream in modo sequenziale**, simile a come un loop for consuma una List, ma in modo **asincrono**.

- **Bloccante Asincrono:** È la sua definizione principale.
    - **"Bloccante":** Blocca l'esecuzione del codice all'interno della tua funzione. Il codice dopo il loop await for non viene eseguito finché il loop non è terminato.
    - **"Asincrono":** Non blocca l'applicazione (l'interfaccia utente o altri task). Mentre la tua funzione è in pausa in attesa di dati, il resto del programma continua a funzionare.
- **Attesa Passiva:** La tua funzione si "mette in pausa" (await) e aspetta che lo stream emetta un valore. Quando il valore arriva, il codice dentro il loop viene eseguito, e poi la funzione torna in pausa ad aspettare il valore successivo.

- **Chiusura Automatica:** Il loop termina da solo, automaticamente, quando lo stream si chiude (invia l'evento "done"). Non devi gestire **onDone** o cancellare una sottoscrizione manualmente.

[[#es001 Da Named Constructor|Esempio:]]

## Funzioni
### .listen
**.listen()** come a **iscriversi alle notifiche** di un canale.

1) **È il "Pulsante di Avvio":** È il metodo che "accende" la maggior parte degli stream. Senza .listen() (o **await for**), lo stream non parte e non produce dati.
2) **È Non-Bloccante:** Quando chiami **.listen()**, il codice **non si ferma** ad aspettare. Attacca l'ascoltatore e il resto del programma (il codice dopo **.listen()**) continua a essere eseguito immediatamente. Le stampe avverranno in background, non appena i dati arrivano.
3) **Gestisce Eventi:** Il suo scopo principale è gestire 3 tipi di "notifiche" (eventi) che uno stream può inviare, fornendo una funzione (callback) per ciascuno:
    - **onData** : "Cosa fare quando arriva un dato".
    - **onError**: "Cosa fare se lo stream ha un errore".
	- **onDone**: "Cosa fare quando lo stream si chiude e finisce".

[[#es002 Da (function) Generator|Esempio:]]

### .forEach
**.forEach()** è un altro "consumatore" di stream, simile a **.listen** e **await for**, ma con uno scopo specifico.

1) **Cosa fa:** Prende una singola funzione (callback) e la esegue per ogni dato (onData) emesso dallo stream.
2) **Cosa restituisce:** Restituisce un **Future\<void>**.
3) Questo Future si completa **solo quando lo stream si chiude** (evento onDone). Se lo stream emette un errore, il Future si completa con quell'errore.

**È Asincrono:** L'operazione di scorrere tutti gli elementi di uno stream non è istantanea. Potrebbe richiedere secondi o minuti (pensa a uno stream che emette un dato ogni 10 secondi).  Se stream.forEach non restituisse nulla), tu lo avvieresti e... non avresti **nessun modo di sapere quando ha finito** o se ha fallito, ecco a cosa serve che restituisca un **Future**.

Non ti dà un **StreamSubscription**, quindi non puoi metterlo in pausa o cancellarlo. È un "consumatore" semplice.

[[#007 For Each|Esempio:]]

### .take
In Dart, **.take(N)** applicato a uno stream:
- **Prende i primi N dati** emessi dallo stream.
- **Ignora il resto**: Non appena ha ricevuto N dati, cancella l'abbonamento allo stream originale.
- **Chiude lo stream**: Invia un evento "done" (chiusura) subito dopo l'N-esimo dato.

[[#008 Selezione ed Approccio funzionale alla creazione di uno stream|Esempio:]]

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

  // Sostituiamo .listen() con il loop await for
  await for (int data in stream) {
    print('Ricevuto: $data');
  }
  
  // Questa riga ora aspetta che lo stream sia finito!
  print("Loop 'await for' completato. Programma terminato.");
}
```

## es003 Named Constructor

``` Dart
Stream<String> stream = 
  new Stream<String>.fromIterable(['fante', 'cavallo', 're']);

main() {
  print('Before');
  stream.listen((s) { print(s); });
  print('After');
}
```

**Output:**
```
Before 
After 
fante 
cavallo 
re
```

**Alternativa await for:**
``` Dart
print('BEFORE');
await for(String s in stream) { print(s); }
print('AFTER');  
```

**Output:**
```
BEFORE 
fante 
cavallo 
re 
AFTER
```

## es004 Stream Da Una Collezione di Future

``` Dart
void main() {
  List<Future<int>> futures = <Future<int>>[];
  
  for (int i = 1; i <= 10; i++) {
    futures.add(getNumberDelayed(i));
  }
  
  Stream<int> stream = streamFromFutures(futures);
  
  stream.listen( (data) => print('yeld: $data'), 
  onDone: (() => print('done')) );
}

Future<int> getNumberDelayed(int i) =>
    Future.delayed(Duration(seconds: i), () => i);

// passing an iterable
Stream<T> streamFromFutures<T>(Iterable<Future<T>> futures) async* {
  for (var future in futures) {
    var result = await future;
    yield result;
  }
}
```

**Output:**
```
yeld: 1 
yeld: 2 
yeld: 3 
yeld: 4 
yeld: 5 
yeld: 6 
yeld: 7 
yeld: 8 
yeld: 9 
yeld: 10 
done
```

**Esecuzione:**
1) **Avvia 10 timer (Futures) in parallelo**: il primo dura 1 secondo (restituisce 1), il secondo 2 secondi (restituisce 2), e così via fino a 10 secondi.
2) **Crea uno Stream (async*)** che riceve questa lista di timer.
3) Lo Stream li attende (await) **uno alla volta, in ordine sequenziale**.
4) **Risultato:** Anche se i timer sono partiti tutti insieme, lo stream li "sblocca" uno al secondo. Il codice stampa `yeld: 1` (dopo 1 sec), `yeld: 2` (dopo 1 altro sec), `yeld: 3` (dopo 1 altro sec), fino a `yeld: 10`.
5) Infine, stampa `done`. L'intero processo dura 10 secondi.

**Domande:**
- Confrontare con `await for`
	Entrambi ottengono lo stesso identico output (`yeld: 1`, `yeld: 2`, ... `done`). La differenza è il **flusso**: `.listen` non blocca la funzione, `await for` la mette in pausa finché lo stream non è completo.

- Uno stream può essere sostituito da una "raffica" di future?
	**No, non sono la stessa cosa, ma sono strettamente correlati.**
	- Una **"Raffica di Future"** (`List<Future<T>>`) è una collezione statica di promesse. Sai quante sono.
	- Uno `Stream<T>` è una sequenza dinamica di eventi nel tempo. Potrebbe essere infinita (come `Stream.periodic`).

## es005 Done Event
``` Dart
void main() {
  Stream<int> stream = timedCounter(Duration(seconds: 5), 10);
  stream.listen(
    (data) => print('yeld: $data'),
    onDone: () => print('xe finia'),
  );
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
xe finia
```

**Esecuzione:**
Questo codice stampa un numero **ogni 5 secondi**, partendo da `0` e arrivando fino a `9`.

Dopo aver stampato `yeld: 9` (al secondo 50), il `break` interrompe il ciclo, lo stream si chiude e il programma stampa `xe finia`.

**Domande:**
- l'evento `onDone` quando ha luogo? Come viene gestito in `listen(...)`?
	L'evento `onDone` ha luogo **quando lo stream si chiude**.
	Nel tuo codice, questo accade **immediatamente dopo che l'ultimo valore (`9`) è stato emesso (`yield`)**.

## eso06 Errori da Stream

``` Dart
void main() {
  Stream<int> stream = timedCounter(Duration(seconds: 1), 10);
  stream.listen((data) => print('yeld: $data'), onError: (e) => print(e));
}

Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == 4) throw Exception('go sbajà');
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
Exception: go sbajà
```

## 007 For Each

``` Dart
void main() {
  timedCounter(Duration(seconds: 1), 10).handleError((e) {
    print(e.toString());
  }).forEach((data) => print('yeld: $data'));
}

Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
    if (i == 4) throw Exception('go sbaja');
  }
}
```

**Esempio:**
```
yeld: 0 
yeld: 1 
yeld: 2 
yeld: 3 
Exception: go sbaja
```

## 008 Selezione ed Approccio funzionale alla creazione di uno stream

``` Dart
void main() {
  Stream.periodic(const Duration(seconds: 1), (count) {
    if (count == 2) {
      throw Exception('Exceptional event');
    }
    return count;
  }).take(4).handleError(print).forEach(print);
}
```
 
 **Output:**
``` 
0 
1 
Exception: Exceptional event 
3 
4
```

**Esecuzione:**
`.take(4)` è un metodo che **"prende" i primi 4 eventi di _dati_** dallo stream originale e poi chiude lo stream.

Ecco cosa fa nel dettaglio:
1. Si mette in ascolto dello stream `Stream.periodic`.
2. Lascia passare i primi 4 dati che arrivano (gli errori non contano in questo "conteggio").
3. Non appena il 4° evento di dati è passato, `.take(4)` fa due cose:
    - **Cancella l'abbonamento** allo stream originale (`Stream.periodic`), fermandolo.
    - **Invia un evento "done"** (chiusura) al resto della catena (a `.handleError` e `.forEach`).

Nel tuo codice, l'esecuzione sarà:
1) `t=0`: Emette `0`. (`.forEach` stampa `0`) - (1° dato preso)
2) `t=1`: Emette `1`. (`.forEach` stampa `1`) - (2° dato preso)
3) `t=2`: Lancia `Exception`. (`.handleError` stampa l'errore) - (Errore, non conta come dato)
4) `t=3`: Emette `3`. (`.forEach` stampa `3`) - (3° dato preso)
5) `t=4`: Emette `4`. (`.forEach` stampa `4`) - (4° dato preso)
6) **STOP**: `.take(4)` ha ricevuto 4 dati. Ora chiude lo stream. `Stream.periodic` viene fermato. Il `Future` di `.forEach` si completa.

## es009 Approccio Ricorsivo
``` Dart
void main() {
  Stream<int> stream = timer(10);
  stream.listen((data) => print('yeld: $data'));
}

Stream<int> timer(int n) async* {
  if (n > 0) {
    await Future.delayed(Duration(seconds: 1));
    yield n;
    yield* timer(n - 1);
  }
}
```

**Output:**
```
yeld: 10 
yeld: 9 
yeld: 8 
yeld: 7 
yeld: 6 
yeld: 5 
yeld: 4 
yeld: 3 
yeld: 2 
yeld: 1
```

**Esecuzione:**
Mentre `yield` emette un **singolo valore**, `yield*` emette un'**intera sequenza** (un altro `Stream`).
Nel tuo codice, `yield* timer(n - 1);` è il motore della **ricorsione**:
1. `main` chiama `timer(10)`.
2. **`timer(10)`**:
    - Aspetta 1 secondo.
    - Emette (`yield`) il valore `10`.
    - Poi, con `yield* timer(9)`, dice: "Ora, collega l'intero stream `timer(9)` qui e inoltra tutto ciò che fa".
3. **`timer(9)`**:
    - Aspetta 1 secondo.
    - Emette (`yield`) il valore `9`.
    - Poi, con `yield* timer(8)`, collega lo stream `timer(8)`.
4. ...e così via, fino a `timer(1)`.
5. **`timer(1)`**:
    - Aspetta 1 secondo.
    - Emette (`yield`) il valore `1`.
    - Chiama `yield* timer(0)`.
6. **`timer(0)`**:
    - La condizione `if (n > 0)` è falsa.
    - La funzione termina, chiudendo il suo stream (vuoto).
    - Questo "sblocca" la chiusura a catena di tutti gli stream.

Il risultato è un unico stream che emette `10`, `9`, `8`, `7`, `6`, `5`, `4`, `3`, `2`, `1`, uno al secondo.

## es010 StreamController
``` Dart
import 'dart:async';

void main() async {
  // final StreamController<dynamic>
  final StreamController ctrl = StreamController();

  final Stream stream = ctrl.stream;
  stream.listen((data) => print('$data'), onDone: () => print("done"));

  ctrl.sink.add('my name');
  await Future.delayed(Duration(seconds: 2), 
	  () => ctrl.sink.add(1234));
  await Future.delayed(Duration(seconds: 2),
      () => ctrl.sink.add({'a': 'element A', 'b': 'element B'}));
  await Future.delayed(Duration(seconds: 2), 
	  () => ctrl.sink.add(123.45));
	  
  ctrl.close();
}
```

**Output:**
```
my name 
//aspetta 2 secondi
1234 
//aspetta 2 secondi
{a: element A, b: element B} 
//aspetta 2 secondi
123.45 
done
```

**Esecuzione:**
1) **Creazione del Gestore:** Viene creato un `StreamController` (`ctrl`). Pensa a questo come al "rubinetto" che userai per controllare il flusso dei dati.
2) **Ottenere l'Output:** Si ottiene lo `Stream` (`ctrl.stream`) dal controller. Questa è la parte "output" (il "tubo") che viene data a chiunque voglia ricevere i dati.
3) **Attivare l'Ascolto:** Si avvia un ascoltatore (`.listen`) sullo `stream`. Questo è il "secchio" messo sotto il tubo. Da ora in poi, stamperà qualsiasi dato (`onData`) che esce e stamperà "done" non appena il tubo verrà chiuso (`onDone`).
4) **Aggiungere Dati (Input):** Usando il "lato input" del controller (`ctrl.sink`), si iniziano ad aggiungere (`.add`) dati. Il `listen` li riceve e li stampa:
    - `'my name'` viene aggiunto e stampato subito.
    - Il codice aspetta 2 secondi, poi aggiunge e stampa `1234`.
    - Il codice aspetta altri 2 secondi, poi aggiunge e stampa la mappa.
    - Il codice aspetta altri 2 secondi, poi aggiunge e stampa `123.45`.
5) **Chiusura:** Dopo un totale di 6 secondi, `ctrl.close()` chiude il rubinetto. Questo invia l'evento `onDone` al `listen`, che esegue la sua ultima azione stampando "done".

**Domande:**
- **Perché ascoltare prima di aggiungere?** Perché lo stream, di default, non ha memoria. Se chiami `.add()` (apri il rubinetto) prima di `.listen()` (mettere il secchio), i dati vengono persi.
- **Perché lo `StreamController` è `dynamic`?** Perché non hai specificato un tipo (es. `StreamController<String>()`). Quando il tipo non è specificato, Dart usa `dynamic`, che permette allo stream di trasportare qualsiasi tipo di dato.
- **Cosa succede senza `ctrl.close()`?** Il programma **non finirà mai**. La callback `onDone` (che stampa "done") non verrà mai chiamata e l'applicazione rimarrà "appesa" perché l'ascolto è ancora attivo.
- **`sink` sincrono vs asincrono**
    - **Asincrono (Default):** Chiamare `.sink.add("ciao")` schedula l'invio. Il codice dopo `.add()` viene eseguito prima_ che il `.listen` riceva "ciao".
    - **Sincrono (`sync: true`):** Chiamare `.sink.add("ciao")` interrompe il codice ed esegue il `.listen` immediatamente. Il codice dopo `.add()` viene eseguito dopo che il `.listen` ha ricevuto "ciao".

## es011 Eventi Di Uno Stream

``` Dart
import 'dart:async';

void main() async {
  final StreamController ctrl = StreamController();
  final Stream stream = ctrl.stream;
  
  stream.listen((data) => 
	  print('$data'),
      onDone: () => print("done"), 
      onError: (e) => print(e));
      
  ctrl.sink.add('my name');
  
  await Future.delayed(Duration(seconds: 2), 
	  () => ctrl.sink.add(1234));
  await Future.delayed(Duration(seconds: 2), 
      () => ctrl.sink.addError("an error occured"));
  await Future.delayed(Duration(seconds: 2),
      () => ctrl.sink.add({'a': 'element A', 'b': 'element B'}));
  await Future.delayed(Duration(seconds: 2), 
	  () => ctrl.sink.add(123.45));
	  
  ctrl.close();
}
```

**Output:**
```
my name 
1234 
an error occured 
{a: element A, b: element B} 
123.45 
done
```

## es012 Stream da Iterable

``` Dart
void main() async {
  var data = <int>[1, 3, 4, 5, 11, 666];
  var stream = Stream.fromIterable(data); 
  stream.listen((value) {
    print("Received: $value"); 
  }); 
}
```

**Output:**
``` 
Received: 1 
Received: 3 
Received: 4 
Received: 5 
Received: 11 
Received: 666
```

## es013 Trasformazione

``` Dart
void main() async {
  Stream<int> stream =
      Stream<int>.periodic(const Duration(seconds: 1), transform);
  stream = stream.take(5);
  await for (int i in stream) {
    print(i);
  }
}

int transform(int x) {
  return (x + 1) * 2;
}
```

**Output:**
```
2 
4 
6 
8 
10
```

**Esecuzione:**
1) Il programma si avvia e il loop si mette in attesa.
2) **Dopo circa 1 secondo:** `periodic` genera `0`, `transform` lo converte in `2`. Lo stream emette `2`. Il loop assegna `2` alla variabile `i` e `print(i)` stampa **2**.
3) **Dopo un altro secondo:** `periodic` genera `1`, `transform` lo converte in `4`. Lo stream emette `4`. Il loop stampa **4**.
4) **Dopo un altro secondo:** `periodic` genera `2`, `transform` lo converte in `6`. Lo stream emette `6`. Il loop stampa **6**.
5) **Dopo un altro secondo:** `periodic` genera `3`, `transform` lo converte in `8`. Lo stream emette `8`. Il loop stampa **8**.
6) **Dopo un altro secondo:** `periodic` genera `4`, `transform` lo converte in `10`. Lo stream emette `10`. Il loop stampa **10**.
7) **Fine:** A questo punto, lo stream ha emesso 5 valori. L'operatore `.take(5)` interviene, chiude lo stream e segnala al loop `await for` che non arriveranno altri dati. Il loop termina e il programma si conclude.

**Alternativa:**
``` Dart
void main() async {
	final stream =
	    Stream<int>.periodic(const Duration(seconds: 1), (count) => count)
	        .take(5);
	
	final calculationStream =
	    stream.map<String>((event) => 'Square: ${event * event}');
	calculationStream.forEach(print);
	
}
```

**Output:**
```
Square: 0 
Square: 1 
Square: 4 
Square: 9  
Square: 16 
```

**Esecuzione:**
1) `calculationStream.forEach(print);`: Questa è la riga che "accende i motori".
2) `.forEach` si **iscrive** (si mette in ascolto) a `calculationStream`. È solo in questo momento che lo stream sorgente (`stream`) inizia effettivamente a emettere i suoi valori.
3) Ogni volta che `calculationStream` emette una delle stringhe trasformate, la funzione `print` viene eseguita con quella stringa.
4) Dopo che il quinto elemento (`'Square: 16'`) è stato ricevuto e stampato, lo stream sorgente si chiude (a causa di `.take(5)`),

## es014 Broadcast Stream

``` Dart
import 'dart:async';

StreamController<String> streamController = StreamController.broadcast();

void main() {
  print("Listening a StreamController...");
  
  streamController.stream.listen((data) {
    print("DataReceived1: $data");
  }, onDone: () {
    print("Task Done1");
  }, onError: (error) {
    print("Some Error1");
  });
  
  streamController.stream.listen((data) {
    print("DataReceived2: $data");
  }, onDone: () {
    print("Task Done2");
  }, onError: (error) {
    print("Some Error2");
  });
  
  streamController.add("data 1");
  streamController.add("data 2");
  print("ciao");
  print("code controller is here");
}
```

**Output:**
```
Listening a StreamController... 
ciao 
code controller is here 
DataReceived1: data 1 
DataReceived2: data 1 
DataReceived1: data 2 
DataReceived2: data 2
```

**Esecuzione:**
Viene stampato "ciao" e "code controller is here" per **prima** perchè sono operazioni sincrone, anche se **aggiungiamo** i dati prima della loro stampa.

## es015 Broadcast Stream

``` Dart
import 'dart:async';

int transform(int x) => (x + 1) * 2;

void main() {
  print("Creating a StreamController...");
  
  StreamController<int> streamController = StreamController.broadcast();
  
  Stream<int> stream =
      Stream<int>.periodic(const Duration(seconds: 1), transform);
  stream = stream.take(5);
  
  //streamController.addStream(stream);
  streamController.stream.listen((data) {
    print("DataReceived1: $data");
  }, onDone: () {
    print("Task Done1");
  }, onError: (error) {
    print("Some Error1");
  });
  
  streamController.stream.listen((data) {
    print("DataReceived2: $data");
  }, onDone: () {
    print("Task Done2");
  }, onError: (error) {
    print("Some Error2");
  });
  
  streamController.addStream(stream);
  
  print("code controller is here");
}
```

**Output:**
```
Creating a StreamController... 
code controller is here 
DataReceived1: 2 
DataReceived2: 2 
DataReceived1: 4 
DataReceived2: 4 
DataReceived1: 6 
DataReceived2: 6 
DataReceived1: 8 
DataReceived2: 8 
DataReceived1: 10 
DataReceived2: 10
```

**Esecuzione:**
1) **Setup:** Crei un controller di stream **broadcast**, che permette a più "ascoltatori" di connettersi.
2) **Listener:** Registri **due listener** (DataReceived1, DataReceived2) che si mettono in ascolto sul controller.
3) **Stream Sorgente:** Definisci uno stream separato che genera 5 numeri (2, 4, 6, 8, 10), uno al secondo.
4) **Collegamento:** Usi `addStream` per "collegare" lo stream sorgente al controller.
5) **Esecuzione:** Il controller riceve i numeri dallo stream sorgente (2, 4, 6...) e li "trasmette" (broadcast) a entrambi i listener contemporaneamente.
6) **Chiusura:** Dopo il quinto numero (10), lo stream sorgente si chiude. Questo invia un segnale "Done" al controller, che a sua volta lo notifica a entrambi i listener (Task Done1, Task Done2).

**Domande:**
-  e se lo stream fosse aggiunto ove commentato?
	- Non cambiava niente
- confrontare per il `Sink` i metodi `add()` e `addSTream()`
	- Non cambia nulla

## es016 Lo Streamsubscription 
``` Dart
import 'dart:async';

void main() {
  late StreamSubscription sub;
  sub = Stream<int>.periodic(const Duration(seconds: 1), (value) => value + 1)
      .take(20)
      .listen((data) async {
		print('recieved: $data');
		if (data == 10) {
		  sub.pause();
		  await Future.delayed(const Duration(seconds: 2));
		  print('fire');
		  sub.resume();
	    }
	  },onDone: () {
	    print("FINE");
	  });
}
```

**Output:**
```
recieved: 1 
recieved: 2 
recieved: 3 
recieved: 4 
recieved: 5 
recieved: 6 
recieved: 7 
recieved: 8 
recieved: 9 
recieved: 10 
// aspetta 2 secondi (Future)
fire 
recieved: 11 
recieved: 12 
recieved: 13 
recieved: 14 
recieved: 15 
recieved: 16 
recieved: 17 
recieved: 18 
recieved: 19 
recieved: 20 
FINE
```

**Domande:**
- per quale motivo la dichiarazione con `late` senza inizializzare la subscription?
	- Perché la variabile `sub` (la subscription) **deve essere usata all'interno della callback** di `.listen()` (per poter chiamare `sub.pause()`), ma **ottiene il suo valore** solo dopo che `.listen()` è stato chiamato (è il valore di ritorno di `.listen()` stesso).

- cosa accade agli eventi quando la subscription è in pausa?
	- Il stream.periodic continua a generare i numeri (11 e 12 durante i 2 secondi di pausa) ,`StreamSubscription` li "trattiene" in un buffer interno. Appena chiami `sub.resume()`, la subscription "svuota la coda" e invia immediatamente tutti gli eventi accumulati (`11`, `12`) al tuo listener, prima di ricominciare a ricevere quelli nuovi (`13`, `14`...) al ritmo di uno al secondo.

- cosa rappresenta una subscription nel design pattern dell'observer?
	- **Subject (Soggetto):** È lo `Stream`.
	- **Observer (Osservatore):** Sono le funzioni di callback che passi a `.listen()` (la funzione `(data) => ...`, `onDone`, `onError`).
	- La `StreamSubscription` è **l'oggetto che rappresenta la connessione stessa** tra il Subject e l'Observer. È il "contratto" che l'Observer riceve e che può usare per gestire la connessione (mettendola in pausa o annullandola con `cancel()`).
## es017 Argument in pause

``` Dart
import 'dart:async';

void main() {
  late StreamSubscription sub;
  sub = Stream<int>.periodic(const Duration(seconds: 1), (value) => value + 1)
      .take(20)
      .listen((data) {
    print('recieved: $data');
    if (data == 10) {
      sub.pause(
          Future.delayed(const Duration(seconds: 2), () => print('fire'))
	  );
    }
  }, onDone: () {
    print("FINE");
  });
}
```

**Output:**
```
recieved: 1 
recieved: 2 
recieved: 3 
recieved: 4 
recieved: 5 
recieved: 6 
recieved: 7 
recieved: 8 
recieved: 9 
recieved: 10 
// aspetta 2 secondi (Future)
fire 
recieved: 11 
recieved: 12 
recieved: 13 
recieved: 14 
recieved: 15 
recieved: 16 
recieved: 17 
recieved: 18 
recieved: 19 
recieved: 20 
FINE
```

**Domande:**
- Dove accade il resume?
-
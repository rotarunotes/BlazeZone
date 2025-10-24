# FUTURE

## es001: Un Primo Esempio

```dart
void main() async {
  int x = await number(5);
  print(x);
  print('after received');
}

Future<int> number(int n) {
  return Future.delayed(const Duration(seconds: 5), () => n);
}
```

**Funzionamento:**
  
1. `main` inizia.
2. La chiamata a `number(5)` inizia un'attesa di 5 secondi e ritorna un `Future<int>`.
3. `await` sospende l'esecuzione di `main` (senza bloccare l'applicazione) e l'event loop può eseguire altre cose.
4. Dopo 5 secondi, il `Future` si completa con il valore `5`
5. L'esecuzione di `main` riprende: `x` è assegnato a `5`, `print(5)` viene eseguito, seguito da `print('after received')`.

| Modifica                        | Esito                                              | Ragione                                                                                                     |
| :------------------------------ | :------------------------------------------------- | :---------------------------------------------------------------------------------------------------------- |
| **Elimina `async`** (da `main`) | Errore di compilazione.                            | `await` può essere usato solo in funzioni marcate come `async`.                                             |
| **Elimina `await`**             | Errore di tipo in fase di esecuzione/compilazione. | Si tenta di assegnare un `Future<int>` (il risultato immediato di `number(5)`) a una variabile `int` (`x`). |
| **Elimina `async` e `await`**   | Errore di tipo.                                    | Stesso errore del caso precedente: tentativo di assegnare un `Future` a un `int`.                           |
|                                 |                                                    |                                                                                                             |

-----

## es002: La Clausola `then`

```dart
void main() {
  print("START");
  Future.delayed(const Duration(seconds: 0), () {
    print("from callback");
    return 666;
  }).then((value) {
    print(value);
  });
  print("STOP");
}
```

**Esecuzione:**

1. Stampa **`START`** (sincrono).
2. `Future.delayed` (con durata 0) programma un evento. L'esecuzione continua immediatamente.
3. Stampa **`STOP`** (sincrono).
4. L'event loop gestisce l'evento: esegue la prima callback, stampa **`from callback`**, ritorna `666`.
5. Il `Future` si completa, il `.then()` viene eseguito, stampa **`666`**.

**Output:** `START`, `STOP`, `from callback`, `666`.

| Domanda | Risposta |
| :--- | :--- |
| **Come mai manca `async`?** | La funzione `main` non ha bisogno di essere `async` perché non utilizza la parola chiave **`await`**. L'operazione asincrona e la gestione del suo risultato sono gestite interamente dal metodo a catena **`.then()`**. |
| **Differenze con es001?** | `es001` usa **`async/await`** per un approccio **sequenziale (stile sincrono)** alla gestione asincrona. `es002` usa **`.then()`** per un approccio **basato su callback** per gestire il risultato del `Future`. L'uso di `.then()` non richiede che la funzione contenitrice sia `async`. |

-----

## es003: Go On (Parallelismo Asincrono)

```dart
void main() {
  printDelayed(5); // Inizia attesa 5s
  printDelayed(3); // Inizia attesa 3s
  print('Go go go'); // Esecuzione sincrona
}

Future<void> printDelayed(int s) async {
  Future.delayed(Duration(seconds: s), () => print('after $s seconds')); // Nessun await
}
```

**Commento sull'esecuzione:**

1. `main` è sincrono (non ha `async/await`).
2. `printDelayed(5)` e `printDelayed(3)` vengono chiamate. Poiché **non c'è `await`** all'interno di `printDelayed`, le due chiamate a `Future.delayed` *programmano* i loro rispettivi eventi nell'event queue e **ritornano immediatamente** (prima che i timer scadano).
3. `print('Go go go')` viene eseguito subito dopo.
4. L'event loop gestisce i timer: dopo 3s stampa `'after 3 seconds'`, dopo 5s stampa `'after 5 seconds'`.

**Output (Ordine):** `'Go go go'`, `'after 3 seconds'`, `'after 5 seconds'`.

| Modifica/Domanda | Risposta |
| :--- | :--- |
| **Sostituisci il tipo di ritorno con `void`** | Se si forza il tipo di ritorno a `void`, si ottiene un errore perché una funzione `async` *deve* ritornare un `Future`. |
| **Tipo di ritorno di una computazione asincrona?** | È sempre un **`Future<T>`**, `T` è il tipo del valore che la funzione è destinata a restituire. **`Future<void>`** se la funzione non restituisce nulla. |
| **Tempi uguali (es. 3s e 3s)?** | Se i tempi sono uguali, le chiamate all'interno dell'event queue verranno eseguite nell'ordine in cui sono state programmate. |

-----

## es004: Go On (Sincronizzazione Interna)

```dart
void main() {
  printDelayed(3);
  print('Go go go');
}

void printDelayed(int s) async {
  await Future.delayed(Duration(seconds: s), () => print('after $s seconds'));
}
```

**Perché in `main` non appare `async`?**

- La funzione `main` **non usa `await`**.
- La chiamata a `printDelayed(3)` è asincrona, ma **non bloccante** per `main`. `printDelayed` inizia la sua esecuzione, incontra `await`, sospende la sua *propria* esecuzione e ritorna un `Future<void>` a `main`.
- `main` prosegue immediatamente con la stampa di `'Go go go'`. L'output sarà `'Go go go'`, seguito dopo 3 secondi da `'after 3 seconds'`.

-----

## es005: Un Esempio Più Complesso

```dart
import 'dart:math'; // Fornisce la classe Random

class Employee {
  int id;
  String firstName;
  String lastName;

  Employee(this.id, this.firstName, this.lastName);
}

void main() async {
  print("getting employee...");
  var x = await getEmployee(33);
  print("Got back ${x.firstName} ${x.lastName} with id# ${x.id}");
}

Future<Employee> getEmployee(int id) async {
  Random rnd = Random();
  int s = 1 + rnd.nextInt(4);
  await Future<void>.delayed(Duration(seconds: s)); // Attesa asincrona
  Employee e = Employee(id, "Joe", "Coder");
  return e;
}
```

| Domanda | Risposta |
| :--- | :--- |
| **`import` cosa ci permette di dare?** | `import 'dart:math';` permette di **accedere alle funzionalità** definite nella libreria **`dart:math`**, ad esempio la classe **`Random`** usata in `getEmployee`. |
| **Quali tipi di costruttori vengono utilizzati?** | Viene utilizzato un **costruttore abbreviato**. Questa sintassi è un'abbreviazione di `this.id = id`. |

-----

## es006: Una Variante Del Precedente

```dart
Future<Employee> getEmployee(int id) async {
  Random rnd = Random();
  int s = 1 + rnd.nextInt(4);
  await Future<void>.delayed(Duration(seconds: s)); // Attesa asincrona
  Employee e = Employee(id, "Joe", "Coder");
  return e;
}

Future<Employee> getEmployee(int id) {
  Random rnd = Random();
  int s = 1 + rnd.nextInt(4);
  return Future<Employee>.delayed( // Ritorna direttamente il Future
      Duration(seconds: s), () => Employee(id, "Joe", "Coder"));
}
```

Nella nuova versione viene ritornato un `Future<Employee>` dato dalla funzione anonima `() => Employee(...)`, senza l'uso di `async/await`.

-----

## es007: Un Esempio di Sincronizzazione (Approccio Bloccante o Sequenziale)

```dart
Future<String> myAsync(int n) async {
  return Future<String>.delayed(const Duration(seconds: 2), () {
    return "$n : async";
  });
}

void main() async {
  String s1 = await myAsync(1); // 2s di attesa
  print(s1);
  String s2 = await myAsync(2); // 2s di attesa
  print(s2);
  String s3 = await myAsync(3); // 2s di attesa
  print(s3);
  print('done');
}
```

**Commento:** L'uso di `await` in sequenza fa sì che **ogni operazione asincrona debba completarsi prima che la successiva possa iniziare**.

## es007: Un Esempio di Sincronizzazione (Approccio Parallelo)

Per eseguire le operazioni in parallelo e attendere che **tutte** si completino, si usa **`Future.wait`**:

```dart
void main() async {
  // Inizializza tutte le Future contemporaneamente
  Future<String> f1 = myAsync(1);
  Future<String> f2 = myAsync(2);
  Future<String> f3 = myAsync(3);

  // Attende che TUTTE le Future si completino
  List<String> results = await Future.wait([f1, f2, f3]);

  print(results[0]);
  print(results[1]);
  print(results[2]);
  print('done');
}
```

-----

## es008: Crivello di Eratostene

```dart
import 'dart:math';

Future<bool> isPrimeNumber(int number) async {
  if (number == 1) return false;
  if (number == 2) return true;

  double mysqrt = sqrt(number);
  int limit = mysqrt.ceil();

  for (int i = 2; i <= limit; ++i) {
    if (number % i == 0) return false;
  }

  return true;
}

void main() async {
  await Future.forEach( // Loop asincrono
      [10000, 97, 82, 81, 10, 9, 8, 5, 3],
      (int n) => isPrimeNumber(n)
          .then((x) => print("${n}${x ? " is" : " is not"} a prime number")));

  print('done!');
}
```

| Domanda                                                 | Risposta                                                                                                                                                                                                                                               |
| :------------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Esaminare dal punto di vista matematico il crivello** | Il codice **verifica la primalità di un numero**. L'ottimizzazione chiave è che per la verifica è sufficiente testare la divisibilità fino alla **radice quadrata** di `n` (`mysqrt.ceil()`), non fino a `n-1`.                                        |
| **`Future.forEach` cosa rappresenta?**                  | **`Future.forEach`** è un metodo utile per eseguire un'operazione asincrona su ogni elemento di una lista e **attendere il completamento di tutte le operazioni**. Simile a un loop `for` che usa `await`, ma è specifico per le operazioni asincrone. |

-----

## es009: Altro Esempio (Future.wait)

```dart
import 'dart:math';

Future<int> getRandomNumber() {
  Random random = new Random();
  int n = random.nextInt(100);
  print("$n is generated");
  int t = 1 + random.nextInt(4);
  return Future.delayed(Duration(seconds: t), () => n);
}

void findSmallestNumberInList(List<int> lst) {
  print("all numbers are in:");
  lst.forEach((n) => print(n));
  lst.sort();
  int largest = lst.first;
  print("The smallest random int we generated was: ${largest}");
}

void main() async {
  Future.wait([
    getRandomNumber(),
    getRandomNumber(),
    getRandomNumber(),
    getRandomNumber()
  ]).then((List<int> results) => findSmallestNumberInList(results));
}
```

**Perché usiamo un `Future` nel metodo `getRandomNumber()`?**

Viene usato un `Future` per **simulare un'operazione che richiede tempo** o per rendere il metodo esplicitamente asincrono. L'uso di `Future.wait` nel `main` dipende proprio dal fatto che `getRandomNumber()` restituisca un `Future`.

**Modifiche e motivazione:** Si può modificare l'esempio usando `async/await` invece che **`.then()`**, l'esito sarà identico all'originale.

```dart
void main() async {
  List<int> results = await Future.wait([
    getRandomNumber(),
    getRandomNumber(),
    getRandomNumber(),
    getRandomNumber()
  ]);
  
  findSmallestNumberInList(results);
}
```

-----

## es010: Generare Eccezioni

```dart
Future<void> openFile(String fileName) async {
  throw new Exception("BOOM!");
}

void main() async {
  try {
    await openFile("theFile");
    print("success!");
  } catch (e) {
    print("Looks like we caught an error: ${e.toString()}");
  }
}
```

**Se togliamo `await`?**

1. La chiamata `openFile("theFile")` ritorna un `Future<void>` **immediatamente**.
2. L'errore `BOOM!` viene lanciato in modo asincrono, ma non viene catturato dal `try-catch` sincrono del `main`, che non sta aspettando il risultato del `Future`.
3. L'esecuzione continua immediatamente: viene stampato **`success!`**.
4. Successivamente, l'errore asincrono si propaga e non viene gestito, causando probabilmente un **errore non gestito dall'event loop** o dal runtime (mostrando un messaggio d'errore). **Per gestire l'errore di un `Future` senza `await`, si userebbe `.catchError()`**.

-----

## es011: Un Esempio dalla Documentazione

```dart
String createOrderMessage() {
  var order = getUserOrder();
  return 'Your order is: $order';
}

Future<String> getUserOrder() {
  return Future.delayed(Duration(seconds: 4), () => 'Large Latte');
}

main() {
  print('Fetching user order...');
  print(createOrderMessage());
}
```

-----

## es012: Segue il Precedente (Alternativa)

```dart
void main() async {
  countSeconds(4); // Ritorna Future<void>, ma non è atteso
  await createOrderMessage();
}

void countSeconds(s) async {
  for (var i = 1; i <= s; i++) {
    await Future.delayed(Duration(seconds: i), () => print(i));
  }
}

// Alternativa
Future<void> countSeconds(s) {
  for( var i = 1 ; i <= s; i++ ) { 
      Future.delayed(Duration(seconds: i), () => print(i)); // Non attende i Future
  }
  return Future.value(); // Ritorna un Future completato immediatamente
}
```

**Provare l'alternativa motivando l'esito:**

1. La funzione `countSeconds` nell'alternativa **non è `async`** (ma ritorna `Future<void>`).
2. Il loop `for` esegue **immediatamente** tutte e 4 le chiamate a `Future.delayed`, programmando gli eventi nell'event queue per i tempi 1s, 2s, 3s e 4s. **Non aspetta** la fine di ogni attesa.
3. `countSeconds` ritorna **immediatamente** un `Future<void>` già completato (`Future.value()`).
4. `main` prosegue con `await createOrderMessage()`.

**Rispetto alla versione originale (sincronizzata):**

**Originale:** `countSeconds` usava `await` all'interno del loop, causando una stampa sequenziale: `1` (dopo 1s), `2` (dopo 1+2s), `3` (dopo 1+2+3s), `4` (dopo 1+2+3+4s).
**Alternativa:** Le stampe sono programmate in **parallelo** per i tempi assoluti: `1` (dopo 1s), `2` (dopo 2s), `3` (dopo 3s), `4` (dopo 4s). L'esecuzione è **più rapida**.

## es013: Restando in Tema

```dart
Future<void> createOrderMessage() async {
  try {
    var order = await getUserOrder();
    print('Awaiting user order...');
    print(order);
  } catch (err) {
    print('Caught error: $err');
  }
}

Future<String> getUserOrder() {
  var str = Future.delayed(
      Duration(seconds: 4), () => throw 'Cannot locate user order');
  return str;
}

main() async {
  await createOrderMessage();
}
```

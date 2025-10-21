Data: 2025-10-19
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Future \<T\>
- È definito come un **asynchronous computation**. nel  momento in cui viene attivata una tale computazione viene generato un **evento** che, posto nella **event queue**, verrà gestito dall'**event loop**

___
# Teoria
- Il Future in dart è come una promessa di un valore che riceverai
## Gestione Asincrona 
### Async
- Si mette dopo il nome di una funzione (es.  void main() async). È un' etichetta che dice: 
	- Attenzione, questa funzione potrebbe contenere operazioni asincrone e usare la parola chiave **await**.

#### Tipi di return con Async
 - Quando metti **async** davanti a una **funzione**, stai dicendo al compilatore Dart: "Trasforma questa funzione: anche se sembra normale,  deve obbligatoriamente restituire un **Future**.
 
``` Dart
void miaFunzione() async {
  // ...
}
//il compilatore Dart lo lege e lo converte automaticamente in:
Future<void> miaFunzione() async {
  // ...
}
```

- **In Sintesi**

| Funzione                     | Ritorno                                         |
| :--------------------------- | :---------------------------------------------- |
| void miaFunzione()           | Ritorna **niente** (sincrono).                  |
| Future\<void\> miaFunzione() | Ritorna una **promessa di niente** (sincrono).  |
| void miaFunzione() **async** | Ritorna una **promessa di niente** (asincrono). |
##### Return fantasma

``` Dart
Future<String> getMessaggio() async {
  print("Preparo il messaggio...");
  return "Ciao";
}
// ❌ Errore di compilazione
// Prometti una 'String', ma il "return fantasma" è 'null'.
Future<String> getMessaggio() async {
  print("Preparo il messaggio...");
// ERRORE: La funzione finisce con return null ma era promesso una stringa!
}
```

### Await
- Si usa davanti a una chiamata che restituisce un Future.  È un' etichetta che dice:
	-  Attenzione, il programma aspetterà in quel punto il risultato del **Future** prima di continuare

## Metodo Callback
### Then
- Il  **.then()**  che "attacchi" a un **Future** dice: "
	- Esegui questa funzione quando il Future si completa con successo.
- Il parametro del then è una funzione che deve essere in grado di accettare come argomento il valore restituito dal **Future**, quando si completa con successo
___
# Dimostrazione
## es001: Un Primo Esempio

```dart
void main() async {
  print('before received');
  int x = await number(5);
  print(x);
  print('after received');
}

Future<int> number(int n) {
  return Future.delayed(const Duration(seconds: 5), () => n);
}
```

**Output:**
``` 
before received
//aspetta 5 secondi
5
after received
```

**Esecuzione:**
1. `main` inizia.
2. La chiamata a `number(5)` inizia un'attesa di 5 secondi e ritorna un `Future<int>`.
3. `await` sospende l'esecuzione di `main` (senza bloccare l'applicazione) e l'event loop può eseguire altre cose.
4. Dopo 5 secondi, il `Future` si completa con il valore `5`
5. L'esecuzione di `main` riprende: `x` è assegnato a `5`, `print(5)` viene eseguito, seguito da `print('after received')`.

| Modifica                        | Esito                   | Ragione                                                                                                     |
| :------------------------------ | :---------------------- | :---------------------------------------------------------------------------------------------------------- |
| **Elimina `async`** (da `main`) | Errore di compilazione. | `await` può essere usato solo in funzioni marcate come `async`.                                             |
| **Elimina `await`**             | Errore di compilazione. | Si tenta di assegnare un `Future<int>` (il risultato immediato di `number(5)`) a una variabile `int` (`x`). |
| **Elimina `async` e `await`**   | Errore di compilazione. | Stesso errore del caso precedente: tentativo di assegnare un `Future` a un `int`.                           |

## es002: Esempio Col Then

```dart
void main() {
  int x = 0;
  print("START");
  
  Future.delayed(Duration(seconds: x), () {
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

**Output:**
``` 
START
STOP
//aspetta x (0) secondi
from callback
666
```

| Domanda                     | Risposta                                                                                                                                                                                                                                                                                    |
| :-------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Come mai manca `async`?** | La funzione `main` non ha bisogno di essere `async` perché non utilizza la parola chiave **`await`**. L'operazione asincrona e la gestione del suo risultato sono gestite interamente dal metodo a catena **`.then()`**.                                                                    |
| **Differenze con es001?**   | `es001` usa **`async/await`** per un approccio **sequenziale (stile sincrono)** alla gestione asincrona. `es002` usa **`.then()`** per un approccio **basato su callback** per gestire il risultato del `Future`. L'uso di `.then()` non richiede che la funzione contenitrice sia `async`. |

## es003: Go On (Parallelismo Asincrono)

```dart
void main() {
  printDelayed(5); // Inizia attesa 5s
  printDelayed(3); // Inizia attesa 3s
  print('Go go go'); // Esecuzione sincrona
}

Future<void> printDelayed(int s) async {
  Future.delayed(Duration(seconds: s), () => print('after $s seconds'));
}
```

**Output:**
``` 
Go go go
//aspetta 3 secondi
after 3 seconds
//aspetta 5 secondi
after 5 seconds
```

**Esecuzione**
1. `main` è sincrono (non ha `async/await`).
2. `printDelayed(5)` e `printDelayed(3)` vengono chiamate. Poiché **non c'è `await`** all'interno di `printDelayed`, le due chiamate a `Future.delayed` **programmato** i loro rispettivi eventi nell'event queue e **ritornano immediatamente** (prima che i timer scadano).
3. `print('Go go go')` viene eseguito subito dopo.
4. L'event loop gestisce i timer: dopo 3s stampa `'after 3 seconds'`, dopo 5s stampa `'after 5 seconds'`.

| Modifica/Domanda                                   | Risposta                                                                                                                                                 |
| :------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sostituisci il tipo di ritorno con `void`**      | Se si forza il tipo di ritorno a `void`, si ottiene un errore perché una funzione `async` **deve** ritornare un `Future`.                                |
| **Tipo di ritorno di una computazione asincrona?** | È sempre un **`Future<T>`**, `T` è il tipo del valore che la funzione è destinata a restituire. **`Future<void>`** se la funzione non restituisce nulla. |
| **Tempi uguali (es. 3s e 3s)?**                    | Se i tempi sono uguali, le chiamate all'interno dell'event queue verranno eseguite nell'ordine in cui sono state programmate.                            |

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

**Output:**
``` 
Go go go
//aspetta 3 secondi
after 3 seconds
```

**Esecuzione**
- La funzione `main` **non usa `await`**.
- La chiamata a `printDelayed(3)` è asincrona, ma **non bloccante** per `main`. `printDelayed` inizia la sua esecuzione, incontra `await`, sospende la sua **propria** esecuzione e ritorna un `Future<void>` a `main`.
- `main` prosegue immediatamente con la stampa di `'Go go go'`. L'output sarà `'Go go go'`, seguito dopo 3 secondi da `'after 3 seconds'`.

| Modifica/Domanda                                   | Risposta                                                                                 |
| :------------------------------------------------- | :--------------------------------------------------------------------------------------- |
| per quale motivo in **main** non appare **async?** | Nel tuo codice, **main** sta usando un approccio "lancia e dimentica" (fire and forget). |
___
 
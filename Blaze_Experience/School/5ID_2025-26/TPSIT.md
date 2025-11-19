Data: 2025-11-07
[5ID_2025-26](./README.md)
#School/5ID_2025-26
___
# Verifica 5IC
## Ex 1
1. Cosa fanno le seguenti istruzioni?
``` Dart
var data1 = <Object> {};
var data2 = <dynamic, dynamic> {};
var datat3 = <String> {};
var data4 = {};
```

data1 è un set di oggetti
data2 è una mappa dynamic dynamic
data3 è  un set di stringhe
data4 è un set vuoto "dynamic"

## Es 2
2. Qual è il motivo per cui Dart ammette un solo metodo costruttore il cui nome è quello data classe in cui viene definito? Cosa sono i **named constructor**? Dare un esempio di tale costruttore.

Il motivo per cui dart ammette solo costrutto è dovuto al fatto che non è un linguaggio polimorfico, ovvero esiste solo un costruttore all'interno della classe chiamato come la classe.

Dato che dart non è un linguaggio polimorfico, Si è dovuto introdurre i Named constructor, che ti permette di creare "ricette" alternative per costruire il tuo oggetto, dando loro un nome.

Esempio:
``` Dart
class Casa {
	int? porta;
	Casa.buildaPorta() {
		this.porta = 777;
	}
}
```

`Casa.buildaPort` è il costruttore col nome

## Es 3
3. Scritta la classe `MyInt`, essa può avere un costruttore const che inizializza la sua unica property in modo casuale?

No, non è possibile.
Un costruttore `const` richiede che **tutti** i valori usati per inizializzare le sue property siano **costanti di compilazione** (noti prima che il programma venga eseguito).
Un valore casuale (es. generato da `Random()`) è l'opposto: è un valore calcolato a **runtime** (mentre il programma è in esecuzione). 
--Gemini

## Es 4
4. Cosa scrivere al posto di `RET`? Se si toglie `await` cosa succede?

``` Dart
RET calculus() async {
	int x = await getNumber(5);
	print(x);
	return x;
}
```

Al posto di RET si mette `Future<int>` perchè la funzione ha implementato async e async deve sempre restituire un Future

Se si toglie await si verifica un errore  di compilazione dato che `getNumber` ritorna un subito un `Future<int>`

## Es 5
5. Si descriva nel dettaglio la property sink di uno StreamController?

StreamController È l'oggetto che ti permette di creare e gestire manualmente uno stream.
In pratica, funge da tramite tra chi produce i dati e chi li ascolta.
Componenti fondamentali di uno streamController:
- Sink (Input): immaginalo come un imbuto in cui versi i dati destinati allo stream
	- **sink.add(123);** → Invia il dato 123 nello stream.
	- **sink.addError('ops');** → Invia un errore nello stream.
	- **sink.close();** → Chiude il flusso; gli ascoltatori riceveranno l’evento onDone.

## Es 6
6. Dopo aver sintetizzato la differenza fra uno `stream` e `stream broadcast` dare almeno una possibilità per trasformare uno stream normale in broadcast.

Uno stream di default nasce unicast, ovvero che lo stream non può avere più di un ascoltatore, invece uno stream broadcast invece ne può avere più di uno

Esempio:
``` Dart
Stream<int> streamNormale = Stream.periodic(Duration(seconds: 1), 
	(i) => i).take(5);
Stream<int> streamBroadcast = streamNormale.asBroadcastStream();
```

## Es 7
7. Per cosa è pensata la classe Socket in Dart, e quali sono le classi che implementa

Un oggetto Socket è la rappresentazione di una connessione di rete a basso livello. È come un "tubo" digitale tra due computer.
Un oggetto Socket è:
	[[#1) Il Socket come IOSink (Output)]]
	**Un sink:** è un posto dove i dati "entrano" per essere inviati via. Significa che si può usare il l'oggetto socket per **scrivere dati** e inviarli attraverso la rete.
	[[#2) Il Socket come Stream <Uint8List> (Input / Ascoltare]] )
	**Stream:** Lo stream ha compito di mettere in ascolto il tuo oggetto socket per **ricevere dati** non appena arrivano dalla rete. 

## Es 8
8. Qual è il ruolo del metodo `setState()` in una classe `State<T>` in Flutter?

Il ruolo di `setState()` è dire al framework Flutter che **lo stato interno del widget è cambiato** e che l'interfaccia utente (UI) **deve essere ricostruita** per riflettere tale cambiamento.
Quando chiami `setState()`, stai facendo due cose:
1. Aggiorni una o più variabili di stato.
2. Contrassegni il widget come "dirty" (sporco), segnalando a Flutter di richiamare il metodo `build()` di quel widget al prossimo frame disponibile.
-- Gemini

___
# 5IE

## Ex 1
Cosa fanne le seguenti istruzioni?
``` Dart
var data1 = <dynamic, dynamic> {};
var data2 = <Object> {};
var datat3 = <int> {};
var data4 = {};
```

data1 una mappa dynamic dynamic
data2 è un set di oggetti  
data3 è un set di int
data4 è un set vuoto "dynamic"

## Ex 2
Qual è il motivo per cui Dart nono ammette oveloading? Quanti Costruttori const della classe sono ammessi?

Dart non è un linguaggio polimorfico, ovvero esiste solo un costruttore all'interno della classe chiamato come la classe. Perchè è stato progettato per essere **semplice** e per evitare ambiguità
Una classe può avere **un (1) costruttore `const` _non_ nominato** e **molteplici costruttori `const` _nominati_**.

## Ex 3
Scritta la classe MyEvent, essa può avere un costruttore const che inizializza la sua unica property di tipo DataTime con la data odierna?

No, i costruttori const accettano come parametri dei valori già stabiliti in tempo di compilazione, DataTime ritorna il valore durante il tempo di esecuzione
`or`
Si, la classe MyEvent può avere un costruttore const che inizializza la sua unica property di tipo DateTime con la data odierna, purchè sia dichiarata final. Una variabile final viene assegnata una volta e non può più essere modificata successivamente. In questo caso, la data viene calcolata a runtime dal compilatore e rimane costante per tutta la vita dell'oggetto.

## Ex 4
Cosa scrivere al posto di `RET`? Se si toglie `await` cosa succede?

``` Dart
RET calculus() async {
	int x = await getNumber(5);
	print(x);
}
```

Al posto di RET si scrive `Future<void>` dato che la classe non ritorna nulla e in più implementa async, e una funzione async deve sempre ritornare  un Future 

Se si toglie await si verifica un errore  di compilazione dato che `getNumber` ritorna un subito un `Future<int>`

## Ex 5
Un Socket cosa rappresenta? Come può inviare in modo String? come può trasmettere dati in modo asincrono

1. Un oggetto Socket è la rappresentazione di una connessione di rete TCP a basso livello. È come un "tubo" digitale tra due computer.

2. Il Socket non invia stringhe, invia solo byte (`List<int>`). Per inviare una stringa, devi prima **codificarla** (convertirla) in byte, di solito usando UTF-8 
``` Dart
import 'dart:convert'; // Richiede l'import

String mioMessaggio = "Ciao mondo";
socket.add(utf8.encode(mioMessaggio)); 
```

3. È **asincrono per natura** in Dart. Le operazioni non bloccano il programma:
- **Invio (Output):** Usi `socket.add(...)`. Questa operazione (gestita da `IOSink`) è non bloccante; consegna i dati al sistema operativo per l'invio.
- **Ricezione (Input):** Ascolti lo `Stream` (`socket.listen(...)`), che ti notifica in modo asincrono ogni volta che nuovi dati arrivano.
--gemini

## Ex 6
Una StramSubcription come la si ottiene? in quale occasione essa "bufferizza" gli eventi di un oggetto Stream?

1. **Come la si ottiene:** Si ottiene **chiamando il metodo `.listen()` su uno `Stream`**. L'oggetto `StreamSubscription` restituito rappresenta quell'abbonamento attivo.
``` Dart
Stream<int> stream = ...;

// Chiamando .listen() si ottiene la sottoscrizione
StreamSubscription<int> miaSottoscrizione = stream.listen((data) {
  print(data);
});
```

2. **Quando "bufferizza" gli eventi:** La sottoscrizione (o il meccanismo interno dello stream) "bufferizza" (accumula) gli eventi principalmente in una situazione: **quando la sottoscrizione viene messa in pausa** (usando `miaSottoscrizione.pause()`).

Se lo stream continua a produrre eventi mentre la sua sottoscrizione è in pausa, quegli eventi vengono messi in coda. Non appena la sottoscrizione viene riattivata (con `miaSottoscrizione.resume()`), gli eventi "bufferizzati" vengono consegnati tutti insieme (o il più velocemente possibile) prima di riprendere la normale ricezione.
--gemini

## Ex 7
Per cosa è pensata la classe ServerSocket in Dart e quali classi implementa?

Il suo ruolo è **ascoltare** su una porta e un indirizzo IP specifici, attendendo che i client (che usano `Socket`) si connettano. Quando un client si connette, il `ServerSocket` **accetta** la connessione e crea un oggetto `Socket` dedicato a quel client.
2. **Quali classi implementa:** Implementa principalmente: **`Stream<Socket>`**
È un flusso (Stream) che **emette un nuovo oggetto `Socket`** ogni volta che un nuovo client si connette con successo al server.
--gemini

## Ex 8
Qual è il legame che esiste fra una **Statefuildget** ed il suo stato?

Il legame è che il `StatefulWidget` **crea** il suo oggetto `State`.
L'oggetto `State` contiene i dati mutabili e la logica (`build()`), mentre il `StatefulWidget` è immutabile e sa solo come _creare_ quell'oggetto `State`.
--gemini
Data: 2025-11-04
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___

# Teoria
[[Libraries#'darth io'|Teoria]]
# Dimostrazione
## es001 Client TCP
``` Dart
import 'dart:io';

void main() {
  Socket.connect("127.0.0.1", 3000).then((socket) {
    print('Connected to: '
        '${socket.remoteAddress.address}:${socket.remotePort}');
    socket.destroy();
  }).catchError((e) {
    // server down
    if (e is SocketException) print('SocketException => $e');
  });
}
```

**Client:**
``` terminale
Connected to: 192.168.1.125:3000
```

**Server:**
``` terminale
```

**Domande:**
- in Dart cos'è un oggetto Socket? Coincide con un socket (inteso come terminale di una connessione ...)?
	- **Sì, coincidono.** Un oggetto `Socket` in Dart è l'astrazione software che rappresenta il "terminale" (endpoint) di una connessione di rete TCP.

- descrivere - vedi api - il metodo connect (parametri e tipo di ritorno)
	- **Metodo:** `Socket.connect(dynamic host, int port)`
	- **Parametri:** `host` (l'indirizzo IP o il nome DNS) e `port` (il numero di porta).
	- **Ritorno:** `Future<Socket>`. È un'operazione asincrona; il `Future` si completa con l'oggetto `Socket` se la connessione ha successo.

- in quale caso connect da luogo ad una SocketException?
	- Dà luogo a una `SocketException` quando la connessione **fallisce**. Il caso più comune è `Connection refused`, che significa che il server non è in ascolto su quella porta o l'indirizzo non è raggiungibile.

- cosa è in Dart un oggetto della classe Socket?
	- È un oggetto che permette di **leggere e scrivere dati** sulla rete. Tecnicamente, implementa due interfacce chiave:
		- `IOSink`: Per **inviare** (scrivere) dati.
		- `Stream<Uint8List>`: Per **ricevere** (leggere) dati.

- cosa fa i metodo destroy()?
	- Il metodo `destroy()` **chiude immediatamente la connessione** del socket, interrompendo qualsiasi operazione di lettura o scrittura in corso.

- tentare un ritardo prima di chiamare destroy()
	- Ecco il codice con un **ritardo di 3 secondi** prima di chiudere la connessione, usando `Future.delayed`:

## es002 Browser Testuale Minimale

``` Dart
import 'dart:io';

void main() {
  
  String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';
  Socket.connect("localhost", 3000).then((socket) {
    print('*** Connected to: '
      '${socket.remoteAddress.address}:${socket.remotePort}');
   
    socket.listen((List<int> data) { // Uint8List
    //.fromCharCodes È un costruttore della classe `String` che **crea una nuova stringa di testo a partire da una lista di numeri (codici di carattere).**
      print(String.fromCharCodes(data).trim());
    },
    onDone: () {
      print("*** Done");
      socket.destroy();
    });
  
    //Send the request
    socket.write(indexRequest);
  });
}
```

**Domande:**
- Che tipo di dato è Uni8List e, in ascolto lavora un Socket
	- Uni8List è il modo in cui Dart rappresenta una lista di byte
	- **Come lavora un `Socket` in ascolto?** In ascolto, un `Socket` si comporta come uno **`Stream`** (un flusso).
	    - **Non ricevi tutto subito:** I dati dalla rete arrivano a "pacchetti" (chunks) nel tempo, non tutti in un unico blocco.
	    - **`socket.listen()`:** Questo metodo "apre il rubinetto". Dice al socket: "Appena ricevi un _qualsiasi_ pacchetto di dati, esegui questa funzione".
	    - **Il Callback:** La funzione `(List<int> data) { ... }` è il "callback". Viene eseguita automaticamente _ogni volta_ che un nuovo pacchetto (`Uint8List`) arriva.
## es003 Server TCP
``` Dart
import 'dart:io';

void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 3000).then((ServerSocket server) {
    server.listen(handleClient);
  });
}

void handleClient(Socket client) {
  print('Connection from ' +
      '${client.remoteAddress.address}:${client.remotePort}');
  client.write("Hello from simple server!\n");
  client.close();
}
```

___
 
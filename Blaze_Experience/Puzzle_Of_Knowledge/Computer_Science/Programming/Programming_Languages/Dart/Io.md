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
Connected to: 127.0.0.1:3000
```

**Server:**
``` terminale
(Nessun output, riceve solo la connessione che viene subito chiusa)
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

**Client:**
```
*** Connected to: 127.0.0.1:3000
HTTP/1.1 200 OK
X-Powered-By: Express
... (Header e corpo HTML della pagina) ...
*** Done
```

**Server:**
```
[2025-11-06T08:30:00.000Z] "GET / HTTP/1.1" 200 - "..."
```

**Domande:**
- che tipo di dato è Uint8List e, in ascolto, come lavora un Socket?
    - `Uint8List` è una **lista specializzata di interi a 8-bit non segnati**, ovvero l'equivalente di un array di byte. È il modo standard in Dart per rappresentare dati binari grezzi.
    - In ascolto (`.listen`), il `Socket` si comporta come uno `Stream<Uint8List>`. Significa che **emette "pacchetti" (chunk) di dati** man mano che arrivano dalla rete. Ogni "pacchetto" è un `Uint8List` (che nell'esempio viene convertito in `String`).

## es003: server TCP
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

**Client:**
```
Hello from simple server!
(La connessione si chiude)
```
**Server:**
```
Connection from 127.0.0.1:54321 (porta client casuale)
```

**Domande:**
- studiare la classe ServerSocket
    - La classe `ServerSocket` serve per **accettare connessioni TCP in entrata** (agisce da "server").
    - **`ServerSocket.bind()`:** È il metodo statico (asincrono) che crea l'istanza del server, legandola a un indirizzo IP (`InternetAddress.anyIPv4` significa "tutti gli indirizzi IP di questa macchina") e a una porta. Restituisce un `Future<ServerSocket>`.
    - **`.listen(callback)`:** Una volta che il server è attivo, il suo metodo `.listen()` imposta una _funzione di callback_ (nell'esempio, `handleClient`) che viene **eseguita automaticamente ogni volta che un nuovo client si connette**. La callback riceve come parametro l'oggetto `Socket` del client appena connesso.
## es004 Un Server Echo
``` Dart
import 'dart:io';

int nClient = 0;

void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 3000).then((server) {
    server.listen((client) {
      handleConnection(client);
    });
  });
}
void handleConnection(Socket client) {
  int n = ++nClient;
  print('client ' +
      nClient.toString() +
      ' connected from ' +
      '${client.remoteAddress.address}:${client.remotePort}');
  // manage data and retrun data
  client.listen((data) {
    String str = String.fromCharCodes(data).trim().toUpperCase();
    print('[$n]: ' + str);
    client.write(str + '\n');
  }, onDone: () {
    // await client.flush()
    client.flush();
    client.close();
  });
}
```

**Client:**
```
(L'utente scrive) hello
(Il server risponde) HELLO
(L'utente scrive) test
(Il server risponde) TEST
```

**Server:**
```
client 1 connected from 127.0.0.1:54322
[1]: HELLO
[1]: TEST
```

**Domande:**
- qual è il ruolo del metodo flush() in un oggetto Socket?
    - Il metodo `flush()` (che è asincrono e restituisce un `Future`) **forza l'invio immediato di tutti i dati** che sono ancora nel buffer di scrittura del socket.
    - L'invio di dati sulla rete è spesso "bufferizzato" (messo in attesa) dal sistema operativo per ottimizzare le prestazioni (es. raggruppare più piccole scritture in un unico invio).
    - Chiamare `flush()` assicura che tutti i dati inviati con `.write()` siano stati effettivamente passati al sistema operativo per la trasmissione prima di procedere (ad esempio, prima di `close()`).

## es006 Una Chatroom
Questo esempio è diviso in più parti: studio di `stdin`, client e server.

**6a. Studio `stdin`**
``` Dart
import 'dart:io';

void main() {
    print("Enter your name?");
    String? name = stdin.readLineSync(); 
    print("Hello, $name! \nWelcome to GeeksforGeeks!!");
}
```

**Terminale:**
```
Enter your name?
(L'utente scrive) Mario
Hello, Mario! 
Welcome to GeeksforGeeks!!
```

**Domande:**
- su dart:io studiare la top level property stdin
    - `stdin` è una variabile globale (top-level property) in `dart:io` che rappresenta lo **Standard Input** dell'applicazione (di solito, la tastiera). È un oggetto di tipo `Stdin`.
- nel codice proposto stdin lavora in modo sincrono o asincrono?
    - Lavora in modo **sincrono**. Il metodo `stdin.readLineSync()` **blocca l'esecuzione** del programma finché l'utente non inserisce una riga e preme Invio.
- come lavora un oggetto della classe Stdin in modo asincrono?
    - `Stdin` (come `Socket`) è anche uno `Stream<List<int>>`. Per usarlo in modo asincrono, si usa il metodo `.listen()`, che **non blocca il programma**. Si imposta una callback che viene eseguita ogni volta che l'utente invia dati (come si vedrà nell'esempio del client chat).

**6b. Chat Client:**
``` Dart
import 'dart:io';

late Socket socket;

void main() {
  Socket.connect("localhost", 3000).then((Socket sock) {
    socket = sock;
    socket.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);
  }, onError: (e) {
    print("Unable to connect: $e");
    exit(1);
  });
  stdin
      .listen((data) => socket.write(String.fromCharCodes(data).trim() + '\n'));
}

void dataHandler(data) {
  print(String.fromCharCodes(data).trim());
}

void errorHandler(error, StackTrace trace) {
  print(error);
}

void doneHandler() {
  socket.destroy();
  exit(0);
}
```

**6c. Chat Server**
``` Dart
import 'dart:io';

late ServerSocket server;

List<ChatClient> clients = [];

void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 3000).then((ServerSocket socket) {
    server = socket;
    server.listen((client) {
      handleConnection(client);
    });
  });
}

void handleConnection(Socket client) {
  print('Connection from '
      '${client.remoteAddress.address}:${client.remotePort}');
  clients.add(ChatClient(client));
  client.write("Welcome to dart-chat! "
      "There are ${clients.length - 1} other clients\n");
}

void removeClient(ChatClient client) {
  clients.remove(client);
}

void distributeMessage(ChatClient client, String message) {
  for (ChatClient c in clients) {
    if (c != client) {
      c.write(message + "\n");
    }
  }
}

// ChatClient class for server
class ChatClient {
  late Socket _socket;
  String get _address => _socket.remoteAddress.address;
  int get _port => _socket.remotePort;
  ChatClient(Socket s) {
    _socket = s; // Errore nel codice originale, qui si assegna a _socket
    _socket.listen(messageHandler,
        onError: errorHandler, onDone: finishedHandler);
  }
  
  void messageHandler(data) {
    String message = new String.fromCharCodes(data).trim();
    distributeMessage(this, '${_address}:${_port} Message: $message');
  }
  
  void errorHandler(error) {
    print('${_address}:${_port} Error: $error');
    removeClient(this);
    _socket.close();
  }
  
  void finishedHandler() {
    print('${_address}:${_port} Disconnected');
    removeClient(this);
    _socket.close();
  }

  void write(String message) {
    _socket.write(message);
  }
}
```

**Client:**
```
Welcome to dart-chat! There are 0 other clients
(L'utente scrive) Ciao a tutti
(Arriva un messaggio da un altro client)
127.0.0.1:54323 Message: Ciao!
```

**Server:**
```
Connection from 127.0.0.1:54322
Connection from 127.0.0.1:54323
```

**Domande:**
- (Client) studiare e testare il codice
    - Il client chat è un ottimo esempio di **programmazione asincrona event-driven**. Gestisce due "Stream" contemporaneamente:
        1. **`socket.listen`**: Ascolta i dati _in arrivo_ dalla rete (dal server) e li stampa (tramite `dataHandler`).
        2. **`stdin.listen`**: Ascolta i dati _in arrivo_ dallo standard input (la tastiera) e li invia _in uscita_ al server (tramite `socket.write`).
    - Entrambe le operazioni avvengono senza bloccarsi a vicenda.
- (Server) studiare il codice analizzandolo alla luce del design pattern dell'observer
    - Questo codice è una perfetta implementazione del **Pattern Observer** (noto anche come Publish/Subscribe).
    - **Subject (Soggetto):** La "chatroom" nel suo insieme, rappresentata dalla lista globale `clients` e dalla funzione `distributeMessage`. È l'entità che mantiene la lista degli osservatori.
    - **Observers (Osservatori):** Gli oggetti `ChatClient`. Ogni `ChatClient` si "registra" al Subject venendo aggiunto alla lista `clients` (`clients.add(ChatClient(client))`).
    - **Notifica (Notify):** Quando un Observer (un `ChatClient`) riceve un evento (un messaggio, in `messageHandler`), non lo gestisce localmente, ma "notifica" il Subject (chiamando `distributeMessage`).
    - **Distribuzione:** Il Subject (`distributeMessage`) si occupa quindi di inoltrare la notifica (il messaggio) a _tutti_ gli altri Observer registrati (`for (ChatClient c in clients) ... c.write(message)`).
    - `removeClient` gestisce l'annullamento della registrazione (unsubscribe) quando un Observer si disconnette.

## es007 http Server
``` Dart
import 'dart:io';
main() {
  HttpServer.bind(InternetAddress.anyIPv6, 8080).then((server) {
    print('server is running');
    server.listen((HttpRequest request) {
      switch (request.method) {
        case 'GET':
          handleGetRequest(request);
          break;
        case 'POST':
        // bla bla bla
      }
    });
  });
}

void handleGetRequest(HttpRequest req) {
  HttpResponse res = req.response;
  res.headers.add(HttpHeaders.contentTypeHeader, "text/html");
  res.write('''
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="utf-8">
          <title>HelloWorld</title>
        </head>
        <body>
          <h1>Server </h1>
          <p>Hello World</p>
        </body>
        </html>''');
  res.close();
}
```

**Client:**
**Server:**

## es008 UDP Receiver
**Client:**
**Server:**

## es009 Sender
**Client:**
**Server:**

## es010 Il Sever Echo UDP
**Client:**
**Server:**

## es011 Multicast
**Client:**
**Server:**

## es012 File
**Client:**
**Server:**

___
 
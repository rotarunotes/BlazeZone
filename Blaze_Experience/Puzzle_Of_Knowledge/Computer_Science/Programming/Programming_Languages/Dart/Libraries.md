Data: 2025-10-21
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Index

# 'darth:math'
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
# 'darth:io'
**dart:io** è il ponte di collegamento tra il  codice **Dart** e il **sistema operativo** su cui viene eseguito.

**Cos'è?**
Come suggerisce il nome (io sta per **Input/Output**), questa libreria permette di gestire tutto ciò che riguarda l'ingresso e l'uscita dei dati al di fuori della applicazione in dart.

Questo include due aree principali:
1. **Interagire con il File System:** Leggere, scrivere, creare o cancellare file e cartelle (directory) sul disco rigido del computer.
2. **Interagire con la Rete:** Comunicare con altri computer o servizi tramite Internet o una rete locale.

## 1) Gestione di File e Directory

Questo è l'uso più semplice di dart:io. La libreria fornisce classi come **File** e **Directory** che  permettono di eseguire operazioni comuni:

- **File:** Usata per 
	- **file.readAsString()**: leggere il contenuto di un file.
	- **file.writeAsString()**: Scrivere dentro a un file
    
- **Directory:** Usata per **elencare** i file al suo interno, creare **nuove** cartelle o **cancellarle**.

## 2) Networking (Sockets, HTTP, ecc.)

dart:io permette al programma Dart di comportarsi sia da **client** (che richiede dati, come un browser web) sia da **server** (che fornisce dati, come un sito web).

livelli di astrazione:
- **HTTP (Client e Server):** Questo è il livello più alto e comune. È il protocollo usato dal web. dart:io  permette di creare un piccolo server web (con HttpServer) o di "visitare" un sito web per scaricare dati (con HttpClient).
- **WebSockets:** Un protocollo per una comunicazione **bidirezionale** e in tempo reale (ad esempio, per una chat).
- **Sockets (Il livello base):**

### Spiegazione della Classe Socket
Un oggetto Socket è la rappresentazione di una connessione di rete a basso livello. È come un "tubo" digitale tra due computer.

Un oggetto Socket è:
	[[#1) Il Socket come IOSink (Output)]]
	[[#2) Il Socket come Stream <Uint8List> (Input / Ascoltare]]  

 L'oggetto **Socket** in Dart è un singolo oggetto che implementa due interfacce (contratti) separate:

Quindi, quando si crea o si riceve un Socket, si ottiene un singolo oggetto che puoi usare **contemporaneamente** per inviare dati (usandolo come IOSink) e per ricevere dati (usandolo come Stream).

#### 1) Il Socket come IOSink (Output)
**Un sink:** è un posto dove i dati "entrano" per essere inviati via. Significa che si può usare il l'oggetto socket per **scrivere dati** e inviarli attraverso la rete.

**Utilizzo:** Usi metodi come **socket.write("Ciao server!")** o **socket.add(lista_di_byte)** per inviare messaggi.

#### 2) Il Socket come Stream\<Uint8List> (Input / Ascoltare
**Stream:** Lo stream ha compito di mettere in ascolto il tuo oggetto socket per **ricevere dati** non appena arrivano dalla rete. 

**Uint8List:** La rete non capisce "testo" o "immagini"; capisce solo **byte** (dati grezzi). Uint8List è semplicemente una lista di numeri (byte) che rappresentano i dati ricevuti. Poi si può convertire byte in testo.

**Utilizzo:** Usi socket.listen((dati_ricevuti) { ... }). Il codice dentro listen viene eseguito ogni volta che arriva un nuovo "pacchetto" di dati.
### Server `ServerSocket`
È una classe che serve per creare un **server TCP**. Il suo compito è "ascoltare" su una porta specifica e accettare connessioni in arrivo da client.

Non gestisce lo scambio di dati (lo fa il `Socket`), ma gestisce solo l'**accettazione** delle connessioni.
#### Funzioni Principali
-  **ServerSocket.bind(address, port)**
    - È il metodo statico per **creare e avviare** il server.
    - Gli dici su quale **indirizzo IP** (address) e **porta** (port) deve mettersi in ascolto.
    - È asincrono: restituisce un **Future\<ServerSocket>.**
- **listen(void onData(Socket client))**
    - Questo è il metodo più importante dell'oggetto ServerSocket.
    - È un "callback": gli dici quale funzione eseguire (onData) **ogni volta che un nuovo client si connette**.
    - La tua funzione riceve l'oggetto Socket del client, che puoi usare per comunicare.
- **close()**
    - **Ferma** il server. Smette di accettare nuove connessioni.
    - Le connessioni client già attive non vengono chiuse (devi chiuderle tu singolarmente).
#### Proprietà Principali
- `address`
    - L'oggetto InternetAddress su cui il server è in ascolto (es. 127.0.0.1).
- `port`
    - Il numero di int della porta su cui il server è in ascolto (es. 3000).
#### Funzioni:

### Client
La classe **Socket** è usata (tramite il suo metodo statico **connect**) per creare un **client TCP**. Il suo compito è **iniziare** una connessione verso un server per poi scambiare dati (leggere e scrivere).
##### Socket.connect(...)
- Questo è il comando che inizia il tentativo di connessione
	- Gli dici "dove" connetterti, i **parametri**:
	    - L'indirizzo IP
	    - il numero di "porta" su cui stai cercando di connetterti.
- **Importante**: Questa operazione è **asincrona**. Non blocca il programma. Invece, restituisce immediatamente un oggetto [Future](Future.md). È una "promessa" che in futuro conterrà il risultato: Socket **connesso** o un **errore**.

[[Io#es001 Client TCP|Esempio]]

##### .listen(void onData(List\<int> data))
- Il "callback" per **ricevere dati** (Stream). Si attiva ogni volta che il server invia qualcosa.
##### write(String msg)
- Metodi per **inviare dati** al server (Sink).
##### .then((socket) { ... })
- Questo blocco di codice viene eseguito **solo se la connessione ha successo**.
- La parola **socket** tra parentesi è l'oggetto che rappresenta la connessione appena stabilita.

[[Io#es001 Client TCP|Esempio:]]

##### socket.destroy()
- Questo comando chiude immediatamente la connessione.

[[Io#es001 Client TCP|Esempio:]]

##### .catchError((e) { ... })
- Questo blocco di codice viene eseguito solo se la connessione fallisce
	- Se **Socket.connect** non riesce a trovare un server all'indirizzo IP (perché il server non è avviato, o il firewall lo blocca), questo blocco viene eseguito.

[[Io#es001 Client TCP|Esempio:]]

### Netcat
**netcat:** È uno strumento a riga di comando che fa esattamente questo: apre un "tubo" (un socket) e ti permette di scrivere e leggere byte manualmente.
È lo strumento perfetto per testare i tuoi server o client Socket in Dart, perché puoi digitare un messaggio in netcat e vederlo apparire nel tuo programma Dart (e viceversa).

Download: https://nmap.org/download.html

**Terminale 1:**
``` cmd
ncat -l "porta"
```

**Terminale 2:**
```
"Percorso file della cartella dove si trova il file da eseguire"
C:\Users\user\Fold\Scuola\tpsit>dart run "Nome_File".dart
```

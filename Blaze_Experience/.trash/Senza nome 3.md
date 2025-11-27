 Client
La classe Socket usata tramite il suo metodo statico connect  server per creare un client TCP. Il suo compito è iniziare una connessione verso un server per poi scambiare dati.
Socket.connect(...)
- Questo è il comando che inizia il tentativo di connessione
	parametri:
	    - L'indirizzo IP
	    - il numero di "porta" su cui stai cercando di connetterti.
- Operazione è asincrona. Non blocca il programma.
- Restituisce immediatamente un oggetto Future. È una "promessa" che in futuro conterrà il risultato: Socket connesso o un errore.
 .listen(void onData(List\<int> data))
- Il "callback" per ricevere dati (Stream). Si attiva ogni volta che il server invia qualcosa.
 write(String msg)
- Metodi per inviare dati al server (Sink).
 .then((socket) { ... })
- Questo blocco di codice viene eseguito solo se la connessione ha successo.
 socket.destroy()
- Questo comando chiude immediatamente la connessione.
 .catchError((e) { ... })
- Questo blocco di codice viene eseguito solo se la connessione fallisce
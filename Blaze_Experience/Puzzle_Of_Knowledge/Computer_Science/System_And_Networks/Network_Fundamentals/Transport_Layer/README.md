Data: 2026-04-23
[Network_Fundamentals](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Transport_Layer
___
# Transport_Layer
## Porta
Le porte sono l'elemento che permette il **Multiplexing**.

![[ISO_OSI#Multiplexing]]

- **Definizione:** L'indirizzo IP identifica l'host (il computer), la porta identifica il **processo** o il **servizio** specifico (es. il browser vs Spotify).
- **Socket:** È l'unione di `Indirizzo IP + Protocollo + Numero di Porta`.
### Porta Effimera
È una porta di comunicazione temporanea utilizzata dal lato **Client** di una connessione TCP/IP.

Mentre i **server** utilizzano porte fisse e ben note per "ascoltare" le richieste (es. la porta 80 per il web, http), il tuo computer ha bisogno di una porta unica per ricevere le risposte. Immaginala come una **casella postale temporanea** che viene creata solo per la durata di una specifica conversazione.

**Senza** le porte effimere, non potresti fare due cose contemporaneamente. 
Se aprissi due schede del browser per visitare lo stesso sito, il tuo computer non saprebbe a quale scheda destinare i dati in arrivo se non avesse due "porte di ritorno" differenti.
___
# Indice
- [TCP](./TCP.md)
- [UDP](./UDP.md)
___

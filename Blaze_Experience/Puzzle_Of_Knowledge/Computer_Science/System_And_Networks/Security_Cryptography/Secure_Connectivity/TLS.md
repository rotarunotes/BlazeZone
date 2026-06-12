Data: 2026-06-11
[Secure_Connectivity](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Secure_Connectivity
___
# Index
- [[#TLS]]
	- [[#Panoramica]]
- [[#Transport Layer Security]]
	- [[#Evoluzione Delle Versioni]]
- [[#Miglioramenti Di Sicurezza Rispetto A SSL]]
- [[#Flusso Di Connessione TLS Handshake]]
	- [[#Fasi Dettagliate Dell'Handshake]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _TLS_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Protocollo crittografico standard IETF per la sicurezza delle comunicazioni di rete |
| **Livello OSI** | 5 — Sessione (opera sopra TCP) |
| **Stato Corrente** | Standard globale (consigliate le versioni 1.2 e 1.3) |
| **Applicazione principale** | HTTPS (porta 443), SMTPS, IMAPS, VPN client-server |

___
# Transport Layer Security

Il protocollo TLS, *Transport Layer Security*, è il successore standardizzato a livello internazionale del protocollo SSL di Netscape. Ha lo scopo di autenticare i nodi (server ed eventualmente client) e stabilire un canale cifrato sicuro per impedire intercettazioni e manomissioni dei dati.

## Evoluzione Delle Versioni
- **TLS 1.0** (RFC 2246 - 1999): Basato su SSL 3.0 con modifiche minime. Deprecato nel 2021.
- **TLS 1.1** (RFC 4346 - 2006): Aggiunta protezione contro attacchi ai blocchi CBC. Deprecato nel 2021.
- **TLS 1.2** (RFC 5246 - 2008): Standard corrente ampiamente supportato. Aggiunge supporto per algoritmi di cifratura autenticata AEAD (es. AES-GCM) ed elimina le funzioni di hashing deboli come MD5 e SHA-1 dai processi interni.
- **TLS 1.3** (RFC 8446 - 2018): Ultima versione. Ridisegnato per velocizzare l'handshake (ridotto a 1 solo Round Trip Time - RTT) ed eliminare algoritmi e configurazioni legacy deboli (es. rimosso lo scambio chiavi RSA statico a favore di Diffie-Hellman effimero, garantendo Perfect Forward Secrecy).

___
# Miglioramenti Di Sicurezza Rispetto A SSL

Sebbene TLS derivi storicamente da SSL, i due protocolli non sono compatibili direttamente a causa di differenze strutturali:
- **Integrità migliorata**: TLS utilizza l'algoritmo HMAC standardizzato, a differenza della versione proprietaria modificata di SSLv3.
- **Robustezza crittografica**: TLS supporta algoritmi crittografici moderni eliminando i cifrari a flusso deboli come RC4.
- **Forward Secrecy**: Con le versioni recenti viene imposto l'uso di chiavi di sessione effimere (DHE/ECDHE), impedendo che la compromissione futura della chiave privata del server consenta di decifrare il traffico registrato in passato.

___
# Flusso Di Connessione TLS Handshake

L'handshake TLS consente a client e server di autenticare le rispettive identità (tramite certificati X.509 della CA) e concordare i parametri di sicurezza.

```
Client                                                          Server
  │                                                               │
  │─── 1. ClientHello (Cipher suite, client random) ─────────────►│
  │                                                               │
  │◄── 2. ServerHello (Cipher scelto, server random) ─────────────│
  │◄── 3. Certificato Server + Richiesta Certificato Client ──────│ (Richiesta client cert opzionale)
  │                                                               │
  │    [Client controlla validità certificato server]             │
  │                                                               │
  │─── 4. Certificato Client (se richiesto) ─────────────────────►│
  │─── 5. Pre-Master Key (cifrata con chiave pubblica server) ───►│
  │─── 6. Richiesta Cambio Cipher Spec (passaggio a cifrato) ─────►│
  │                                                               │
  │    [Server ricava la Master Secret comune]                    │
  │                                                               │
  │◄── 7. Conferma e Cambio Cipher Spec (pronto) ─────────────────│
  │                                                               │
  ◄═════════════ Canale Dati Cifrato Simmetrico ══════════════════►
```

## Fasi Dettagliate Dell'Handshake
1. **ClientHello**: Il client avvia la sessione inviando una lista degli algoritmi crittografici supportati (*cipher suites*) e un numero casuale (*client random*) utilizzato per derivare le chiavi.
2. **ServerHello**: Il server risponde selezionando l'algoritmo crittografico comune migliore dalla lista e inviando il proprio numero casuale (*server random*).
3. **Certificato Server**: Il server invia il proprio certificato digitale X.509 per autenticare la propria identità. Se necessario, può inviare una richiesta per ottenere il certificato digitale del client (*Client Certificate Request*).
4. **Verifica Certificato**: Il client verifica la catena di fiducia del certificato del server tramite le CA fidenziali locali. Se la verifica fallisce, la connessione viene immediatamente interrotta.
5. **Invio Chiave Client**: Il client genera una chiave preliminare (*pre-master key*), la cifra con la chiave pubblica del server (estratta dal certificato appena ricevuto) e la invia al server. Se richiesto, invia anche il proprio certificato per autenticarsi.
6. **Cambio Cifrario (Client)**: Il client invia il messaggio `ChangeCipherSpec` comunicando che tutti i successivi messaggi saranno cifrati utilizzando la chiave simmetrica finale (derivata da client random, server random e pre-master key).
7. **Conferma Server**: Il server decifra la pre-master key con la propria chiave privata, ricava la medesima chiave simmetrica finale, attiva la cifratura lato server e invia un messaggio di conferma cifrato di fine handshake. Il canale sicuro è stabilito.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **OSI Layer** | Livello 5 (Sessione) — opera sopra TCP. |
| **Handshake TLS 1.2** | Richiede 2 RTT (Round Trip Time) per completare la negoziazione. |
| **Handshake TLS 1.3** | Ottimizzato a **1 RTT** (scambio DH integrato nel ClientHello). |
| **Autenticazione Client** | Opzionale, implementata in ambienti aziendali critici (Mutual TLS - mTLS). |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Il client cifra i dati della sessione con la chiave pubblica del server** | **FALSO**. La chiave pubblica del server serve solo a cifrare la pre-master key durante l'handshake (o a verificare le firme). I dati effettivi della sessione sono cifrati tramite una **chiave simmetrica** concordata, poiché la crittografia asimmetrica sarebbe troppo lenta. |
| **TLS 1.3 supporta la compatibilità con le vecchie suite crittografiche come RC4 o MD5** | **FALSO**. TLS 1.3 ha eliminato del tutto il supporto a suite obsolete e insicure per impedire attacchi di downgrade e velocizzare l'elaborazione. |
| **La CA garantisce la crittografia del tunnel** | **FALSO**. La CA (Certificate Authority) garantisce unicamente l'**identità** del server firmando il certificato. La crittografia del tunnel è determinata dagli algoritmi negoziati direttamente tra client e server durante l'handshake. |

___
# Quick Reference Card

```
TLS (TRANSPORT LAYER SECURITY):
  - Standard IETF (successore sicuro di SSL)
  - Layer 5 OSI (Sessione)
  - Versioni correnti: TLS 1.2 e TLS 1.3 (massima velocità e sicurezza)

PUNTI CHIAVE HANDSHAKE (LATO SICUREZZA):
  1. ClientHello         -> Propone cipher suites + client random
  2. ServerHello         -> Sceglie cipher + server random
  3. Server Certificate  -> Certificato X.509 del server (autenticazione)
  4. Client Verification -> Client convalida il certificato della CA
  5. Key Exchange        -> Invio Pre-Master Key cifrata con chiave pubblica server
  6. Derivazione Chiave  -> Entrambi generano la Master Secret simmetrica
  7. ChangeCipherSpec    -> Passaggio alle comunicazioni cifrate
```
___
--Gemini

Data: 2026-06-11
[Secure_Connectivity](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Secure_Connectivity
___
# Index
- [[#SSL]]
	- [[#Panoramica]]
- [[#Secure Sockets Layer]]
	- [[#Storia E Sviluppo]]
- [[#Architettura E Livello OSI]]
	- [[#I Sotto-Protocolli Di SSL]]
- [[#Confronto SSL Vs TLS]]
- [[#Aspetti Di Sicurezza E Vulnerabilità]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _SSL_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Protocollo crittografico progettato per proteggere le comunicazioni su una rete IP |
| **Livello OSI** | 5 — Sessione (opera sopra TCP) |
| **Sviluppatore** | Netscape Communications |
| **Stato Corrente** | Completamente deprecato a causa di vulnerabilità note (sostituito da TLS) |

___
# Secure Sockets Layer

Il protocollo SSL, *Secure Sockets Layer*, è stato il primo standard crittografico ampiamente diffuso per proteggere le transazioni sul web (es. dando vita a HTTPS, *Hypertext Transfer Protocol Secure*). 

## Storia E Sviluppo
Sviluppato da Netscape negli anni '90, ha attraversato tre versioni principali prima di essere deprecato:
- **SSL 1.0**: Mai rilasciato pubblicamente a causa di gravi difetti crittografici intrinseci.
- **SSL 2.0**: Rilasciato nel 1995. Conteneva diverse debolezze di progettazione (es. vulnerabilità nel riutilizzo delle chiavi, mancanza di protezione per l'handshake). Deprecato ufficialmente nel 2011.
- **SSL 3.0**: Rilasciato nel 1996. Ridisegnato completamente da zero per risolvere i problemi di SSL 2.0. È servito come base logica per la nascita del protocollo TLS, *Transport Layer Security*. Dichiarato obsoleto e insicuro nel 2015.

___
# Architettura E Livello OSI

A differenza di IPsec che opera a livello di rete (Layer 3), SSL lavora a **livello sessione** (Layer 5 dell'OSI o come strato intermedio tra il livello di trasporto TCP ed il livello applicazione del modello TCP/IP). 
- **Trasparenza**: Protegge le comunicazioni a livello applicativo (es. HTTP, FTP, SMTP) incapsulando il traffico dati in segmenti TCP sicuri.

```
+-------------------------------------------------------------+
| Livello Applicazione (HTTP, FTP, SMTP)                      |
+-------------------------------------------------------------+
| Livello Sessione (SSL / TLS)                                |
|   - Handshake Protocol, Change Cipher Spec, Alert, Record   |
+-------------------------------------------------------------+
| Livello Trasporto (TCP)                                     |
+-------------------------------------------------------------+
```

## I Sotto-Protocolli Di SSL
SSL è composto internamente da due livelli logici di protocollo:
1. **SSL Record Protocol**: Fornisce i servizi di base di riservatezza (cifratura) e integrità/autenticazione dei dati tramite HMAC. Riceve i dati dalle applicazioni, li frammenta, li comprime (opzionale), calcola il MAC ed cifra il payload prima di inoltrarlo a TCP.
2. **SSL Handshake Protocol**: Consente al client e al server di autenticarsi a vicenda (tramite certificati digitali) e di negoziare gli algoritmi crittografici e le chiavi di sessione prima che il Record Protocol inizi a trasmettere i dati reali. Comprende anche:
   - **Change Cipher Spec Protocol**: Segnala la transizione alle comunicazioni cifrate con i parametri appena concordati.
   - **Alert Protocol**: Gestisce i messaggi di avviso e di errore (es. certificato scaduto, handshake fallito).

___
# Confronto SSL Vs TLS

Sebbene i due termini vengano spesso usati come sinonimi (es. "certificato SSL"), TLS rappresenta l'evoluzione moderna e sicura di SSL.

| Caratteristica | SSL (v3.0) | TLS (v1.2 / v1.3) |
| :--- | :--- | :--- |
| **Standard** | Proprietario Netscape | Standard aperto IETF (RFC 5246 / RFC 8446) |
| **Compatibilità** | - | Non retrocompatibili direttamente, ma interoperabili tramite negoziazione |
| **Integrità (MAC)** | Basato su MD5/SHA-1 modificati | HMAC standardizzato |
| **Generazione Chiavi** | Basata su funzioni MD5/SHA-1 | Basata su PRF, *Pseudo-Random Function*, e HKDF |
| **Sicurezza** | Altamente vulnerabile (Poodle, Beast) | Sicuro (le versioni TLS 1.2 e 1.3 sono gli standard attuali) |

___
# Aspetti Di Sicurezza E Vulnerabilità

Tutte le versioni di SSL sono oggi considerate **vulnerabili e non sicure**. L'attacco più celebre che ha sancito il definitivo abbandono di SSL 3.0 è stato:
- **POODLE**, *Padding Oracle On Downgraded Legacy Encryption*: Sfrutta una debolezza nel meccanismo di padding dei blocchi di cifratura CBC di SSLv3 per decifrare informazioni sensibili (es. cookie di sessione HTTPS) forzando un downgrade del protocollo dal client.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Livello OSI** | Layer 5 (Sessione) — si posiziona sopra TCP (Layer 4) e sotto l'applicazione (Layer 7). |
| **Stato** | **Deprecato**. Nessun browser moderno supporta connessioni SSL 2.0 o 3.0. |
| **Vulnerabilità** | POODLE è l'attacco critico associato a SSL 3.0. |
| **Sviluppatore** | Netscape Communications. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Quando compro un "certificato SSL" sto usando il protocollo SSL** | **FALSO**. I certificati digitali sono solo chiavi pubbliche standard X.509. Vengono usati indifferentemente con SSL o con il moderno protocollo **TLS**. Quello che cambia è il protocollo configurato sul server web, che oggi deve essere rigorosamente TLS. |
| **SSL è compatibile con UDP** | **FALSO**. SSL è progettato specificamente per lavorare sopra un canale affidabile orientato alla connessione come **TCP**. Per proteggere le trasmissioni UDP è stato sviluppato uno standard correlato chiamato DTLS, *Datagram Transport Layer Security*. |
| **SSLv3 è considerato sicuro per usi leggeri** | **FALSO**. SSLv3 è insicuro a causa di vulnerabilità di design crittografico non risolvibili tramite patch. Deve essere completamente disattivato su tutti i server web e dispositivi di rete. |

___
# Quick Reference Card

```
SSL (SECURE SOCKETS LAYER):
  - Sviluppato da Netscape (versioni 1.0, 2.0, 3.0)
  - Layer 5 OSI (Sessione) - protegge applicazioni TCP (es. HTTPS porta 443)
  - Completamente obsoleto e insicuro (sostituito da TLS)

ARCHITETTURA:
  - SSL Record Protocol    -> Cifratura ed integrità dei blocchi dati
  - SSL Handshake Protocol -> Autenticazione CA ed accordo parametri crittografici
  - Change Cipher Spec     -> Segnala il passaggio alle comunicazioni protette
  - Alert Protocol         -> Gestione messaggi di errore

ATTACCO CHIAVE:
  - POODLE -> Forza il downgrade a SSLv3 e decifra i cookie HTTPS
```
___
--Gemini

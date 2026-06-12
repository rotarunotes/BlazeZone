Data: 2026-06-11
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#Hashing And Integrity]]
	- [[#Panoramica]]
- [[#Funzioni Di Hashing]]
	- [[#Proprietà Fondamentali]]
	- [[#Integrità Dei Dati]]
- [[#Algoritmi Di Hashing Comuni]]
	- [[#Message Digest 5]]
	- [[#Secure Hash Algorithm 1]]
	- [[#Secure Hash Algorithm 2]]
- [[#Sicurezza Avanzata Del Hashing]]
	- [[#Salt]]
	- [[#Hash-Based Message Authentication Code]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Hashing And Integrity_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Algoritmo unidirezionale che converte dati di lunghezza variabile in una stringa a lunghezza fissa |
| **Scopo principale** | Garantire l'integrità dei dati e la memorizzazione sicura delle password |
| **Input/Output** | Qualsiasi dimensione in input; output a lunghezza fissa (digest) |
| **Algoritmi Chiave** | MD5, SHA-1, SHA-2 |

___
# Funzioni Di Hashing

Una **funzione di hashing** prende in input un blocco di dati di qualsiasi dimensione (un testo, un file, un intero disco fisso) e lo trasforma in una stringa di caratteri alfanumerici a lunghezza fissa, chiamata **hash** o **digest**.

## Proprietà Fondamentali
Per essere considerata crittograficamente sicura, una funzione di hashing deve rispettare le seguenti proprietà:
1. **Unidirezionalità** (one-way): Deve essere matematicamente impossibile risalire ai dati di input originali conoscendo solamente il valore hash di output.
2. **Resistenza alle collisioni**: Deve essere estremamente improbabile trovare due input differenti che producano lo stesso identico valore hash in output.
3. **Effetto valanga**: Una minima variazione nei dati di input (anche un singolo bit modificato) deve produrre un valore hash di output completamente diverso e non correlato.
4. **Determinismo**: Lo stesso input produrrà sempre lo stesso identico output.

## Integrità Dei Dati
L'hashing garantisce il pilastro dell'**integrità** nella sicurezza delle reti. Ad esempio, quando si scarica un software, il fornitore pubblica il valore hash ufficiale. Il destinatario può calcolare l'hash del file scaricato localmente: se i due valori coincidono, si ha la certezza che il file non è stato corrotto durante il download o manipolato da terzi.

___
# Algoritmi Di Hashing Comuni

## Message Digest 5
Il MD5, *Message Digest 5*, è un algoritmo storico ampiamente utilizzato in passato.
- **Dimensione dell'output**: 128 bit (solitamente rappresentati come stringa esadecimale a 32 caratteri).
- **Stato**: Altamente insicuro a causa di gravi debolezze algoritmiche che permettono di generare collisioni (due file diversi con lo stesso hash) in pochi secondi. È deprecato per usi crittografici, ma ancora usato per verifiche di integrità non critiche.

## Secure Hash Algorithm 1
Il SHA-1, *Secure Hash Algorithm 1*, è stato progettato dalla NSA, *National Security Agency*.
- **Dimensione dell'output**: 160 bit.
- **Stato**: Deprecato a partire dal 2011 a causa di collisioni teoriche e poi pratiche dimostrate dai ricercatori. Non deve essere utilizzato per firme o certificati digitali.

## Secure Hash Algorithm 2
Il SHA-2, *Secure Hash Algorithm 2*, è la famiglia di algoritmi standard corrente.
- **Varianti**: Include SHA-224, SHA-256, SHA-384 e SHA-512 (il numero indica la dimensione dell'output in bit).
- **Stato**: Sicuro ed ampiamente utilizzato in VPN, SSL/TLS, firme digitali e blockchain.

___
# Sicurezza Avanzata Del Hashing

## Salt
Quando si memorizzano le password degli utenti in un database, non si salvano mai in chiaro, bensì sotto forma di hash. Tuttavia, se due utenti scelgono la stessa password, il loro hash sarà identico. Un attaccante che ottiene il database può usare tabelle precalcolate (rainbow table) per scoprire le password.
- **Salt**: Consiste nell'aggiungere una stringa casuale univoca (chiamata salt) a ogni password prima di calcolarne l'hash. Il salt viene memorizzato insieme all'hash. Questo costringe l'attaccante a ricalcolare le tabelle per ogni singolo utente, neutralizzando l'efficacia delle rainbow table.

## Hash-Based Message Authentication Code
L'HMAC, *Hash-based Message Authentication Code*, unisce una funzione di hashing a una chiave simmetrica condivisa.
- **Scopo**: Oltre a garantire l'integrità del messaggio, garantisce l'autenticità del mittente. Solo chi possiede la chiave simmetrica condivisa può generare e verificare l'HMAC corretto.
- **Utilizzo**: Impiegato in IPsec e TLS per verificare l'integrità dei singoli pacchetti dati in transito.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Integrità** | Verificata tramite hashing (il digest non deve cambiare). |
| **MD5 & SHA-1** | Entrambi deprecati a causa della vulnerabilità alle collisioni. |
| **HMAC** | Hash + Chiave Simmetrica. Assicura **Integrità** ed **Autenticazione**. |
| **Salt** | Stringa casuale che impedisce gli attacchi basati su Rainbow Table. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **L'hashing serve a cifrare le informazioni sensibili** | **FALSO**. Hashing e cifratura sono concetti diversi. La cifratura è bidirezionale (consente di recuperare l'input decifrando). L'hashing è strettamente **unidirezionale** (non si può decalcificare o decodificare l'hash per riavere l'input originale). |
| **Se due file hanno lo stesso hash MD5, sono sicuramente identici** | **FALSO**. A causa delle collisioni di MD5, un attaccante può generare intenzionalmente due file diversi con lo stesso hash MD5. Solo con algoritmi resistenti come SHA-256 questo assunto è valido. |
| **HMAC protegge dalla lettura in chiaro dei dati** | **FALSO**. L'HMAC assicura solo che il messaggio non sia stato alterato e provenga da un mittente fidato. Non cifra il messaggio, che può viaggiare in chiaro a meno che non si applichi anche un algoritmo di cifratura (es. AES). |

___
# Quick Reference Card

```
PROPRIETÀ HASHING:
  1. Unidirezionale (One-Way)
  2. Resistente alle collisioni
  3. Effetto valanga (Avalanche Effect)
  4. Deterministico

ALGORITMI:
  - MD5     -> 128 bit (Insicuro)
  - SHA-1   -> 160 bit (Insicuro)
  - SHA-2   -> 256/512 bit (Standard sicuro corrente)

TECNICHE CHIAVE:
  - Salt -> Password + Stringa Casuale prima dell'hash (previene Rainbow Table)
  - HMAC -> Hash + Chiave Simmetrica (garantisce Integrità e Autenticazione)
```
___
--Gemini

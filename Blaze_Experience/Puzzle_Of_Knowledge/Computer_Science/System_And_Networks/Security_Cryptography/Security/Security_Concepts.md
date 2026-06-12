Data: 2026-06-12
[Security](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Security
___
# Index
- [[#Security Concepts]]
	- [[#Panoramica]]
- [[#Crittologia E Crittografia]]
	- [[#Tecniche Di Crittografia]]
	- [[#Steganografia]]
	- [[#Crittoanalisi]]
- [[#Internet Security E Architettura X800]]
	- [[#Requisiti Di Sicurezza Raccomandazione X800]]
- [[#Esempi Di Violazione E Attacchi]]
	- [[#Sniffing]]
	- [[#Spoofing]]
	- [[#Intercettazione Attiva]]
	- [[#Denial Of Service]]
- [[#Sistemi Di Crittografia]]
	- [[#Il Principio Di Kerckhoffs]]
- [[#Classificazione Dei Sistemi Crittografici]]
- [[#Attacchi Alle Password]]
	- [[#Dictionary Attack]]
	- [[#Brute Force Attack]]
	- [[#Rainbow Table]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Security Concepts_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Studio delle tecniche per garantire la sicurezza delle informazioni e delle trasmissioni in rete |
| **Standard di Riferimento** | ITU-T Recommendation X.800 Security Architecture |
| **Principio Cardine** | Principio di Kerckhoffs |
| **Applicazione** | Protezione da attacchi attivi e passivi su reti pubbliche |

___
# Crittologia E Crittografia

La **crittografia** (o criptografia) è la branca della crittologia che tratta i metodi per rendere un messaggio non comprensibile a persone non autorizzate a leggerlo, garantendo la confidenzialità delle informazioni.

## Tecniche Di Crittografia
Si dividono principalmente in:
- **Cifrario**: Tecnica in cui un singolo carattere del testo in chiaro viene trasformato in un altro carattere.
- **Codice**: Tecnica in cui un carattere o un simbolo rappresenta direttamente un intero concetto o parola.

## Steganografia
La **steganografia** rappresenta l'insieme delle tecniche che permettono di nascondere l'esistenza stessa di un messaggio senza che questo venga modificato o cifrato (es. nascondere un testo all'interno di un'immagine o di un file audio).

## Crittoanalisi
La **crittoanalisi** rappresenta l'approccio inverso rispetto alla crittografia, volto a violare, analizzare o rompere un meccanismo crittografico per recuperare il messaggio in chiaro senza conoscere la chiave. Un sistema si considera computazionalmente sicuro se la sua violazione richiede tempi e risorse tali da rendere vani i successivi tentativi di attacco.

___
# Internet Security E Architettura X800

L'**Internet Security** definisce l'insieme di misure utilizzate per proteggere i dati sensibili durante la loro trasmissione attraverso reti pubbliche non sicure.

## Requisiti Di Sicurezza Raccomandazione X800
Il documento standard internazionale **Recommendation X.800 Security Architecture** definisce cinque requisiti essenziali che ogni sistema sicuro deve soddisfare:
1. **Autenticazione**: Verifica e garantisce l'identità dell'entità mittente o destinataria.
2. **Controllo degli Accessi**: Limita e controlla i diritti di accesso alle risorse di rete solo agli utenti autorizzati.
3. **Confidenzialità**: Protegge i dati trasmessi da accessi e letture non autorizzate.
4. **Integrità dei Dati**: Garantisce che i dati non vengano alterati, inseriti o cancellati durante la trasmissione.
5. **Non Ripudiabilità**: Impedisce che un'entità possa negare di aver compiuto un'azione (es. inviato o ricevuto un messaggio).

___
# Esempi Di Violazione E Attacchi

Le violazioni della sicurezza di rete si dividono in due grandi categorie:

## Sniffing
Lo **sniffing** consiste nell'intercettazione passiva del traffico dati in transito sulla rete.
- **Tipo di attacco**: **Attacco passivo** (non modifica i dati, compromette solo la confidenzialità).

## Spoofing
Lo **spoofing** consiste nella falsificazione dell'identità di un host o utente per indurre un dispositivo a fidarsi di una sorgente malevola.

## Intercettazione Attiva
L'**intercettazione attiva** avviene quando un terzo non autorizzato si inserisce nella comunicazione per catturare, alterare, inserire o eliminare i messaggi (es. attacchi Man-in-the-Middle).
- **Tipo di attacco**: **Attacco attivo** (compromette l'integrità e l'autenticità).

## Denial Of Service
Il DoS, *Denial of Service*, consiste nella compromissione dei servizi di rete per renderli inutilizzabili agli utenti legittimi (sovraccaricando le risorse o i canali di comunicazione).

___
# Sistemi Di Crittografia

Un sistema di crittografia fornisce una famiglia di algoritmi che permettono al mittente di trasmettere un messaggio cifrato in modo sicuro. La decifratura efficiente del messaggio è possibile solo possedendo un'informazione extra: la **chiave**.

## Il Principio Di Kerckhoffs
Il **Principio di Kerckhoffs** stabilisce che la sicurezza di un sistema crittografico deve basarsi esclusivamente sulla conoscenza e segretezza della **chiave**, mentre l'algoritmo di cifratura può essere di pubblico dominio senza compromettere la sicurezza del sistema.

___
# Classificazione Dei Sistemi Crittografici

I sistemi si classificano secondo tre criteri principali:
- **Tipo di operazione**:
  - **Sostituzione**: Ogni simbolo viene trasformato in un altro simbolo.
  - **Trasposizione**: I caratteri del testo vengono permutati senza cambiarli.
- **Elaborazione del testo**:
  - **A blocchi**: Il testo viene diviso e cifrato in porzioni a lunghezza fissa.
  - **A flusso**: Il testo viene cifrato in modo continuo a lunghezza variabile.
- **Tecnica di cifratura**:
  - **Chiave Simmetrica**: La chiave per cifrare è uguale a quella per decifrare.
  - **Chiave Asimmetrica**: La chiave per cifrare è diversa da quella per decifrare.

___
# Attacchi Alle Password

- **Dictionary Attack**: Confronta gli hash delle password con dizionari di parole comuni.
- **Brute Force Attack**: Tenta sistematicamente ogni possibile combinazione di caratteri.
- **Rainbow Table**: Tabella precalcolata per invertire rapidamente gli hash (neutralizzata dall'uso del **salt**).

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Cifrario vs Codice** | Il cifrario opera sul singolo carattere; il codice opera sull'intero concetto. |
| **Steganografia** | Nasconde il messaggio (es. dentro un'immagine) senza modificarlo. |
| **X.800** | Standard per l'architettura di sicurezza (Autenticazione, Accessi, Confidenzialità, Integrità, Non Ripudio). |
| **Kerckhoffs** | Solo la chiave deve essere segreta, l'algoritmo può essere pubblico. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **La steganografia cifra il testo** | **FALSO**. La steganografia nasconde il testo alla vista (lo rende invisibile); non applica formule matematiche di cifratura sul testo stesso. |
| **Lo sniffing è un attacco attivo** | **FALSO**. Lo sniffing è un attacco **passivo** poiché si limita ad ascoltare e registrare il traffico senza modificarlo. |
| **Un sistema è sicuro solo se l'algoritmo è segreto** | **FALSO**. Secondo il principio di Kerckhoffs, la sicurezza dipende unicamente dalla segretezza della chiave. Gli algoritmi pubblici sono più sicuri perché analizzati da esperti mondiali. |

___
# Quick Reference Card

```
CLASSIFICAZIONE CRITTOGRAFICA:
  - Operazione: Sostituzione (cambia simbolo) vs Trasposizione (sposta posizione)
  - Elaborazione: A blocchi (lunghezza fissa) vs A flusso (lunghezza variabile)
  - Chiave: Simmetrica (stessa chiave) vs Asimmetrica (pubblica e privata distinte)

RACCOMANDAZIONE X.800 (SERVIZI CORE):
  1. Autenticazione (verifica identità)
  2. Controllo Accessi (permessi)
  3. Confidenzialità (riservatezza/cifratura)
  4. Integrità dei Dati (nessuna modifica)
  5. Non Ripudiabilità (impossibile negare l'azione)
```
___
--Gemini

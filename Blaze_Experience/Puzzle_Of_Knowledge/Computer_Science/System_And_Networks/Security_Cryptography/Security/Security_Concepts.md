Data: 2026-06-11
[Security](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Security
___
# Index
- [[#Security Concepts]]
	- [[#Panoramica]]
- [[#Concetti Fondamentali]]
	- [[#Minaccia]]
	- [[#Vulnerabilità]]
	- [[#Exploit]]
	- [[#Mitigazione]]
- [[#Attacchi Comuni]]
	- [[#Denial Of Service E Distributed Denial Of Service]]
	- [[#Spoofing]]
	- [[#Man-In-The-Middle]]
	- [[#Phishing]]
	- [[#Social Engineering]]
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
| **Livello OSI** | 1 — 7 (Coinvolge tutti i livelli) |
| **Scopo** | Identificare i concetti fondamentali di sicurezza di rete e le tipologie di attacco più diffuse |
| **Focus Principale** | Triade CIA (**Riservatezza**, **Integrità**, **Disponibilità**) |
| **Applicazione** | Protezione e irrobustimento delle infrastrutture IT |

___
# Concetti Fondamentali

Nel campo della sicurezza informatica, la protezione degli asset aziendali si basa sulla comprensione della differenza tra minaccia, vulnerabilità ed exploit, al fine di applicare efficaci strategie di mitigazione.

## Minaccia
Una **minaccia** (threat) rappresenta una qualsiasi potenziale causa di un incidente che potrebbe danneggiare un sistema informatico o un'organizzazione. Le minacce possono essere di natura intenzionale (es. attacchi hacker, malware) o accidentale (es. disastri naturali, guasti hardware).

## Vulnerabilità
Una **vulnerabilità** (vulnerability) rappresenta una debolezza o una falla presente nel sistema (software, hardware, procedure di sicurezza o comportamento umano) che può essere sfruttata da una minaccia per causare danni.
> [!EXAMPLE] Esempio
> Un software non aggiornato che contiene un bug di sicurezza è una **vulnerabilità**.

## Exploit
Un **exploit** è il meccanismo, il codice software o la tecnica utilizzata per sfruttare una vulnerabilità nota al fine di ottenere accessi non autorizzati, elevare i privilegi o causare malfunzionamenti.
> [!NOTE] Nota
> Quando un exploit viene utilizzato prima che sia disponibile una patch correttiva, si parla di attacco **Zero-Day**.

## Mitigazione
La **mitigazione** (mitigation) comprende l'insieme delle contromisure, delle policy e dei controlli implementati per ridurre la probabilità che una minaccia si verifichi o per limitare l'impatto di un attacco andato a buon fine.
> [!TIP] Strategia
> La mitigazione segue il principio della **Defense in Depth** (sicurezza a strati), applicando controlli fisici, logici e amministrativi.

___
# Attacchi Comuni

## Denial Of Service E Distributed Denial Of Service
Gli attacchi DoS, *Denial of Service*, e DDoS, *Distributed Denial of Service*, mirano a rendere una risorsa di rete (es. server web, link WAN) non disponibile per gli utenti legittimi sovraccaricandola di traffico dannoso.

- **DoS**: L'attacco proviene da una singola sorgente.
- **DDoS**: L'attacco viene sferrato simultaneamente da centinaia o migliaia di sorgenti diverse, spesso organizzate in una rete di computer infetti chiamata botnet.

> [!WARNING] Tipologie Comuni
> - **SYN Flood**: Sfrutta l'handshake a tre vie di TCP inviando pacchetti SYN a cui non segue la conferma ACK, saturando la tabella delle connessioni dello switch o server.
> - **ICMP Flood**: Invio massiccio di pacchetti di richiesta echo.

## Spoofing
Lo **spoofing** consiste nella falsificazione delle informazioni di identificazione in un pacchetto per nascondere la reale identità dell'attaccante o per impersonare un host fidato.

- **IP Spoofing**: Modifica dell'indirizzo IP sorgente nell'header IP.
- **MAC Spoofing**: Falsificazione dell'indirizzo hardware a livello di collegamento dati.
- **ARP Spoofing**: Invio di messaggi ARP gratuiti falsi per associare l'IP del gateway al MAC dell'attaccante.

## Man-In-The-Middle
Un attacco MITM, *Man-in-the-Middle*, si verifica quando un attaccante si inserisce segretamente nel canale di comunicazione tra due endpoint legittimi. L'attaccante può intercettare, leggere o modificare i dati in transito all'insaputa delle parti coinvolte.
- **Tecniche**: Spesso realizzato tramite ARP spoofing nella rete locale o manipolazione del server DNS.

## Phishing
Il **phishing** è una tecnica di truffa online che consiste nell'invio di email ingannevoli che impersonano marchi o istituzioni note (es. banche, servizi cloud) al fine di indurre le vittime a rivelare informazioni sensibili, quali credenziali di accesso o dati finanziari.
- **Spear Phishing**: Attacco mirato a un individuo o a un'azienda specifica.

## Social Engineering
La **social engineering** (ingegneria sociale) è l'arte di manipolare psicologicamente le persone per convincerle a compiere azioni o a divulgare informazioni riservate. Sfrutta debolezze umane quali la fiducia, l'autorità o il senso di urgenza.

___
# Attacchi Alle Password

## Dictionary Attack
Il **dictionary attack** (attacco a dizionario) tenta di indovinare una password confrontando l'hash della password di destinazione con gli hash di una lista predefinita di parole comuni, termini di dizionario e variazioni frequenti.

## Brute Force Attack
Il **brute force attack** consiste nel provare sistematicamente ogni possibile combinazione di caratteri (lettere, numeri, simboli) fino a trovare quella corretta.
- **Limitazioni**: Richiede notevole tempo e risorse computazionali all'aumentare della complessità della password.

## Rainbow Table
Una **rainbow table** è una tabella precalcolata utilizzata per invertire le funzioni di hash crittografiche, consentendo di recuperare rapidamente una password partendo dal suo valore hash.
- **Contromisure**: L'utilizzo di un valore casuale aggiuntivo prima dell'hashing, chiamato **salt**, rende inservibili le rainbow table.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Triade CIA** | Confidentiality (Riservatezza), Integrity (Integrità), Availability (Disponibilità). |
| **Vulnerabilità vs Minaccia** | La vulnerabilità è intrinseca al sistema; la minaccia è esterna ed esprime il potenziale pericolo. |
| **SYN Flood** | Sfrutta lo stato semi-aperto delle connessioni TCP porta a saturare le risorse di memoria. |
| **Salt** | Stringa casuale aggiunta alla password prima del calcolo dell'hash per neutralizzare le rainbow table. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Un exploit coincide con la vulnerabilità** | **FALSO**. La vulnerabilità è il buco nel muro; l'exploit è la scala usata dall'attaccante per arrampicarsi ed entrare. |
| **Il phishing è un attacco prettamente tecnico** | **FALSO**. Si tratta di un attacco di ingegneria sociale che fa leva sul fattore umano. |
| **Un attacco DDoS può essere bloccato chiudendo una sola porta** | **FALSO**. Essendo distribuito da molteplici sorgenti e spesso su porte legittime (es. 80/443), richiede sistemi di mitigazione complessi di tipo scrub o rate limiting. |

___
# Quick Reference Card

```
MINACCIA      -> Evento dannoso potenziale
VULNERABILITÀ -> Debolezza interna del sistema
EXPLOIT       -> Strumento/codice per sfruttare la debolezza
MITIGAZIONE   -> Contromisura per ridurre il rischio

ATTACCHI PASSWORD:
- Brute Force  -> Prova tutte le combinazioni possibili
- Dictionary   -> Usa file di testo con parole note
- Rainbow Table-> Tabella precalcolata di hash invertiti

DIFESA PRINCIPALE:
- Password forti + MultiFactor Authentication (MFA)
- Crittografia end-to-end (previene MITM)
- Hashing con Salt (neutralizza Rainbow Tables)
```
___
--Gemini

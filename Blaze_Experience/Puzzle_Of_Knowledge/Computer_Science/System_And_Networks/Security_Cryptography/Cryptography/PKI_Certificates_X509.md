Data: 2026-06-11
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#PKI Certificates X509]]
	- [[#Panoramica]]
- [[#Public Key Infrastructure]]
	- [[#Componenti Della PKI]]
- [[#Certificati Digitali]]
	- [[#Il Ruolo Del Trust]]
- [[#Lo Standard X509]]
	- [[#Struttura Del Certificato X509]]
- [[#Revoca Dei Certificati]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _PKI Certificates X509_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Insieme di ruoli, politiche, hardware, software e procedure per gestire i certificati digitali |
| **Scopo principale** | Legare un'identità reale ad una chiave pubblica crittografica in modo verificabile |
| **Standard di Riferimento** | ITU-T X.509 |
| **Entità Centrale** | CA, *Certificate Authority* |

___
# Public Key Infrastructure

La PKI, *Public Key Infrastructure*, è l'architettura di sicurezza che rende utilizzabile la crittografia asimmetrica su larga scala (es. sull'intera rete Internet). Senza PKI, non vi sarebbe alcun modo affidabile per verificare che una chiave pubblica appartenga effettivamente all'entità dichiarata, esponendo gli utenti ad attacchi Man-in-the-Middle.

## Componenti Della PKI
L'infrastruttura PKI si compone di diversi attori con responsabilità specifiche:

- **CA**, *Certificate Authority*: L'ente di certificazione terzo e fidato che emette e firma digitalmente i certificati, garantendo la validità del legame tra l'identità del richiedente e la sua chiave pubblica.
- **RA**, *Registration Authority*: L'entità delegata dalla CA che verifica l'identità fisica o legale dei richiedenti prima che la CA emetta il certificato. Non firma i certificati direttamente.
- **Repository**: Database pubblico e accessibile contenente i certificati emessi e le informazioni sullo stato di validità degli stessi.
- **Abbonato** (Subscriber): L'utente o il server che richiede, ottiene e utilizza il certificato.

___
# Certificati Digitali

Un **certificato digitale** è un documento elettronico che associa in modo sicuro la chiave pubblica di un soggetto (es. un server web) alla sua reale identità (es. l'indirizzo del sito `azienda.com`).

## Il Ruolo Del Trust
Per fidarsi di un certificato, il client (es. browser) deve fidarsi della CA che lo ha firmato. I browser e i sistemi operativi integrano una lista predefinita di certificati delle CA radice (*Root CA*) considerate altamente affidabili.
1. Il client riceve il certificato dal server.
2. Il client verifica la firma digitale del certificato usando la chiave pubblica della CA emittente.
3. Se la CA fa parte della lista dei trust, il certificato viene considerato valido.

___
# Lo Standard X509

Lo standard **X.509** definisce il formato standardizzato per i certificati digitali a chiave pubblica.

## Struttura Del Certificato X509
Un certificato conforme a X.509 versione 3 contiene i seguenti campi strutturati:

| Campo | Descrizione |
| :--- | :--- |
| **Version** | Specifica la versione dello standard X.509 (normalmente v3). |
| **Serial Number** | Numero identificativo univoco assegnato dalla CA a quel certificato. |
| **Signature Algorithm** | Algoritmo crittografico usato dalla CA per firmare il certificato (es. SHA256withRSA). |
| **Issuer** | Nome dell'ente emittente (la CA). |
| **Validity** | Intervallo temporale di validità (Data di inizio e data di scadenza). |
| **Subject** | Nome dell'entità a cui appartiene la chiave pubblica (es. il Common Name del sito). |
| **Subject Public Key Info** | La chiave pubblica dell'entità ed l'algoritmo associato (es. RSA a 2048 bit). |
| **Extensions** | Campi opzionali (es. Subject Alternative Name - SAN, restrizioni d'uso). |
| **Signature Value** | La firma digitale effettiva calcolata dalla CA sull'intero certificato. |

___
# Revoca Dei Certificati

Un certificato può essere revocato prima della sua naturale scadenza (es. se la chiave privata associata è stata compromessa o se l'identità del soggetto è cambiata). La PKI gestisce la revoca tramite due meccanismi:

- **CRL**, *Certificate Revocation List*: Una lista periodicamente pubblicata e firmata dalla CA contenente tutti i seriali dei certificati revocati non ancora scaduti. I client devono scaricare regolarmente questa lista per fare le verifiche.
- **OCSP**, *Online Certificate Status Protocol*: Un protocollo che consente al client di interrogare in tempo reale un risponditore della CA sullo stato di un singolo certificato specifico, riducendo l'overhead dovuto al download di intere CRL.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Scopo PKI** | Associare una chiave pubblica a un'identità reale in modo sicuro e certificato. |
| **Ruolo CA** | Firma i certificati digitali con la propria chiave privata. |
| **X.509** | Standard internazionale che definisce la sintassi e il formato del certificato. |
| **Verifica Revoca** | Avviene tramite CRL (offline/periodico) o OCSP (online/in tempo reale). |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Il certificato contiene la chiave privata del server** | **FALSO**. Il certificato contiene esclusivamente la **chiave pubblica** del server, insieme alle informazioni identificative e alla firma della CA. La chiave privata non viene mai condivisa né inclusa nel certificato. |
| **La RA si occupa di firmare i certificati** | **FALSO**. La RA (Registration Authority) si occupa solo di verificare l'identità dell'utente/server. La firma crittografica del certificato spetta unicamente alla CA (Certificate Authority). |
| **Un certificato autofirmato è intrinsecamente insicuro** | **FALSO**. Dal punto di vista crittografico è robusto quanto un certificato firmato da una CA pubblica. Tuttavia, non essendo legato ad una Root CA fidata preinstallata nei browser, genera un avviso di sicurezza (*Untrusted Certificate Warning*) poiché il client non ha una catena di fiducia verificabile. |

___
# Quick Reference Card

```
COMPONENTI PKI:
  - CA  -> Certificate Authority (Firma i certificati)
  - RA  -> Registration Authority (Verifica le identità)
  - CRL -> Lista dei certificati revocati (periodica)
  - OCSP-> Verifica revoca in tempo reale via query diretta

FORMATO X.509 v3:
  - Serial Number, Issuer (CA), Subject (Proprietario), Validity
  - Subject Public Key (Chiave pubblica del proprietario)
  - Signature (Firma crittografica della CA)

PROCESSO DI VERIFICA CLIENT:
  1. Riceve certificato dal server
  2. Verifica firma CA usando chiave pubblica CA (preinstallata nel browser)
  3. Verifica date di validità
  4. Verifica revoca tramite CRL o OCSP
```
___
--Gemini

Data: 2026-06-12
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#PKI Certificates X509]]
	- [[#Panoramica]]
- [[#Public Key Infrastructure]]
	- [[#Componenti Core Della PKI]]
- [[#Certificati Digitali X509]]
	- [[#Struttura Certificato X509]]
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
| **Definizione** | Architettura per la gestione e distribuzione sicura dei certificati digitali |
| **Obiettivo** | Legare una chiave pubblica all'identità reale del proprietario |
| **Standard** | ITU-T X.509 v3 |
| **Fattore Chiave** | Catena di fiducia (catena di trust) |

___
# Public Key Infrastructure

La PKI, *Public Key Infrastructure*, fornisce il framework di gestione per l'uso sicuro delle chiavi pubbliche e private su reti aperte.

## Componenti Core Della PKI
- **CA**, *Certificate Authority*: Ente terzo fidato che firma digitalmente ed emette i certificati.
- **RA**, *Registration Authority*: Verifica l'identità del richiedente prima dell'emissione (non firma direttamente).
- **Abbonato** (Subscriber): Utente o server proprietario del certificato.
- **Repository**: Database pubblico contenente i certificati attivi.

___
# Certificati Digitali X509

Un certificato digitale è un documento firmato che attesta la proprietà di una chiave pubblica.

## Struttura Certificato X509
I campi principali dello standard X.509 v3 sono:
- **Version & Serial Number**: Dati identificativi univoci.
- **Signature Algorithm**: Algoritmo usato dalla CA per la firma (es. SHA256withRSA).
- **Issuer**: Nome della CA emittente.
- **Validity**: Periodo di validità temporale del certificato.
- **Subject**: Nome del proprietario (es. URL del sito web).
- **Subject Public Key**: La chiave pubblica del proprietario.
- **Signature Value**: La firma crittografica reale calcolata con la chiave privata della CA.

___
# Revoca Dei Certificati

Per invalidare un certificato prima della sua scadenza naturale:
- **CRL**, *Certificate Revocation List*: Elenco firmato e aggiornato dei seriali revocati (controllo offline).
- **OCSP**, *Online Certificate Status Protocol*: Query in tempo reale per verificare lo stato di un singolo certificato (controllo online).

___
# Note Esame

## Da Sapere A Memoria

- **CA**: Firma i certificati con la propria chiave privata.
- **X.509**: Standard che definisce il formato del certificato.
- **CRL vs OCSP**: CRL è una lista periodica; OCSP è una query in tempo reale.

## Trabocchetti Frequenti

- **Chiave Privata nel Certificato**: **FALSO**. Il certificato contiene solo la **chiave pubblica** del proprietario.
- **Firma RA**: **FALSO**. La RA verifica solo l'identità, la firma spetta sempre alla CA.

___
# Quick Reference Card

```
PKI ARCHITETTURA:
  - CA   -> Emittente fidata (firma i certificati)
  - RA   -> Verificatore di identità
  - CRL  -> Lista seriali revocati (offline)
  - OCSP -> Controllo stato in tempo reale (online)
  - X.509-> Formato standard del certificato v3
```
___
--Gemini

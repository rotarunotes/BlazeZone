Data: 2026-06-12
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#Hashing And Integrity]]
	- [[#Panoramica]]
- [[#Funzioni Di Hashing]]
	- [[#Proprietà Fondamentali]]
- [[#Algoritmi Di Hashing]]
- [[#Meccanismi Di Sicurezza Avanzati]]
	- [[#Salt]]
	- [[#HMAC]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Hashing And Integrity_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Algoritmo matematico unidirezionale (one-way) |
| **Scopo** | Garantire l'integrità dei dati (triade CIA) |
| **Output** | Stringa a lunghezza fissa (digest) |
| **Algoritmi** | MD5, SHA-1, SHA-2 |

___
# Funzioni Di Hashing

Una funzione di hashing trasforma dati di lunghezza variabile in una stringa di caratteri alfanumerici a lunghezza fissa.

## Proprietà Fondamentali
- **Unidirezionalità**: Impossibile risalire all'input originario dall'hash di output.
- **Resistenza alle collisioni**: Difficile trovare due input diversi che producano lo stesso hash.
- **Effetto Valanga**: Una minima modifica dell'input cambia completamente l'hash.
- **Determinismo**: Stesso input produce sempre lo stesso identico output.

___
# Algoritmi Di Hashing

- **MD5**, *Message Digest 5*: Genera hash a 128 bit. Considerato **insicuro** a causa di collisioni generate facilmente.
- **SHA-1**, *Secure Hash Algorithm 1*: Genera hash a 160 bit. **Deprecato** e vulnerabile ad attacchi.
- **SHA-2**, *Secure Hash Algorithm 2*: Famiglia di algoritmi sicuri (SHA-256, SHA-512). **Standard attuale** per VPN e SSL/TLS.

___
# Meccanismi Di Sicurezza Avanzati

## Salt
- Stringa casuale aggiunta alla password prima dell'hashing. Impedisce la decodifica tramite dizionari precalcolati (**rainbow table**).

## HMAC
L'HMAC, *Hash-based Message Authentication Code*, combina l'hashing a una chiave simmetrica condivisa.
- **Scopo**: Garantisce contemporaneamente **Integrità** dei dati e **Autenticazione** del mittente.

___
# Note Esame

## Da Sapere A Memoria

- **Integrità**: Verificata tramite hashing.
- **MD5/SHA-1**: Deprecati, non sicuri.
- **HMAC**: Hashing + Chiave Simmetrica.

## Trabocchetti Frequenti

- **Hashing vs Cifratura**: L'hashing è unidirezionale (irreversibile); la cifratura è bidirezionale (reversibile tramite decifratura).
- **Cifratura HMAC**: L'HMAC non cifra i dati (che viaggiano in chiaro); assicura solo che non siano modificati.

___
# Quick Reference Card

```
HASHING:
  - Input variabile -> Output fisso (Digest)
  - MD5 (128 bit) & SHA-1 (160 bit) -> Insicuri
  - SHA-2 (256/512 bit)             -> Sicuro (Standard)
  - Salt -> Previene attacchi Rainbow Table
  - HMAC -> Garantisce Integrità ed Autenticità
```
___
--Gemini

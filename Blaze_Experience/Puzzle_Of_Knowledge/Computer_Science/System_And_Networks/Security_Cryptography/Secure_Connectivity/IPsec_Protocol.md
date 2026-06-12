Data: 2026-06-11
[Secure_Connectivity](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Secure_Connectivity
___
# Index
- [[#IPsec Protocol]]
	- [[#Panoramica]]
- [[#Architettura IPsec]]
	- [[#I Tre Componenti Principali]]
- [[#Modalità Di Funzionamento]]
	- [[#Transport Mode]]
	- [[#Tunnel Mode]]
- [[#Protocolli Interni Di IPsec]]
	- [[#Authentication Header]]
	- [[#Encapsulating Security Payload]]
	- [[#Internet Key Exchange]]
- [[#Database Di Sicurezza SAD E SPD]]
- [[#Elaborazione Dei Pacchetti]]
	- [[#Flusso In Uscita Outbound]]
	- [[#Flusso In Ingresso Inbound]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _IPsec Protocol_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 3 — Rete (Network) |
| **Scopo** | Proteggere e cifrare le comunicazioni IP a livello di rete |
| **Modalità** | Transport Mode, Tunnel Mode |
| **Componenti Core** | AH (Autenticazione), ESP (Cifratura), IKE (Scambio chiavi) |
| **Database Chiave** | SAD, *Security Association Database*; SPD, *Security Policy Database* |

___
# Architettura IPsec

L'IPsec, *IP Security*, è una suite di protocolli e standard aperti che protegge le comunicazioni IP attraverso reti non sicure (come Internet). Lavorando a livello 3 (Network), ha il vantaggio di essere trasparente per le applicazioni e gli utenti: qualsiasi tipo di traffico IP (TCP, UDP, ICMP, ecc.) viene cifrato senza necessità di riconfigurare i client finali.

## I Tre Componenti Principali
La suite IPsec si basa sulla combinazione di tre protocolli:
1. **AH**, *Authentication Header*: Garantisce l'integrità dei dati e l'autenticazione dell'origine del pacchetto.
2. **ESP**, *Encapsulating Security Payload*: Garantisce l'integrità dei dati, l'autenticazione dell'origine e la **riservatezza** (cifratura) del payload.
3. **IKE**, *Internet Key Exchange*: Gestisce la negoziazione dei parametri di sicurezza e lo scambio delle chiavi crittografiche.

___
# Modalità Di Funzionamento

IPsec può essere implementato in due modalità distinte, a seconda di quale parte del pacchetto IP debba essere protetta o nascosta.

## Transport Mode
Viene utilizzata prevalentemente per connessioni endpoint-to-endpoint (host-to-host).
- **Funzionamento**: Cifra solamente il payload del pacchetto IP originale (i dati dei livelli superiori). L'header IP originale rimane intatto e visibile durante il transito.
- **Struttura del pacchetto**:
  ```
  [ Header IP Originale ] [ Header IPsec (AH/ESP) ] [ Payload (Cifrato) ]
  ```

## Tunnel Mode
Viene utilizzata tipicamente per VPN, *Virtual Private Network*, Site-to-Site (gateway-to-gateway) per collegare due LAN aziendali remote attraverso Internet.
- **Funzionamento**: Cifra l'**intero pacchetto IP originale** (inclusi gli indirizzi IP sorgente e destinazione privati originali). Il pacchetto cifrato viene poi inserito all'interno di un nuovo pacchetto IP esterno che riporta come sorgente e destinazione gli indirizzi IP pubblici dei gateway VPN.
- **Struttura del pacchetto**:
  ```
  [ Nuovo Header IP Pubblico ] [ Header IPsec ] [ Header IP Privato Originale (Cifrato) ] [ Payload (Cifrato) ]
  ```

___
# Protocolli Interni Di IPsec

## Authentication Header
L'AH (IP protocol 51) fornisce servizi di autenticazione dell'origine, integrità dei dati e protezione dagli attacchi di tipo replay (tramite un numero di sequenza).
- **Limitazione**: Non fornisce cifratura; i dati transitano leggibili in chiaro. Inoltre, calcola l'integrità includendo l'header IP esterno: questo rende AH incompatibile con il NAT, *Network Address Translation*, poiché la modifica dell'IP da parte del router invalida il controllo di integrità.
- **SPI**, *Security Parameter Index*: Un campo di 32 bit nell'header AH che identifica univocamente la Security Association associata al pacchetto.

## Encapsulating Security Payload
L'ESP (IP protocol 50) offre tutti i servizi di AH ed aggiunge la **riservatezza** (cifratura) dei dati.
- **Funzionamento**: Cifra i dati posizionandoli tra l'Header ESP ed il Trailer ESP. Aggiunge in coda un campo di autenticazione (*ESP Auth*) contenente il digest calcolato sul payload crittografato.
- **Vantaggio**: Poiché non include l'header IP esterno nel calcolo dell'integrità, l'ESP è compatibile con i meccanismi di NAT (attraverso l'incapsulamento aggiuntivo UDP 4500, denominato NAT-Traversal).

## Internet Key Exchange
L'IKE (porta 500/UDP) gestisce lo scambio automatico dei parametri di sicurezza tramite sessioni peer-to-peer. Opera in due fasi distinte:
- **IKE Fase 1**: I due gateway si autenticano e stabiliscono un canale di gestione sicuro e cifrato (IKE SA). Viene eseguito l'algoritmo Diffie-Hellman.
- **IKE Fase 2**: Utilizzando il canale sicuro stabilito nella Fase 1, i gateway negoziano i parametri effettivi per il traffico dati (IPsec SA), stabilendo quali algoritmi simmetrici (es. AES) e di hashing (es. SHA-256) utilizzare per la sessione.

___
# Database Di Sicurezza SAD E SPD

L'operatività del gateway IPsec si basa sull'interrogazione costante di due database locali:
- **SPD**, *Security Policy Database*: Contiene le politiche (policy) di sicurezza configurate dall'amministratore che determinano cosa fare del traffico. Le regole del database SPD definiscono se un pacchetto deve essere:
  - **Discard**: Scartato immediatamente.
  - **Bypass**: Inviato in chiaro senza protezione IPsec.
  - **Protect**: Elaborato e protetto tramite IPsec.
- **SAD**, *Security Association Database*: Contiene le SA attive correnti sul dispositivo. Una SA, *Security Association*, è un accordo unidirezionale che definisce le chiavi crittografiche, la durata della sessione e gli algoritmi concordati tramite IKE per la trasmissione dati.

___
# Elaborazione Dei Pacchetti

## Flusso In Uscita Outbound
Quando il gateway riceve un pacchetto destinato alla rete esterna:
1. Consulta il database **SPD**.
2. Se la policy definisce **Discard**, il pacchetto viene scartato. Se definisce **Bypass**, il pacchetto viene inviato direttamente in chiaro.
3. Se la policy definisce **Protect**:
   - Il gateway consulta il database **SAD** per verificare se esiste già una SA attiva per quella destinazione.
   - Se la SA **esiste**, il gateway applica la cifratura/firma crittografica definita nella SA ed invia il pacchetto.
   - Se la SA **non esiste**, il gateway avvia il protocollo **IKE** per negoziare una nuova SA con il peer remoto, memorizza la nuova SA nel database SAD ed elabora infine il pacchetto IPsec per l'invio.

## Flusso In Ingresso Inbound
Quando il gateway riceve un pacchetto da un'interfaccia esterna:
1. Controlla se il pacchetto è di tipo IPsec (protocollo 50 o 51).
2. Se il pacchetto **non è** IPsec, consulta l'SPD per verificare se quel traffico è ammesso in chiaro (Bypass) o se deve essere scartato.
3. Se il pacchetto **è** IPsec:
   - Il gateway estrae il valore **SPI** dall'header del pacchetto e interroga il database **SAD**.
   - Se la SA corrispondente all'SPI **non viene trovata**, il pacchetto viene scartato.
   - Se la SA **viene trovata**, il pacchetto viene decifrato e verificato nei controlli di integrità. Una volta decifrato, il gateway consulta l'**SPD** per verificare che la policy consenta effettivamente quel tipo di traffico decifrato, ed infine lo inoltra alla LAN interna.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Livello OSI** | Layer 3 (Rete). |
| **IKE** | Porta **500/UDP**. Gestisce le SA automatiche. |
| **AH vs ESP** | AH (protocollo 51, no cifratura, incompatibile con NAT); ESP (protocollo 50, sì cifratura, compatibile con NAT). |
| **Tunnel vs Transport** | Tunnel cifra l'intero pacchetto originale (nuovo header IP); Transport cifra solo il payload. |
| **Database** | SPD contiene le policy (cosa proteggere); SAD contiene le SA (le chiavi e algoritmi attivi). |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **IPsec opera a livello di trasporto perché usa UDP** | **FALSO**. IPsec è un protocollo di livello **Rete** (Layer 3). IKE usa UDP (porta 500) a livello 4 solo per la negoziazione delle chiavi, ma il traffico IPsec effettivo viaggia direttamente sopra IP tramite i protocolli 50 (ESP) o 51 (AH). |
| **AH è più sicuro di ESP perché autentica anche l'header IP esterno** | **FALSO**. AH non fornisce **riservatezza** (non cifra i dati). ESP è considerato molto più utile in produzione poiché garantisce la cifratura ed è compatibile con i router NAT. |
| **Una singola SA gestisce la comunicazione bidirezionale tra due sedi** | **FALSO**. Le SA sono **unidirezionali**. Per una VPN bidirezionale tra Sede A e Sede B, sono necessarie sempre almeno due SA distinte (una per A → B ed una per B → A). |

___
# Quick Reference Card

```
IPSEC (IP SECURITY):
  - Layer 3 suite di protocolli
  - Fornisce Riservatezza (ESP), Autenticazione ed Integrità (AH/ESP), Replay Protection

MODALITÀ:
  - Transport -> Cifra solo payload. Header IP originale esposto. (Host-to-Host)
  - Tunnel    -> Cifra intero pacchetto. Aggiunge nuovo Header IP. (Site-to-Site VPN)

PROTOCOLLI CORE:
  - AH  -> Protocollo IP 51. Autentica intero pacchetto. No cifratura. No NAT.
  - ESP -> Protocollo IP 50. Cifra payload. Sì crittografia. Sì NAT.
  - IKE -> Porta UDP 500. Negozia le SA (Fase 1: Canale Mgmt; Fase 2: Canale IPsec)

DATABASE LOCALI:
  - SPD (Policy) -> Regole per decidere: Discard / Bypass / Protect
  - SAD (Active) -> Associazione parametri attivi e chiavi associati a un SPI
```
___
--Gemini

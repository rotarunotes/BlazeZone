Data: 2026-06-11
[Network_Defense](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Network_Defense
___
# Index
- [[#AAA Framework]]
	- [[#Panoramica]]
- [[#Il Modello AAA]]
	- [[#Authentication]]
	- [[#Authorization]]
	- [[#Accounting]]
- [[#Network Access Server]]
- [[#Protocolli AAA]]
	- [[#Remote Authentication Dial-In User Service]]
	- [[#Terminal Access Controller Access-Control System Plus]]
	- [[#Confronto RADIUS Vs TACACS+]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _AAA Framework_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Framework di sicurezza per la gestione degli accessi, dei permessi e del tracciamento delle attività utente |
| **Componenti** | **Authentication** (Chi sei?), **Authorization** (Cosa puoi fare?), **Accounting** (Cosa hai fatto?) |
| **Dispositivo Chiave** | NAS, *Network Access Server* |
| **Protocolli Principali** | RADIUS, TACACS+ |

___
# Il Modello AAA

Il framework AAA, *Authentication, Authorization, and Accounting*, fornisce una struttura modulare per gestire in modo centralizzato la sicurezza degli accessi a una rete o a un dispositivo (es. accessi VPN o login amministrativi su switch e router).

## Authentication
L'**autenticazione** (Authentication) verifica l'identità del soggetto (utente o dispositivo) che richiede l'accesso al sistema.
- **Meccanismo**: L'utente immette credenziali come username e password.
- **Robustezza**: Per elevare la sicurezza, si associano ulteriori fattori tramite MFA, *Multi-Factor Authentication*, inserendo codici temporanei generati da token hardware, software o chiavi elettroniche.

## Authorization
L'**autorizzazione** (Authorization) determina a quali risorse o servizi l'utente autenticato può accedere e quali azioni è abilitato a compiere.
- **Meccanismo**: Viene definita una policy di servizio (*service policy*) centralizzata. Ad esempio, a un utente VPN standard può essere autorizzato l'accesso solo a determinati server in LAN, mentre un amministratore di rete riceve l'autorizzazione per eseguire tutti i comandi CLI di configurazione.

## Accounting
L'**accounting** misura e documenta le risorse consumate e le azioni svolte dall'utente durante l'intera sessione di connessione.
- **Dati registrati**: I dati vengono scritti in file di log sul server di autenticazione e includono dettagli quali:
  - Durata totale della sessione.
  - Quantità di dati inviati e ricevuti (byte loggati).
  - Indirizzo IP assegnato.
  - Comandi effettivamente digitati (nel caso di sessioni CLI).
- **Scopo**: L'analisi dei log serve per scopi di auditing (rilevamento di azioni indesiderate o non autorizzate), troubleshooting e statistiche di utilizzo.

___
# Network Access Server

Il NAS, *Network Access Server*, è il dispositivo di rete che fa da gateway e punto di accesso per gli utenti remoti (es. il concentratore VPN o il router di bordo).
- **Ruolo**: Il NAS non contiene direttamente il database delle credenziali degli utenti. Quando un utente tenta di connettersi, il NAS intercetta le credenziali e le inoltra a un server AAA centralizzato (es. Cisco ISE) utilizzando i protocolli RADIUS o TACACS+.
- **Risposta**: Il server centralizzato risponde al NAS confermando l'identità (Authentication), indicando i permessi associati (Authorization) e registrando l'inizio della sessione (Accounting).

```
Utente ──► [ NAS / Concentratore VPN ] ──► (Inoltra credenziali) ──► [ Server AAA Centralizzato ]
                                  ◄── (OK + Policy d'accesso) ◄──┘
```

___
# Protocolli AAA

La comunicazione tra il NAS e il server AAA centralizzato avviene tramite due protocolli principali.

## Remote Authentication Dial-In User Service
Il RADIUS, *Remote Authentication Dial-In User Service*, è un protocollo standard aperto (RFC 2865).
- **Trasporto**: Usa UDP (porte 1812 per autenticazione/autorizzazione e 1813 per accounting).
- **Sicurezza**: Cifra unicamente il campo password nei pacchetti; il resto dell'header e del payload transita in chiaro.
- **Modo d'uso**: Combina le fasi di Autenticazione e Autorizzazione in un unico flusso logico. È ideale per la gestione degli accessi utente alla rete (es. VPN, reti Wi-Fi 802.1X).

## Terminal Access Controller Access-Control System Plus
Il TACACS+, *Terminal Access Controller Access-Control System Plus*, è un protocollo proprietario Cisco (rilasciato poi come standard aperto).
- **Trasporto**: Usa TCP (porta 49), garantendo maggiore affidabilità a livello trasporto.
- **Sicurezza**: Cifra l'intero corpo del pacchetto, offrendo un livello di riservatezza superiore rispetto a RADIUS.
- **Modo d'uso**: Separa nettamente le tre funzioni di Autenticazione, Autorizzazione ed Accounting. È ideale per il controllo degli accessi amministrativi sui dispositivi di rete (es. tracciamento dei comandi impartiti dagli ingegneri di rete).

## Confronto RADIUS Vs TACACS+

| Caratteristica | RADIUS | TACACS+ |
| :--- | :--- | :--- |
| **Standard** | Aperto (IETF) | Sviluppato da Cisco |
| **Protocollo di Trasporto** | **UDP** (Porte 1812/1813) | **TCP** (Porta 49) |
| **Cifratura** | Solo la password | **Tutto il corpo** del pacchetto |
| **Separazione AAA** | No (Autenticazione/Autorizzazione unite) | **Sì** (Autenticazione, Autorizzazione, Accounting distinte) |
| **Uso Tipico** | Accesso alla rete (VPN, 802.1X) | Amministrazione dei dispositivi (Device Administration) |

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **AAA Definizione** | **A**uthentication (Chi sei), **A**uthorization (Cosa puoi fare), **A**ccounting (Cosa hai fatto). |
| **RADIUS Porte** | **UDP 1812** (Auth) e **UDP 1813** (Acct). |
| **TACACS+ Porta** | **TCP 49**. |
| **Cifratura TACACS+** | Cifra l'intero pacchetto (tranne l'header di controllo), rendendolo più sicuro per la gestione interna. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Il NAS memorizza le password di tutti gli utenti VPN** | **FALSO**. Il NAS (es. switch, router, firewall) è solo un intermediario. Inoltra le credenziali al server AAA (es. server RADIUS) che interroga il database centrale (es. Active Directory). |
| **RADIUS usa TCP per garantire l'affidabilità** | **FALSO**. RADIUS si appoggia a **UDP**, gestendo le ritrasmissioni e i timeout direttamente a livello applicativo. TACACS+ utilizza invece **TCP**. |
| **L'accounting impedisce agli utenti di eseguire comandi vietati** | **FALSO**. Quello è compito dell'**Autorizzazione** (Authorization). L'**Accounting** si limita a documentare e salvare nei log le azioni intraprese, a fini di audit e verifica postuma. |

___
# Quick Reference Card

```
AAA (AUTHENTICATION, AUTHORIZATION, ACCOUNTING):
  - Authentication -> Verifica identità (Login, password, Multi-Factor Auth)
  - Authorization  -> Definisce i privilegi (Policy d'accesso a risorse/comandi)
  - Accounting     -> Traccia le attività (Durata sessione, byte inviati/ricevuti, log)

CONFRONTO PROTOCOLLI:
  - RADIUS:
    * UDP (1812 / 1813)
    * Cifra solo la password
    * Unisce Auth/Authz
    * Ideale per Network Access (es. VPN, Wi-Fi 802.1X)
  - TACACS+:
    * TCP (49)
    * Cifra l'intero payload
    * Separa nettamente A - A - A
    * Ideale per Device Administration (es. tracciamento comandi router/switch)
```
___
--Gemini

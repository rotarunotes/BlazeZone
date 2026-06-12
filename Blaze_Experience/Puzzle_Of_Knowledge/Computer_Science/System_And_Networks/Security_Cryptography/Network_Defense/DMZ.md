Data: 2026-06-11
[Network_Defense](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Network_Defense
___
# Index
- [[#DMZ]]
	- [[#Panoramica]]
- [[#Demilitarized Zone]]
	- [[#Scopo E Funzionamento]]
- [[#Servizi Esposti]]
- [[#Architetture DMZ]]
	- [[#Architettura A Firewall Singolo]]
	- [[#Architettura A Doppio Firewall]]
- [[#Proxy Server E Sicurezza]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _DMZ_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Nome Esteso** | DMZ, *Demilitarized Zone* |
| **Definizione** | Sotto-rete logica o fisica che separa la LAN privata interna da una rete pubblica insicura come Internet |
| **Servizi Ospitati** | Web server, Mail server, FTP server, DNS pubblico, proxy |
| **Obiettivo Principale** | Proteggere la rete LAN interna in caso di compromissione dei server pubblici |

___
# Demilitarized Zone

Una DMZ, *Demilitarized Zone*, rappresenta un'area perimetrale di difesa all'interno dell'infrastruttura di rete di un'organizzazione. 

## Scopo E Funzionamento
I server che devono essere accessibili da utenti esterni via Internet (es. il sito web aziendale) sono intrinsecamente più vulnerabili agli attacchi rispetto ai sistemi interni. 
- **Isolamento**: Invece di posizionare questi server direttamente all'interno della rete locale (LAN), vengono inseriti nella DMZ.
- **Politiche di Sicurezza**: Le regole di sicurezza configurate sul firewall consentono agli utenti esterni di accedere unicamente ai servizi esposti nella DMZ, bloccando qualsiasi tentativo di connessione diretta da Internet verso la LAN interna.
- **Contenimento**: Se un server situato nella DMZ viene compromesso da un hacker, la LAN privata rimane protetta poiché il firewall limita rigorosamente anche il traffico in uscita dalla DMZ verso l'interno della LAN.

___
# Servizi Esposti

Tutti i servizi rivolti a utenti esterni all'organizzazione dovrebbero risiedere all'interno della DMZ. Esempi comuni includono:
- **WEB Server**: Fornisce l'accesso al sito pubblico aziendale o ad applicazioni web.
- **MAIL Server**: Gestisce la ricezione delle email provenienti dall'esterno.
- **FTP Server**: Consente il trasferimento di file da e verso l'esterno.
- **VoIP Server**: Gestisce le comunicazioni telefoniche via IP, *Internet Protocol*.
- **DNS Server Pubblico**: Risolve i nomi di dominio dell'azienda per gli utenti esterni.

> [!CAUTION] Gestione Database
> Molti server web o mail necessitano di accedere a database interni (contenenti dati sensibili dei clienti). Per ragioni di sicurezza, il database reale deve risiedere nella LAN protetta, consentendo al server web in DMZ di comunicare con esso solo su porte specifiche (es. porta 3306 per MySQL) e sotto lo stretto controllo di un application firewall.

___
# Architetture DMZ

Esistono due approcci principali per strutturare una DMZ a seconda del livello di ridondanza e sicurezza richiesto.

## Architettura A Firewall Singolo
Chiamata anche **architettura a tre gambe** (*three-homed firewall*). Utilizza un unico firewall fisico dotato di almeno tre interfacce di rete distinte:
1. **Interfaccia WAN**: Collegata a Internet (rete pubblica).
2. **Interfaccia DMZ**: Collegata alla sotto-rete perimetrale dei server esposti.
3. **Interfaccia LAN**: Collegata alla rete privata interna protetta.

```
                  Internet (WAN)
                        │
                        ▼
                 [ FIREWALL ] ──► DMZ (Server Web, Mail, FTP)
                        │
                        ▼
                    LAN Interna
```

## Architettura A Doppio Firewall
Utilizza due firewall disposti in serie per creare una zona intermedia protetta (la DMZ):
- **Firewall Esterno**: Posizionato tra Internet e la DMZ. Filtra il traffico in ingresso permettendo solo le connessioni destinate ai server esposti.
- **Firewall Interno**: Posizionato tra la DMZ e la LAN privata. Filtra il traffico dalla DMZ alla rete interna, applicando regole molto restrittive.

```
Internet ──► [ FIREWALL ESTERNO ] ──► DMZ ──► [ FIREWALL INTERNO ] ──► LAN Interna
```
> [!TIP] Vantaggio
> L'architettura a doppio firewall è più sicura: se un attaccante riesce a compromettere il primo firewall (esterno), deve comunque superare un secondo dispositivo (spesso di un produttore diverso per evitare le stesse vulnerabilità) prima di accedere alla LAN.

___
# Proxy Server E Sicurezza

All'interno della DMZ vengono solitamente installati anche i **proxy server**:
- **Forward Proxy**: Intercetta le richieste di navigazione degli host interni dirette verso Internet, registrandole, filtrando i contenuti web dannosi ed effettuando caching.
- **Reverse Proxy**: Riceve le richieste degli utenti esterni dirette ai server web interni, nascondendo la reale struttura della rete e distribuendo il carico di lavoro tra più server (load balancing).

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Zona perimetrale a sicurezza intermedia per l'esposizione di servizi pubblici. |
| **Politica DMZ -> LAN** | Deve essere bloccata di default; sono permesse solo risposte a connessioni avviate dalla LAN o flussi specifici tracciati. |
| **Firewall a tre gambe** | Configurazione economica che usa un solo apparato con 3 interfacce. |
| **Firewall doppio** | Configurazione a massima sicurezza con DMZ racchiusa tra due barriere hardware separate. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **La DMZ è una zona priva di qualsiasi regola di sicurezza** | **FALSO**. La DMZ ha meno restrizioni rispetto alla LAN interna per consentire l'accesso da Internet ai server pubblici, ma il traffico in ingresso è comunque strettamente filtrato (sono aperte solo le porte dei servizi esposti, es. 80, 443). |
| **I database aziendali devono risiedere nella DMZ per velocizzare le query del sito web** | **FALSO**. I database contenenti informazioni sensibili non devono mai essere esposti in DMZ. Devono risiedere nella LAN interna protetta; il web server in DMZ comunicherà con essi tramite regole firewall mirate. |
| **Se un server in DMZ viene compromesso, l'intera LAN interna è persa** | **FALSO**. Lo scopo primario della DMZ è proprio contenere l'attacco. Il firewall blocca il traffico orizzontale (lateral movement) dalla DMZ verso la LAN. |

___
# Quick Reference Card

```
DMZ (DEMILITARIZED ZONE):
  - Area a sicurezza intermedia tra LAN e WAN
  - Ospita server pubblici (Web, Mail, DNS, FTP, VoIP, Proxy)
  - Limita i danni in caso di violazione (contenimento dell'attacco)

ARCHITETTURE:
  1. Singolo Firewall (3-Homed):
     - Unico apparato, 3 interfacce (WAN, DMZ, LAN)
     - Più economico, punto singolo di fallimento (SPOF)
  2. Doppio Firewall:
     - Due apparati in serie (Esterno ed Interno)
     - DMZ al centro delle due barriere
     - Massima sicurezza (difesa in profondità)
```
___
--Gemini
Data: 2026-06-11
[Secure_Connectivity](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Secure_Connectivity
___
# Index
- [[#VPN]]
	- [[#Panoramica]]
- [[#Virtual Private Network]]
	- [[#Vantaggi Rispetto Alle Linee Dedicate]]
	- [[#Svantaggi E Criticità]]
- [[#Tipologie Di VPN]]
	- [[#Remote-Access VPN]]
	- [[#Site-To-Site VPN]]
- [[#Componenti Di Sicurezza]]
- [[#Classificazione In Base Alla Sicurezza]]
	- [[#Trusted VPN]]
	- [[#Secure VPN]]
	- [[#Hybrid VPN]]
- [[#Tunneling Senza Cifratura]]
	- [[#Generic Routing Encapsulation]]
- [[#Altri Utilizzi Delle VPN]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _VPN_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Rete privata logica creata all'interno di un'infrastruttura di rete pubblica come Internet |
| **Scopo** | Collegare in modo sicuro host remoti o sedi aziendali dislocate geograficamente |
| **Tecnologie Chiave** | Cifratura, Tunneling, AAA |
| **Classificazione** | Trusted, Secure, Hybrid |

___
# Virtual Private Network

Una VPN, *Virtual Private Network*, consente di emulare il comportamento di una rete locale (LAN) protetta sfruttando l'estensione geografica e la ridondanza tipica delle reti WAN pubbliche. Evita alle aziende di dover noleggiare costosi cablaggi o linee dedicate esclusive (*leased lines*) per scambiarsi informazioni in modo riservato.

## Vantaggi Rispetto Alle Linee Dedicate
- **Costi ridotti**: Sfruttando la connettività Internet ordinaria, i costi di attivazione e manutenzione sono notevolmente più bassi.
- **Scalabilità**: È semplice aggiungere nuove sedi o utenti remoti alla VPN configurando solo i parametri software del gateway.
- **Ridondanza**: Il traffico sfrutta l'infrastruttura di Internet, che instrada dinamicamente i pacchetti lungo percorsi alternativi in caso di guasto.
- **Flessibilità**: Permette la riconfigurazione logica immediata dei collegamenti.

## Svantaggi E Criticità
- **Latenza variabile**: Il traffico transita su Internet, soggetto a congestione e ritardi non controllabili direttamente dall'organizzazione.
- **Complessità di sicurezza**: L'esposizione pubblica richiede controlli rigorosi sull'autenticazione degli utenti e sulla crittografia dei dati per prevenirne l'intercettazione.

___
# Tipologie Di VPN

## Remote-Access VPN
Consente a singoli utenti remoti (es. lavoratori in smart working) di stabilire una connessione cifrata e sicura verso la rete LAN aziendale protetta.
- **Funzionamento**: L'utente installa un client software sul proprio PC (o usa un portale web SSL) che effettua il login verso il concentratore VPN aziendale (NAS).
- **Risultato**: Il computer remoto riceve un indirizzo IP della LAN interna e può accedere a server, file e stampanti privati come se si trovasse fisicamente in ufficio.

## Site-To-Site VPN
Collega intere sotto-reti locali (LAN) di sedi distanti geograficamente per creare un'unica rete WAN privata aziendale.
- **Funzionamento**: I router gateway situati al bordo delle rispettive sedi stabiliscono un tunnel cifrato permanente (tipicamente usando IPsec). Gli host delle singole reti locali comunicano tra loro in modo trasparente, senza necessità di software client individuali.
- **Sotto-tipologie**:
  - **Intranet VPN**: Collega diverse filiali o sedi distaccate appartenenti alla medesima organizzazione.
  - **Extranet VPN**: Consente a società partner o fornitori esterni di condividere un canale sicuro per accedere in modo limitato solo a specifiche risorse della rete aziendale.

___
# Componenti Di Sicurezza

Per implementare una VPN sicura sopra l'infrastruttura pubblica, si combinano tre elementi essenziali:
1. **Procedura AAA**: Autenticazione (Authentication) dell'identità tramite username/password e MFA; Autorizzazione (Authorization) dell'accesso selettivo tramite policy; Accounting per tracciare i log di sessione (durata e byte scambiati).
2. **Cifratura**: Offre la riservatezza tramite algoritmi di crittografia simmetrica (AES, 3DES).
3. **Tunneling**: Protocollo che incapsula un pacchetto dati privato all'interno di un nuovo pacchetto di trasporto (carrier) pubblico per instradarlo in sicurezza attraverso la rete.

___
# Classificazione In Base Alla Sicurezza

Il livello di sicurezza e riservatezza dei dati definisce tre modelli di VPN:

## Trusted VPN
La riservatezza del canale non è delegata alla crittografia dei dati, ma è garantita dal provider di servizi Internet (ISP).
- **Funzionamento**: L'ISP instrada il traffico del cliente all'interno di circuiti dedicati ed isolati (es. tramite protocolli BGP/MPLS), assicurando che nessun utente terzo possa accedervi e offrendo garanzie di larghezza di banda e bassa latenza (QoS).
- **Criticità**: Non applicano crittografia o tunneling sui dati, che viaggiano in chiaro all'interno dell'infrastruttura protetta del provider.

## Secure VPN
Il traffico viene protetto tramite algoritmi di cifratura forte e protocolli di tunneling gestiti direttamente dall'azienda (es. IPsec o SSL/TLS).
- **Funzionamento**: Garantisce riservatezza, integrità e autenticazione indipendentemente dall'infrastruttura di rete fisica attraversata.

## Hybrid VPN
Unisce i vantaggi dei due modelli precedenti, facendo transitare una VPN protetta (Secure VPN) all'interno di una rete virtuale isolata e gestita dal provider (Trusted VPN), unendo la riservatezza del tunnel cifrato alle prestazioni garantite dal provider (QoS).

___
# Tunneling Senza Cifratura

## Generic Routing Encapsulation
Il GRE, *Generic Routing Encapsulation*, è un protocollo di tunneling di base (sviluppato da Cisco) che incapsula un'ampia varietà di protocolli di rete all'interno di collegamenti IP virtuali point-to-point.
- **Rischio**: **GRE non supporta alcun tipo di crittografia o autenticazione**. Tutti i dati che transitano in un tunnel GRE viaggiano in chiaro su Internet.
- **Uso combinato**: Per rendere sicuro un tunnel GRE, lo si incapsula all'interno di IPsec (modalità GRE-over-IPsec), unendo la capacità di GRE di trasportare traffico multicast e di routing all'affidabilità crittografica di IPsec.

___
# Altri Utilizzi Delle VPN

Oltre all'amministrazione e al collegamento aziendale, le connessioni VPN crittografate vengono utilizzate a livello personale per:
- **Nascondere l'indirizzo IP**: Mascherare l'indirizzo IP reale dell'utente per tutelare la privacy ed evitare il tracciamento pubblicitario.
- **Aggirare restrizioni geografiche**: Accedere a servizi streaming, cataloghi e siti web limitati geograficamente simulando la connessione da un altro paese.
- **Sicurezza in reti pubbliche**: Proteggere l'home banking o l'immissione di dati sensibili (come numeri di carte di credito) quando ci si connette a Wi-Fi pubbliche non protette.
- **Gaming**: Ridurre il routing asimmetrico o evitare attacchi DDoS diretti al proprio IP domestico.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Site-to-Site vs Remote** | Site-to-Site collega LAN-to-LAN (trasparente per gli host); Remote Access collega Host-to-LAN (richiede client o browser). |
| **Extranet** | VPN condivisa tra due o più aziende partner distinte. |
| **GRE** | Protocollo di tunneling che **NON cifra i dati** di default. |
| **Trusted VPN** | Sicurezza gestita dall'ISP (es. MPLS) basata sull'isolamento del percorso, non sulla cifratura dei dati. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Un tunnel GRE protegge i file da intercettazioni** | **FALSO**. GRE si limita ad incapsulare il traffico (es. per trasportare pacchetti di routing come OSPF non supportati nativamente da IPsec standard), ma non applica alcuna cifratura. Chiunque catturi il pacchetto su Internet può leggerne il contenuto in chiaro. |
| **Tutte le VPN cifrano il traffico** | **FALSO**. Le *Trusted VPN* (come le reti MPLS fornite dagli ISP) non cifrano i dati, ma garantiscono la sicurezza solo isolando fisicamente o logicamente il traffico all'interno della rete del provider. |
| **Con la VPN Site-to-Site ogni dipendente in sede deve installare un software client** | **FALSO**. La cifratura e il tunneling vengono eseguiti a livello hardware dal router gateway della sede. Per i dispositivi interni alla LAN, la connessione verso la sede remota è trasparente. |

___
# Quick Reference Card

```
VPN (VIRTUAL PRIVATE NETWORK):
  - Rete privata logica sopra rete pubblica (Internet)
  - Elementi core: Cifratura (Confidenzialità), Tunneling (Incapsulamento), AAA (Accesso)

TIPOLOGIE:
  - Remote Access -> Utente a LAN (Lavoratori remoti, client software / SSL portal)
  - Site-to-Site  -> LAN a LAN (Router-to-Router, permanente, Intranet o Extranet)

SICUREZZA (CLASSIFICAZIONE):
  - Trusted VPN -> Sicurezza da isolamento dell'ISP (QoS alto, no cifratura)
  - Secure VPN  -> Sicurezza crittografica autonoma (IPsec / SSL / TLS)
  - Hybrid VPN  -> Tunnel Secure all'interno di un canale Trusted dell'ISP

PROTOCOLLI CHIAVE:
  - IPsec -> Layer 3 tunneling cifrato (Site-to-Site e Remote Access)
  - SSL   -> Layer 5 sessione, client/server (Remote Access)
  - GRE   -> Tunneling semplice, NO CIFRATURA, supporta multicast/routing
```
___
--Gemini

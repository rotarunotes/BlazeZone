Benvenuto. È un'ottima decisione quella di affrontare le VPN (Virtual Private Network) in ottica progettuale. All'Esame di Stato, i commissari non si accontentano di definizioni a memoria: vogliono vedere come applichi questi concetti per garantire la sicurezza e l'interconnessione aziendale in uno scenario reale.

Procediamo con il nostro metodo ingegneristico: estrazione dei pilastri teorici dal PDF e successiva applicazione a una traccia in stile seconda prova.

# 1. Riassunto Tecnico: Virtual Private Network (VPN)

Le VPN nascono per superare gli svantaggi delle reti private fisiche dedicate (costi altissimi, scarsa scalabilità, assenza di ridondanza) sfruttando l'infrastruttura pubblica (Internet) per creare connessioni virtuali sicure. Offrono costi ridotti, scalabilità e ridondanza, ma introducono sfide legate alla latenza, all'autenticazione e alla sicurezza delle trasmissioni.

## 1.1 Architetture VPN

Esistono due modelli architetturali principali:

- **Remote-Access VPN:** Consente a utenti remoti (es. smart worker) di stabilire una connessione sicura con la LAN aziendale. Emula il desktop situato in ufficio, permettendo l'accesso alle risorse come se si fosse collegati fisicamente alla rete.
    
- **Site-to-Site VPN:** Collega tra loro intere LAN attraverso la rete pubblica (LAN-to-LAN), creando una vera e propria WAN privata. Può essere una _Intranet_ (sedi della stessa società) o una _Extranet_ (sedi di società diverse che condividono risorse).
    

## 1.2 I Pilastri della Sicurezza: AAA e Tunneling

Poiché le VPN viaggiano su Internet, la sicurezza è demandata a server NAS (Network Access Server) e Security Gateway. I fattori chiave sono:

1. **Procedura AAA:**
    
    - _Authentication:_ Verifica l'identità del sistema/utente (es. login, MultiFactor Authentication - MFA).
        
    - _Authorization:_ Definisce le policy di accesso e i permessi una volta superata l'autenticazione.
        
    - _Accounting:_ Registra nei file di log le attività (durata sessione, dati trasferiti) per controlli o fini statistici.
        
2. **Cifratura:** Utilizzo di algoritmi (es. 3DES, IDEA) concordati per nascondere il contenuto della comunicazione.
    
3. **Tunneling:** Aggiunge un livello di sicurezza incapsulando il pacchetto originale (Passenger Protocol) in un Tunneling Protocol, che a sua volta viaggia su un Carrier Protocol (es. IPv4).
    

## 1.3 Protocolli di Sicurezza: IPsec vs SSL/TLS

Il documento evidenzia due protocolli fondamentali per la creazione di tunnel sicuri:

### A. Protocollo IPsec (Livello Network)

È una suite di protocolli operante a livello 3 (Rete), utilizzabile sia per Remote-Access che per Site-to-Site. Si basa su tre componenti:

- **AH (Authentication Header):** Fornisce autenticazione, integrità e protezione da attacchi _replay_, ma **non cifra** il payload.
    
- **ESP (Encapsulating Security Payload):** Fornisce tutti i servizi di AH e aggiunge la **confidenzialità** (cifratura dei dati).
    
- **IKE (Internet Key Exchange):** Gestisce automaticamente la creazione delle _Security Association_ (SA), collegamenti logici peer-to-peer unidirezionali tra i Security Gateway. Le SA attive sono salvate nel **SAD** (Security Association Database), mentre le regole di routing sicuro (scartare, inoltrare in chiaro, inoltrare in IPsec) risiedono nel **SPD** (Security Policy Database).
    

**Modalità operative di IPsec:**

- _Modalità Trasporto:_ Usata per Remote-Access, cifra solo il payload TCP/UDP mantenendo l'Header IP originale in chiaro.
    
- _Modalità Tunneling:_ Usata per Site-to-Site, cifra l'intero pacchetto originario e aggiunge un Nuovo Header IP.
    

### B. Protocollo SSL/TLS (Livello Session)

Operante a livello 5 (Sessione), è basato su un'architettura Client/Server ed è tipicamente usato per le Remote-Access VPN. La connessione avviene tramite uno scambio di certificati digitali e la negoziazione di chiavi pre-master (handshake) per stabilire un canale crittografato che protegge il traffico TCP.

|**Caratteristica**|**IPsec**|**SSL/TLS**|
|---|---|---|
|**Architettura**|Complessa (3 protocolli), Peer-to-Peer|Semplice (1 protocollo), Client/Server|
|**Livello OSI**|Network (Livello 3)|Session (Livello 5)|
|**Traffico protetto**|Tutto il traffico IP|Traffico TCP specifico|

## 1.4 Classificazione in base alla Sicurezza

- **Trusted VPN:** La sicurezza (QoS) è demandata all'ISP, senza cifratura o tunneling.
    
- **Secure VPN:** Utilizzano protocolli per cifratura e tunneling, garantendo autenticazione ed elevata crittografia.
    
- **Hybrid VPN:** Utilizzano una Secure VPN come parte di una rete Trusted VPN.
    

---

# 2. Caso Aziendale: "TechLogistics S.p.A." (Simulazione Seconda Prova)

**Scenario:** L'azienda TechLogistics possiede una Sede Centrale a Milano e una Filiale Operativa a Roma. Inoltre, vanta un team di 50 agenti commerciali che lavorano in mobilità. Il candidato deve progettare l'infrastruttura logica per permettere alla filiale e agli agenti di accedere ai server gestionali di Milano in totale sicurezza tramite Internet.

### 2.1 Analisi dei Requisiti e Architettura

L'azienda necessita di un approccio ibrido alle VPN:

1. **Collegamento Milano - Roma:** Richiede una connettività continua, trasparente per gli host delle LAN e indipendente dai dispositivi. Realizzeremo una **Site-to-Site VPN**.
    
2. **Collegamento Agenti in mobilità:** Richiede l'accesso da dispositivi diversi (laptop, tablet) via Internet. Realizzeremo una **Remote-Access VPN**.
    

### 2.2 Dimensionamento e Schema Indirizzamento IP

Adotteremo indirizzamento privato conforme alla RFC 1918.

Plaintext

```
Spazio Aziendale: 10.0.0.0 /16
- Sede Milano (HQ):       10.0.10.0 /24  (Gateway/Security Gateway: 10.0.10.1)
- Filiale Roma:           10.0.20.0 /24  (Gateway/Security Gateway: 10.0.20.1)
- Pool IP Remote Access:  10.0.30.0 /24  (Assegnati dinamicamente agli agenti)
```

### 2.3 Scelte Tecnologiche di Sicurezza

- **VPN Site-to-Site (Milano-Roma):**
    
    - _Protocollo:_ Scegliamo **IPsec in Modalità Tunneling**. Questo perché dobbiamo incapsulare e proteggere il traffico tra due intere LAN, generando un nuovo Header IP (quello pubblico dei due router ISP).
        
    - _Componenti:_ Utilizzeremo il protocollo **IKE** per stabilire automaticamente le Security Association (SA) tra i due router di confine (Security Gateway). Per garantire l'integrità, l'autenticazione e soprattutto la _confidenzialità_ dei dati aziendali, configureremo il protocollo **ESP** (Evitiamo AH da solo, poiché non cifra i dati).
        
    - _Logica di Routing (SPD):_ Il router di Milano verificherà il _Security Policy Database (SPD)_; se il pacchetto in uscita è destinato a `10.0.20.0/24` (Roma), applicherà le direttive IPsec, incapsulerà il pacchetto e lo invierà.
        
- **VPN Remote-Access (Agenti Commerciali):**
    
    - _Protocollo:_ Scegliamo **SSL/TLS**. È un'architettura Client/Server operante a livello Session. È l'ideale per i dipendenti remoti perché non richiede configurazioni di rete complesse sui loro dispositivi: spesso basta un browser web o un client leggero per validare il certificato del Server VPN aziendale e instaurare una sessione protetta.
        
    - _Sicurezza Aggiuntiva:_ Per l'autenticazione degli agenti applicheremo una rigorosa policy AAA, richiedendo una MultiFactor Authentication (MFA).
        

### 2.4 Diagramma Logico Testuale

Plaintext

```
                                        [INTERNET]
                                            |
      =============================================================================
      | (Tunnel IPsec ESP)                                       | (Connessione SSL/TLS)
      |                                                          |
[Router/Security GW ROMA]                                [Agente Commerciale]
WAN IP: 203.0.113.2                                      IP Dinamico (ISP pubblico)
LAN IP: 10.0.20.1                                        IP Virtuale: 10.0.30.X
      |                                                          |
[Switch LAN Roma]                                                V
      |---------------- [PC Roma: 10.0.20.10]                    |
                                                                 |
===================================================================================
      |
[Router/Security GW MILANO (HQ)]
WAN IP: 198.51.100.2
LAN IP: 10.0.10.1
      | (Consulta SPD e SAD per instradare le VPN verso i Server interni)
[Switch Core Milano]
      |---------------- [Server Gestionale: 10.0.10.100]
      |---------------- [PC Milano: 10.0.10.10]
```

---

# 3. Tips per la Maturità

1. **Distingui AH da ESP (Errore classico):** Molti studenti scrivono che "IPsec usa AH per criptare". È **sbagliato**. AH garantisce solo autenticazione e integrità. È **ESP** che si occupa della confidenzialità (cifratura) dei dati. Se in un tema d'esame devi proteggere segreti industriali, specifica di voler configurare _IPsec con ESP_.
    
2. **Trasporto vs Tunneling:** Fai ben capire al commissario che hai compreso la differenza. Se colleghi due router per unire due sedi (Site-to-Site), usa la modalità _Tunneling_ (aggiunge un nuovo header IP pubblico nascondendo gli IP privati interni). Se colleghi un PC remoto, puoi citare la modalità _Trasporto_ (o meglio ancora usare SSL/TLS).
    
3. **Il ruolo di IKE:** Menziona sempre il protocollo IKE quando parli di IPsec. Dimostra che sai che le chiavi crittografiche non vengono inserite "a mano" ogni volta, ma c'è un protocollo dedicato a livello applicativo che gestisce automaticamente le _Security Association (SA)_ in modo peer-to-peer.
    
4. **Vocabolario di Sicurezza:** Quando parli del controllo accessi degli smart worker, usa l'acronimo **AAA** (Authentication, Authorization, Accounting). Dà immediatamente al tuo elaborato un tono altamente professionale e ingegneristico.
    

Senti di aver assimilato bene il meccanismo con cui il router consulta il database SPD per decidere se un pacchetto deve essere incapsulato nel tunnel IPsec o semplicemente scartato?
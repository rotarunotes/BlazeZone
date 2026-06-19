Vado a svolgere la prova completa di Sistemi e Reti per l'Esame di Stato 2024.Ecco la soluzione completa della prova di Sistemi e Reti 2024.

---

# PRIMA PARTE

## Punto 1 — Descrizione e schema dell'infrastruttura di rete**Piano di indirizzamento — ipotesi aggiuntive**

La rete regionale usa lo spazio `10.0.0.0/8` suddiviso per tipologia di struttura:

|Tipologia|Sottorete assegnata|
|---|---|
|Enti locali|10.10.0.0/16|
|Scuole|10.20.0.0/16|
|Sanità pubblica|10.50.0.0/16|
|**Sanità privata convenzionata (NUOVA)**|**10.100.0.0/16**|

La sottorete `10.100.0.0/16` mette a disposizione 65.534 host. Per connettere circa 2000 strutture garantendo almeno 8 indirizzi ciascuna, si assegna a ogni struttura una sottorete `/28` (16 indirizzi, 14 utilizzabili per host + indirizzo di rete + broadcast), che offre ampio margine di crescita. Con una `/28` si possono ospitare fino a 4096 strutture (`65536 / 16 = 4096`), ben oltre le 2000 previste.

Esempi di assegnazione:

- Struttura 1: `10.100.0.0/28` (host da .1 a .14)
- Struttura 2: `10.100.0.16/28`
- Struttura N: `10.100.0.0 + N×16`

La sottorete è configurata senza default gateway verso Internet: il routing consente solo il traffico verso il data-center (`10.100.0.0/16` → solo verso la rete del DC), applicando politiche di filtering sul core router.

---

## Punto 2 — Dispositivo fornito alle strutture private

Ogni struttura riceve un **router/firewall gestito da remoto** (CPE — Customer Premises Equipment) con le seguenti caratteristiche:

**Tipologia**: Router firewall di fascia professionale (es. MikroTik RB4011, Cisco ISR 1100, Fortinet FortiGate 40F o equivalenti), gestito tramite protocollo sicuro (SSH/HTTPS/TR-069) dalla società regionale.

**Porte hardware**:

- 1 porta **WAN** (SFP o RJ-45 Gigabit) → collegamento alla fibra regionale (rete `10.100.x.x/28`)
- 4 porte **LAN** (RJ-45 Gigabit) → rete interna della struttura privata
- 1 porta di **management** out-of-band (RJ-45) → accesso remoto sicuro per la società regionale

**Configurazione delle porte**:

|Porta|Indirizzo|Funzione|
|---|---|---|
|WAN|`10.100.x.1/28` (assegnato dalla società regionale)|Collegamento alla rete fibra|
|LAN (gateway interno)|`192.168.1.1/24` (o schema interno della struttura)|Default gateway per la LAN locale|
|Management|Indirizzo dedicato su VLAN di gestione|Accesso remoto operatori regionali|

**Servizi configurati sul dispositivo**:

- **Firewall stateful** con regole che permettono solo il traffico dalla LAN locale verso il data-center (nessun accesso alle altre strutture private o a Internet)
- **NAT/PAT** (se la struttura usa indirizzi privati interni diversi dalla `/28` assegnata)
- **VPN IPsec o TLS** verso il data-center per cifrare tutti i flussi sanitari
- **QoS** per dare priorità al traffico verso il data-center rispetto ad altri flussi interni
- **ACL** che bloccano il traffico tra la sottorete `10.100.0.0/16` di una struttura e le sottoreti delle altre strutture
- **NTP** sincronizzato con il server regionale, necessario per i log e la schedulazione dei trasferimenti
- **Syslog remoto** verso la società regionale per monitoraggio e audit
- **SNMP v3** (o protocollo equivalente) per il monitoraggio dello stato del dispositivo da remoto

---

## Punto 3 — Integrazione con la LAN pre-esistente della struttura

Una struttura sanitaria privata convenzionata tipica dispone già di una LAN con switch, server interni (gestione pazienti, immagini DICOM, ecc.) e PC client.

**Scenario tipico e interventi necessari**:

Il CPE fornito dalla società regionale si inserisce tra la fibra regionale e la rete locale esistente. Se la struttura usa già un proprio router/firewall, si applicano due opzioni:

_Opzione A — CPE come border router unico_: il router preesistente della struttura viene posto "a valle" del CPE regionale, come ulteriore layer di sicurezza interna. Il CPE regionale diventa il gateway verso la rete fibra, il router interno gestisce la LAN locale.

_Opzione B — doppia interfaccia sul CPE_: il CPE regionale gestisce sia la connessione WAN (fibra regionale) sia la LAN della struttura, rendendo superfluo il vecchio router di confine.

**Esempio pratico** (struttura con LAN 192.168.10.0/24):

|Elemento|Configurazione|
|---|---|
|CPE — porta WAN|`10.100.0.17/28` (assegnato dalla regione)|
|CPE — porta LAN|`192.168.10.1/24` (gateway interno)|
|Switch della struttura|Collegato alla porta LAN del CPE|
|Server applicativo interno|`192.168.10.10/24` — GW: `192.168.10.1`|
|PC client|`192.168.10.20-100/24` via DHCP dal CPE|

**Route statica aggiunta al CPE**: tutto il traffico verso `10.0.0.0/8` è instradato verso la rete fibra regionale; tutto il resto è bloccato (no Internet). Una ACL in uscita sulla porta WAN del CPE blocca esplicitamente i pacchetti con destinazione diversa dal range del data-center.

Eventuali apparati aggiuntivi consigliati: uno **switch gestito** (se non già presente) per segmentare tramite VLAN il traffico dei PC clinici da quello dei server di gestione; un **UPS** per garantire continuità del CPE durante i trasferimenti schedulati notturni.

---

## Punto 4 — Sicurezza e schedulazione dei trasferimenti

**Archiviazione sicura nel data-center**:

- I dati del Fascicolo Sanitario Elettronico sono archiviati con **cifratura a riposo** (AES-256) su storage ridondato (RAID 6 + backup off-site su storage secondario geograficamente separato).
- Controllo degli accessi basato su **RBAC** (Role-Based Access Control): medici, amministrativi e pazienti accedono solo ai dati di loro pertinenza.
- **Audit log** immodificabile di ogni accesso o modifica, conservato per almeno 10 anni (GDPR e normativa sanitaria).
- **Pseudonimizzazione** dei dati per le elaborazioni statistiche/anonime.

**Sicurezza in transito**:

- Tutti i trasferimenti avvengono su **tunnel VPN IPsec (IKEv2)** o in alternativa **TLS 1.3** con certificati X.509 emessi dalla CA regionale, garantendo confidenzialità e integrità dei dati.
- Autenticazione mutua (mutual TLS o certificati IPsec) tra il CPE della struttura e il concentratore VPN del data-center: solo i dispositivi censiti possono inviare dati.
- **Firma digitale** dei pacchetti di dati trasferiti per garantire l'integrità e la non ripudiabilità.

**Schedulazione dei trasferimenti**:

I dati delle prestazioni sanitarie si distinguono in due categorie:

_Dati urgenti/real-time_ (es. referti di pronto soccorso, esami di laboratorio con esito critico): trasferimento **immediato** non appena disponibili, tramite connessione VPN sempre attiva, con priorità QoS massima.

_Dati differibili_ (referti ambulatoriali ordinari, immagini diagnostiche, documentazione di visita): trasferimento in **finestre notturne programmate**, tipicamente tra le **01:00 e le 05:00**, quando il carico di rete è minimo. La schedulazione è gestita da un agent software installato sul server della struttura (o sul CPE stesso) tramite job pianificato (cron o task scheduler). Il trasferimento avviene per **batch cifrati** con checksum SHA-256 allegato; il data-center verifica l'integrità e restituisce un ACK di conferma. In assenza di ACK entro un timeout definito, il trasferimento viene ripetuto automaticamente nella finestra successiva.

---

# SECONDA PARTE

## Quesito I — Strategie contro la perdita di dati

**In caso di malfunzionamento della connessione durante il trasferimento**:

Il software di trasferimento sul server della struttura implementa un meccanismo di **checkpoint e ripresa** (resume): il trasferimento viene suddiviso in blocchi (es. da 10 MB ciascuno) e per ogni blocco completato e confermato dal data-center viene aggiornato un file di stato locale. In caso di interruzione, alla ripresa della connessione il trasferimento riprende dall'ultimo blocco confermato, evitando la ritrasmissione di dati già ricevuti.

I dati da trasmettere vengono conservati localmente in una **coda persistente** (queue su storage locale della struttura) fino alla conferma di ricezione da parte del data-center. Solo dopo l'ACK del DC il dato viene marcato come "trasferito" e può essere archiviato in sola lettura in locale.

**In caso di malfunzionamento dei sistemi di archiviazione**:

Il data-center implementa una strategia di archiviazione ridondante secondo la regola **3-2-1**:

- 3 copie dei dati
- su 2 supporti diversi (storage primario NAS/SAN + storage secondario a nastro o cloud privato)
- di cui 1 copia off-site (data-center di disaster recovery geograficamente separato)

I backup vengono eseguiti con politica **incrementale giornaliera** e **completa settimanale**, con verifica automatica dell'integrità dei backup (restore test periodico). Un sistema di **replica sincrona** tra storage primario e secondario garantisce RPO (Recovery Point Objective) prossimo a zero per i dati critici.

---

## Quesito II — Autenticazione qualificata a più fattori per il FSE

Per consentire al cittadino di accedere via web al proprio Fascicolo Sanitario Elettronico in modo sicuro, si adotta un sistema di autenticazione a più fattori (MFA). Le opzioni disponibili in Italia nell'ambito dei servizi pubblici digitali sono:

**SPID (Sistema Pubblico di Identità Digitale) di livello 2 o 3**: Il cittadino si autentica con le credenziali del proprio Identity Provider SPID. Il livello 2 richiede una password più un secondo fattore (OTP via app o SMS). Il livello 3 usa un certificato su smart card o dispositivo hardware (CNS/CIE). Questo è il metodo preferito in ambito sanitario italiano.

**CIE (Carta d'Identità Elettronica)** con lettore NFC o smart card: il cittadino usa la propria CIE come primo fattore (possesso del documento fisico) e il PIN della carta come secondo fattore (conoscenza). L'accesso avviene tramite il middleware CIE fornito dal Ministero dell'Interno.

**CNS (Carta Nazionale dei Servizi)** o Tessera Sanitaria abilitata: funziona come smart card con certificato digitale. Richiede lettore di smart card + PIN.

**App mobile con push notification**: dopo l'inserimento delle credenziali sul portale web, il sistema invia una notifica push all'app ufficiale installata sullo smartphone del cittadino (precedentemente registrato e abbinato all'account). Il cittadino approva l'accesso dall'app, che costituisce il secondo fattore (possesso del dispositivo).

Il flusso tipico di autenticazione a due fattori via SPID L2 è:

1. Il cittadino accede al portale FSE e sceglie "Accedi con SPID"
2. Viene reindirizzato all'Identity Provider prescelto
3. Inserisce username e password (primo fattore — conoscenza)
4. L'IdP invia un OTP temporaneo (TOTP via app autenticatore o SMS) come secondo fattore (possesso)
5. Dopo la verifica, l'IdP rilascia un'asserzione SAML o token OpenID Connect al portale FSE
6. Il portale FSE verifica il token e apre la sessione, mostrando solo i dati del paziente autenticato

---

## Quesito III — Configurazione router per web server con HTTP, HTTPS e SSH

**Scenario**: router con un solo IP pubblico statico (es. `203.0.113.10`), web server interno con IP privato (es. `192.168.1.100`).

La tecnica da usare è il **Port Forwarding (DNAT — Destination NAT)**, che reindirizza le connessioni in arrivo su specifiche porte pubbliche verso il server interno.

**Regole da configurare**:

|Servizio|Porta pubblica|IP/porta destinazione interna|
|---|---|---|
|HTTP|TCP 80|192.168.1.100:80|
|HTTPS|TCP 443|192.168.1.100:443|
|SSH|TCP 22|192.168.1.100:22|

**Motivazione delle scelte**: HTTP (porta 80) e HTTPS (porta 443) sono le porte standard per i web server; modificarle richiederebbe che i client specificassero la porta nell'URL. SSH usa convenzionalmente la porta 22; si potrebbe scegliere una porta non standard (es. 2222) per ridurre i tentativi di accesso automatizzati (sicurezza per oscurità), ma la scelta dipende dalla policy aziendale.

**Comandi iptables (Linux/router Linux-based)**:

```bash
# Abilita IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# DNAT: reindirizza le connessioni in arrivo sull'IP pubblico verso il server interno
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80  -j DNAT --to-destination 192.168.1.100:80
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to-destination 192.168.1.100:443
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 22  -j DNAT --to-destination 192.168.1.100:22

# MASQUERADE: garantisce che le risposte del server tornino attraverso il router
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# FORWARD: permette il transito dei pacchetti verso il server interno
iptables -A FORWARD -p tcp -d 192.168.1.100 --dport 80  -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -d 192.168.1.100 --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -d 192.168.1.100 --dport 22  -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
```

**Per rendere le regole persistenti al riavvio**:

```bash
iptables-save > /etc/iptables/rules.v4
```

Per router con interfaccia web (es. MikroTik, OpenWrt), le stesse regole si configurano tramite le sezioni "Firewall → NAT → Port Forwarding" dell'interfaccia grafica, specificando interfaccia esterna, protocollo, porta di destinazione esterna e indirizzo/porta interna.

**Considerazione di sicurezza aggiuntiva**: è buona pratica limitare l'accesso SSH tramite whitelist di IP sorgente (se il gestore ha IP fisso) e disabilitare l'autenticazione SSH tramite password, usando solo chiavi crittografiche.

---

## Quesito IV — Diagnosi impossibilità di navigare su Internet

Un tecnico help-desk che riceve la segnalazione "non riesco a navigare su Internet" deve procedere per livelli del modello ISO/OSI, partendo dal basso.

**Causa 1 — Problema a livello fisico/di rete locale (L1/L2)**

Il primo passo è verificare la connettività locale. Il tecnico usa il comando `ipconfig` (Windows) o `ip addr` (Linux) per verificare che il PC abbia un indirizzo IP valido (non del tipo `169.254.x.x`, che indica un fallimento DHCP). Se l'IP manca o è APIPA, il problema è nel cablaggio fisico (cavo scollegato, porta switch guasta) o nel server DHCP (non raggiungibile o esaurito il pool di indirizzi). Strumenti: controllo LED dello switch, `ipconfig /release` + `ipconfig /renew`, verifica del server DHCP.

**Causa 2 — Problema a livello di routing / gateway (L3)**

Se il PC ha un IP valido, il secondo passo è verificare la connettività verso il gateway: `ping 192.168.1.1` (o l'indirizzo del router). Se il ping al gateway fallisce, il problema è nella rete locale (switch, VLAN, configurazione del router). Se il ping al gateway ha successo ma Internet non funziona, il problema è a monte: il router non ha connettività verso l'esterno (linea ISP down, credenziali PPPoE errate, IP pubblico non assegnato). Strumenti: `ping`, `tracert`/`traceroute`, accesso all'interfaccia di gestione del router per verificare lo stato della WAN.

**Causa 3 — Problema DNS (L7 applicativo)**

Se il ping funziona verso IP pubblici noti (es. `ping 8.8.8.8` raggiunge Google) ma la navigazione web fallisce, il problema è nella risoluzione dei nomi DNS. Il browser non riesce a tradurre `www.esempio.it` in indirizzo IP. Il tecnico verifica la configurazione DNS del PC (`ipconfig /all`, voce "DNS Server") e prova a risolvere manualmente un nome con `nslookup www.google.com`: se il comando fallisce mentre il ping a 8.8.8.8 funziona, il server DNS configurato è irraggiungibile o non funzionante. La soluzione è cambiare il server DNS (es. impostare 8.8.8.8 o 1.1.1.1 manualmente) o verificare il server DNS aziendale. Strumenti: `nslookup`, `dig`, `ipconfig /all`.
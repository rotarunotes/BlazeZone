## Risoluzione di Mattia Scatto di sessione ordinaria 2024 di sistemi e reti
___
### Prima parte
#### Contesto e ipotesi aggiuntive
Il progetto coinvolge l'espansione di una rete MAN in fibra regionale già esistente che connette enti locali, scuole, strutture sanitarie pubbliche e un data-center centralizzato che contiene oltre ad altre informazioni i dati sanitari dei cittadini tramite il "fascicolo sanitario elettronico". L'espansione riguarda le strutture sanitarie private con l'obbiettivo principale di confluire i dati prodotti da tali strutture nello stesso data-center.

Ogni struttura sanitaria privata ha già presente al loro interno una rete LAN preconfigurata e funzionante. La regione deve consegnare un dispositivo preconfigurato e accessibile da remoto che consente l'integrazione totale alla rete MAN. Inoltre ogni struttura non può poter comunicare con le altre. Bisogna integrare circa $2000$ strutture con possibili incrementi garantendo $8$ indirizzi complessivi per ciascuna.

Il blocco totale di indirizzi disponibile della MAN è $10.0.0.0/8$ ed è già stato pianificato l'assegnazione del blocco $10.100.0.0/8$ all'espansione. 

Per la progettazione sono state fatte le seguenti ipotesi aggiuntive:
- il numero di strutture degli enti locali, scuole e strutture sanitarie pubbliche all'interno della regione è paragonabile a quello delle strutture sanitarie private, quindi sempre $2000$, e sempre con $8$ indirizzi complessivi per ciascuna;
- il data-center è un unica struttura fisica con sede fissa;
- la grandezza delle rete del data-center è relativamente piccola rispetto alle altre categorie prevedendo un numero di host massimo di $200$ dispositivi;
- nel contesto del progetto si ipotizza la priorità verso la semplicità di gestione e la separazione logica delle entità rispetto all'ottimizzazione estrema dello spazio di indirizzamento IP, considerando lo spazio $10.0.0.0/8$ sufficientemente ampio;
- la rete LAN interna delle strutture sanitarie private sono già sufficientemente configurate per garantire servizi di rete basilari come il DHCP o la suddivisione interna in VLAN funzionali.

#### Punto 1
La rete MAN preesistente è configurata tramite l'assegnazione dei seguenti blocchi di indirizzi principali:
- enti locali -> $10.1.0.0/16$
- scuole -> $10.2.0.0/16$
- strutture sanitarie pubbliche -> $10.3.0.0/16$
- data-center -> $10.200.0.0/24$

Infatti questa suddivisione rispetta i vincoli del progetto in quanto una maschera di $/16$ garantisce $2^{16}=65534$ indirizzi disponibili che è maggiore rispetto al numero di indirizzi necessari cioè $2000 \cdot 8 = 16000$, cioè il numero di strutture da collegare per il numero di indirizzi complessivi che ciascuna struttura può avere al massimo.

Ogni blocco delle prime tre sottoreti (quindi quelle degli enti locali, delle scuole e delle strutture sanitarie pubbliche) ha al loro interno altre sottoreti con maschera $/29$ per garantire la disponibilità degli $8$ indirizzi complessivi in quanto rimangono $3$ bit riservati agli host e dunque $2^3 = 8$ indirizzi totali.

Infine è presente il blocco dedicato al data-center che verrà assegnato alla sua corrispettiva struttura fisica senza ulteriori suddivisioni in sottorete interne. Si è scelto una maschera di $/24$ per garantire un totale di $2^8 - 2= 254$ host disponibili, che è maggiore della necessità ipotizzata di $200$.

Per quanto riguarda l'estensione della rete per le strutture sanitarie private il procedimento è analogo. È già stato riservato lo spazio di indirizzamento $10.100.0.0/16$ per questa espansione. Questo blocco garantisce come detto prima $65534$ indirizzi complessivi che rispetta i vincoli progettuali. Analogamente alle altre entità a cui è dedicato un blocco di indirizzi con maschera $/16$ anche il seguente si suddivide ulteriormente in sottoreti con maschera $/29$ garantendo per ciascuna struttura $8$ indirizzi complessivi.

Lo schema grafico dell'infrastruttura di rete è il seguente:

![[prova esame.png]]

E la tabella di indirizzamento IP si può riassumere come segue:

| Entità            | Rete            | Host                        | Broadcast      |
| ----------------- | --------------- | --------------------------- | -------------- |
| Ente locale 1     | $10.1.0.0/29$   | $10.1.0.1 - 10.1.0.6$       | $10.1.0.7$     |
| Ente locale 2     | $10.1.0.8/29$   | $10.1.0.9 - 10.1.0.14$      | $10.1.0.15$    |
| ...               | ...             | ...                         | ...            |
| Scuola 1          | $10.2.0.0/29$   | $10.2.0.1 - 10.2.0.6$       | $10.2.0.7$     |
| Scuola 2          | $10.2.0.8/29$   | $10.2.0.9 - 10.2.0.14$      | $10.2.0.15$    |
| ...               | ...             | ...                         | ...            |
| Str. san. pub. 1  | $10.3.0.0/29$   | $10.3.0.1 - 10.3.0.6$       | $10.3.0.7$     |
| Str. san. pub. 2  | $10.3.0.8/29$   | $10.3.0.9 - 10.3.0.14$      | $10.3.0.15$    |
| ...               | ...             | ...                         | ...            |
| Str. san. priv. 1 | $10.100.0.0/29$ | $10.100.0.1 - 10.100.0.6$   | $10.100.0.7$   |
| Str. san. priv. 2 | $10.100.0.8/29$ | $10.100.0.9 - 10.100.0.14$  | $10.100.0.15$  |
| ...               | ...             | ...                         | ...            |
| Data-center       | $10.200.0.0/24$ | $10.200.0.1 - 10.200.0.254$ | $10.200.0.255$ |

#### Punto 2
Il tipo di dispositivo da consegnare a ciascuna delle strutture sanitarie private consiste in un router a banda larga che dispone di:
- 1 porta per la fibra per il collegamento verso l'esterno;
- 4 porte gigabitehternet per il collegamento con la rete LAN interna.

I servizi che devono essere preconfigurati sono:
- routing dinamico con algoritmi come OSPF;
- SSH per garantire l'accesso remoto e sicuro;
- firewall / ACL per fare impedire la comunicazione con le altre strutture sanitarie private e garantire la comunicazione con il data-center;
- NAT/PAT per tradurre gli indirizzi della rete LAN interna verso la corrispettiva rete MAN con maschera $/29$;
- servizio VPN site-to-site per garantire ancora più protezione e sicurezza durante la comunicazione in SSH;
- NTP per la coerenza temporale dei log registrati in quanto il sistema deve anche gestire la raccolta di dati;
- SNMP per manutenzione e monitoraggio.

Un possibile esempio di configurazione dell'interfaccia in fibra in inbound per quanto riguarda la parte di firewall/ACL in sintassi Cisco potrebbero essere il seguente:

```
Router (conf)> ip access-list extended ACL
Router (access-list)> 10 permit ip 10.200.0.0 0.0.0.255 any
Router (access-list)> 20 deny ip 10.100.0.0 0.0.255.255 any
Router (access-list)> 30 deny ip any any
```

La prima regola permette l'entrata di pacchetti che provengono dal data-center verso la struttura.
La seconda regola scarta i pacchetti provenienti dalle altre strutture sanitarie private, impedendone la comunicazione come richiesto dalle condizioni progettuali.
La terza regola è quella di default e impedisce il passaggio di tutto il resto.

#### Punto 3
La rete LAN della struttura sanitaria privata sarà molto probabilmente composta da più switch e da un router/firewall interno con connessione a internet e potenziali server interni oltre che ovviamente gli host corrispondenti ai dispositivi di pazienti e del personale.

Oltre al router preconfigurato si dovrà dare una dispositivo per convertire la fibra ottica in cavo ethernet se non già integrato nel router.

Si dovrà riconfigurare il firewall per indirizzare tutto il traffico diretto verso il data-center per il router dato dalla regione preconfigurato.

#### Punto 4
Per quanto riguarda la sicurezza dei dati in transito si faranno uso di protocolli di rete cifrati sotto TLS/SSL. In particolare si utilizzeranno principalmente:
- HTTPS per il trasferimento sicuro dei dati dalle strutture al server web nel data-center;
- SFTP per il trasferimento sicuro di file multimediali come immagini e video;
- SSH per l'accesso remoto al dispositivo router concesso alle strutture dalla regione;
- VPN ipsec site-to-site per aumentare la sicurezza dell'accesso remoto.

Il data-center sarà predisposto con una zona DMZ con firewall configurati adeguatamente in cui ci si esporrà servizi come il server web, il server STFP per i file multimediali e il server RADIUS con politiche AAA per utilizzate per l'accesso remoto.

Oltre alla zona DMZ il datacenter possederà anche un database interno per la raccolta e il mantenimento dei dati. Per i dati a riposo, si useranno tecniche di hashing e criptazione nel database e nei file di backup. 

Per garantire la persistenza dei dati a lungo termine ed evitare la loro perdita si è deciso di mantenere quattro copie dei dati: l'originale nel database, una copia locale in nastri magnetici, una copia locale conservata in dischi SSD e una copia dislocata conservata in un servizio cloud esterno. La frequenza dell'aggiornamento dei backup sarà giornaliera.

Una volta che le strutture sanitarie private devono erogare dati verso il data-center essi vengono trasferiti tramite protocollo HTTPS per dati poco pesanti oppure con SFTP per dati (file multimediali) più pesanti ai corrispettivi server esposti nella DMZ del data-center. I server trasferiranno e processeranno i dati verso il database come struttura di archiviazione principale.
___

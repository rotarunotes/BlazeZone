Data: 2026-01-13
[Netting](segaSistemai/Systems_Theory/Netting/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Systems_Theory/Netting
___
**Pratica**: [[segaSistemai/Networking/Configuration/WLAN|WLAN Pratica]]
___
# Index

- [[#Wireless Local Area Network (WLAN)]]
- [[#Cenni Teorici e Dimensioni]]
    - [[#Dimensioni delle Reti Wireless]]
    - [[#Standard IEEE 802.11]]
- [[#Modulazione e Frequenze]]
    - [[#Bande ISM (Industrial, Scientific, Medical)]]
    - [[#Hiperlan]]
- [[#Apparati Wi-Fi]]
    - [[#Access Point (AP)]]
    - [[#Repeater]]
    - [[#Bridge]]
    - [[#WLAN Controller (WLC)]]
- [[#Progettazione di una WLAN]]
    - [[#Requisiti AP]]
        - [[#Posizionamento]]
        - [[#Requisiti]]
        - [[#Numero]]
        - [[#Priorità]]
    - [[#Valutazione Dell'Ambiente]]
        - [[#Attenuazione del segnale]]
        - [[#Interferenze]]
        - [[#Propagazione su più cammini]]
        - [[#Canale Radio]]
- [[#Principali Parametri Di Configurazione]]
    - [[#Configurazione e Prestazioni]]
- [[#Sicurezza degli Accessi]]
    - [[#Protocolli di Sicurezza]]
    - [[#Sicurezza Enterprise (IEEE 802.1X / RADIUS)]]

---

Ti serve che io trasformi anche i titoli nel corpo del testo in intestazioni cliccabili per questi link?
# Wireless Local Area Network (WLAN)

Una **WLAN** è una tecnologia che permette l'accesso e connessione di host rete tramite **onde radio**, eliminando la necessità di collegamenti fisici **cablati**. 

Generalmente viene integrata in una LAN cablata per estenderne i servizi, come l'accesso a Internet e la condivisione di risorse.

___
# Cenni Teorici e Dimensioni
## Dimensioni delle Reti Wireless
Le reti senza fili si classificano in base al raggio di copertura:
1. **WPAN** (Personal): Raggio limitato al corpo umano o a una stanza (es. Bluetooth).
    2) **WLAN** (Local): Una WLAN di solito è integrata in una LAN cablata per estenderne i servizi (l'accesso a internet).
       Operano in un raggio che va dai 10 a 500 metri, utilizzato per le scuole o aziende.
2. **WMAN (Metropolitan):** Copertura a livello cittadino.
3. **WWAN (Wide):** Copertura geografica molto vasta (es. reti cellulari).
## Standard IEEE 802.11
Le WLAN sono regolate dallo standard **IEEE 802.11**, che definisce il funzionamento del livello fisico e del livello MAC (Livello 2 OSI).
- **Topologia Infrastructure:** Prevede un'infrastruttura di rete cablata e l'uso di AP.
- **Topologia Ad Hoc:** Comunicazione diretta tra dispositivi senza infrastruttura centrale (Peer-to-Peer).

|**Generazione/Standard IEEE**|**Velocità min/max**|**Frequenze**|**Anno**|
|---|---|---|---|
|**Wi-Fi 6 (IEEE 802.11ax)**|600–9608 Mbit/s|2,4/5 GHz (1–6 GHz ISM)|2019|
|**Wi-Fi 5 (IEEE 802.11ac)**|433–6933 Mbit/s|5 GHz|2014|
|**Wi-Fi 4 (IEEE 802.11n)**|72–600 Mbit/s|2,4/5 GHz|2009|
|**Wi-Fi 3 (IEEE 802.11g)**|3–54 Mbit/s|2,4 GHz|2003|
|**Wi-Fi 2 (IEEE 802.11a)**|1,5–54 Mbit/s|5 GHz|1999|
|**Wi-Fi 1 (IEEE 802.11b)**|1–11 Mbit/s|2,4 GHz|1999|

---
# Modulazione e Frequenze

Il segnale wireless deve essere **modulato** per trasportare dati. 
La ricerca tecnologica punta a "incastrare" più dati in tempi brevi ottimizzando proprio la modulazione.
- **FM (Frequency Modulation):** La frequenza cambia in base al dato trasmesso.
- **Bande ISM (Industrial, Scientific, Medical):**
    - **2.4 GHz**: Le onde a frequenza bassa, hanno una lunghezza d'onda maggiore, queste permette di coprire una distanza maggiore.
    - **5 GHz**: Offre canali più ampi e meno affollati.
 - **Interferenze**: Nella banda a **2.4 GHz**, lo spazio totale disponibile è limitato e ogni canale occupa una larghezza di circa 20-22 MHz. Poiché le frequenze centrali dei canali sono distanti tra loro solo 5 MHz, la maggior parte dei canali finisce per "calpestare" quelli vicini, creando interferenze.
   Per questo motivo, si utilizzano i canali **1**, **6** e **11**: sono gli unici tre che mantengono una distanza sufficiente a non sovrapporsi mai, garantendo una trasmissione pulita e senza errori.
![[Schema_Bande_Interferenze|500]]

| **Caratteristica**         | **2.4 GHz**                                             | **5 GHz**                                                     |
| -------------------------- | ------------------------------------------------------- | ------------------------------------------------------------- |
| **Copertura (Range)**      | Maggiore: copre distanze più ampie.                     | Minore: il segnale si affievolisce più velocemente.           |
| **Penetrazione Ostacoli**  | Ottima: attraversa meglio muri e oggetti solidi.        | Scarsa: viene facilmente riflessa o assorbita dai muri.       |
| **Velocità (Data Rate)**   | Inferiore: canali più stretti e meno banda disponibile. | Superiore: supporta canali più ampi per trasferimenti veloci. |
| **Interferenze**           | Elevate: affollata da Bluetooth, microonde e altri AP.  | Ridotte: meno dispositivi operano su questa frequenza.        |
| **Canali non sovrapposti** | Solo 3 (tipicamente 1, 6, 11).                          | Molti di più (fino a 24), riducendo la congestione.           |
| **Uso Principale**         | Dispositivi IoT, smart home e lunghe distanze.          | Gaming, streaming 4K, videochiamate e alte prestazioni.       |

## Hiperlan
Proprio come lo standard **IEEE 802.11** definisce come funziona il WI-FI, **HIPERLAN/2** è lo standard europeo che definisce come devono viaggiare i dati a 5 GHz per le connessioni a lungo raggio.
- Mentre il Wi-Fi è nato per l'uso interno (uffici, case), HIPERLAN è stato ottimizzato per la trasmissione dati ad alta **velocità** in ambienti **esterni**.

Differenze strutturali tra Hiperlan e WI-FI:
1) **Direzionalità**: I telefoni sono omnidirezionali (irradiano in tutte le direzioni); le antenne Hiperlan usano parabole direttive per concentrare il segnale in un punto preciso.
2) **Potenza**: L'Hiperlan eroga più potenza fino a 1000mW, per mantenere la riservatezza e l'integrità dei dati permettendo di coprire distanze fino a 10 km.

---
# Apparati Wi-Fi

## Access Point (AP)
È l'**interfaccia** tra il mondo wireless e la rete cablata Ethernet:
1) Gestisce l'associazione dei client
2) Controlla il traffico (i client non comunicano tra loro direttamente ma tramite l'AP).
3) Filtra gli accessi tramite indirizzi MAC
Definizioni:
- **BSA (Basic Service Area):** L'area geografica (cella) coperta dal segnale dell'AP.
- **BSS (Basic Service Set):** L'insieme dei client serviti dall'AP all'interno della BSA. 
  
![[Access_Point]] 
## Repeater
Estende il segnale in zone dove non arriva il cavo LAN, collegandosi via radio a un altro AP.
![[Repeater_Esempio]]
## Bridge
Permette di collegare due o più LAN distanti tra loro:
- **Punto-punto:** Connessione tra due bridge per unire due edifici.
- **Punto-multipunto:** Configurazione a stella con un bridge "root" e diversi bridge periferici.
![[Bridge_Esempio|600]]
## WLAN Controller (WLC)
Dispositivo per la gestione centralizzata di reti **medie/grand**i.
- **Controllo:** Prende il controllo di N Access Point.    
- **Propagazione:** L'amministratore imposta la configurazione sul WLC, che la propaga a tutti gli AP tramite protocolli specifici.
- **QoS (Quality of Service):** Protocollo che stabilisce la priorità e la qualità dei servizi sulla rete.
![[WLAN_Controller_Esempio|600]]

___
# Progettazione di una WLAN

## Requisiti AP
### Posizionamento
l'**AP** va posizionato in punto strategico dove ha un'area di copertura abbastanza libera, di solito sono posizionati in **alto**:
### Requisiti
1) Potenza di trasmissione **regolabile**
2) Buona **sensibilità** in ricezione
3) Apparato **multifunzione** (AP, repeater e bridge)
4) Possibilità di impiego di **antenne** diverse per gestire meglio la copertura radio:
	- Omnidirezionale
	- Direttive
5) Configurabilità da **remoto**
6) In caso di più AP deve essere **compatibilità** con i WLAN controller
7) Alimentazione dell'a AP direttamente tramite la porta Ethernet
### Numero
Per stabilire il numero di **AP** in base al numero di host, indicativamente ogni AP può avere 25 host.
### Priorità
Stabilire la **priorità** degli utenti

## Valutazione Dell'Ambiente
### Attenuazione del segnale
**Materiale** dell'edificio (gli edifici pubblici sono rinforzati 10 volte tanto), questo implica all'attenuazione del segnale. sulla base di questo capiamo il numero di Access Point corretto da inserire all'interno della rete.

| **Materiale**        | **Attenuazione** | **Esempio**                                                       |
| -------------------- | ---------------- | ----------------------------------------------------------------- |
| Aria                 | Nessuna          | Spazio aperto                                                     |
| Legno                | Bassa            | Tramezzo d'ufficio                                                |
| Plastica             | Bassa            | Muri interni                                                      |
| Legno                | Bassa            | Porte e mobili                                                    |
| Materiali sintetici  | Bassa            | Tramezzo d'ufficio                                                |
| Amianto              | Bassa            | Soffitto                                                          |
| Vetro                | Bassa            | Finestre                                                          |
| Vetro colorato       | Media            | Finestre con vetri a specchio                                     |
| Acqua                | Media            | Legno umido o Acquario                                            |
| Esseri viventi       | Media            | Persone e vegetazione                                             |
| Mattoni              | Media            | Muri interni ed esterni                                           |
| Marmo                | Media            | Muri interni                                                      |
| Ceramica             | Alta             | Pavimenti                                                         |
| Cartone              | Alta             | Magazzini, ripostigli                                             |
| Carta                | Alta             | Grandi cartine, giornali                                          |
| Cartongesso          | Alta             | Pareti divisorie, controsoffitti                                  |
| Cemento armato       | Alta             | Pavimento e muri esterni                                          |
| Vetro antiproiettili | Alta             | Separé di sicurezza                                               |
| Metalli              | Molto alta       | Scrivania, tramezzi d'uffici, specchi, armature in cemento armato |
### Interferenze
I dispositivi che trasmettono segnali a radiofrequenza operano su frequenze **condivise**.
la presenza di altri **apparati** o di disturbi ambientali (come trasformatori, telecomandi e interferenze elettromagnetiche) può compromettere la **qualità** della trasmissione e causare problemi di connettività.
### Propagazione su più cammini
Il segnale può subire 
![[Propagazione_Del_Segnale|500]]
### Canale Radio
Selezionare il canale corretto sulla base delle altre reti WI-FI, [[#Modulazione e Frequenze]]

dBm Unità di misura diversa per esprimere la potenza. Più è negativo il numero e più la potenza è bassa

$$
1dBm = 10 \log{10}{\frac{P}{1mW}}
$$

| **Parametri** | **Descrizione**                                                                                                                                                                           |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| dbm           | Unità di misura diversa per esprimere la potenza.<br>Più vado in negativo e più la potenza è piccola                                                                                      |
| Signal (dBm)  | La potenza del sengale                                                                                                                                                                    |
| Noise (dBm)   | La potenza del disturbo, se il disturbo supera il segnale, sovrasta il  segnale                                                                                                           |
| SNR           | Signal Noise Ratio: Determina la qualità di un segnale, Più alto è, più il segnale è ottimo<br>- rapporto tra potenza $\frac{signal}{noise}$ <br>- sottrazione se in dBm $signal - noise$ |

---

# Principali Parametri Di Configurazione

## 4. Configurazione e Prestazioni

- **Capacità di carico**: Un AP garantisce prestazioni accettabili per circa **20-25 client** contemporanei.
- **SSID (Service Set Identifier)**: Stringa alfanumerica che rappresenta tutti i dispositivi collegati a un determinato access point. 
	- Se in **Broadcast**: semplifica la connessione;
	- Se **Nascosto**: aumenta leggermente la **sicurezza** ma richiede configurazione manuale sui client.
- **Roaming (Handover)**: Permette all'utente di muoversi tra diverse celle (BSA) senza perdere la connessione.
	- **Sovrapposizione e Canali:** Per un roaming fluido, le celle degli Access Point (AP) devono sovrapporsi leggermente e utilizzare canali diversi (tipicamente **1, 6, 11** sulla banda 2.4 GHz) per evitare interferenze distruttive tra AP adiacenti.
	- **Il Ruolo del WLC (Wireless LAN Controller):** 
		1) Senza un controller, gli AP non comunicano tra loro e il dispositivo dovrebbe **ri-autenticarsi** ogni volta che cambia cella. 
		2) Con il **WLC**, le credenziali vengono mantenute **centralmente**: quando il dispositivo passa dall'AP1 all'AP2.
		   Questo ci permette di **mantenere** il servizio nonostante si cambi AP.
		   quella piccola **variazione** di AP di 1ms, è il tempo che ci mette il mio dispositivo a **cambiare** AP, ed è invisibile all'utente.
![[Schema_Roaming|500]]
- **EIRP**: rappresenta la potenza totale effettivamente irradiata dall'antenna. 
- ##### chiedere al vex
	- **Formula:** Si calcola sommando la potenza del trasmettitore al guadagno dell'antenna, sottraendo le perdite dei cavi. 
	- **Limiti Legali:** Per evitare l'inquinamento elettromagnetico e le interferenze, esistono limiti definiti per legge (es. **+20 dBm** o 100mW per la banda 2.4 GHz).
	- **Differenza tra Bande:** Spesso sulla banda **5 GHz** sono permessi limiti EIRP più elevati poiché le frequenze alte hanno una portata inferiore e necessitano di più spinta per superare gli ostacoli.

|**Banda**|**Utilizzo**|**EIRP massimo**|
|---|---|---|
|**$2400 \div 2483,5$ MHz**|Indoor/outdoor|**+ 20 dBm** (100 mW)|
|**$5150 \div 5250$ MHz**|Indoor|**+ 23 dBm** (200 mW)|
|**$5250 \div 5350$ MHz**|Indoor/outdoor|**+ 23 dBm** (200 mW)|
|**$5470 \div 5725$ MHz**|Outdoor|**+ 30 dBm** (1 W)|
___
# Sicurezza degli Accessi

Una rete sicura deve avere:
- **Riservatezza**: i dati trasmessi attraverso il canale non devono essere intercettati  e interpretati; 
- **Controllo di accesso** (Access Control): alla rete possono accedere solo gli host autorizzati; 
- **Integrità dei dati**: i messaggi trasmessi non devono essere manomessi, cioè devono giungere integri a destinazione.
  
Protocolli di Sicurezza:
1. **WEP**: Protezione debole, ormai superata.
2. **WPA2 Personal**: Usa la cifratura **AES** ed è lo standard per uso domestico/piccoli uffici (SOHO).
3. **WPA3**: La protezione più forte attualmente disponibile. 4) **Filtraggio MAC**: Permette l'accesso solo a specifici dispositivi, ma è facilmente aggirabile conoscendo un MAC autorizzato.

| **Tipo di sicurezza** | **Autenticazione**                          | **Cifratura**           | **Ambito di impiego** | **Caratteristiche**                                                  |
| --------------------- | ------------------------------------------- | ----------------------- | --------------------- | -------------------------------------------------------------------- |
| Nessuna               | Open (nessuna)                              | Nessuna                 | SOHO                  | Nessuna protezione                                                   |
| WEP                   | Open (nessuna)                              | WEP (64 o 128 bit)      | SOHO                  | Protezione debole                                                    |
|                       | Shared key                                  | WEP (64 o 128 bit)      | SOHO                  | Protezione debole. L'autenticazione è basata sulla chiave WEP stessa |
| WEP dinamico / LEAP   | IEEE 802.1X                                 | WEP (128 bit)           | Enterprise            | Soluzione non standard transitoria. Autenticazione con server RADIUS |
| WPA / WPA2 personal   | WPA-PSK                                     | TKIP (128 bit)          | SOHO/SMB              | Buona protezione                                                     |
|                       | WPA2-PSK (802.11i)                          | AES (128, 192, 256 bit) | SOHO/SMB              | Protezione forte. Richiede hardware in grado di supportare AES       |
| WPA3 personal         | Simultaneous Authentication of Equals (SAE) | AES                     | SOHO/SMB              | Protezione molto forte. Disponibile nei dispositivi più recenti      |
| WPA / WPA2 enterprise | IEEE 802.1X / EAP                           | TKIP                    | Enterprise            | Protezione forte; richiede l'impiego di un server RADIUS             |
|                       | IEEE 802.1X / EAP                           | AES                     | Enterprise            | Protezione molto forte; richiede l'impiego di un server RADIUS       |
| WPA3 enterprise       | Simultaneous Authentication of Equals (SAE) | AES                     | Enterprise            | Protezione molto forte; richiede l'impiego di un server RADIUS       |

## Sicurezza Enterprise (IEEE 802.1X / RADIUS)
In un'architettura di rete una rete aziendale, la protezione dell'accesso non si basa su una semplice password condivisa, ma sul framework **IEEE 802.1X**, che implementa il modello **AAA** (Authentication, Authorization, Accounting) che ne aumenta la sicurezza.
- **Authentication**: verifica l'identità dell'utente chiedendo "Chi sei?".
- **Authorization**: stabilisce i permessi dell'utente chiedendo "Cosa puoi fare?".
- **Accounting**: traccia l'attività dell'utente registrando "Cosa hai fatto?".

##### Chiedere al vex
- **Supplicant:** Il client che richiede l'accesso.
- **Authenticator:** L'Access Point che fa da tramite.
- **RADIUS Server:** Il server che detiene il database degli utenti e le chiavi di accesso; verifica se l'utente è autorizzato ed emette la chiave crittografica.
- **Verifica**: Solo se il server RADIUS conferma l'identità inviando una chiave crittografata, l'AP "apre la porta" al traffico dati dell'utente.
Server AAA: verifica l'autorizzazione, verifica le credenziali, registra le informazioni
- AAA indica un gruppo di protocolli, radius è un protocollo AAA

---

# Pratica
## CAPWAP
È il protocollo che gestisce la comunicazione tra AP e WLC

- di solito si aggiunge una vlan, (vlan 100) per far transitare i dati 

- rimuovere il dhcp pool
- conroller: si crean sub interface
	- port number
	- ip address
	- ip dhcp
	  
wlan:
- ![[Pasted image 20260224133928.png]]
  serve a delgare un server radius esterno


![[Pasted image 20260224134039.png]]


AP groups
si crea l'associazioen tra ap e 

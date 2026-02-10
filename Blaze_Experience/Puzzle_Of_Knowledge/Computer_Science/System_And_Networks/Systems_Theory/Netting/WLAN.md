Data: 2026-01-13
[Netting](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Systems_Theory/Netting
___

# Wirless Local Area Network

# Appunti

- Modulare un segnale
- fm frequency modulacion, cambia la frequenza in base al dato

- cercare di incastraer dei dati in tempi più brevi nel segnale, grazie allo studio della modulazione
cosa cambia tra telefono e antenna hiperlan nella banda 5Ghz
- la parabola è dirizionata invece i telefoni sono omnidirizionale, questo permette di concentrare il segnale in un determinato punto, in più l'hyperlan eroga più potenza

Dispositivi:
1. Access Point (AP):
	1. BSA è l'area che copre quel determinato access point 
	2. BSS, è l'access point che copre BSA
	3. Access point gestisce tutta l'infrastruttura della rete
2. Reapeter:
	1. ripete il segnale, esso è un semplice AP che viene configurato per interconnettersi via radio con un altro AP con la LAN cablata
3. bridge:
	1. punto-punto
	2. punto-multipunto
4. WLAN Controller
	1. Mi permette di agevolare l'installazione e la configurazione di reti wireless, loro prendono il controllo di N AP, assumono la configurazione dall'utente e la propagano agli AP tramite dei protocolli.

Quality of service è un protocollo che stabilisce la qualità di un servizio


Configurazione:
1. 
___
# Modulare un segnale
- fm frequency modulacion, cambia la frequenza in base al dato

- cercare di incastraer dei dati in tempi più brevi nel segnale, grazie allo studio della modulazione
cosa cambia tra telefono e antenna hiperlan nella banda 5Ghz
- la parabola è dirizionata invece i telefoni sono omnidirizionale, questo permette di concentrare il segnale in un determinato punto, in più l'hyperlan eroga più potenza

Dispositivi:
1. Access Point (AP):
	1. BSA è l'area che copre quel determinato access point 
	2. BSS, è l'access point che copre BSA
	3. Access point gestisce tutta l'infrastruttura della rete
2. Reapeter:
	1. ripete il segnale, esso è un semplice AP che viene configurato per interconnettersi via radio con un altro AP con la LAN cablata
3. bridge:
	1. punto-punto
	2. punto-multipunto
4. WLAN Controller
	1. Mi permette di agevolare l'installazione e la configurazione di reti wireless, loro prendono il controllo di N AP, assumono la configurazione dall'utente e la propagano agli AP tramite dei protocolli.

Quality of service è un protocollo che stabilisce la qualità di un servizio


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
    - **2.4 GHz:** Banda pubblica soggetta a molte interferenze (Bluetooth, microonde).
    - **5 GHz:** Offre canali più ampi e meno affollati; utilizzata dagli standard più recenti come 802.11ac.
	 - **Interferenze**: Poiché le frequenze centrali distano solo 5 MHz, i canali si sovrappongono. Per evitarlo, si utilizzano i canali **1**, **6** e **11** che mantengono una spaziatura di 5 canali.
![[Schema_Bande_Interferenze|500]]

## Hiperlan
Proprio come lo standard **IEEE 802.11** definisce come funziona il Wi-Fi, **HIPERLAN/2** è lo standard europeo che definisce come devono viaggiare i dati a 5 GHz per le connessioni a lungo raggio.
- Mentre il Wi-Fi è nato per l'uso interno (uffici, case), HIPERLAN è stato ottimizzato per la trasmissione dati ad alta **velocità** in ambienti **esterni**.

Differenze strutturali:
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
## Repeater
Estende il segnale in zone dove non arriva il cavo LAN, collegandosi via radio a un altro AP.
## Bridge
Permette di collegare due o più LAN distanti tra loro:
- **Punto-punto:** Connessione tra due bridge per unire due edifici.
- **Punto-multipunto:** Configurazione a stella con un bridge "root" e diversi bridge periferici.
## WLAN Controller (WLC)

Dispositivo per la gestione centralizzata di reti **medie/grand**i.
- **Controllo:** Prende il controllo di N Access Point.    
- **Propagazione:** L'amministratore imposta la configurazione sul WLC, che la propaga a tutti gli AP tramite protocolli specifici.
- **QoS (Quality of Service):** Protocollo che stabilisce la priorità e la qualità dei servizi sulla rete.

---
# 4. Configurazione e Parametri Principali

1) SSID (Service Set Identifier): Il nome della rete wireless24. Può essere trasmesso in broadcast (visibile a tutti) o nascosto (richiede inserimento manuale sul client.

2) Roaming (Handover): Permette a un utente di spostarsi tra diverse celle (BSA) mantenendo la connessione attiva senza interruzioni.

# 5. Progettazione di una WLAN
Abbiamo una infrastruttura cablata, ora inizia la progettazione della struttura wireless,
I parametri di cui ho bisogno:
- Numero di host
- Grandezza dell' Area da coprire
- materiale dell'edificio (gli edifici pubblici sono rinforzati 10 volte tanto), questo implica all'attenuazione del segnale. sulla base di questo capiamo il numero di Access Point corretto da inserire all'interno della rete.
- Stabilire la priorità degli utenti

## Access Point

### Posizione
l'**AP** va posizionato in punto strategico dove ha un'area di copertura abbastanza libera, di solito sono posizionati in alto:
### Requisiti
Requisiti degli **AP**:
- Potenza di trasmissione regolabile
- Buona sensibilità in ricezione
- Apparato multifunzione (AP, repeater e bridge)
- Possibilità di impiego di antenne diverse per gestire meglio la copertura radio:
	- Omnidirezionale
	- Direttive
- Configurabilità da remoto
- In caso di AP deve essere compatibilità con i WLAN controller
- Alimentazione dell'a AP direttamente tramite la porta Ethernet
### Numero
Per stabilire il numero di **AP** in base al numero di host, indicativamente ogni AP può avere 25 host.
### Attenuazione del segnale

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
Per dispositivi che trasmettono segnale a radiofrequenza su sui viaggiamo può essere condivisa da altri dispositivi o altri rumori ambientali come rumori, trasformatori, telecomandi, ecc., possono causare problemi.
### Propagazione su più cammini
Il segnale può subire 
![[Propagazione_Del_Segnale|500]]
### Canale Radio
Capire il canale giusto da selezionare sulla base delle altre reti WI-FI
Per evitare interferenze a 2.4 GHz, si usano canali distanziati di almeno 5 posizioni (tipicamente 1, 6, 11).

- dBm Unità di misura diversa per esprimere la potenza. Più vado in negativo e più la potenza è piccola

$$
1dBm = 10 \log{10}{\frac{P}{1mW}}
$$

| **Parametri** | **Descrizione**                                                                                                                                                                             |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| dbm           | Unità di misura diversa per esprimere la potenza.<br>Più vado in negativo e più la potenza è piccola                                                                                        |
| Signal (dbm)  | La potenza del sengale                                                                                                                                                                      |
| Noise (dbm)   | La potenza del disturbo, se il disturbo supera il segnale, sovrasta il  segnale                                                                                                             |
| SNR           | Signal Noise Ratio: Determina la qualità di un segnale<br>- rapporto tra potenza $\frac{signal}{noise}$ <br>- sottrazione se in dbm $signal - noise$<br>Più alto è, più il segnale è ottimo |



![[Tabella_Del_Segnale|1000]]


---

# Principali Parametri Di Configurazione

## 4. Configurazione e Prestazioni

- **Capacità di carico**: Un AP garantisce prestazioni accettabili per circa **20-25 client** contemporanei.
- **SSID (Service Set Identifier)**: Stringa alfanumerica che rappresenta tutti i dispositivi collegati a un determinato access point. 
	- Se in Broadcast, semplifica la connessione; se 
	- Nascosto, aumenta leggermente la sicurezza ma richiede configurazione manuale sui client.
- **Roaming (Handover)**: Permette all'utente di muoversi tra diverse celle (BSA) senza perdere la connessione. Richiede che le celle si sovrappongano e utilizzino canali diversi (1, 6, 11) per non interferire.
	  - dal momento in cui mi aggancio dal secondo AP, devo ridire un'altra volta al secondo AP le credenziali.
	-   l'AP1 e l'AP2  non parlano, non possono sapere che mi sono autenticato su un AP:
	- Il roaming sfrutta WLC: autenticazione avverrà  nell'ap. il wlc mantiene le credenziali anche se cambiamo AP, questo ci permette di mantenere il servizio nonostante cambio AP
	- I 2 AP devono trovarsi su canali diversi, altrimenti si potrebbero verificarsi dei disturbi, tipo, 1 - 2 - 3 - 2 - 1
	- quella piccola variazione di AP di 1ms, è il tempo che ci mette il mio dispositivo a cambiare AP
![[Schema_Roaming|500]]
- **EIRP**: Potenza irradiata comprensiva del guadagno dell'antenna + trasmettitore. 
	-  Esistono limiti: legali (es. +20 dBm per i 2.4 GHz) per limitare l'inquinamento elettromagnetico.
		- a 5GHz ha il doppio dell'EIRP perchè serve più potenza

|**Banda**|**Utilizzo**|**EIRP massimo**|
|---|---|---|
|**$2400 \div 2483,5$ MHz**|Indoor/outdoor|**+ 20 dBm** (100 mW)|
|**$5150 \div 5250$ MHz**|Indoor|**+ 23 dBm** (200 mW)|
|**$5250 \div 5350$ MHz**|Indoor/outdoor|**+ 23 dBm** (200 mW)|
|**$5470 \div 5725$ MHz**|Outdoor|**+ 30 dBm** (1 W)|

# Sicurezza degli Accessi

Una rete sicura deve avere:
- **Riservatezza**: i dati trasmessi attraverso il canale non devono essere intercettati e interpretati; 
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
In una rete aziendale c'è bisogno di una rete che permetta di tracciare il traffico dei dati attraverso delle credenziali.

## Sicurezza Enterprise (IEEE 802.1X / RADIUS)
Nelle aziende si usa il modello **AAA** (Authentication, Authorization, Accounting):
- **Supplicant:** Il client che richiede l'accesso.
- **Authenticator:** L'Access Point che fa da tramite.
- **RADIUS Server:** Il server che detiene il database degli utenti e le chiavi di accesso; verifica se l'utente è autorizzato ed emette la chiave crittografica.
- **Verifica**: Solo se il server RADIUS conferma l'identità inviando una chiave crittografata, l'AP "apre la porta" al traffico dati dell'utente.
Server AAA: verifica l'autorizzazione, verifica le credenziali, registra le informazioni
- AAA indica un gruppo di protocolli, radius è un protocollo AAA

---


### Tipologie di Apparati

- **Access Point (AP)**: Gestisce l'associazione dei client, controlla il traffico (i client non comunicano tra loro direttamente ma tramite l'AP) e può filtrare gli accessi tramite indirizzi MAC.
    
    +2
    
- **Repeater**: Estende il segnale in zone dove non arriva il cavo LAN, collegandosi via radio a un altro AP.
    
- **Bridge**: Collega LAN separate geograficamente. Può essere **punto-punto** o **punto-multipunto** (configurazione a stella con un bridge "root").
    
    +1
    
- **WLAN Controller (WLC)**: Necessario in reti grandi per centralizzare l'amministrazione di molti AP.
    

Considerazioni Ambientali

Il segnale radio è soggetto ad attenuazione in base ai materiali attraversati:

- **Bassa**: Legno, plastica, vetro, amianto.
    
- **Media**: Mattoni, marmo, esseri viventi (persone e vegetazione).
    
- **Alta**: Cemento armato, cartongesso, ceramica.
    
- **Molto Alta**: Metalli (scrivanie, armature, specchi).
    

---

## 4. Configurazione e Prestazioni

- **Capacità di carico**: Un AP garantisce prestazioni accettabili per circa **20-25 client** contemporanei.
    
- **SSID (Service Set Identifier)**: Stringa alfanumerica che identifica la rete. Se irradiato (broadcast), semplifica la connessione; se nascosto, aumenta leggermente la sicurezza ma richiede configurazione manuale sui client.
    
    +2
    
- **Roaming (Handover)**: Permette all'utente di muoversi tra diverse celle (BSA) senza perdere la connessione. Richiede che le celle si sovrappongano e utilizzino canali diversi (1, 6, 11) per non interferire.
    
- **EIRP**: Potenza irradiata comprensiva del guadagno dell'antenna. Esistono limiti legali (es. +20 dBm per i 2.4 GHz) per limitare l'inquinamento elettromagnetico.
    
    +1
    

---



Desideri che approfondisca ulteriormente la parte riguardante i protocolli AAA o la gestione del roaming?
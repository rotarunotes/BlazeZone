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

# 1. Cenni Teorici e Dimensioni
## Dimensioni delle Reti Wireless
Le reti senza fili si classificano in base al raggio di copertura3:
1. WPAN (Personal): Raggio limitato al corpo umano o a una stanza (es. Bluetooth).
    2) WLAN (Local): Copertura da 10 a 500 metri; ideale per edifici, scuole o aziende4.
2. **WMAN (Metropolitan):** Copertura a livello cittadino.
3. **WWAN (Wide):** Copertura geografica molto vasta (es. reti cellulari).

## Standard IEEE 802.11
Le WLAN sono regolate dallo standard **IEEE 802.11**, che definisce il funzionamento del livello fisico e del livello MAC (Livello 2 OSI)5.
- **Topologia Infrastructure:** Prevede un'infrastruttura di rete cablata e l'uso di Access Point6.
- **Topologia Ad Hoc:** Comunicazione diretta tra dispositivi senza infrastruttura centrale (Peer-to-Peer)7.
---

# 2. Modulazione e Frequenze
Il segnale wireless deve essere modulato per trasportare dati. La ricerca tecnologica punta a "incastrare" più dati in tempi brevi ottimizzando proprio la modulazione.
- **FM (Frequency Modulation):** La frequenza cambia in base al dato trasmesso.
- **Bande ISM (Industrial, Scientific, Medical):**
    - **2.4 GHz:** Banda pubblica soggetta a molte interferenze (Bluetooth, microonde).        
    - **5 GHz:** Offre canali più ampi e meno affollati; utilizzata dagli standard più recenti come 802.11ac.

## Focus: Telefono vs Antenna Hiperlan (5 GHz)

Sebbene entrambi possano operare a 5 GHz, esistono differenze strutturali:

1) Direzionalità: I telefoni sono omnidirezionali (irradiano in tutte le direzioni); le antenne Hiperlan usano parabole direttive per concentrare il segnale in un punto preciso.
2) Potenza: L'Hiperlan eroga più potenza (fino a 1W EIRP in esterno) per coprire distanze fino a 10 km.

---

# 3. Apparati Wi-Fi

## 1) Access Point (AP)

È l'interfaccia tra il mondo wireless e la rete cablata Ethernet.
- **BSA (Basic Service Area):** L'area geografica (cella) coperta dal segnale dell'AP.
- **BSS (Basic Service Set):** L'insieme dei client serviti dall'AP all'interno della BSA.  
- **Funzioni:** Gestisce l'associazione dei client, la sicurezza (autenticazione/cifratura) e il controllo del traffico.
## 2) Repeater
Apparato utilizzato per estendere il segnale.
## 3) Bridge
Permette di collegare due o più LAN distanti tra loro:
- **Punto-punto:** Connessione tra due bridge per unire due edifici.
- **Punto-multipunto:** Configurazione a stella con un bridge "root" e diversi bridge periferici.
## 4) WLAN Controller (WLC)

Dispositivo per la gestione centralizzata di reti **medie/grand**i.
- **Controllo:** Prende il controllo di N Access Point.    
- **Propagazione:** L'amministratore imposta la configurazione sul WLC, che la propaga a tutti gli AP tramite protocolli specifici.
- **QoS (Quality of Service):** Protocollo che stabilisce la priorità e la qualità dei servizi sulla rete.

---
# 4. Configurazione e Parametri Principali

1) SSID (Service Set Identifier): Il nome della rete wireless24. Può essere trasmesso in broadcast (visibile a tutti) o nascosto (richiede inserimento manuale sul client.

2) Roaming (Handover): Permette a un utente di spostarsi tra diverse celle (BSA) mantenendo la connessione attiva senza interruzioni.

# 4. Progettazione di una WLAN
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
Capire il canale giusto da selezionare sulla base delle altre reti WI-Fi
Per evitare interferenze a 2.4 GHz, si usano canali distanziati di almeno 5 posizioni (tipicamente 1, 6, 11).

---
# 5. Sicurezza degli Accessi

La sicurezza wireless si basa su tre pilastri: **Riservatezza**, **Controllo d'accesso** e **Integrità**28.
Protocolli di Sicurezza
- **WEP:** Standard obsoleto e insicuro.
- **WPA2 (AES):** Protezione forte, standard attuale per la maggior parte dei dispositivi.
- **WPA3:** Il protocollo più recente e sicuro, con protezione molto forte.
    

### Autenticazione Enterprise (802.1X / RADIUS)

Nelle reti aziendali non si usa una singola password per tutti, ma un sistema **AAA**:
- **Supplicant:** Il client che richiede l'accesso.
- **Authenticator:** L'Access Point che fa da tramite.
- **RADIUS Server:** Il server che detiene il database degli utenti e le chiavi di accesso; verifica se l'utente è autorizzato ed emette la chiave crittografica.
---

Ti servono approfondimenti sulla tabella degli standard IEEE (velocità e anni) o sulla tabella dell'attenuazione dei materiali?
___
 
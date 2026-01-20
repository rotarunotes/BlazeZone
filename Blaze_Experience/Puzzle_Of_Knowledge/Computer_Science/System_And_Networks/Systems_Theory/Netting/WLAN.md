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

### Focus: Telefono vs Antenna Hiperlan (5 GHz)

Sebbene entrambi possano operare a 5 GHz, esistono differenze strutturali:

1) Direzionalità: I telefoni sono omnidirezionali (irradiano in tutte le direzioni); le antenne Hiperlan usano parabole direttive per concentrare il segnale in un punto preciso10101010.

2) Potenza: L'Hiperlan eroga più potenza (fino a 1W EIRP in esterno) per coprire distanze fino a 10 km11111111.+4

---

# 3. Apparati Wi-Fi

## 1) Access Point (AP)

È l'interfaccia tra il mondo wireless e la rete cablata Ethernet12.

- **BSA (Basic Service Area):** L'area geografica (cella) coperta dal segnale dell'AP13.
    
- **BSS (Basic Service Set):** L'insieme dei client serviti dall'AP all'interno della BSA1414.
    
    +1
    
- **Funzioni:** Gestisce l'associazione dei client, la sicurezza (autenticazione/cifratura) e il controllo del traffico15151515.
    
    +1
    

## 2) Repeater

Apparato utilizzato per estendere la copertura in zone dove non arriva il cavo LAN16. Si interconnette via radio a un altro AP principale17.

+1

## 3) Bridge

Permette di collegare due o più LAN distanti tra loro18:

- **Punto-punto:** Connessione tra due bridge per unire due edifici19.
    
- **Punto-multipunto:** Configurazione a stella con un bridge "root" e diversi bridge periferici20.
    

## 4) WLAN Controller (WLC)

Dispositivo per la gestione centralizzata di reti medie/grandi21.

- **Controllo:** Prende il controllo di N Access Point ("Lightweight").
    
- **Propagazione:** L'amministratore imposta la configurazione sul WLC, che la propaga a tutti gli AP tramite protocolli specifici22.
    
- **QoS (Quality of Service):** Protocollo che stabilisce la priorità e la qualità dei servizi sulla rete23.
    

---

# 4. Configurazione e Parametri Principali

1) SSID (Service Set Identifier): Il nome della rete wireless24. Può essere trasmesso in broadcast (visibile a tutti) o nascosto (richiede inserimento manuale sul client)25252525.

2) Canale Radio: Per evitare interferenze a 2.4 GHz, si usano canali distanziati di almeno 5 posizioni (tipicamente 1, 6, 11)26.

3) Roaming (Handover): Permette a un utente di spostarsi tra diverse celle (BSA) mantenendo la connessione attiva senza interruzioni27.+4

---

# 5. Sicurezza degli Accessi

La sicurezza wireless si basa su tre pilastri: **Riservatezza**, **Controllo d'accesso** e **Integrità**28.

Protocolli di Sicurezza 29

- **WEP:** Standard obsoleto e insicuro.
    
- **WPA2 (AES):** Protezione forte, standard attuale per la maggior parte dei dispositivi.
    
- **WPA3:** Il protocollo più recente e sicuro, con protezione molto forte.
    

### Autenticazione Enterprise (802.1X / RADIUS)

Nelle reti aziendali non si usa una singola password per tutti, ma un sistema **AAA**30303030:

+1

- **Supplicant:** Il client che richiede l'accesso31.
    
- **Authenticator:** L'Access Point che fa da tramite32.
    
- **RADIUS Server:** Il server che detiene il database degli utenti e le chiavi di accesso; verifica se l'utente è autorizzato ed emette la chiave crittografica33333333.
    
    +1
    

---

Ti servono approfondimenti sulla tabella degli standard IEEE (velocità e anni) o sulla tabella dell'attenuazione dei materiali?
___
 
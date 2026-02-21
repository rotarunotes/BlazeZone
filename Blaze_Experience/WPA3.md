
# Configurazione 

## Il Handshake a 4 vie (4-Way Handshake)
1) È il protocollo di comunicazione che avviene ogni volta che colleghi un dispositivo al Wi-Fi. Serve a dimostrare che **entrambi conoscete la password ma senza mai inviarla**.
	1. **Messaggio 1:** L'Access Point (Router) invia un numero casuale (ANonce) al dispositivo.
	2. **Messaggio 2:** Il dispositivo genera il proprio numero casuale (SNonce) e crea una firma digitale usando la **password del Wi-Fi**.
	3. **Messaggio 3:** Il router verifica la firma. Se è corretta, conferma al dispositivo che anche lui conosce la password e prepara le chiavi di cifratura.
	4. **Messaggio 4:** Il dispositivo conferma che tutto è pronto. 
	Da questo momento, i dati sono criptati.
## Obiettivo: Chiavi Temporanee
Il fine ultimo non è usare la tua password per cifrare i dati, ma usarla come "base" per generare delle **chiavi temporanee** (PTK - Pairwise Transient Key).

- **Sessione specifica:** Ogni volta che ti disconnetti e ti riconnetti, le chiavi cambiano.
- **Sicurezza:** Anche se un hacker riuscisse a decifrare una singola sessione, non potrebbe usare quella chiave per leggere  il traffico passato o futuro, né quello di altri dispositivi connessi alla stessa rete.
## L'importanza della Password (Entropia)
1) Nelle reti che usano chiavi **pre-condivise**, come il Wi-Fi di casa, la password è l'unico sistema di sicurezza.
2) È fortemente **consigliato cambiare la password** di default del router perchè i produttori spesso impostano password predefinite che si possono facilmente reperire online, e quindi possono compromettere la sicurezza della rete.
3) Mentre **WPA2** è vulnerabile ad alcuni attacchi offline se la password è debole, il **WPA3** introduce una protezione maggiore. Tuttavia, per entrambi, se la password è debole la cifratura è facile da abbattere.
4) **Entropia**: È la misura della casualità e complessità della password. Più è alta, più è difficile per un hacker indovinarla tramite "brute force" (tentativi automatici).
___
# Violazione
## Handshake Capture & Dictionary Attack:
Poiché il **WPA2** scambia dati derivati dalla password durante l'handshake, un **attaccante** può catturare questi messaggi "nell'aria".
Tramite il suo computer può **provare miliardi** di combinazioni finché non trova quella che genera la stessa firma. 
È un attacco **offline**: il router non si accorge di nulla mentre l'hacker tenta le password sul suo PC.

## Evil Twin (Gemello Cattivo)
L'attaccante crea una rete Wi-Fi aperta o con lo stesso nome di una rete nota (es. "Wi-Fi_Aeroporto"). Il tuo dispositivo potrebbe connettersi **automaticamente** a questa rete falsa. 
A quel punto, l'attaccante può mostrarti una **finta pagina di login** per rubare le tue credenziali o intercettare tutto il tuo traffico.

## Deauthentication Attack:
È il precursore del furto dell'**handshake**. L'attaccante invia pacchetti speciali ("deauth") che dicono al tuo PC di disconnettersi dal router. Il tuo dispositivo proverà subito a ricollegarsi automaticamente, eseguendo un nuovo handshake che l'attaccante è pronto a catturare.

___
# Strumenti Di Analisi

## Aircrack-ng
È il "coltellino svizzero" per il Wi-Fi. 
Permette di mettere la scheda di rete in **modalità monitor** (per ascoltare tutto il traffico aereo)
- **inietta pacchetti** (per l'attacco di deautenticazione) 
- **tenta il cracking** delle password.

## Wireshark
È il microscopio della rete. 
Mentre Aircrack cattura i dati, Wireshark permette di analizzarli **visivamente**, vedendo ogni singolo bit del protocollo. 
È fondamentale per capire se una rete sta subendo **anomalie** o per studiare la **struttura dei pacchetti** WPA3.

## Hashcat:
È il re del cracking di password. 
A differenza di altri software, usa la **GPU** (la scheda video) invece della CPU. 
Poiché le schede video **sono migliaia di volte** più veloci nei calcoli matematici ripetitivi, Hashcat può testare milioni di password al secondo, rendendo vulnerabili anche password mediamente lunghe.

---

# Best Practices

## Passare a WPA3
Il WPA3 sostituisce l'handshake tradizionale con il protocollo **SAE** (Simultaneous Authentication of Equals). La differenza fondamentale è che il WPA3 rende inutili gli attacchi offline (Dictionary Attack): l'attaccante non può più provare milioni di password sul suo PC dopo aver catturato un pacchetto.

## Aggiornamento Firmware
Molti attacchi (come il celebre **KRACK** sfruttano bug nel codice del router. 
Aggiornare il software del router chiude queste **"porte di servizio"** che gli hacker potrebbero usare senza nemmeno conoscere la **password**.

## Disabilitare il WPS
Il Wi-Fi Protected Setup (il tastino per connettersi senza password o tramite PIN a 8 cifre) è insicuro. 
Esistono strumenti che indovinano il PIN in poche ore. **Disattivarlo è la prima regola di sicurezza.**
Data: 2026-01-14
[Network_Protocols](Modelli/segaSistemai/Networking/Network_Protocols/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Network_Protocols
___
Video: "Nessun video utilizzato"
# Index
- [[#Network Time Protocol (NTP)]]
- [[#Caratteristiche Principali]]
- [[#Algoritmo di Sincronizzazione]]
- [[#Gerarchia Stratum]]
- [[#Reference Identifiers (REFID)]]
- [[#Formato del Pacchetto NTP]]
- [[#Sicurezza e Utilizzi]]

---
# Network Time Protocol (NTP)

Il **Network Time Protocol (NTP)** è un protocollo utilizzato per sincronizzare gli orologi dei computer all'interno di una rete a **commutazione di pacchetto**.

I tempi di **latenza** risultano spesso **variabili e inaffidabil**i:
- l'NTP nasce proprio per gestire tali criticità e garantire una **coerenza** temporale tra i nodi.

Il protocollo **definisce**:
- Un'architettura **client-server** (può essere anche **peer-to-peer**).
- Modalità di funzionamento **broadcast** e **multicasting**, dopo la calibrazione iniziale, il client ascolta passivamente gli aggiornamenti del server.
- L'utilizzo della porta **UDP 123** (Quando un client vuole sincronizzare l'ora, invia la sua richiesta esattamente all'indirizzo IP del server puntando alla porta 123).
---
# Caratteristiche Principali

1) **Precisione** L'`NTP` raggiunge una precisione nell'ordine delle decine di millisecondi su Internet e scende sotto il millisecondo all'interno delle reti locali (LAN).

2) L'implementazione del protocollo si basa sul inviare e ricevere **timestamps**, ovvero, la rappresentazione dell'**ora del giorno** in cui è avvenuto un evento
   **Timestamps**:
	- 32 bit per i secondi
	- 32 bit per le frazioni di secondi

3) Prevede la correzione del **leap second** (è la differenza tra tempo atomico e tempo terrestre) tramite un warning. Il Protocollo lo corregge ogni volta 

- **Nota:** Non fornisce informazioni su fusi orari o sul passaggio tra ora legale e ora solare.

---
# Algoritmo di Sincronizzazione

Il client `NTP` interroga regolarmente uno o più server e **corregge gradualmente** il proprio orologio interno.

-  L'accuratezza massima si ottiene quando il ritardo dei pacchetti è simmetrico.
## Calcoli Principali:

- **Round Trip Delay** ($\delta$): Misura il tempo totale dello spazio percorso dal pacchetto, escludendo il tempo di elaborazione del server.$$\delta = (t_3 - t_0) - (t_2 - t_1)$$
- **Time Offset** ($\theta$) Rappresenta il tempo di ritardo medio.$$\theta = \frac{(t_1 - t_0) + (t_3 - t_2)}{2}$$ ![[Algoritmo_NTP]]
I valori ottenuti sono sottoposti ad analisi statistiche: 
- I valori anomali vengono **scartati** 
- L'offset finale (la **differenza** di tempo tra l'orologio del tuo computer e quello del server)  è calcolato sulla base degli ultimi 3 candidati validi.
- Si raggiunge a una **giusta sincronizzazione** quando l'offset finale è a 0. 

---
# Gerarchia Stratum

NTP organizza le sorgenti di tempo in una gerarchia di livelli chiamata **stratum**, numerata per evitare cicli.

- I **dispositivi** in ogni stratum possono comunicare tra di loro per eseguire dei test

| **Stratum** | **Descrizione**                                                                                                                                                                                                                                                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **0**       | **Orologi atomici** nei satelliti:<br>- Misurano il tempo con la frequenza di risonanza degli atomi.<br>- `GNSS`, sistema satellitare.<br>- `PTP`, Precise Time Protocol.<br>Generano accuratamente un **impulso** per secondo che attiva un **interrupt**.<br>Nel protocollo `NTP` è indicato come uno stratum non specificato. |
| **1**       | Server primari collegati **direttamente** ai dispositivi Stratum 0. Sincronizzati con scarti di pochi microsecondi.                                                                                                                                                                                                              |
| **2**       | Dispositivi sincronizzati con lo Stratum 1 con la differenza che la sincronizzazione avviene attraverso la rete di elaboratori.<br>- Sono **client** per stratum 1, e possono interrogare più server.<br>- Sono **server** per stratum 3.                                                                                        |
| **3**       | Dispositivi sincronizzati con lo Stratum 2 attraverso la rete di elaboratori.<br>- Sono **client** per stratum 2, e possono interrogare più server.<br>- Sono **server** per stratum 4.                                                                                                                                          |
| ....        |                                                                                                                                                                                                                                                                                                                                  |
| **15**      |                                                                                                                                                                                                                                                                                                                                  |
- **Limite massimo:** Il numero massimo di stratum è 15.
-  Stratum:
	- $0$ = Invalido
	- $1$ = Server Primario
	- $2$-$15$ = Server secondari
	- $16$ = Non sincronizzato

- **Qualità:** Il livello di stratum non è necessariamente un indicatore di qualità o affidabilità della sincronizzazione.

---
# Reference Identifiers (REFID)
- Common time reference identifiers codes (**REFID**)

sono codici con la quale il server è in grado di identificare la sorgente per ogni server attraverso questi reference identifiers.

- **Esempi comuni:** 
	- GPS
	- PPS (Generic Pulse-Per-Second).

- **Kiss-o'-Death (KoD):** Il campo REFID può contenere messaggi di stato speciali che ordinano al client di interrompere le interrogazioni al server.

---
# Formato del Pacchetto NTP

L'header del pacchetto NTP contiene diversi campi critici per il funzionamento del protocollo28:

| **Campo**                | **Descrizione**                                                                                                                                                  |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Leap Indicator (LI)**  | Avviso su secondi intercalari:<br>- $0$ = no warning.<br>- $1$ = l'ultimo minuto è di $61s$.<br>- $2$ = l'ultimo minuto è di $59s$.<br>- $3$ = non sincronizzato |
| **Version Number (VN)**  | Indica la versione del protocollo utilizzata.                                                                                                                    |
| **Mode**                 | Specifica la modalità di associazione (client, server, ecc.).                                                                                                    |
| **Stratum**              | Indica il livello gerarchico del server.                                                                                                                         |
| **Poll**                 | l'intervallo di tempo che intercorre tra una richiesta di sincronizzazione e la successiva inviata dal client al server.                                         |
| **Root Delay**           | Ritardo totale accumulato fino all'orologio di riferimento primario.                                                                                             |
| **Reference ID (REFID)** | sono codici con la quale il server è in grado di identificare la sorgente per ogni server attraverso questi reference identifiers.                               |

---
# Sicurezza e Utilizzi

## Sicurezza:
1) I server sono vulnerabili ad attacchi **Man-in-the-Middle** se non viene utilizzata l'autenticazione crittografica.
	- Questo tipo di attacco può alterare l'orologio del client e bypassare la scadenza della chiave di crittografia
2) Gli attacchi possono alterare l'orologio del client o causare interruzioni tramite **DoS** (sovraccarico computazionale).
## Utilizzi:
1) **Sincronizzazione**: nei sistemi distribuiti con la presenza di più server che operano.
2) **Settore Finanziario/Legale**: Fondamentale per transazioni bancarie, firme digitali e operazioni in borsa.
3) **Protocolli di Rete**: Garantisce la coerenza temporale in DHCP, DNS e SNMP, evitando scadenze o rinnovi errati dei record.

---
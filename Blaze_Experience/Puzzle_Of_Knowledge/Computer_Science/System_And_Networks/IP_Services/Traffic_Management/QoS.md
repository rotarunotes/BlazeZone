Data: 2026-06-08
[Traffic_Management](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/IP_Services/Traffic_Management
___
# Index
- [[#Quality Of Service]]
- [[#Perché Quality Of Service]]
	- [[#Latenza]]
	- [[#Jitter]]
	- [[#Perdita Di Pacchetti]]
- [[#Classificazione E Marcatura]]
	- [[#Class Of Service]]
	- [[#Differentiated Services Code Point]]
- [[#Meccanismi Di Accodamento]]
	- [[#First In First Out]]
	- [[#Weighted Fair Queueing]]
	- [[#Class-Based Weighted Fair Queueing]]
	- [[#Low Latency Queueing]]
- [[#Policing Vs Shaping]]
	- [[#Policing]]
	- [[#Shaping]]
- [[#Trust Boundary]]
___
# Quality Of Service

La QoS, *Quality of Service*, è l'insieme di tecnologie che permettono di gestire:
* **Larghezza di banda**.
* **Latenza**.
* **Perdita di pacchetti**.
Il suo scopo principale è garantire prestazioni prevedibili e affidabili nel traffico di rete, specialmente quello in tempo reale come voce e video.
___
# Perché Quality Of Service

Senza meccanismi di QoS, la rete opera secondo il principio del **Best Effort**, trattando ogni tipo di traffico allo stesso modo. Tuttavia, diverse applicazioni hanno requisiti estremamente diversi:

- **Traffico Voce**, VoIP (*Voice over IP*): Richiede un trattamento preferenziale estremo. Ha bisogno di una larghezza di banda ridotta ma costante, ed è estremamente sensibile ai ritardi e alla perdita di pacchetti.
- **Traffico Video**: Simile alla voce, richiede maggiore banda ma tollera una minima percentuale in più di latenza grazie ai buffer di riproduzione.
- **Traffico Dati** (es. Email, Web, FTP*File Transfer Protocol*): È elastico. Può tollerare ritardi e variazioni di tempo, ma richiede un'integrità assoluta dei dati (zero perdita, garantita a livello di trasporto dal protocollo TCP).

I tre parametri di rete principali che la QoS mira a controllare sono descritti di seguito.
## Latenza
La **latenza** (o delay) misura il **tempo** totale impiegato da un pacchetto per viaggiare dalla sorgente alla destinazione.
## Jitter
Il **jitter** rappresenta la variazione del ritardo di arrivo dei pacchetti consecutivi appartenenti allo stesso flusso. Se i pacchetti arrivano a intervalli **irregolari**, l'audio risulterà distorto o interrotto.

## Perdita Di Pacchetti
La **perdita di pacchetti** (*packet loss*) indica la percentuale di dati che non raggiunge la destinazione.
___
# Classificazione E Marcatura

Il processo di QoS si divide in fasi sequenziali. La prima è la **classificazione** (identificazione del tipo di traffico), seguita dalla **marcatura** (scrittura di un flag di priorità nell'header).

## Class Of Service
La CoS, *Class of Service*, è un meccanismo di marcatura a **Layer 2** (collegamento dati), definito all'interno dello standard IEEE 802.1Q (utilizzato per il tagging delle VLAN)
- Utilizza **3 bit** situati nel campo PCP, *Priority Code Point*, dell'header Ethernet taggato.
- Fornisce valori da $0$ (priorità minima) a $7$ (priorità massima).
- Poiché opera a Layer 2, la marcatura CoS viene persa quando il pacchetto attraversa un router.

## Differentiated Services Code Point
Il DSCP, *Differentiated Services Code Point*, è il meccanismo di marcatura a **Layer 3** (rete), definito all'interno del campo ToS, *Type of Service*, nell'header IPv4, o nel campo Traffic Class dell'header IPv6.
- Utilizza **6 bit** (valori disponibili da $0$ a $63$).
- Consente una classificazione del traffico molto più granulare rispetto a CoS.
- Le classi DSCP più importanti sono:
	- **BE** (*Best Effort*): Rappresenta il traffico standard non prioritario.
	- **EF** (*Expedited Forwarding*): Destinato al traffico che richiede bassissimo ritardo e bassa perdita, come la voce VoIP.
	- **AF** (*Assured Forwarding*): Definisce una serie di classi con diversi livelli di priorità di trasmissione e di probabilità di scarto in caso di congestione.

| Classi AF | Bassa Probabilità Di Scarto | Media Probabilità Di Scarto | Alta Probabilità Di Scarto |
| :---: | :---: | :---: | :---: |
| **Classe 1** | AF11 (valore $10$) | AF12 (valore $12$) | AF13 (valore $14$) |
| **Classe 2** | AF21 (valore $18$) | AF22 (valore $20$) | AF23 (valore $22$) |
| **Classe 3** | AF31 (valore $26$) | AF32 (valore $28$) | AF33 (valore $30$) |
| **Classe 4** | AF41 (valore $34$) | AF42 (valore $36$) | AF43 (valore $38$) |

___
# Meccanismi Di Accodamento

Quando si verifica una congestione su un'interfaccia di rete, i pacchetti in uscita vengono memorizzati temporaneamente in code di memoria prima dell'invio. Lo scheduler determina l'ordine di svuotamento di queste code in base a diversi algoritmi:

## First In First Out
Il meccanismo **First In, First Out**, FIFO (*First In First Out*), è l'accodamento di default. I pacchetti vengono trasmessi nello stesso identico ordine con cui arrivano, senza alcuna distinzione di classe o priorità. Non è adatto per gestire traffico sensibile al ritardo in presenza di congestione.

## Weighted Fair Queueing
Il **Weighted Fair Queueing**, WFQ (*Weighted Fair Queueing*), suddivide automaticamente il traffico in flussi (*flows*) basati sulle conversazioni attive (analizzando indirizzi IP e porte). Assegna a ciascuna coda una quantità di banda proporzionale al peso della conversazione, impedendo che i flussi a banda elevata (es. download FTP) monopolizzino l'interfaccia a scapito di quelli più leggeri. Non garantisce tuttavia una latenza prevedibile per la voce.

## Class-Based Weighted Fair Queueing
Il **Class-Based Weighted Fair Queueing**, CBWFQ (*Class-Based Weighted Fair Queueing*), permette all'amministratore di definire classi di traffico personalizzate tramite criteri di corrispondenza specifici (es. protocolli o ACL, *Access Control List*) e di assegnare a ciascuna classe una quantità minima di banda garantita espressa in valore assoluto o in percentuale.

## Low Latency Queueing
Il **Low Latency Queueing**, LLQ (*Low Latency Queueing*), è un'estensione di CBWFQ che introduce una coda a priorità stretta, PQ (*Priority Queue*), destinata al traffico a bassissima tolleranza al ritardo (como il VoIP). Lo scheduler serve la coda PQ prima di qualsiasi altra coda. Per evitare che il traffico prioritario saturi l'intero collegamento (*starvation* delle altre code), la coda PQ viene associata a un limite massimo di banda oltre il quale i pacchetti in eccesso vengono scartati.

___
# Policing Vs Shaping

Il **Traffic Conditioning** si occupa di limitare la velocità del traffico in uscita o in ingresso per allinearlo ai profili contrattuali o alle capacità fisiche del link. I due metodi principali per raggiungere questo obiettivo sono il policing e lo shaping:

## Policing
Il **policing** monitora la velocità del traffico e agisce in modo immediato quando viene superata la soglia di banda definita, CIR (*Committed Information Rate*).
- I pacchetti che eccedono il limite vengono immediatamente scartati (*drop*) o rimarcati con una priorità inferior.
- Genera un andamento del traffico fortemente discontinuo (*a dente di sega*).
- È applicabile sia in ingresso (*ingress*) che in uscita (*egress*) su un'interfaccia.
- Viene tipicamente implementato dai provider di servizi (ISP, *Internet Service Provider*) per limitare la banda degli utenti al limite contrattuale.

## Shaping
Lo **shaping** limita la velocità del traffico bufferizzando i pacchetti in eccesso per trasmetterli in un secondo momento, distribuendo la trasmissione nel tempo.
- Rende il traffico omogeneo e costante (*smooth*).
- Evita la perdita immediata di pacchetti, al costo di introdurre una latenza aggiuntiva dovuta al tempo trascorso nelle code di buffer.
- È applicabile esclusivamente in uscita (*egress*).
- Viene comunemente configurato sul lato client per evitare lo scarto del traffico da parte del policing dell'ISP.
___
# Trust Boundary
Il **trust boundary** (confine di fiducia) è il punto all'interno dell'infrastruttura di rete in cui i dispositivi iniziano a considerare valide le marcature QoS presenti nei frame o nei pacchetti ricevuti.
- Se le marcature provengono da una sorgente esterna a questo confine (ad esempio, il computer di un utente generico), esse vengono resettate a $0$ (Best Effort) per impedire accessi abusivi alle code prioritarie della rete (QoS spoofing).
- Tipicamente, il trust boundary si colloca sullo switch di accesso o sul telefono IP ad esso collegato.
___

Data: 2026-05-07
[Routing_Logic](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Routing_Logic
___
# Index
- [[#Routing Dinamico]]
	- [[#Vantaggi rispetto al routing statico]]
	- [[#Classificazione dei protocolli]]
- [[#Distance Vector RIP]]
	- [[#Come funziona]]
	- [[#Routing Information Protocol]]
	- [[#Svantaggi]]
- [[#Link State OSPF]]
	- [[#Come funziona]]
	- [[#Open Shortest Path First]]
	- [[#Tipi di pacchetti OSPF]]
	- [[#DR e BDR Election (su reti multi-accesso)]]
	- [[#OSPF Multi-Area]]
- [[#Convergenza]]
	- [[#Tempo di convergenza]]
	- [[#Perché RIP converge lentamente]]
	- [[#Perché OSPF converge rapidamente]]
___
# Routing Dinamico

Nel routing dinamico i router **si scambiano informazioni tra loro** tramite protocolli appositi, costruendo e aggiornando automaticamente la tabella di routing.
- Non è necessaria la configurazione manuale di ogni rotta.
## Vantaggi rispetto al routing statico
- Si adatta **automaticamente** ai guasti e ai cambiamenti topologici.
- Scalabile su **reti grandi**.
- **Riduce** il lavoro di configurazione manuale.

## Classificazione dei protocolli
I protocolli di routing dinamico si dividono in due grandi famiglie in base all'algoritmo che usano:

| Famiglia        | Algoritmo      | Protocolli principali |
| --------------- | -------------- | --------------------- |
| Distance Vector | Bellman-Ford   | RIP, EIGRP            |
| Link State      | Dijkstra (SPF) | OSPF, IS-IS           |
___
# Distance Vector RIP

## Come funziona
Ogni router conosce solo i **vicini diretti** e invia periodicamente la propria **tabella di routing completa** a questi vicini.
I router aggiornano la propria tabella in base alle informazioni ricevute.

> [!NOTE] Nota
> L'algoritmo si chiama **distance vector** perché ogni rotta è descritta da due informazioni:
> - **Distanza** (metrica).
> - **Direzione** (next-hop).
## *Routing Information Protocol*
- **Metrica**: hop count (numero di router attraversati)
- **Limite massimo**: 15 hop — una rete con distanza 16 è considerata **irraggiungibile**
- **Administrative Distance**: 120
- **Aggiornamenti**: inviati ogni **30 secondi** in broadcast/multicast
- **Versioni**:
    - **RIPv1**: Classful, non supporta VLSM/CIDR, broadcast.
    - **RIPv2**: Classless, supporta VLSM, multicast su `224.0.0.9`.
    - **RIPng**: Versione per IPv6.
## Svantaggi
- Non adatto a **reti grandi** (max 15 hop).
- Convergenza **lenta**.
- Non tiene conto della **banda**, solo del numero di salti.
___
# Link State OSPF

## Come funziona
Ogni router costruisce una **mappa completa della topologia di rete** (LSDB *Link State Database*).
- Usando l'**algoritmo di Dijkstra** (SPF *Shortest Path First*), calcola il percorso più breve verso ogni destinazione.

I router si scambiano LSA *Link State Advertisement*, Pacchetti che descrivono lo stato dei propri link, invece della tabella completa.

- A differenza di RIP, ogni router "vede" **tutta la rete** e calcola autonomamente il percorso migliore.
## *Open Shortest Path First*
- **Metrica**: Cost, calcolato come `100 Mbps / banda dell'interfaccia`
    - FastEthernet (100 Mbps) → cost 1
    - Ethernet (10 Mbps) → cost 10
    - Serial (1.544 Mbps) → cost 64
- **Administrative Distance**: 110
- **Protocollo di trasporto**: direttamente su IP (protocollo 89)
- **Multicast**: `224.0.0.5` (tutti i router OSPF), `224.0.0.6` (DR/BDR)
- **Versioni**:
	- **OSPFv3**: OSPF per IPv6
## Tipi di pacchetti OSPF

|Tipo|Nome|Funzione|
|---|---|---|
|1|Hello|Scopre e mantiene i neighbor|
|2|DBD|Riassunto del LSDB|
|3|LSR|Richiesta di LSA specifici|
|4|LSU|Invio degli LSA richiesti|
|5|LSAck|Conferma ricezione LSA|
## DR e BDR Election (su reti multi-accesso)
In reti Ethernet con più router (es. uno switch con 5 router collegati), OSPF elegge:

- **DR** *Designated Router*: router centrale con cui tutti gli altri fanno flooding degli LSA
- **BDR** *Backup Designated Router*: backup del DR

**Criterio di elezione**:
1. Router con **priority più alta** (default: 1, range 0–255; 0 = non eleggibile)
2. In caso di parità → Router con **Router ID più alto** (scelto tra gli IP delle loopback o delle interfacce fisiche)

> [!NOTE] Nota
> Il DR e BDR vengono eletti una volta sola: se arriva un router con priority più alta **dopo** l'elezione, non scalza quelli già eletti (non-preemptive).

## OSPF Multi-Area
In reti grandi, OSPF viene diviso in **aree** per limitare il flooding degli LSA e ridurre il carico computazionale dell'algoritmo SPF.

```
Area 0 (Backbone)
    │
    ├── Area 1
    ├── Area 2
    └── Area 3
```

- **Area 0 (Backbone)**: obbligatoria, tutte le altre aree devono connettersi ad essa
___
# Convergenza

La **convergenza** è il processo attraverso cui tutti i router di una rete raggiungono una **visione coerente e aggiornata della topologia** dopo un cambiamento (es. caduta di un link, aggiunta di un router).
## Tempo di convergenza

| Protocollo | Convergenza tipica |
| ---------- | ------------------ |
| RIP        | Lenta (minuti)     |
| OSPF       | Rapida (secondi)   |
## Perché RIP converge lentamente
RIP soffre di problemi come il **counting to infinity**: quando un link cade, i router possono continuare ad annunciarsi a vicenda rotte errate, aumentando il hop count fino a 16 (infinito) prima di eliminare la rotta.

Meccanismi di protezione in RIP:
- **Split Horizon**: non riannunciare una rotta sull'interfaccia da cui è stata appresa
- **Route Poisoning**: annunciare la rotta con metrica 16 (irraggiungibile) appena cade
- **Hold-down timer**: ignora aggiornamenti per una rotta per un certo periodo dopo che è caduta
## Perché OSPF converge rapidamente
OSPF ha una mappa completa della rete: quando un link cade, i router interessati **inondano immediatamente** la rete con LSA aggiornati, e ogni router ricalcola il percorso SPF autonomamente.
___
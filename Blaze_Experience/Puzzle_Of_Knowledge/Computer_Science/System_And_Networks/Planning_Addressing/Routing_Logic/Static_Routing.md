Data: 2026-05-07
[Routing_Logic](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Routing_Logic
___
# Index
- [[#Routing Statico]]
	- [[#Vantaggi]]
	- [[#Svantaggi]]
- [[#Default Route: Gateway of Last Resort]]
	- [[#Quando usarla]]
- [[#Administrative Distance (AD)]]
- [[#Metrica]]
- [[#Tabella riassuntiva]]
___
# Routing Statico 

Il routing statico consiste nel configurare **manualmente** le rotte su un router, senza l'utilizzo di protocolli di routing dinamici.
L'amministratore di rete definisce esplicitamente il percorso che ogni pacchetto deve seguire per raggiungere una rete specifica.
## Vantaggi
- **Nessun overhead** di CPU o banda (nessun protocollo da far girare).
- Comportamento **prevedibile** e controllato.
- Maggiore **sicurezza** (nessun annuncio di rotte non volute).
## Svantaggi
- **Non si adatta** automaticamente ai guasti della rete.
- Difficile da gestire in **reti grandi**.
- Richiede **aggiornamento manuale** ad ogni cambiamento topologico.
___
# Default Route: Gateway of Last Resort

La **default route** è una rotta speciale che cattura tutto il traffico per cui il router **non ha una rotta specifica**. È identificata dall'indirizzo:

```
0.0.0.0/0
```
## Quando usarla
- Su router **perimetrali** (edge) verso Internet.
- In reti semplici con un **solo punto di uscita** (stub network).
- Come "catch-all" in combinazione con **rotte più specifiche**.
___
# *Administrative Distance* (AD)

L'**Administrative Distance** è un valore numerico che indica il **grado di fiducia** di una rotta rispetto alla sua sorgente.
È usata dal router per scegliere tra le rotte per la stessa rete, ma da sorgenti diverse.
___
# Metrica

La metrica in breve, indica il "**costo**" o la "**fatica**" necessaria per percorrere una specifica strada verso la destinazione.
___
# Tabella riassuntiva

| Caratteristica          | Distanza Amministrativa (AD)                                                   | Metrica                                                                           |
| ----------------------- | ------------------------------------------------------------------------------ | --------------------------------------------------------------------------------- |
| **Cosa rappresenta**    | L'**affidabilità** della sorgente della rotta.                                 | Il **costo**/**sforzo** per raggiungere la destinazione.                          |
| **Quando si usa**       | Per confrontare rotte provenienti da **protocolli diversi** (es. OSPF vs RIP). | Per confrontare rotte provenienti dallo **stesso protocollo** (es. OSPF vs OSPF). |
| **Ambito**              | è un valore **predefinito** dai costruttori di hardware                        | È un valore **condiviso** e calcolato dinamicamente dai protocolli di routing.    |
| **Gerarchia di scelta** | Viene controllata **prima** della metrica.                                     | Viene controllata **dopo** (è l'ultimo criterio di scelta).                       |
| **Esempio di valore**   | Statico = 1, OSPF = 110, RIP = 120.                                            | Hop count (RIP), Costo (OSPF), Banda/Ritardo (EIGRP).                             |
| **Logica di selezione** | Il valore **più basso** vince (più affidabile).                                | Il valore **più basso** vince (più efficiente).                                   |

___
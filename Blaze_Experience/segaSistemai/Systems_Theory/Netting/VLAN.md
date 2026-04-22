Data: 2025-11-14
[Netting](README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Systems_Theory/Netting
___
**Pratica:** [[segaSistemai/Networking/Configuration/VLAN|VLAN_Pratica]]
# Virtual Local Area Network
Una **VLAN** è una partizione logica di una rete locale (LAN) a livello 2 (Data Link Layer) del modello OSI. 

Consente di suddividere un singolo switch fisico in più switch virtuali e isolati. I dispositivi all'interno della stessa VLAN comunicano tra loro come se fossero connessi allo stesso cavo
___
# Parametri VLAN
1) **VID:** \[1-4094] Un numero intero unico che identifica in modo univoco una specifica VLAN.
2) **VNAME:** Un nome descrittivo assegnato alla VLAN
---
# Vantaggi e Perché Servono le VLAN
 1)  **Gestione del Traffico (Riduzione del Broadcast):** Riducendo i domini di broadcast, si riduce il carico sulla rete e sui dispositivi, migliorando le prestazioni complessive.
 2) **Efficienza / Risparmio:** L'utilizzo delle VLAN consente di creare diverse **LAN logiche** all'interno di un **singolo switch fisico** sufficientemente capiente. In questo modo, si elimina la necessità di acquistare switch separati per segmentare la rete e riducendo significativamente i costi.
 3) **Miglioramento della Sicurezza (Isolamento):** Il traffico di broadcast di una VLAN **non può passare** a un'altra VLAN senza l'uso di un router o di uno switch di Livello 3. Questo migliora l'efficienza della rete e la sicurezza.

---
# Tipi di Porte VLAN
## Porte di Accesso (VLAN Untagged)
-  Un solo switch
- **Scopo:** Connettono dispositivi finali (host) come PC, stampanti, server.
- **Funzionamento:** La porta è assegnata a **una sola VLAN**. Il traffico che esce da questa porta **non è "taggato"** (non contiene l'intestazione VLAN $802.1Q$).

![[VLAN_Untagged|700]]
## Porte Trunk (VLAN Tagged)
Tramite il trunk si inviano i pacchetti con un solo cavo, tra 2 reti 
- **Scopo:** Connettono switch tra loro.
- **Funzionamento:** Una porta trunk può trasportare il traffico di **molteplici VLAN** contemporaneamente.
- **Standard:** Viene utilizzato lo standard **IEEE 802.1Q** per incapsulare il frame Ethernet aggiungendo un **tag** che specifica l'ID della VLAN di appartenenza.
- **Vantaggio:** Permette di estendere una singola VLAN su più switch fisici e di instradare il traffico tra diverse VLAN (inter-VLAN routing) tramite il router collegato.

![[VLAN_Tagged|700]]


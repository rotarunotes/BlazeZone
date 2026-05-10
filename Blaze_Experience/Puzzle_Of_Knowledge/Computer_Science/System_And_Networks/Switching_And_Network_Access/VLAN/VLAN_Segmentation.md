Data: 2026-05-07
[VLAN](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/VLAN
___
# Index
- [[#Virtual Local Area Network]]
- [[#Parametri VLAN]]
- [[#Vantaggi e Perché Servono le VLAN]]
- [[#Data VLAN]]
- [[#Voice VLAN]]
- [[#Native VLAN]]
- [[#Management VLAN]]
___
# *Virtual Local Area Network*

Una **VLAN** è una partizione logica di una rete locale (LAN) a livello 2 (Data Link Layer) del modello OSI. 
Consente di suddividere un singolo **switch fisico** in più switch virtuali e isolati.

![Schema_VLAN.png](../../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/Schema_VLAN.png)
___
# Parametri VLAN
1) **VID**: \[1-4094] Un numero intero unico che identifica in modo univoco una specifica VLAN.
2) **VNAME**: Un nome descrittivo assegnato alla VLAN
___
# Vantaggi e Perché Servono le VLAN
 1)  **Gestione del Traffico (Riduzione del Broadcast)**: Riducendo i domini di broadcast, si riduce il carico sulla rete e sui dispositivi, migliorando le prestazioni complessive.
 2) **Efficienza / Risparmio**: L'utilizzo delle VLAN consente di creare diverse **LAN logiche** all'interno di un **singolo switch fisico** sufficientemente capiente. In questo modo, si elimina la necessità di acquistare switch separati per segmentare la rete e riducendo significativamente i costi.
 3) **Miglioramento della Sicurezza (Isolamento)**: Il traffico di broadcast di una VLAN **non può passare** a un'altra VLAN senza l'uso di un router o di uno switch di Livello 3. Questo migliora l'efficienza della rete e la sicurezza.
___
# Data VLAN

La Data VLAN trasporta il traffico dati **standard** generato dagli utenti, navigazione web, file sharing, accesso ad applicativi aziendali, ecc.
___
# Voice VLAN

La Voice VLAN è dedicata al traffico **VoIP** *Voice over IP* e consente alla stessa porta di uno switch di trasportare sia traffico dati che traffico voce, mantenendoli separati.

- Fondamentale per i **telefoni IP**: il telefono viene rilevato automaticamente e assegnato alla Voice VLAN, mentre il PC collegato al telefono rimane nella Data VLAN.
- La separazione garantisce **QoS** (Quality of Service): il traffico voce, sensibile a latenza.
- **Configurazione tipica**: la porta dello switch è in modalità access per la Data VLAN e ha una Voice VLAN associata (es. `switchport voice vlan 100`).
___
# Native VLAN

Quando a uno switch arriva un pacchetto che non ha nessuna etichetta (**non si sa a che VLAN appartenga**), lo switch inoltra quel pacchetto nella VLAN nativa.

- **La Native VLAN è la "destinazione predefinita"**.
- Se un pacchetto arriva "nudo", lo switch dice: "Visto che non hai un'etichetta, ti metto nella Native VLAN".

Di default è la **VLAN 1**, ma per ragioni di sicurezza si consiglia di cambiarla.

La VLAN nativa esiste perché in una rete non tutto è sempre perfettamente etichettato.
Serve come **rete di salvataggio** per far sì che il traffico "senza nome" e i messaggi di controllo vitali abbiano sempre un posto dove andare e non vadano persi.

> [!warning] Attenzione
> Se la Native VLAN coincide su tutti i trunk, un attaccante potrebbe sfruttarla per un attacco di **VLAN hopping**. Buona pratica: assegnarla a una VLAN inutilizzata o poco trafficata

___
# Management VLAN

La Management VLAN è dedicata esclusivamente al **traffico amministrativo** dei dispositivi di rete (switch, router, access point).

- Permette agli amministratori di accedere ai dispositivi tramite SSH, Telnet, SNMP, HTTP/HTTPS
- Deve essere **separata** dalle VLAN utente per evitare che un utente comune possa raggiungere le interfacce di gestione
___
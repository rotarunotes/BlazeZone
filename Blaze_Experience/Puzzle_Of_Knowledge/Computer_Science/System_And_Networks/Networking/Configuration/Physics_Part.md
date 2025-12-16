


# Esercizio
Creare una rete di una scuola a più piani seguendo queste caratteristiche
- Tutti gli aspetti tecnici li teniamo nella Vlan 99
- Per arrivare in tutti i piani utilizziamo una struttura a “centro stella”. 
- Abbiamo l'area di ingresso che ci fornisce la connessione a internet che successivamente sarà collegato al locale tecnico tramite a delle dorsali. 
- Il locale tecnico è collegato o ogni armadio di piano attraversa uno cablaggio verticale. 
- Ogni armadio di piano si collega a tutte le stanze di quel piano attraverso il cablaggio orizzontale 

- Su più edifici ci sarà un ulteriore livello: un ufficio (edificio principale) che fa da locale tecnico agli altri locali tecnici degli altri edifici
- Occorre utilizzare i patch panel

## Suggerimenti Torici (Consigli del Vex):
- Per ogni postazione ci devono essere almeno 2 prese
- Quando un cavo scorre dentro a una struttura(muro), bisogna avere 2 prese.
	- patch panel - muro - presa esterna  - Host
- Reapeter in Packet Tracer trasforma il segnale in fibra ottica in segnale con cavo di rame

## Svolgimento
Stanze:
- **Area di ingresso**: Il luogo dove ci viene fornita la rete dal provider (Wind, TIM)
	- Rack:
		- Repeater: Collega l'area di ingresso al locale tecnico
- **locale tecnico**: Il luogo centrale dove gestiamo tutta l'infrastruttura della rete
	- Rack:
		- Repeater: Collega l'area tecnica all'area di ingresso
		- Repeater: Collega l'area tecnica all'armadio di piano
		- Switch: "centro stella" ogni porta corrisponde a un piano
		- Router
		- Server DHCP
		- Centralino telefono
- **Armadio di piano**: Fornisce un collegamento a ogni stanza di quel piano
	- Rack:
		- Repeater: Collega l'armadio di piano al locale tecnico
		- Switch: Collega le varie stanza
- **Laboratorio di informatica**
	- Rack:
		- switch: Collegato all'armadio di piano![[Collegamento_In_Cross|1000]]
	- Postazione Fisica
		- 12 postazioni studenti
		- 2 postazioni docenti
		- 1 postazione tecnico + IP phone	
- **Aule**
	- Postazione Fisica:
		- 1 pc
		- 2 presa (pc personale)
- **Segreteria**
	- Rack
		- switch
	- Postazione Fisica:
		- 4 postazioni, 
		- 4 telefoni
- **Corridoi**
	- access point wi-fi, 
	- fotocopiatore (stampante wi-fi)
	- , postazione collaboratore scolastico con IP phone
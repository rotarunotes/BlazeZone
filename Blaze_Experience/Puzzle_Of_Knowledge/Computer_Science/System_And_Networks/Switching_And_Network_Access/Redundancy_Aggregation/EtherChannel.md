Data: 2026-05-09
[Redundancy_And_Aggregation](Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/Redundancy_Aggregation/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/Redundancy_And_Aggregation
___
# Index
- [[#Problema STP]]
- [[#EtherChannel]]
	- [[#STP Con EtherChannel]]
___
# Problema STP

Per proteggere la rete, STP blocca tutte le rotte tranne una, rendendo gli altri cavi inutilizzati e **sprecando banda** preziosa.
___
# EtherChannel

L'EtherChannel aggrega fino a 8 link fisici in un unico **link logico** chiamato Port-Channel.

- **Aumento Banda**: Somma la capacità dei singoli cavi (es. 8 x 1 Gbps = 8 Gbps al cavo finale).
- **Ridondanza**: Se un cavo si rompe, il traffico si ridistribuisce istantaneamente sugli altri senza interruzioni.
- **Efficienza**: Permette di sfruttare tutte le porte disponibili contemporaneamente.
## STP Con EtherChannel
Con l'EtherChannel attivo, STP non vede più i singoli cavi ma solo l'interfaccia logica **Port-Channel**.

- **Armonia**: Poiché STP non rileva loop e mantiene il collegamento aperto.
- **Protezione**: Se un altro cavo esterno all'EtherChannel venisse collegato creando un vero loop, il protocollo interverrebbe immediatamente per bloccare (nel caso di loop) l'EtherChannel.
___

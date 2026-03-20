Data: 2026-03-20
[](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking
___
Prova: [23/24](https://www.istruzione.it/esame_di_stato/202324/Istituti%20tecnici/Ordinaria/A038_ORD24.pdf)

# Analisi della situazione
## Elenco puntato
1. Rete preesistente:
	1. **Proprietà**
		- fibra ottica
		- Regionale 
		- WAN 
		- Privata
	2. **Entità**:
		1. Ente locale (Comune)
		2. Scuole
		3. Sanità pubblica
		4. Data-Center (Con dati sensibili)
			1. Cittadini
			2. Medici
2. Rete da  creare
	1. Estendere la rete preesistente per offrire il servizio di connettività a **banda larga** a tutte le **strutture sanitarie** private, in modo tale che i dati da loro prodotto possano confluire nel **Data-Center**
	2. Rete privata che copre tutta la ragione: **10.0.0.0/8**;
		1. Sotto rete per SSCP **10.100.0.0/16**;
		2. No internet
		3. 2000 struttura sanitaria convenzionate private (**SSCP**):
			1. Minimo di 8 indirizzi complessivi
		4. Ogni SSCP dispone già d'infrastruttura di rete. Quindi ogni SSCP ha una propria LAN, bisognerà collegare ogni LAN a la nostra WAN
		5. Ogni SSCP, viene fornito un router controllato da remoto (SSH).

## Testo

Dall'analisi della realtà abbiamo già una rete preesistente le cui peculiarità sono: Una rete in fibra ottica Regionale (WAN) privata.
Le entità di questa rete sono diverse: L'ente locale (il comune), le scuole, sanità pubblica e un Data-Center.
Quest'ultimo contiene dati sensibili

L'obbiettivo è estendere considerando la scalabilità la rete preesistente per includere tutte le strutture sanitarie convenzionate private SSCP

Considerazioni:
Sicurezza, Ridondanza

Servizi:


___
# Titolo 2
___
 
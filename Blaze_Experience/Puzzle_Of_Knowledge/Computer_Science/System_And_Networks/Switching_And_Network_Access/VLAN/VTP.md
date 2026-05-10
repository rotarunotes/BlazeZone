Data: 2026-05-08
[VLAN](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/VLAN
___
# Index
- [[#VLAN Trunking Protocol]]
- [[#Modi operativi]]
- [[#Revision Number]]
___
# *VLAN Trunking Protocol*

Protocollo **Cisco proprietario** che sincronizza il database VLAN tra gli switch senza dover configurare ogni VLAN su ogni switch. 
Si configura un solo switch "Server" e le modifiche si propagano automaticamente a tutta la rete.
___
# Modi operativi

|Modalità|Crea/Elimina VLAN|Propaga modifiche|Salva config locale|
|---|---|---|---|
|**Server**|✅|✅ invia e riceve|✅|
|**Client**|❌|✅ riceve e inoltra|❌|
|**Transparent**|✅ (solo locale)|↪️ inoltra ma ignora|✅|
___
# Revision Number

Il **Revision Number** è un contatore che si incrementa ad ogni modifica del DB VLAN.
Ogni switch che riceve un annuncio VTP con revisione **più alta** della propria **sovrascrive il suo database** senza fare domande.

- Non collegare mai uno switch alla rete senza prima **azzerare il suo Revision Number**. In ambienti critici valuta di usare **VTP Transparent** o disabilitare VTP del tutto.
___

Data: 2026-06-11
[Network_Defense](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Network_Defense
___
# Index
- [[#Layer 2 Security]]
	- [[#Panoramica]]
- [[#Port Security]]
	- [[#Funzionamento]]
	- [[#Violation Mode]]
- [[#Dhcp Snooping]]
	- [[#Database Di Binding]]
- [[#Dynamic Arp Inspection]]
- [[#Ip Source Guard]]
- [[#Comandi Cisco IOS]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Layer 2 Security_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Livello OSI** | 2 — Collegamento dati (Switching) |
| **Scopo** | Proteggere l'infrastruttura LAN interna da attacchi di spoofing, starvation ed accessi abusivi |
| **Tecnologie Chiave** | Port Security, DHCP Snooping, DAI, IP Source Guard |
| **Dispositivo Principale** | Switch Managed |

___
# Port Security

La funzionalità **Port Security** limita il numero di indirizzi MAC, *Media Access Control*, validi consentiti su una singola porta fisica dello switch, impedendo attacchi come il MAC address flooding (che satura la tabella CAM, *Content Addressable Memory*, dello switch trasformandolo in un hub).

## Funzionamento
Si definisce un numero massimo di indirizzi MAC associabili a una porta. Gli indirizzi possono essere appresi in modo:
- **Statico**: Configuratili manualmente dall'amministratore.
- **Dinamico**: Appresi automaticamente dallo switch man mano che i dispositivi inviano traffico. Vengono persi al riavvio dello switch.
- **Sticky**: Appresi dinamicamente e salvati automaticamente nella configurazione attiva (*running-config*), rimanendo persistenti al riavvio.

## Violation Mode
Se il numero di indirizzi MAC supera il limite massimo configurato o se viene rilevato un MAC non autorizzato, lo switch applica una delle tre modalità di violazione:

| Modalità | Inoltro Traffico | Log / Messaggio Syslog | Incremento Contatore Violazioni | Stato della Porta |
| :--- | :---: | :---: | :---: | :---: |
| **Protect** | Scartato | No | No | Rimane attiva |
| **Restrict** | Scartato | Sì (Syslog / SNMP) | Sì | Rimane attiva |
| **Shutdown** | Scartato | Sì (Syslog / SNMP) | Sì | Disabilitata immediatamente (*err-disabled*) |

> [!NOTE] Nota
> Lo stato **err-disabled** richiede l'intervento manuale dell'amministratore (comando `shutdown` seguito da `no shutdown` sull'interfaccia) o l'abilitazione della funzionalità di recovery automatico (*errdisable recovery*).

___
# Dhcp Snooping

Il **DHCP Snooping** è una funzionalità di sicurezza di livello 2 che distingue le porte dello switch in:
- **Trusted Ports** (Fidate): Porte collegate a server DHCP, *Dynamic Host Configuration Protocol*, legittimi o ad altri switch. Tutti i messaggi DHCP sono ammessi.
- **Untrusted Ports** (Non fidate): Porte collegate agli host utente. Tutti i messaggi in ingresso di tipo offerta o conferma (`DHCPOFFER`, `DHCPACK`, `DHCPNAK`) provenienti da porte non fidate vengono **scartati**, impedendo attacchi basati su server DHCP non autorizzati (*Rogue DHCP Server*).

## Database Di Binding
Lo switch monitora lo scambio di pacchetti legittimi sulle porte untrusted e popola un database di binding dinamico contenente le associazioni:
- Indirizzo MAC del client
- Indirizzo IP assegnato
- Porta fisica dello switch
- VLAN associata
- Durata del lease

Questo database è fondamentale poiché costituisce la sorgente dati utilizzata da DAI ed IP Source Guard.

___
# Dynamic Arp Inspection

Il DAI, *Dynamic ARP Inspection*, protegge la rete da attacchi di ARP spoofing (o ARP poisoning) che consentono ad un attaccante di effettuare intercettazioni Man-in-the-Middle.
- **Funzionamento**: Lo switch intercetta tutte le richieste e risposte ARP, *Address Resolution Protocol*, transitanti su porte untrusted e le confronta con le informazioni contenute nel database di binding del DHCP Snooping.
- **Azione**: Se la coppia IP/MAC indicata nel messaggio ARP non corrisponde a un'assegnazione DHCP legittima registrata nel database, lo switch scarta il pacchetto ARP bloccando il tentativo di avvelenamento della cache ARP.

___
# Ip Source Guard

L'**IP Source Guard** (IPSG) contrasta gli attacchi di IP spoofing (falsificazione dell'indirizzo IP sorgente) a livello di porta dello switch.
- **Funzionamento**: IPSG crea una ACL port-based dinamica applicata in ingresso sulle porte untrusted.
- **Azione**: Lo switch controlla l'indirizzo IP sorgente di tutti i pacchetti IP in transito confrontandoli con il database di binding del DHCP Snooping. Se l'IP sorgente non corrisponde alla porta fisica a cui è associato nel database, il pacchetto IP viene scartato a livello hardware.

___
# Comandi Cisco IOS

Esempio di configurazione delle difese di livello 2 su switch Cisco:

```cisco
! Configurazione Port Security
interface GigabitEthernet0/1
 switchport mode access
 switchport port-security
 switchport port-security maximum 2
 switchport port-security violation restrict
 switchport port-security mac-address sticky

! Abilitazione DHCP Snooping
ip dhcp snooping
ip dhcp snooping vlan 10
!
interface GigabitEthernet0/24        ! Interfaccia verso il server DHCP reale
 ip dhcp snooping trust

! Abilitazione DAI (richiede DHCP Snooping attivo)
ip arp inspection vlan 10
!
interface GigabitEthernet0/24        ! Interfaccia di uplink verso altri switch/router
 ip arp inspection trust

! Abilitazione IP Source Guard (sulla singola interfaccia di accesso)
interface GigabitEthernet0/1
 ip verify source
```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Port Security Default** | Massimo 1 MAC, modalità di violazione predefinita: **Shutdown**. |
| **DHCP Snooping Trust** | Solo le porte trusted lasciano passare risposte DHCP (`DHCPOFFER`/`DHCPACK`). |
| **Dipendenza DAI** | Richiede che il DHCP Snooping sia precedentemente configurato ed attivo. |
| **Sticky MAC** | Vengono salvati nella running-config dello switch; non vanno persi al riavvio se la configurazione viene salvata. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Port Security impedisce lo spoofing ARP** | **FALSO**. Port Security controlla solo il MAC sorgente fisicamente collegato alla porta a livello di frame. Non analizza i campi interni dei pacchetti di controllo ARP; per bloccare l'ARP spoofing è necessario abilitare **DAI**. |
| **DHCP Snooping blocca tutte le richieste DHCP sulla rete** | **FALSO**. DHCP Snooping lascia passare le richieste dei client (`DHCPDISCOVER`) su tutte le porte untrusted. Blocca esclusivamente le **risposte** dei server provenienti da porte non fidate. |
| **La violazione Protect disabilita l'interfaccia** | **FALSO**. Solo la modalità **Shutdown** spegne la porta (stato *err-disabled*). Le modalità *Protect* e *Restrict* lasciano la porta attiva scartando il traffico abusivo. |

___
# Quick Reference Card

```
PORT SECURITY:
  - switchport port-security [maximum <N>]
  - violation:
    * protect  -> scarta, no log, no incremento contatore
    * restrict -> scarta, sì log syslog/SNMP, incrementa contatore
    * shutdown -> scarta, sì log, err-disabled (richiede manual recovery)

DHCP SNOOPING:
  - ip dhcp snooping -> ip dhcp snooping vlan <ID>
  - Porte trust   -> ip dhcp snooping trust (verso DHCP server)
  - Porte untrust -> (Default) blocca messaggi server DHCP, crea binding table

DYNAMIC ARP INSPECTION (DAI):
  - ip arp inspection vlan <ID>
  - Controlla i pacchetti ARP confrontandoli con il database DHCP Snooping

IP SOURCE GUARD (IPSG):
  - ip verify source (su interfaccia)
  - Blocca pacchetti con IP sorgente falsificato (IP spoofing)
```
___
--Gemini

Data: 2026-06-11
[Security](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Security
___
# Index
- [[#Device Hardening]]
	- [[#Panoramica]]
- [[#Politica Delle Password]]
	- [[#Criteri Di Sicurezza]]
	- [[#Configurazione Cisco IOS]]
- [[#Accesso Remoto Sicuro]]
	- [[#Confronto SSH Vs Telnet]]
	- [[#Login Banner]]
- [[#Mitigazione Degli Attacchi Brute Force]]
- [[#Riduzione Della Superficie Di Attacco]]
	- [[#Disabilitare Servizi Non Utilizzati]]
	- [[#Cisco Discovery Protocol Selettivo]]
	- [[#Disattivazione Delle Porte Inutilizzate]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Device Hardening_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Insieme di configurazioni volte a minimizzare le vulnerabilità di un dispositivo di rete |
| **Obiettivo** | Ridurre la superficie di attacco complessiva dei router e switch |
| **Metodologia** | Configurazione di credenziali robuste, disattivazione servizi non necessari, sicurezza delle porte fisiche e logiche |

___
# Politica Delle Password

La protezione degli accessi fisici e logici rappresenta la prima linea di difesa per il hardening dei dispositivi Cisco.

## Criteri Di Sicurezza
Per garantire la robustezza delle credenziali di amministrazione:
- **Complessità**: Utilizzo combinato di lettere maiuscole, minuscole, numeri e caratteri speciali.
- **Lunghezza minima**: Almeno 10–12 caratteri.
- **Cifratura**: Cifrare le password memorizzate nei file di configurazione per evitare che siano visibili a schermo o leggendo la configurazione corrente.

## Configurazione Cisco IOS
I comandi fondamentali per irrobustire le password in Cisco IOS:
- **Cifratura globale**: Cifrare le password in chiaro con l'algoritmo di hashing debole Vigenère tramite il comando:
  ```cisco
  service password-encryption
  ```
- **Password di abilitazione sicura**: Utilizzare l'algoritmo PBKDF2 o SHA-256 invece di MD5 per la password di enable tramite:
  ```cisco
  enable secret PasswordComplessa123!
  ```
- **Lunghezza minima**: Forzare una lunghezza minima per tutte le password create sul dispositivo:
  ```cisco
  security passwords min-length 10
  ```

___
# Accesso Remoto Sicuro

## Confronto SSH Vs Telnet
L'accesso alla CLI, *Command Line Interface*, per la gestione remota deve avvenire esclusivamente tramite protocolli cifrati.

- **Telnet**: Invia dati e credenziali interamente in chiaro (in formato ASCII). È vulnerabile a sniffing passivo tramite strumenti di analisi pacchetti.
- **SSH**, *Secure Shell*: Cifra tutto il traffico (comandi inviati, output generato, credenziali di accesso) fornendo autenticità e riservatezza.

> [!IMPORTANT] Regola Di Hardening
> Disabilitare Telnet sulle linee virtuali VTY, *Virtual Teletype*, consentendo solo SSH:
> ```cisco
> line vty 0 15
>  transport input ssh
> ```

## Login Banner
I banner visualizzati prima del login servono a scopo legale e di avviso per scoraggiare accessi non autorizzati.
- **Regola**: Non rivelare mai informazioni specifiche sul modello del dispositivo, versione del sistema operativo o dettagli aziendali nel banner. Dichiarare esplicitamente che l'accesso è riservato al personale autorizzato.
  ```cisco
  banner motd #ACCESSO RISERVATO AL PERSONALE AUTORIZZATO. OGNI TENTATIVO DI INTRUSIONE VERRA PERSEGUITO A NORMA DI LEGGE.#
  ```

___
# Mitigazione Degli Attacchi Brute Force

Per evitare che un attaccante possa indovinare le credenziali di accesso tramite tentativi continui sulle linee VTY, è fondamentale implementare il blocco temporaneo dei tentativi di login falliti (*login blocking*).

Comando per bloccare i tentativi di accesso per 120 secondi se si registrano 3 fallimenti entro un intervallo di 60 secondi:
```cisco
login block-for 120 attempts 3 within 60
```
Inoltre, è consigliabile registrare i tentativi di accesso falliti e di successo tramite syslog:
```cisco
login on-failure log
login on-success log
```

___
# Riduzione Della Superficie Di Attacco

## Disabilitare Servizi Non Utilizzati
Di default, i sistemi operativi dei router e switch possono avere servizi attivi non necessari per il normale funzionamento di rete.
- **Server HTTP/HTTPS**: Se non si utilizza l'interfaccia grafica web per la gestione, disattivare i relativi servizi:
  ```cisco
  no ip http server
  no ip http secure-server
  ```
- **IP Source Routing**: Disabilitare la capacità di determinare il percorso di instradamento direttamente dall'host sorgente:
  ```cisco
  no ip source-route
  ```

## Cisco Discovery Protocol Selettivo
Il protocollo proprietario CDP, *Cisco Discovery Protocol*, invia informazioni dettagliate sul dispositivo (modello, indirizzo IP, porte collegate) in broadcast sui link di rete.
- **Rischio**: Un attaccante collegato a una porta dello switch può sniffare i pacchetti CDP per mappare la topologia della rete locale.
- **Hardening**: Disabilitare CDP globalmente se non necessario:
  ```cisco
  no cdp run
  ```
  Oppure disabilitarlo in modo selettivo sulle singole interfacce rivolte verso l'esterno o verso i client, mantenendolo attivo solo sui trunk switch-to-switch:
  ```cisco
  interface GigabitEthernet0/1
   no cdp enable
  ```

## Disattivazione Delle Porte Inutilizzate
Qualsiasi porta fisica su uno switch che non è collegata a un dispositivo legittimo rappresenta un potenziale punto di accesso non autorizzato alla rete fisica.
- **Hardening**: Tutte le porte non utilizzate devono essere spente amministrativamente tramite il comando `shutdown` e spostate su una VLAN, *Virtual Local Area Network*, fittizia non instradata (es. VLAN 999 Blackhole):
  ```cisco
  interface range GigabitEthernet0/2 - 24
   shutdown
   switchport access vlan 999
  ```

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Cifratura Password** | `enable secret` usa hashing forte; `enable password` è in chiaro; `service password-encryption` cifra le password in chiaro con hashing debole (tipo 7). |
| **Comando VTY SSH** | `transport input ssh` per escludere Telnet. |
| **Port Hardening** | Spegnere le porte inutilizzate con `shutdown` e posizionarle su una VLAN non utilizzata. |
| **CDP Security** | Disabilitare CDP sulle porte rivolte agli host utente per evitare il leaking di informazioni. |

## Trabocchetti Frequenti

| Concetto Errato                                                                     | Realtà Tecnica                                                                                                                                                                                                  |
| :---------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Il comando "service password-encryption" garantisce la sicurezza delle password** | **FALSO**. Cifra le password del file di configurazione solo per impedire la lettura a schermo (spalleggiamento). La chiave crittografica usata (tipo 7) è facilmente decifrabile in pochi millisecondi online. |
| **Basta impostare una password complessa per evitare attacchi brute force**         | **FALSO**. Senza un blocco temporaneo (es. `login block-for`), un attaccante può tentare infinite combinazioni senza limiti di tempo.                                                                           |
| **Lasciare le porte vuote attive senza shutdown non comporta rischi se sono vuote** | **FALSO**. Chiunque abbia accesso fisico all'edificio può collegare un portatile o un access point abusivo ed entrare nella rete locale.                                                                        |

___
# Quick Reference Card

```
HARDENING BASE DI UN DISPOSITIVO CISCO:

1. CONFIGURAZIONE CREDENZIALI:
   security passwords min-length 10
   enable secret <PASSWORD_COMPLESSA>
   service password-encryption

2. CONFIGURAZIONE ACCESSO SICURO (VTY):
   line vty 0 15
    login local
    transport input ssh
   login block-for 120 attempts 3 within 60

3. DISATTIVAZIONE SERVIZI DI LEAKING:
   no ip http server
   no ip http secure-server
   no ip source-route
   no cdp run  (o disabilitato su porte host con "no cdp enable")

4. HARDENING PORTE FISICHE:
   interface <INTERFACCIA_INUTILIZZATA>
    shutdown
    switchport access vlan 999
```
___
--Gemini

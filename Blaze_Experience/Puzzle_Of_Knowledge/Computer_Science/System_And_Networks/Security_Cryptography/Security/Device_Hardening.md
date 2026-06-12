Data: 2026-06-12
[Security](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Security
___
# Index
- [[#Device Hardening]]
	- [[#Panoramica]]
- [[#Hardening Delle Linee Di Accesso]]
	- [[#Politica Delle Password]]
	- [[#Configurazioni Cisco IOS]]
	- [[#Accesso Remoto Sicuro]]
- [[#Mitigazione Dei Tentativi Di Accesso]]
- [[#Disattivazione Dei Servizi Non Necessari]]
	- [[#CDP Selettivo]]
	- [[#Spegnimento Delle Porte Fisiche]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Device Hardening_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Configurazione dei dispositivi per ridurre le vulnerabilità |
| **Obiettivo** | Riduzione della superficie di attacco complessiva |
| **Metodo** | Password complesse, disabilitazione servizi e spegnimento porte |

___
# Hardening Delle Linee Di Accesso

Il controllo degli accessi fisici e logici è fondamentale per proteggere gli apparati di rete Cisco.

## Politica Delle Password
- **Criteri**: Lunghezza minima (10–12 caratteri), complessità (numeri, maiuscole, caratteri speciali) e cifratura obbligatoria.

## Configurazioni Cisco IOS
- **Cifratura globale**: Cifrare le password nel file di configurazione (algoritmo tipo 7):
  ```cisco
  service password-encryption
  ```
- **Password di abilitazione forte**: Usare l'algoritmo PBKDF2/SHA-256 invece di MD5:
  ```cisco
  enable secret PasswordComplessa123!
  ```
- **Lunghezza minima**:
  ```cisco
  security passwords min-length 10
  ```

## Accesso Remoto Sicuro
- **SSH vs Telnet**: Evitare sempre Telnet (trasmette in chiaro). Utilizzare esclusivamente SSH, *Secure Shell*, che cifra le sessioni.
  ```cisco
  line vty 0 15
   transport input ssh
  ```
- **Login Banner**: Mostrare un banner legale che avvisa di accessi non autorizzati senza divulgare informazioni sul dispositivo:
  ```cisco
  banner motd #ACCESSO RISERVATO AL PERSONALE AUTORIZZATO.#
  ```

___
# Mitigazione Dei Tentativi Di Accesso

Per rallentare attacchi brute force, bloccare l'accesso temporaneamente dopo diversi fallimenti:
```cisco
login block-for 120 attempts 3 within 60
login on-failure log
login on-success log
```

___
# Disattivazione Dei Servizi Non Necessari

- **Server Web**: Disabilitare la gestione tramite interfaccia HTTP/HTTPS se non utilizzata:
  ```cisco
  no ip http server
  no ip http secure-server
  ```
- **IP Source Routing**: Disabilitare l'instradamento guidato dall'host sorgente:
  ```cisco
  no ip source-route
  ```

## CDP Selettivo
Il protocollo proprietario CDP, *Cisco Discovery Protocol*, rivela dati sensibili in broadcast.
- Disabilitare globalmente: `no cdp run`.
- Disabilitare localmente sulle porte host:
  ```cisco
  interface GigabitEthernet0/1
   no cdp enable
  ```

## Spegnimento Delle Porte Fisiche
- Spegnere sempre le porte inutilizzate dello switch amministrativamente con `shutdown` e associarle a una VLAN, *Virtual Local Area Network*, fittizia non instradata (es. VLAN 999 Blackhole):
  ```cisco
  interface range GigabitEthernet0/2 - 24
   shutdown
   switchport access vlan 999
  ```

___
# Note Esame

## Da Sapere A Memoria

- **VTY**: Comando `transport input ssh` per bloccare Telnet.
- **Port Security**: Spengere le porte inutilizzate con `shutdown` e assegnarle a VLAN dedicate non instradate.
- **CDP**: Disabilitare verso i client per evitare fughe di informazioni di rete.

## Trabocchetti Frequenti

- **Password Tipo 7**: `service password-encryption` è debole (facilmente decifrabile); l'unica cifratura sicura è `enable secret`.
- **Porte Vuote**: Anche se vuote, le porte attive sono un rischio di intrusione fisica immediata.

___
# Quick Reference Card

```
LINEE GUIDA DI HARDENING:
  - Cifra configurazione -> service password-encryption
  - Password abilitazione-> enable secret <password>
  - Blocca brute force   -> login block-for 120 attempts 3 within 60
  - Forza SSH su VTY     -> transport input ssh
  - Spegni porte libere  -> shutdown + switchport access vlan 999
  - Disabilita CDP host  -> no cdp enable
```
___
--Gemini

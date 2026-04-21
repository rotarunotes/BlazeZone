Data: 2025-11-14
[](README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Configuration/Switch
___
**Teoria:** [[segaSistemai/Systems_Theory/Netting/VLAN|VLAN_Teoria]]
`SW# show vlan brief`: Mostra tutte le VLAN e porte assegnate
# Creazione VLAN
``` CLI
SW(config)# vlan [numero_vlan]
SW(config-vlan)# name [nome_vlan]
```
# VLAN Untagged (Access  Mode)
## Porta Singola
``` CLI
SW(config)# interface fastEthernet 0/1
SW(config-if)# switchport mode access
SW(config-if)# switchport access vlan [numero_vlan]
```
## Porte Multiple
``` CLI
SW(config)# interface range fastEthernet 0/1 - 10
SW(config-if-range)# switchport mode access
SW(config-if-range)# switchport access vlan [numero_vlan]
```

___
# VLAN Tagged (Trunk Mode)

``` CLI
SW(config)# interface gigabitEthernet 0/1
SW(config-if)# switchport mode trunk
SW(config-if)# switchport trunk allowed vlan 10,20,30 // Elenco VLAN
```

- La stessa configurazione trunk deve essere applicata su entrambi gli switch connessi
___
# Inter VLAN Routing (Routing on stick)
- Si collega un cavo **Trunk** (Routing on stick) tra Router e Switch (contenente le VLAN). Il Router ha bisogno di essere configurato con delle **sub interface** (si comportano come delle interfacce fisiche)
``` CLI
R(config)# interface fastEthernet 0/0
R(config-if)# no shutdown

// Dichiarare una sub interface della vlan 10
R(config)# interface fastEthernet 0/0.10
R(config-subif)# encapsulation dot1Q 10
R(config-subif)# ip address 192.168.10.254 255.255.255.0

// Altro esempio:
R(config)# interface fastEthernet 0/0.20
R(config-subif)# encapsulation dot1Q 20
R(config-subif)# ip address 192.168.20.254 255.255.255.0
```

- Adesso il router avrà due interfacce, di cui 2 fisiche e due virtuali.
___
# VLAN Nativa
Serve per trasportare traffico "non taggato" attraverso il trunk, e la sua configurazione deve essere **coerente** su entrambe le estremità. Per motivi di sicurezza, si consiglia sempre di usare una VLAN Nativa diversa dalla VLAN 1 (quella di default).

___
# VTP (VLAN Trunking Protocol)
Protocollo solo per gli switch, ci permette di assegnare velocemente le VLAN su tutti gli switch in trunk, però l'assegnazione delle porte fisiche deve essere fatta per ogni switch.
Configurazione:
- Come trunk (**prerequisito**)
- vtp mode:
    - server
    - client
    - transparent
- vtp domain "string" (tutti quei dispositivi che rispondono ad un determinato server, un server controlla un solo dominio)
- vtp password
**Dominio:** è un gruppo di host o di reti.
```CLI
SW# show vtp status

// VTP Server
SW(config)# vtp mode server
SW(config)# vtp domain [Nome del dominio]
SW(config)# vtp password [password]
// ora si può procedere con la creazione delle vlan

// VTP Client
SW(config)# vtp mode client
SW(config)# vtp domain [Nome del dominio]
SW(config)# vtp password [password]
```

___
# DHCP Relay agent
- Centralizzare questione server dhcp
-  Le VLAN isolano il dominio di broadcast
``` CLI
R(config)# interface fastEthernet 0/0.10 
R(config-if)# ip helper-address 192.168.99.100 // IP del server

// solo i pacchetti dhcp transitano
```

È un'eccezione che deve essere configurata **per ogni singola interfaccia virtuale (sub-interfaccia)**, 
- Se hai 5 VLAN (10, 20, 30, 40, 50), devi configurare il comando `ip helper-address` separatamente su `fastEthernet 0/0.10`, `fastEthernet 0/0.20`, `fastEthernet 0/0.30`, ecc., per permettere a tutti gli host in quelle VLAN di raggiungere il server DHCP centralizzato.

___
# VOIP
telefono dispositivo fisico
la linea è il collegamento astratto quale numero (telefono sim)

Questa configurazione riguarda un'implementazione VOIP che utilizza una **VLAN dedicata** per il traffico voce.

- Si utilizza il router 2811
### 1. Rete e VLAN VOIP
``` CLI
SW(config-vlan)#switchport voice vlan [Numero vlan voice]]
```
### 2. Configurazione DHCP per il VOIP (Opzione 150)  Sul router
``` CLI
R(config)# ip dhcp pool VOICE
R(dhcp-config)# network [Gateway] [Maschera]
R(dhcp-config)# default-router [Indirizzo dell'interfaccia del router]
R(dhcp-config)# option 150 ip [Gateway]
R(dhcp-config)# exit
R(config)# ip dhcp excluded-address [Indirizzo dell'interfaccia del router]


//ESEMPIO
R(config)# ip dhcp pool VOICE
R(dhcp-config)# network 192.168.101.0 255.255.255.0
R(dhcp-config)# default-router [192.168.101.254]
R(dhcp-config)# option 150 ip 192.168.101.1
R(config)# ip dhcp excluded-address [192.168.101.254]
```

### 3. Configurazione del Centralino
``` CLI
router(config)# telephony-service
router(config-telephony)# ip source-address [Gateway] port 2000
router(config-telephony)# max-dn [Massimi linee (Numeri di telefono)]
router(config-telephony)# max-ephones [Massimo dispositivi fisici]
```

### 4. Creazione delle Linee Telefoniche (ephone-dn)
``` CLI
router(config-telephony)# ephone-dn [Numero Linea]
router(config-ephone-dn)# number [Numero del dispositivo]
router(config-ephone-dn)# exit

//esempi
router(config-telephony)# ephone-dn 1
router(config-ephone-dn)# number 11
router(config-ephone-dn)# exit

router(config-telephony)# ephone-dn 2
router(config-ephone-dn)# number 12
router(config-ephone-dn)# exit

router(config-telephony)# ephone-dn 3
router(config-ephone-dn)# number 21
router(config-ephone-dn)# exit

router(config-telephony)# ephone-dn 4
router(config-ephone-dn)# number 22
router(config-ephone-dn)# exit
```

### 5. Assegnazione Iniziale dei Telefoni Fisici (ephone)
- **Assegnazione Automatica Iniziale:** Permette ai telefoni di registrarsi inizialmente, ma l'assegnazione sarà casuale.

``` CLI
router(config-telephony)# auto-reg-ephone
```

- **Verifica:** Controlla i telefoni che si sono registrati (e a quali numeri MAC sono stati assegnati i numeri `ephone` casualmente). Code snippet

``` CLI
router# show running-config
```
### 6. Associazione Manuale Linea-Telefono (Button Assignment)
- **Scenario Esempio:**
    - Telefoni Fisici: T1, T2, T3, T4  
    - Associazioni casuali: `ephone 1` (T1), `ephone 2` (T3), `ephone 3` (T2), `ephone 4` (T4)  
    - Linee: Linea 1 (dn 1), Linea 2 (dn 2), Linea 3 (dn 3), Linea 4 (dn 4)  
- **Comando di Associazione:** `button 1:X`
    - **1:** Indica il primo bottone del telefono.  
    - **X:** Indica il numero dell'`ephone-dn` (linea) che deve essere associato a quel bottone.

Dopo l'assegnazione automatica casuale, si procede all'associazione **manuale** della linea (**ephone-dn**) al bottone del telefono fisico (**ephone**) per garantire la corretta numerazione.
``` CLI
router(config-telephony)# ephone [Numero del telefono]
router(config-ephone)# 
button [bottone del telefono]:[Indica il numero dell'ephone-dn (linea]
router(config-ephone)# exit

//Esempi
router(config-telephony)# ephone 1
router(config-ephone)# button 1:1  // Associa il bottone 1 alla Linea 1 (Numero 11)
router(config-ephone)# exit

router(config-telephony)# ephone 3  // Associa al telefono 3 (T2)
router(config-ephone)# button 1:2  // Associa il bottone 1 alla Linea 2 (Numero 12)
router(config-ephone)# exit

router(config-telephony)# ephone 2  // Associa al telefono 2 (T3)
router(config-ephone)# button 1:3  // Associa il bottone 1 alla Linea 3 (Numero 21)
router(config-ephone)# exit

router(config-telephony)# ephone 4
router(config-ephone)# button 1:4  // Associa il bottone 1 alla Linea 4 (Numero 22)
router(config-ephone)# exit
```
Data: 2025-11-14
[](README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Configuration/Switch
___
**Teoria:** [[Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Systems_Theory/Netting/VLAN|VLAN_Teoria]]
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

// Dichiarare una sub interface
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
SW(config)# vtp domain Scuola
SW(config)# vtp password scuola
// ora si può procedere con la creazione delle vlan

// VTP Client
SW(config)# vtp mode client
SW(config)# vtp domain Scuola
SW(config)# vtp password scuola
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
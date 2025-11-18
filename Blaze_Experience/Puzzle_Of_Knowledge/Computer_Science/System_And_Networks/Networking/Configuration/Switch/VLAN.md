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



	VLAN VOIC ---> VOIP
192.168.101.0/24

(schema switcht - tel -pc)
avendo la vlan assegnata al voip, dobbiamo assegnare la porta che collega lo switch al telefono:
switchport voice vlan "x"


router 2811
creo una pool con un dhcp server col router 2811

ip dhcp pool voice
network(ip  del voice) mask
option 150 indiritzzo del centralino


ora configurazione della linea

switch
``` CLI
conf t/telephony-service
ip source-address (gatawey che da verso il voip) port 2000

max-dn 5
max-ephones 5

//creo le linee telefoniche che corrispondono per ogni telefono
ephone-dn 1
number 11
exit
ephone-dn 2
number 12
exit
ephone-dn 3
number 21
exit
ephone-dn 4
number 22
exit

//assegno i telefoni a delle ephone
/telephony-service
auto-reg-ephone

verifico se ci sono i telefoni
con show running-config

avendo ora l'assegnazione dei telefoni, però sono stati assegnati in modo casuale, quindi ora assegnamo manualmente ogni linea-telefono alla corretta linea
per esempio se avessimo:
telefono 1, telefono 2, telefono 3, telefono 4

ephone 1 telefono 1
ephone 2 telefono 3
ephone 3 telefono 2
ephone 4 telefono 4



//associo bottone 1 alla linea 1
ephone 1
button 1:1

//associo bottone 1 alla linea 2
ephone 3 
button 1:2

ephone 2
//associo bottone 1 alla linea 3
button 1:3

ephone 4
//associo bottone 1 alla linea 4
button 1:4




```


 massimi di linee telefoniche 
 massimi di telefoni
 
telefono dispositivo fisico
la linea è il collegamento astratto qule numero (telefono sim)


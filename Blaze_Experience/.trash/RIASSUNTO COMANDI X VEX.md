# VLAN

```
// Creazione Delle vlan
SW(config)# vlan [numero_vlan]
SW(config-vlan)# name [nome_vlan]

// Singolo
SW(config)# interface fastEthernet 0/1
SW(config-if)# switchport mode access
SW(config-if)# switchport access vlan [numero_vlan]

// Range
SW(config)# interface range fastEthernet 0/1 - 10
SW(config-if-range)# switchport mode access
SW(config-if-range)# switchport access vlan [numero_vlan]

// Trunk
SW(config)# interface gigabitEthernet 0/1
SW(config-if)# switchport mode trunk
SW(config-if)# switchport trunk allowed vlan 10,20,30 // Elenco VLAN

// Router
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

// VTP

// Mostra vtp status wow
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

# DHCP
```
// Relay agent
R(config)# interface fastEthernet 0/0.10 
R(config-if)# ip helper-address 192.168.99.100 // IP del server DHCP

// DHCP router
R(config)# ip dhcp pool [nome_pool]
R(dhcp-config)# network [Indirizzo di rete] [mask]
R(dhcp-config)# default-router [Indirizzo dell'interfaccia del router]
R(dhcp-config)# exit
R(config)# ip dhcp excluded-address [Indirizzo dell'interfaccia del router]

```

# ACL Estese

```
// Mostra tutte le ACL configurate
Router# show ip access-lists

// Assegnare una ACL ad una interfaccia
Router(config)# interface [Interfaccia] [N]
Router(config-if)# ip access-group [N. ACL] [out/in]

// ACL Estesa
Router(config-ext-nacl)# 
[permit|deny] [protocollo] [src] [wc-src] [$eq_scr$] [dst] [wc-dst] [$eq_dst$]
[$opzioni$]
```

# NAT Da fare in ogni caso
```
// Mosta tabella NAT
show ip nat translations

// Interfaccia
Router(config)# interface fastEthernet 0/0 
Router#(config-if)# ip address [gateway lan] [mask]     
Router(config-if)# ip nat inside               
Router(config-if)# exit
```
# NAT Statico
```
// Assegnazione regola NAT
Router(config)# ip nat inside source static 192.168.1.2 10.0.0.100
```
# PAT
```
// ACL per filtrare quali pacchetti verranno translati dal PAT
Router(config)# access-list 1 permit 192.168.1.0 0.0.0.255

// Regola PAT
Router(config)# ip nat inside source list 1 interface fastEthernet 0/1 overload
```
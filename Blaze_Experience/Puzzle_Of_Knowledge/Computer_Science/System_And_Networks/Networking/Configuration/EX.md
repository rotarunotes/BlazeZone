1) i collegamenti tra switch e router DEVONO essere in trunk, tutto il resto come:
	1) pc
	2) server
	3) WLC
	4) AP
	Devono essere collegato con:
```
SW(config)# interface fastEthernet 0/1
SW(config-if)# switchport mode access
SW(config-if)# switchport access vlan [numero_vlan]
```

2) mettere sempre il default gateway ogni volta che si vuole assegnare un indirizzo ip


# WLC
1) Tolgo il DCHP Scope
![[DHCP_Scope_Remove|1000]]

2) Salva
![[WLC_Salva|1000]]



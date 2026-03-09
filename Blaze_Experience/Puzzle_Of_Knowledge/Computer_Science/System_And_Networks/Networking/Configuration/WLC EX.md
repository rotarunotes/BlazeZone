1) i collegamenti tra switch e router e WLC devono essere in trunk, 
   
2) Tutto il resto come:
	1) PC Admin
	2) Server DHCP e Radius
	3) AP
	Devono essere collegato con:
``` CLI
SW(config)# interface fastEthernet 0/1
SW(config-if)# switchport mode access
SW(config-if)# switchport access vlan [numero_vlan]
```

2) mettere sempre il default gateway ogni volta che si vuole assegnare un indirizzo ip

3) Imposto le trunk native VLAN:
   - Nei collegamenti tra:
	   - Switch e WLC
```
SW(config-if)# switchport trunk native vlan [numero_vlan_WIFI]
```



# WLC
1) Tolgo il DCHP Scope
![[DHCP_Scope_Remove|1000]]

2) Salva
![[WLC_Salva|1000]]

3) verificare che ci siano gli AP
![[WLC_Verifica_AP|10000]]

4) Creare le interfacce
![[WLC_Interfacce|10000]]

5) Imposto:
![[WLC_VLAN_Creazione|10000]]

6) Configuro le varie impostazioni dell'interfaccia:
![[WLC_Interfaccia_Impostazioni|1000]]

7) Apply
![[WLC_Interfacce_Apply|1000]]

8) Ripeto i passaggi dal **4** al **7** per ogni VLAN, in questo esempio aggiungo Int-Docenti
9) Server Radius
	1) Aggiungo il WLC 
	   ![[Server_Radius_WLC|10000]]
	2) Imposto gli user e password
	   ![[Server_Radius_Nome_Utenti|1000]]
10) Imposto il radius nel WLC
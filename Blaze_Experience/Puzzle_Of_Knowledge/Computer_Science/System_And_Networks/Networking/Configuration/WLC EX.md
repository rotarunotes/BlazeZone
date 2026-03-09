

# Parte VTP e DHCP Svolta

# Impostazione Pre Configurazione 
1) i collegamenti che devono essere in trunk: 
	1) Switch e switch
	2) Switch e router 
	3) Switch e WLC
	4) Switch e AP
```
SW(config)# interface fastEthernet [N porta]
SW(config)# switchport mode trunk

//su collegamente WLC e Switch | AP e Switch
SW(config-if)# switchport trunk native vlan [numero_vlan_WIFI]
```
   
3) Tutto il resto come:
	1) Switch e PC-ADMIN
	2) Switch e Server DHCP
	3) Switch e Server Radius
``` CLI
SW(config)# interface fastEthernet 0/1
SW(config-if)# switchport mode access
SW(config-if)# switchport access vlan [numero_vlan]
```

# WLC
1) Creo il profilo admin
	1) Creazione Admin
	   ![[WLC_Create_Admin_User|1000]]
	2) Set Up Your Controller
	   ![[WLC_Admin_Set_Up_Your_Controller|1000]]
	3) Create Your Wireless Networks
	   ![[WLC_Admin_Create_Your_Wireless_Networks|1000]]
	4) Advanced Setting
	   ![[WLC_Admin_Advanced_Setting|1000]]
	5) Mettere https
2) DHCP
	1) Tolgo il DCHP Scope
	![[DHCP_Scope_Remove|1000]]
	2) Salva
	![[WLC_Salva|1000]]
3) verificare che ci siano gli AP
	![[WLC_Verifica_AP|10000]]
4) Interfacce
	1) Creare le interfacce
	![[WLC_Interfacce|10000]]
	2) Imposto:
	![[WLC_VLAN_Creazione|10000]]
	3) Configuro le varie impostazioni dell'interfaccia:
	![[WLC_Interfaccia_Impostazioni|1000]]
	4) Apply
	![[WLC_Interfacce_Apply|1000]]
	5) Ripeto i passaggi dal **4** al **7** per ogni VLAN, in questo esempio aggiungo Int-Docenti
5) Server Radiuis
	1) Aggiungo il WLC 
	   ![[Server_Radius_WLC|10000]]
	2) Imposto gli user e password
	   ![[Server_Radius_Nome_Utenti|1000]]
6) Radius nel WLC
	1) Imposto il radius nel WLC
	![[WLC_Radius|10000]]
	2) Aggiungo il server radius
	![[WLC_Radius_New|10000]]
7) Configurazione delle WLAN
	1) Configuro le VLAN
	![[WLC_Configurazione_WLAN|10000]]
	2) All' inizio quando abbiamo creato una wlan (Durante l'accesso al WLC), c'è la ritroviamo qua, rinomino in **"WLAN Studenti"**, dopodichè la configurazione sarà ugaule alle configurazioni nuove che faremo (WLAN Docenti) correttamente le WLAN
	![[WLC_General|10000]]
	3) Security
		- Layer 2![[WLC_Security_Layer2|10000]]
		- AAA Servers ![[WLC_Security_AAA_Servers|1000]]
	4) Advanced ![[WLC_Advanced|10000]]
	5) apply e salva
	![[WLC_Interfacce_Apply|1000]]
	![[WLC_Salva|1000]]
8) Gruppi AP
	1) Creo i Gruppi Degli AP
	![[WLC_AP_Groups|1000]]
	2) Nome gruppo
	![[WLC_AP_Nome|10000]]
	3) WLANs
	![[WLC_Guppi_WLANs|10000]]
	4) APs
	![[WLC_Grupp_APs|10000]]
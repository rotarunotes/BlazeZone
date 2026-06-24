

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
"C:\Users\user\Desktop\Repo\BlazeZone\Blaze_Experience\Setup_Archive\Viewable\Image\Computer_Science\System_And_Networks\WLC_Admin_Set_Up_Your_Controller.jpg"
# WLC
1) Creo il profilo admin
	1) Creazione Admin:
	   ![WLC_Create_Admin_User.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Create_Admin_User.jpg)
	2) Set Up Your Controller:
	   ![WLC_Admin_Set_Up_Your_Controller.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Admin_Set_Up_Your_Controller.jpg)
	3) Create Your Wireless Networks:
	   ![WLC_Admin_Create_Your_Wireless_Networks.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Admin_Create_Your_Wireless_Networks.jpg)
	4) Advanced Setting
	   ![WLC_Admin_Advanced_Setting.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Admin_Advanced_Setting.jpg)
	5) Mettere https
2) DHCP
	1) Tolgo il DCHP Scope:
		![DHCP_Scope_Remove.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_DHCP_Scope_Remove.jpg)
	2) Salva:
	   ![WLC_Salva.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Salva.jpg)
3) verificare che ci siano gli AP:
	![WLC_Verifica_AP.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Verifica_AP.jpg)
4) Interfacce
	1) Creare le interfacce:
		![WLC_Interfacce.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Interfacce.jpg)
	2) Imposto:
	   ![WLC_VLAN_Creazione.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_VLAN_Creazione.jpg)
	3) Configuro le varie impostazioni dell'interfaccia:
	   ![WLC_Interfaccia_Impostazioni.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Interfaccia_Impostazioni.jpg)
	4) Apply:
	   ![WLC_Interfacce_Apply.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Interfacce_Apply.jpg)
	5) Ripeto i passaggi dal **4** al **7** per ogni VLAN, in questo esempio aggiungo Int-Docenti
5) Server Radius:
	1) Aggiungo il WLC:
	   ![Server_Radius_WLC.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Server_Radius.jpg)
	2) Imposto gli user e password:
	   ![Server_Radius_Nome_Utenti.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Server_Radius_Nome_Utenti.jpg)
6) Radius nel WLC
	1) Imposto il radius nel WLC:
	   ![WLC_Radius.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Radius.jpg)
	2) Aggiungo il server radius:
	   ![WLC_Radius_New.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Radius_New.jpg)
7) Configurazione delle WLAN
	1) Configuro le VLAN:
	   ![WLC_Configurazione_WLAN.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Configurazione_WLAN.jpg)
	2) All' inizio quando abbiamo creato una wlan (Durante l'accesso al WLC), c'è la ritroviamo qua, rinomino in **"WLAN Studenti"**, dopodichè la configurazione sarà ugaule alle configurazioni nuove che faremo (WLAN Docenti) correttamente le WLAN:
	   ![WLC_General.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_General.jpg)
	3) Security:
		- Layer 2:
		  ![WLC_Security_Layer2.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Security_Layer2.jpg)
		- AAA Servers:
		  ![WLC_Security_AAA_Servers.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Security_AAA_Servers.jpg)
	4) Advanced:
	   ![WLC_Advanced.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Advanced.jpg)
	5) apply e salva:
	   ![WLC_Interfacce_Apply.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Interfacce_Apply.jpg)
       ![WLC_Salva.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Salva.jpg)
8) Gruppi AP:
	1) Creo i Gruppi Degli AP:
	   ![WLC_AP_Groups.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_AP_Groups.jpg)
	2) Nome gruppo:
	   ![WLC_AP_Nome.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_AP_Nome.jpg)
	3) WLANs:
	   ![WLC_Guppi_WLANs.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Guppi_WLANs.jpg)
	4) APs:
	   ![WLC_Grupp_APs.jpg](../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/WLC_Grupp_APs.jpg)
9) Laptop cambio scheda
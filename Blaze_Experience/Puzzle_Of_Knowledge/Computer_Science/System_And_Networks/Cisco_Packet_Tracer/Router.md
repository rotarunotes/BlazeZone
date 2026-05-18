Data: 2025-11-18
[](Modelli/segaSistemai/Networking/Configuration/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Configuration
___
# Modelli
- **Router 1841**: 2 interfacce
- **Router 2911**: 3 interfacce
- **Router 2811**: 1 interfaccia/ VOIP
# Reset Del Router
``` CLI
R# show version    // Mostra versione e configurazione registro

# Valori registro comuni:
0x2102 -> Avvia normalmente la configurazione
0x2142 -> Ignora la configurazione della NVRAM (recovery)
```

1. Spegni e riaccendi
2. In fase di avvio del SO bisogna bloccare il boot:
	1. Packet Tracer: **ctrl + shift + c**
	2. Tera term: **alt + b** 
3. Modalità recovery:
4. `confreg 0x2142`
5. `reset`
6. :
``` CLI
# Opzione A: Eliminare completamente la configurazione
R-1# erase startup-config

# Opzione B: Sovrascrivere la configurazione
R-1# copy running-config startup-config
```
7. ripristinare registro normale: `R-1(config)# config-register 0x2102`
8. Riavviare: `R-1# reload`

___
# Assegnazione Dell' IP
``` CLI
R(config)# interface [porta a cui vogliamo assegnare indirizzo ip]
R#(config-if)# ip address [indirizzo del router] [mask]
R#(config-if)# no shutdown

//ESEMPIO 
R(config)# interface fastEthernet 0/0
R(config-if)# ip address 192.168.1.254 255.255.255.0
R#(config-if)# no shutdown
```

# Rotte 
## Rotte Statiche
``` CLI
R(config)#ip route [rete di destinazione] [maschera] [next hop] [Metrica]

//ESEMPIO
R(config)#ip route 192.168.2.0 255.255.255.0 40.0.0.1 1
```

**next hop:** È l'indirizzo  della porta del router dove passa il pacchetto per arrivare a destinazione

- Se si imposta una rotta, bisogna impostare anche la rotta di risposta

### Metriche

- Metrica = priorità
- Un numero compreso da 0-255 dove lo 0 significa direttamente collegata e 1 è di default
- Quando di aggiunge una nuova rotta, per convenzione, si lascia un gap di 10 metriche 
	- Rotta principale metrica: 1
	- Rotta secondaria metrica: 10

## Rotte Dinamiche

``` CLI
R(config)# router rip
R(config-router)# version 2
R(config-router)# network [rete]    // Ripetere per ogni rete connessa direttamente
```

- Le rotte calcolate dinamicamente hanno una metrica molto alta

## Visualizzazione Tabelle Di Routing

- Tabella di routing
``` CLI
R# show ip route
```

- Tutte le rotte statiche impostate
``` CLI
R# show running-config | include ip route
```
## Default-Gateway of Last Resort

``` CLI
R(config)# ip route 0.0.0.0 0.0.0.0 [next hop]
```

Rotta statica di default per tutti i pacchetti sconosciuti

___
# Impostare il DHCP
1. **Configurare IP sull'interfaccia del router**

``` CLI
R(config)# interface fastEthernet [interfaccia]
R(config-if)# ip address [.254] [mask]
R(config-if)# no shutdown

//Esempio
R(config)# interface fastEthernet 0/0
R(config-if)# ip address 192.168.1.254 255.255.255.0
R(config-if)# no shutdown
```

2. **Configurazione DHCP Pool**

``` CLI
R(config)# ip dhcp pool [nome_pool]
R(dhcp-config)# network [Indirizzo di rete] [mask]
R(dhcp-config)# default-router [Indirizzo dell'interfaccia del router]
R(dhcp-config)# exit
R(config)# ip dhcp excluded-address [Indirizzo dell'interfaccia del router]

//Esempio
R(config)# ip dhcp pool [nome_pool]
R(dhcp-config)# network 192.168.1.0  255.255.255.0
R(dhcp-config)# default-router 192.168.1.254 // IP dell'interfaccia router che vogliamo utilizzare
R(dhcp-config)# exit
R(config)# ip dhcp excluded-address 192.168.1.254 // escludero lo stesso ip di default-router
```

___

# Collegamento Seriale DCE-DTE

- **DCE** (Data Communication Equipment): Fornisce il clock
- **DTE** (Data Terminal Equipment): Acquisisce il clock dal DCE

## Procedura di Configurazione

1. **Spegnere il router**
2. **Aggiungere modulo WIC-1T** in uno slot disponibile
3. **Riaccendere il router**
4. **Decidere** se impostare il router come DCE o DTE e collegare i 2 router
	- Su Cisco packet tracer il collegamento in seriale va effettuato con il cavo rosso (con l'orologio)  

## Configurazione Router DCE (Fornisce Clock)

``` CLI
R(config)# interface serial [interfaccia seriale]
R(config-if)# ip address [indirizzo Ip] [mask]
R(config-if)# clock rate [clock]
R(config-if)# no shutdown

//Esempio
R(config)# interface serial 0/0/0
R(config-if)# ip address 10.0.0.1 255.255.255.0
R(config-if)# clock rate 64000 // Imposta velocità clock
R(config-if)# no shutdown
```

## Configurazione Router DTE (Riceve Clock)

``` CLI
R(config)# interface serial [Porta seriale]
R(config-if)# ip address [Indirizzo Ip] [Mask]
R(config-if)# no shutdown

//Esempio
R(config)# interface serial 0/0/0
R(config-if)# ip address 10.0.0.2 255.255.255.0
R(config-if)# no shutdown
```

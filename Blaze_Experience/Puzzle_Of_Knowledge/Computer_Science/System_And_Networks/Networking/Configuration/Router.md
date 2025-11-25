Data: 2025-11-18
[](./README.md)
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
R#(config-if)# ip address [indirizzo del router] [maschera]
R#(config-if)# no shutdown

//ESEMPIO 
R(config)# interface fastEthernet 0/0
R(config-if)# ip address 192.168.1.254 255.255.255.0
R#(config-if)# no shutdown
```

# Rotte Statiche
``` CLI
R(config)# [rete di destinazione] [maschera] [next hop]

//ESEMPIO
R(config)# 192.168.2.0 255.255.255.0 40.0.0.1
```

**next hop:** È l'indirizzo  della porta del router dove passa il pacchetto per arrivare a destinazione

- Se si imposta una rotta, bisogna impostare anche la rotta di risposta

## Visualizzazione Tabelle Di Routing
- Tabella di routing
``` CLI
R# show ip route
```
- Tutte le rotte statiche impostate
``` CLI
R# show running-config | include ip route
```

___
# Default-Gateway of Last Resort
```
R(config)# ip route 0.0.0.0 0.0.0.0 [next hop]
```

___

# Impostare il DHCP
1. **Configurare IP sull'interfaccia del router**

```
R(config)# interface fastEthernet 0/0
R(config-if)# ip address 192.168.1.254 255.255.255.0
R(config-if)# no shutdown
```

2. **Configurazione DHCP Pool**

```
R(config)# ip dhcp pool [nome_pool]
R(dhcp-config)# network [Indirizzo di rete] [Maschera]
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
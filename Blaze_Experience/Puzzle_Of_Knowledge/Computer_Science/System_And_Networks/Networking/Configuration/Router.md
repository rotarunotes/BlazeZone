Data: 2025-11-18
[](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Configuration
___
# Modelli
- **Router 1841**: 2 interfacce
- **Router 2911**: 3 interfacce
- **Router 2811**: 1 interfaccia/ VOIP
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

R(config)# 192.168.2.0 255.255.255.0 40.0.0.1
```

**next hop:** È l'indirizzo  della porta del router dove passa il pacchetto per arrivare a destinazione

- Se si imposta una rotta, bisogna impostare anche la rotta di risposta
___
# Titolo 2
___
 
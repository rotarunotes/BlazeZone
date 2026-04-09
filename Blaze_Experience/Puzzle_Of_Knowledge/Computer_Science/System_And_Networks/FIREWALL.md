firewall
controlla verifica e monitorare i pacchetti fino a livello 4

se vorrei arrivare a un livello più altro devo utilizzare un proxy

Configurazione: regole

**ACL** (Access Control List), è una tabella con i record le singole regole
- Standard: Possono filtrare fino al layer 3, filtrano i pacchetti sulla base della sorgente
	- Range: 1-99, lunghezza del nome identificativo della tabella
	- Devono applicare l'ACL sull'interfaccia OUTBOUND più vicina alla destinazione
- Estese: Filtra fino al layer 3/4, controlla la sorgente e la destinazione
	- Range: 100-199, lunghezza del nome identificativo della tabella

| Numero della regola | Policy   |               |
| ------------------- | -------- | ------------- |
| 10                  | PERMIT   | 192.168.1.130 |
| 20                  | DENY     | 192.168.1.0   |
|                     |          |               |
| Default             | DENY ANY |               |
Il pacchetto inviato, scorre tutte le varie ACL, e ogni singola regola (record)
**Policy**:
- PERMIT: Lascia passare
- DENY: Scarta
- REJECT: Segnala all'utente che c'è stato un blocco del suo pacchetto

**Wildcard musk**
- il firewall ragiona così:
	- 0 = match
	- 1 = ingnore
Voglio fare match con la rete 192.168.1.0
devo guardare i primi 3 otteti per verificare la rete quindi la wildcard musk sarà:

| indirizzo ip  | 192.168.1.132 |
| ------------- | ------------- |
| Wildcard musk | 0.0.0.255     |
tecnicamente è il contrario della subnet


# Esempio
Bloccare rete A con rete B

![[ACL_Spiegazione|10000]]


**ACL 1**
Scarta tutti gli ip della rete 192.168.1.0, tranne 192.168.1.130
- Applico l'ACL nell'interfaccia 2 in OUTBOUND

| Numero della regola | Policy   |               |
| ------------------- | -------- | ------------- |
| 10                  | PERMIT   | 192.168.1.130 |
| 20                  | DENY     | 192.168.1.0   |
|                     |          |               |
| Default             | DENY ANY |               |
Creare la policy:

Ruoter
```

R(config)# interface [porta a cui vogliamo assegnare indirizzo ip]
R#(config-if)# ip address [indirizzo del router] [mask]
R#(config-if)# no shutdown

//ESEMPIO 
R(config)# interface fastEthernet 0/0
R(config-if)# ip address 192.168.1.254 255.255.255.0
R#(config-if)# no shutdown
```

```
// Mostra la lista degli acl
show ip access-lists

// Creo l'ACL
R(config)# access-list [N_ACL] [Policy] [Indirizzo di rete] [Wildcard musk]

//SI entra nella singola interfaccia
R(config)# interface fastEthernet 0/0
R(config-if# ip access-group [N_ACL] [out/in]

```

# Ex passaggio vex

1) Configurare le Interfaccia del router
2) Consiglio: Creare le ACL
```
R(config)# ip access-list standard 1
R(config)# ip access-list standard 2
R(config)# ip access-list standard 3
```
3) Per ogni Interfaccia del router assegnare le ACL, è una convenzione assegnare le ACL in outbound dalla interfaccia più vicina alla destinazione
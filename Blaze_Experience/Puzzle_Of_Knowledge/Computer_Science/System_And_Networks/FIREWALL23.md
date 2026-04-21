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

//Entrare nell'ACL
R(config)# ip access-list standard 3
R(config-std-nacl)# [N_regola] [Policy] [non so come continuare]

```

# Ex passaggio vex

1) Configurare le Interfaccia del router
2) Consiglio: Creare le ACL
```
R(config)# ip access-list standard 1
R(config)# ip access-list standard 2
R(config)# ip access-list standard 3
```
3) Per ogni Interfaccia del router assegnare le ACL, è una convenzione assegnare le ACL in Outbound dalla interfaccia più vicina alla destinazione
4) si fanno el deny
5) **Occhio che bisogna impostare anche la regola per le risposte**

# ACL esteso
1) ACL esteso da 100 a 199
2) Permette di lavorare fino a livello 4, fino a una porta tcp e udp

```
R(config)# ip access-list extended 100
```

![[Pasted image 20260409124016.png]]

![[Pasted image 20260409124143.png]]


```
R(config)# ip access-list extended 100
R(config-ext-nacl)# deny ip 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255
```

# ACL ESTESE

- Filtra la **SRC** e la **DEST**
- Va applicata sempre INBOUND più vicino **SRC**
- Si lavora sul layer 3 e 4, Quindi si filtra sulla base sia sull'IP ma anche della porta (servizio), per abilitare http, abilito la porta 80
- 100-199
  
![[ACL_Spiegazione|10000]]

- Se rete A non può comunicare con rete B, allora B non può comunicare con A perchè anche se è una risposta, rete A non può comunicare con rete B.
	- Se facciamo un ping, l'output è  `request time out` perchè non riceve per l'appunto una risposta, e non `request non enricalbel`
	- Tutti i protocolli che neccessito una risposta (TCP), falliscono nel metodo normale
- Firwall:
	- STATELESS: 
	- STATEFULL: Il firewall riesce a capire se il pacchetto è una risposta o una domanda
Con le regole delle ACL Estese siamo in grado di rendere STATEFULL un firewall, quindi siamo in grado di risolvere: rete A non può comunicare con rete B, allora B non può comunicare con A, perchè ora il pacchetto risposta da rete A verso rete B non viene bloccato dal firewall.

Comandi
Creo le acl
![[Pasted image 20260421132439.png]]

Assegno le ACL alle porte del router:
![[Pasted image 20260421132459.png]]

Rete A non comunica con rete B:

Entriamo nell'ACL più vicina alla sorgente:
![[Pasted image 20260421132619.png]]
Scriviamo la regola: sorgente destinazione
![[Pasted image 20260421132644.png]]

Ora abilitiamo il protocollo ICMP (Include ping), `echo-reply` identifica se è una risposta
![[Pasted image 20260421132953.png]]
![[Pasted image 20260421133026.png]]

Ora permettiamo tutti i pacchetti che hanno stabilito una connessione TCP 
![[Pasted image 20260421133227.png]]
Invece qua permettiamo tutti i pacchetti in "risposta" dal server 
![[Pasted image 20260421134235.png]]

VEDO TUTTE LE ACL
![[Pasted image 20260421133524.png]]


![[Pasted image 20260421134002.png]]



> [!NOTE] Title
> Quando navighi su internet, la comunicazione è come un tunnel con due estremità:
> 1. **Destinazione (Server):** Ha una porta **fissa** (es. 80 o 443). È come il numero dell'ufficio che stai chiamando.
> 2. **Sorgente (Tu):** Il tuo PC apre una porta **casuale ed effimera** (es. 51234). È come l'interno del tuo telefono da cui parte la chiamata.

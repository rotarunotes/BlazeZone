Data: 2026-05-12
[Cisco_Packet_Tracer](Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Cisco_Packet_Tracer/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Cisco_Packet_Tracer
___
# Index
- [[#SHOW]]
- [[#ACCESS GROUP]]
- [[#ACL Standard]]
- [[#ACL Estese]]
	- [[#Esercizio]]
- [[#Workflow Come Configurare le ACL]]
___
# SHOW
``` cisco
! Mostra tutte le ACL configurate
Router# show ip access-lists
```

___
# ACCESS GROUP

Assegnare una ACL a una interfaccia.

``` cisco
Router(config)# interface [Interfaccia] [N]
Router(config-if)# ip access-group [N. ACL] [out/in]
	
### ESEMPIO
Router(config)# interface gigabitEthernet 0/1
Router(config-if)# ip access-group 1 out
```
___
# ACL Standard

> [!success] Nota
> Le ACL standard vanno applicate sempre **outbound** sull'interfaccia più vicina alla **destinazione**.

Ci sono 2 metodi per configurare L'ACL standard:

1) Metodo esteso, prima si crea l'ACL e poi si aggiungono le righe

``` cisco
Router(config)# ip access-list standard [1-99]
Router(config-std-nacl)# [N_regola] [permit|deny] [src] [wc-src]

### ESEMPIO
Router(config)# ip access-list standard 1
Router(config-std-nacl)# 10 permit 192.168.1.130 0.0.0.0
Router(config-std-nacl)# 20 deny   192.168.1.0   0.0.0.255
```

2)  Metodo compatto, crea e aggiungo righe in uno:
``` cisco
Router(config)# access-list [1-99] [permit|deny] [indirizzo] [wildcard]

### Esempio
Router(config)# access-list 1 permit 192.168.1.130 0.0.0.0
Router(config)# access-list 1 deny 192.168.1.0 0.0.0.255
```
___
# ACL Estese

> [!success] Nota
> Le ACL estese vanno applicate sempre **inbound** sull'interfaccia più vicina alla **sorgente**.

- Si può sempre configurare nei 2 modi, io prediligo quello esteso per configurazioni più complesse.
  
Indica parametri opzionali: \$$
- \[**eq**]: Sta per porta.
```cisco
! Creare l'ACL
Router(config)# ip access-list extended [100-199]
! generalemente segue questo schema:
Router(config-ext-nacl)# 
[permit|deny] [protocollo] [src] [wc-src] [$eq_scr$] [dst] [wc-dst] [$eq_dst$]
[$opzioni$]

Router(config)# ip access-list extended 100
Router(config-ext-nacl)# deny ip 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255
Router(config-ext-nacl)# permit ip any any
```

## Esercizio
![[Pasted image 20260428131019.png]]

```c
Extended IP access list 100
    10 permit tcp 192.168.1.0 0.0.0.255 host 192.168.2.100 eq www
    20 permit tcp 192.168.1.0 0.0.0.255 host 192.168.3.1 established
    30 permit icmp 192.168.1.0 0.0.0.255 host 192.168.3.1 echo-reply
    40 permit tcp host 192.168.1.2 host 192.168.3.100 eq ftp
Extended IP access list 101
    10 permit udp any range bootps bootpc any range bootps bootpc
    20 permit tcp host 192.168.2.100 eq www 192.168.1.0 0.0.0.255 established
    30 permit icmp host 192.168.2.100 any echo-reply
    40 deny ip host 192.168.2.100 any
    50 deny ip 192.168.2.0 0.0.0.255 192.168.1.0 0.0.0.255
    60 permit ip 192.168.2.0 0.0.0.255 192.168.3.0 0.0.0.255
Extended IP access list 102
    10 permit tcp host 192.168.3.100 eq ftp host 192.168.1.2
    20 deny tcp host 192.168.3.100 eq ftp any established
    30 permit tcp 192.168.3.0 0.0.0.255 192.168.2.0 0.0.0.255 established
    40 permit icmp 192.168.3.0 0.0.0.255 192.168.2.0 0.0.0.255 echo-reply
    50 permit ip host 192.168.3.1 192.168.1.0 0.0.0.255
    60 deny ip host 192.168.3.1 any
    70 permit udp host 192.168.3.200 range bootps bootpc host 192.168.2.254 range bootps bootpc
```
___
# Workflow: Come Configurare le ACL

```
1. Progetta la topologia
   └─ Identifica sorgenti, destinazioni e i vincoli di comunicazione

2. Decidi il tipo di ACL
   ├─ Standard (1-99)  → filtra solo sorgente → vicino alla destinazione (OUTBOUND)
   └─ Estesa (100-199) → filtra src + dst + protocollo → vicino alla sorgente (INBOUND)

3. Configura le interfacce del router
   └─ ip address + no shutdown su ogni interfaccia

4. Crea le ACL
   └─ Scrivi prima i PERMIT specifici, poi i DENY generali
      (il DENY ANY finale è implicito)

5. Applica le ACL alle interfacce
   └─ ip access-group [N] [in|out]

6. Gestisci il traffico di risposta (se necessario)
   └─ Aggiungi regole con "established" (TCP) o "echo-reply" (ICMP)

7. Verifica
   └─ show ip access-lists
```
___


Rete A comunica solo HTTP server0 Rete B non comunica con rete A Rete B comunica con rete C Server HTTP non può generare richieste Server HTTP risponde al PING PC4 comunica solo con rete A Server FTP raggiungibile solo da PC0 Server DHCP --> assegna ip a rete C e rete B
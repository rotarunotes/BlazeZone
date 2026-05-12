## NAT Statico
$$
1:1
$$

Metto il nat nell porte
- inside: LAN
- outside: WAN
![[Pasted image 20260428141147.png]]

![[Schema_NAT]]

Comando che permette di associare un indirizzo locale nell'indirizzo pubblico (10.0.0.100),
- In questo esercizio è il default gateway del router
![[Pasted image 20260428141636.png]]


| NAT                  | Cardinalità | Descrizione  |
| -------------------- | ----------- | ------------ |
| STATICO              | 1 : 1       | IP, TCP, UDP |
| DINAMICO             | n : n       |              |
| DINAMICO  + OVERLOAD | n : 1       |              |

n : 1

- NAT SASTICO: ()


## NAT DINAMICO
![Disegno_LAN_WAN](Disegno_LAN_WAN.md)

### Configurazione
1) Configurazione interfacce del router
![[Pasted image 20260512132157.png]]

2) Configurazione pool dchp (per assegnare velocemente gli IP)
![[Pasted image 20260512132322.png]]

3) Definire interfaccia inside e interfacci outside
   ![[Pasted image 20260512132503.png]]
4) ACL che identifica una rete (ACL STANDARD)
![[Pasted image 20260512132620.png]]
5) POOl pubblico
 ![[Pasted image 20260512132722.png]]
6)  Regola nat pubblici
![[Pasted image 20260512132730.png]]



Tabella NAT
![[Pasted image 20260512133144.png]]

Assegnazione UNIVOCA

## NAT dinamico + overload (PAT)

Un solo indirizzo pubblico

1) Si specifica l'ACL
2) OVERLOAD
   ![[Pasted image 20260512133624.png]]
3) Nella tabella del NAT, inside local, inside global.
   ![[Pasted image 20260512134201.png]]


## EX
1) Il server 10.0.0.100 può comunicare solo con il nostro server HTTP 192.168.1.100
2) I nostri pacchetti possono fare richieste TCP e ICMP al server 10.0.0.100, e quindi ricevere una risposta:

**soluzione:** Mettere una ACL estesa su 10.0.0.10 che:
- permit richieste all'host 192.168.1.100
- permit risposte TCP
- permit risposte ICMP



![[Pasted image 20260512142121.png]]
Il 
1) Dobbiamo creare una ACL estesa
	   - Con le regole 

![[Pasted image 20260512143928.png]]
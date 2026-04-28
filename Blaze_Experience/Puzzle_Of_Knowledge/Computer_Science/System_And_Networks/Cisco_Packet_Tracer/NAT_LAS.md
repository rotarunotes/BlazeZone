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





| NAT                  | Cardinalità |
| -------------------- | ----------- |
| STATICO              | 1 : 1       |
| DINAMICO             | n : n       |
| DINAMICO  + OVERLOAD | n : 1       |

n : 1
$$

$$
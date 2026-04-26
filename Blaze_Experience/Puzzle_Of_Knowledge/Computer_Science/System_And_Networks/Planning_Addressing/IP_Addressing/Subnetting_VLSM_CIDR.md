### Procedura generale

1. Determinare il numero di sottoreti necessarie → quanti bit di subnet servono? `2^n ≥ sottoreti richieste`
2. Determinare gli host per sottorete → verificare `2^m − 2 ≥ host richiesti`
3. Calcolare il nuovo prefisso: `/prefisso_originale + n`
4. Calcolare il **block size** (salto tra sottoreti): `256 − valore dell'ottetto interessato nella mask`

### Esempio pratico

Dividere `192.168.1.0/24` in 4 sottoreti uguali:

```
Sottoreti richieste = 4  →  2^2 = 4  →  servono 2 bit di subnet
Nuovo prefisso = /24 + 2 = /26
Subnet mask = 255.255.255.192
Block size = 256 - 192 = 64

Sottorete 0:  192.168.1.0/26    host: .1 – .62    broadcast: .63
Sottorete 1:  192.168.1.64/26   host: .65 – .126  broadcast: .127
Sottorete 2:  192.168.1.128/26  host: .129 – .190 broadcast: .191
Sottorete 3:  192.168.1.192/26  host: .193 – .254 broadcast: .255
```

### VLSM (Variable Length Subnet Mask)

Il VLSM permette di assegnare a ciascuna sottorete la dimensione esatta necessaria (invece di suddividere tutto in blocchi uguali). Si parte sempre dalla sottorete più grande e si procede verso le più piccole, assegnando i blocchi in sequenza.
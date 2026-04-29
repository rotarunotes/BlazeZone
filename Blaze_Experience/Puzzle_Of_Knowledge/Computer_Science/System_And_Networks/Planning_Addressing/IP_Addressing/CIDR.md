q SData: 2026-04-28
[IP_Addressing](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/IPv4/CIDR
___
# Index
- [[#Classless Inter-Domain Routing]]
- [[#Notazione]]
- [[#Subnet Mask]]
- [[#Calcoli fondamentali]]
	- [[#Numero di host]]
	- [[#Block size]]
- [[#Tabella CIDR completa]]
- [[#leggere un indirizzo CIDR]]
___
# Classless Inter-Domain Routing

La notazione **CIDR** è un metodo per scrivere le reti IP in modo molto più flessibile e compatto rispetto al vecchio sistema basato sulle classi).

| Problemi Del classful                                                                                                                     | Soluzioni CIDR                                                                                                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Spreco enorme**: un'azienda con 300 host richiedeva una Classe B (`/16` → 65.534 host). I restanti ~65.000 indirizzi venivano sprecati. | **Allocazione su misura**: si assegna esattamente il prefisso necessario (es. `/23` per 510 host).                                      |
| **Route aggregation (supernetting)**: più reti contigue vengono annunciate come un singolo prefisso, comprimendo le tabelle di routing.   | **Route aggregation (supernetting)**: più reti contigue vengono annunciate come un singolo prefisso, comprimendo le tabelle di routing. |
___
# Notazione
Il numero dopo `/` si chiama **prefisso**  e indica quanti dei 32 bit dell'indirizzo IP appartengono alla parte di **rete**, i bit che rimangono appartengono alla parte di **host**. 
```
Es:
192.168.1.0/24

DEC:         192.     168.       1.       0
BIN:	11000000.10101000.00000001.00000000
PARTE: |          RETE            |  HOST  |
```
___
# Subnet Mask
Il prefisso CIDR corrisponde esattamente al numero di bit della **subnet mask**: 
- Bit che corrispondono alla **rete** sono indicati con **1**
- Bit che corrispondono all' **host** sono indicati con **0**

```
/24 → 11111111.11111111.11111111.00000000 → 255.255.255.0

/25 → 11111111.11111111.11111111.10000000 → 255.255.255.128

/26 → 11111111.11111111.11111111.11000000 → 255.255.255.192

/27 → 11111111.11111111.11111111.11100000 → 255.255.255.224
```
___
# Calcoli fondamentali

## Numero di host

$$\text{Host} = 2^{(32 - \text{prefisso})} - 2$$
Si sottraggono 2 perchè corrispondono:
- **Network address** 
- **Broadcast** 
 
## Block size

La **block size** è il numero totale di indirizzi in un blocco CIDR (inclusi network e broadcast):
$$\text{Block size} = 2^{(32 - \text{prefisso})}$$___
# Tabella CIDR completa

| CIDR    | Subnet Mask       | Formula (Host Utilizzabili) | Host Utilizzabili   | Uso tipico                                |
| ------- | ----------------- | --------------------------- | ------------------- | ----------------------------------------- |
| **/1**  | `128.0.0.0`       | $2^{(32-1)} - 2$            | 2.147.483.646       | Metà dell'intera rete Internet            |
| **/2**  | `192.0.0.0`       | $2^{(32-2)} - 2$            | 1.073.741.822       | Grandi blocchi regionali (RIR)            |
| **/3**  | `224.0.0.0`       | $2^{(32-3)} - 2$            | 536.870.910         | Ampie delegazioni geografiche             |
| **/4**  | `240.0.0.0`       | $2^{(32-4)} - 2$            | 268.435.454         | Grandi infrastrutture ISP                 |
| **/5**  | `248.0.0.0`       | $2^{(32-5)} - 2$            | 134.217.726         | Grandi reti di backbone                   |
| **/6**  | `252.0.0.0`       | $2^{(32-6)} - 2$            | 67.108.862          | Blocchi nazionali estesi                  |
| **/7**  | `254.0.0.0`       | $2^{(32-7)} - 2$            | 33.554.430          | Grandi reti pubbliche nazionali           |
| **/8**  | `255.0.0.0`       | $2^{(32-8)} - 2$            | 16.777.214          | Class A (es. 10.0.0.0 privato)            |
| **/9**  | `255.128.0.0`     | $2^{(32-9)} - 2$            | 8.388.606           | Grandi dorsali ISP                        |
| **/10** | `255.192.0.0`     | $2^{(32-10)} - 2$           | 4.194.302           | Suddivisioni regionali ISP                |
| **/11** | `255.224.0.0`     | $2^{(32-11)} - 2$           | 2.097.150           | Infrastrutture Core                       |
| **/12** | `255.240.0.0`     | $2^{(32-12)} - 2$           | 1.048.574           | Reti Private (172.16.0.0/12)              |
| **/13** | `255.248.0.0`     | $2^{(32-13)} - 2$           | 524.286             | Grandi reti aziendali o Telco             |
| **/14** | `255.252.0.0`     | $2^{(32-14)} - 2$           | 262.142             | Enterprise Backbone                       |
| **/15** | `255.254.0.0`     | $2^{(32-15)} - 2$           | 131.070             | Reti metropolitane (MAN)                  |
| **/16** | `255.255.0.0`     | $2^{(32-16)} - 2$           | 65.534              | Class B (LAN aziendali medie)             |
| **/17** | `255.255.128.0`   | $2^{(32-17)} - 2$           | 32.766              | Grandi segmenti di campus                 |
| **/18** | `255.255.192.0`   | $2^{(32-18)} - 2$           | 16.382              | Campus universitari / Data Center         |
| **/19** | `255.255.224.0`   | $2^{(32-19)} - 2$           | 8.190               | Segmenti di rete estesi                   |
| **/20** | `255.255.240.0`   | $2^{(32-20)} - 2$           | 4.094               | Data Center ad alta densità               |
| **/21** | `255.255.248.0`   | $2^{(32-21)} - 2$           | 2.046               | Reti dipartimentali larghe                |
| **/22** | `255.255.252.0`   | $2^{(32-22)} - 2$           | 1.022               | Cluster di server / Grandi uffici         |
| **/23** | `255.255.254.0`   | $2^{(32-23)} - 2$           | 510                 | Uffici corporate medi                     |
| **/24** | `255.255.0.0`     | $2^{(32-24)} - 2$           | 254                 | Standard LAN / Piccole imprese            |
| **/25** | `255.255.255.128` | $2^{(32-25)} - 2$           | 126                 | Sottoreti per reparti specifici           |
| **/26** | `255.255.255.192` | $2^{(32-26)} - 2$           | 62                  | Piccole reti locali o VLAN                |
| **/27** | `255.255.255.224` | $2^{(32-27)} - 2$           | 30                  | Gruppi di lavoro / Reti management        |
| **/28** | `255.255.255.240` | $2^{(32-28)} - 2$           | 14                  | Reti VoIP o dispositivi IoT               |
| **/29** | `255.255.255.248` | $2^{(32-29)} - 2$           | 6                   | Blocchi di IP pubblici (piccoli siti)     |
| **/30** | `255.255.255.252` | $2^{(32-30)} - 2$           | 2                   | Link Punto-Punto (Router-Router)          |
| **/31** | `255.255.255.254` | $2^{(32-31)} - 2$           | 0 (o 2 su link P2P) | Link Punto-Punto moderni (RFC 3021)       |
| **/32** | `255.255.255.255` | $2^{(32-32)}$               | 1 (Host singolo)    | Interfacce di **Loopback** / Host singolo |

___
# leggere un indirizzo CIDR

Dato `172.16.4.200/22`:

| Operazione            | Calcoli / Dettagli                            | Risultato          |
| --------------------- | --------------------------------------------- | ------------------ |
| **CIDR**              | Lunghezza                                     | /22                |
| **Bit di rete**       | Primi 3 ottetti parziali                      | 22                 |
| **Bit di host**       | $32 - 22$                                     | 10                 |
| **Subnet mask**       | Binary: `11111111.11111111.11111100.00000000` | 255.255.252.0      |
| **Wildcard Mask**     | $255.255.255.255 - Mask$                      | 0.0.3.255          |
| **Network Address**   | $IP \land Subnet$                             | 172.16.4.0         |
| **Broadcast Address** | $Network + Wildcard$                          | 172.16.7.255       |
| **Host disponibili**  | $2^{10} - 2$                                  | 1022               |
| **Primo host utile**  | $Network + 1$                                 | 172.16.4.1         |
| **Ultimo host utile** | $Broadcast - 1$                               | 172.16.7.254       |
| **Classe IP**         | Basato sul primo ottetto (172)                | Classe B (Privata) |

___

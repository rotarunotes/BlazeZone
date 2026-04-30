Data: 2026-04-30
[IP_Addressing](README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/IP_Addressing
___
# Index
- [[#Scopo]]
- [[#Concetti Base]]
- [[#Procedura]]
    - [[#Reti di grandezza uguale]]
    - [[#VLSM - Variable Length Subnet Mask]]
    - [[#Supernetting — Aggregation]]
- [[#Tabella Subnet Mask Rapida]]
- [[#Esercizi]]
    - [[#Esercizio 1]]
    - [[#Esercizio 2]]
    - [[#Esercizio 3]]
    - [[#Esercizio 4]]
    - [[#Esercizio 5]]
___
# Scopo
 Il **subnetting** è la pratica di dividere una singola rete IP fisica in più sotto-reti più piccole chiamate subnet.
 Vantaggi:
 - **Efficienza**: Si risparmiano indirizzi
 - **Sicurezza**: Si isola il traffico
 - **Miglioramento**: I messaggi di broadcast restano confinati all'interno della singola sottorete, in questo modo si evita di intasare la banda della rete, 
___
# Concetti Base

| Termine                 | Descrizione                                                               |
| ----------------------- | ------------------------------------------------------------------------- |
| **Prefisso CIDR**       | Indica il numero di bit dedicati alla rete (es. `/24`).                   |
| **Subnet Mask**         | Rappresentazione decimale del prefisso (es. `255.255.255.0`).             |
| **Block Size**          | Dimensione totale del blocco ($256 - \text{valore ottetto interessato}$). |
| **Ottetto Interessato** | L'ottetto in cui avviene la divisione tra rete e host.                    |
| **Indirizzo di Rete**   | Il primo indirizzo (ID) di una sottorete.                                 |
| **Broadcast**           | L'ultimo indirizzo, usato per inviare dati a tutti i nodi della subnet.   |
| **Host Utili**          | Indirizzi assegnabili ai dispositivi ($2^{\text{bit host}} - 2$).         |
___
# Procedura

## Reti di grandezza uguale

**Esempio Spiegazione**:

| Indirizzo IP   | Subnet Mask<br> | Sottoreti Richieste |
| -------------- | --------------- | ------------------- |
| 192.168.4.0/22 | 255.255.252.0   | 20                  |
**Passaggi**:

| Punto                   | Formula                                                      | Esempio                                                                 |
| ----------------------- | ------------------------------------------------------------ | ----------------------------------------------------------------------- |
| **Bit in prestito** $n$ | $2^n \geq \text{numero sottoreti richieste}$                 | $2^n \ge 20 \implies n = 5$                                             |
| **Nuovo  CIDR**         | $\text{Nuovo CIDR} = \text{Prefisso originale} + n$          | $\text{Nuovo CIDR} = /22 + 5 = \mathbf{/27}$                            |
| **Subnet Mask**         | Converti il prefisso in decimale punteggiato                 | $/27 \implies 255.255.255.224$<br>$11111111.11111111.11111111.11100000$ |
| **Block Size**          | $\text{Block size} = 256 - \text{valore ottetto modificato}$ | $256 - 224 = \mathbf{32}$                                               |
| **Host per subnet**     | $\text{Host} = 2^{(32 - \text{nuovo prefisso})} - 2$         | $2^{(32-27)}-2 = 2^5-2 = \mathbf{30}$                                   |

| \#          | Rete (/27)                             | Primo  Utile    | Ultimo  Utile     | Broadcast                     |
| ----------- | -------------------------------------- | --------------- | ----------------- | ----------------------------- |
| Numero rete | $$Rete \space base + incremento * \#$$ | $$Rete + 1$$    | $$Rete dopo - 2$$ | $$\text{1 la parte di host}$$ |
| **1**       | $\mathbf{192.168.4.0}$                 | $192.168.4.1$   | $192.168.4.30$    | $192.168.4.31$                |
| **2**       | $\mathbf{192.168.4.32}$                | $192.168.4.33$  | $192.168.4.62$    | $192.168.4.63$                |
| **3**       | $\mathbf{192.168.4.64}$                | $192.168.4.65$  | $192.168.4.94$    | $192.168.4.95$                |
| **4**       | $\mathbf{192.168.4.96}$                | $192.168.4.97$  | $192.168.4.126$   | $192.168.4.127$               |
| **5**       | $\mathbf{192.168.4.128}$               | $192.168.4.129$ | $192.168.4.158$   | $192.168.4.159$               |
| **6**       | $\mathbf{192.168.4.160}$               | $192.168.4.161$ | $192.168.4.190$   | $192.168.4.191$               |
| **7**       | $\mathbf{192.168.4.192}$               | $192.168.4.193$ | $192.168.4.222$   | $192.168.4.223$               |
| **8**       | $\mathbf{192.168.4.224}$               | $192.168.4.225$ | $192.168.4.254$   | $192.168.4.255$               |
| **9**       | $\mathbf{192.168.5.0}$                 | $192.168.5.1$   | $192.168.5.30$    | $192.168.5.31$                |
| **10**      | $\mathbf{192.168.5.32}$                | $192.168.5.33$  | $192.168.5.62$    | $192.168.5.63$                |
| **11**      | $\mathbf{192.168.5.64}$                | $192.168.5.65$  | $192.168.5.94$    | $192.168.5.95$                |
| **12**      | $\mathbf{192.168.5.96}$                | $192.168.5.97$  | $192.168.5.126$   | $192.168.5.127$               |
| **13**      | $\mathbf{192.168.5.128}$               | $192.168.5.129$ | $192.168.5.158$   | $192.168.5.159$               |
| **14**      | $\mathbf{192.168.5.160}$               | $192.168.5.161$ | $192.168.5.190$   | $192.168.5.191$               |
| **15**      | $\mathbf{192.168.5.192}$               | $192.168.5.193$ | $192.168.5.222$   | $192.168.5.223$               |
| **16**      | $\mathbf{192.168.5.224}$               | $192.168.5.225$ | $192.168.5.254$   | $192.168.5.255$               |
| **17**      | $\mathbf{192.168.6.0}$                 | $192.168.6.1$   | $192.168.6.30$    | $192.168.6.31$                |
| **18**      | $\mathbf{192.168.6.32}$                | $192.168.6.33$  | $192.168.6.62$    | $192.168.6.63$                |
| **19**      | $\mathbf{192.168.6.64}$                | $192.168.6.65$  | $192.168.6.94$    | $192.168.6.95$                |
| **20**      | $\mathbf{192.168.6.96}$                | $192.168.6.97$  | $192.168.6.126$   | $192.168.6.127$               |
## VLSM - _Variable Length Subnet Mask_
**Esempio spiegazione**:

| Indirizzo IP   | Subnet Mask   | Sottoreti Richieste                       |
| -------------- | ------------- | ----------------------------------------- |
| 192.168.1.0/24 | 255.255.255.0 | A=50 host, B=30 host, C=10 host, D=2 host |

- **Ordinamento**: Dal maggiore al minore

|Priorità|Subnet|Host Richiesti|
|---|---|---|
|1°|A|50|
|2°|B|30|
|3°|C|10|
|4°|D|2|

- **Dimensionamento**: Per ogni richiesta, trova la potenza di 2 ($2^h$) tale che $2^h - 2 \geq \text{host necessari}$.

| Subnet | Host Richiesti | Formula $2^h - 2 \geq n$ | $h$ | Host Utili | Nuovo CIDR<br>$32-h$ | Block Size |
| ------ | -------------- | ------------------------ | --- | ---------- | -------------------- | ---------- |
| A      | 50             | $2^6 - 2 = 62 \geq 50$   | 6   | 62         | /26                  | 64         |
| B      | 30             | $2^5 - 2 = 30 \geq 30$   | 5   | 30         | /27                  | 32         |
| C      | 10             | $2^4 - 2 = 14 \geq 10$   | 4   | 14         | /28                  | 16         |
| D      | 2              | $2^2 - 2 = 2 \geq 2$     | 2   | 2          | /30                  | 4          |

- **Assegnazione contigua**:
	- La prima subnet parte dall'indirizzo base della rete madre.
	- La successiva inizia esattamente dove finisce il broadcast della precedente + 1.

| Subnet | Indirizzo di Rete | Primo Utile   | Ultimo Utile  | Broadcast     | CIDR |
| ------ | ----------------- | ------------- | ------------- | ------------- | ---- |
| A      | 192.168.1.0       | 192.168.1.1   | 192.168.1.62  | 192.168.1.63  | /26  |
| B      | 192.168.1.64      | 192.168.1.65  | 192.168.1.94  | 192.168.1.95  | /27  |
| C      | 192.168.1.96      | 192.168.1.97  | 192.168.1.110 | 192.168.1.111 | /28  |
| D      | 192.168.1.112     | 192.168.1.113 | 192.168.1.114 | 192.168.1.115 | /30  |

- **Nessun buco**: Le reti devono essere consecutive nello spazio di indirizzamento
## Supernetting — Aggregation
Consiste nell'unire più reti piccole in una più grande (**Route Summarization**).

| Requisito         | Descrizione                                                                |
| ----------------- | -------------------------------------------------------------------------- |
| **Reti contigue** | Le reti devono essere consecutive nello spazio di indirizzamento           |
| **Potenza di 2**  | Il numero di reti da unire deve essere una potenza di 2 (2, 4, 8, 16, ...) |
| **Allineamento**  | Il blocco aggregato deve essere allineato al suo boundary binario          |
**Formula**:
$$\text{Nuovo CIDR} = \text{Prefisso originale} - \log_2(\text{N° reti})$$
**Esempio**:

| Punto                     | Formula                                                                             | Esempio                                  |
| ------------------------- | ----------------------------------------------------------------------------------- | ---------------------------------------- |
| **Reti da aggregare**     | Devono essere contigue e in numero di potenza di 2                                  | 4 reti `/24` contigue                    |
| **Nuovo CIDR**            | $\text{Prefisso} - \log_2(\text{N° reti})$                                          | $24 - \log_2(4) = 24 - 2 = \mathbf{/22}$ |
| **Subnet Mask**           | Converti il nuovo prefisso in decimale punteggiato                                  | $/22 \implies 255.255.252.0$             |

**Reti originali → Supernet**:

|#|Rete Originale|CIDR|
|---|---|---|
|1|172.16.0.0|/24|
|2|172.16.1.0|/24|
|3|172.16.2.0|/24|
|4|172.16.3.0|/24|
|→|**172.16.0.0**|**/22**|

___
# Tabella Subnet Mask Rapida

| CIDR    | Subnet Mask     | Block Size    | Host Utili   | Note                              |
| ------- | --------------- | ------------- | ------------ | --------------------------------- |
| **/8**  | 255.0.0.0       | 256 (1° ott.) | 16.777.214   | Default Classe A                  |
| **/9**  | 255.128.0.0     | 128 (2° ott.) | 8.388.606    |                                   |
| **/10** | 255.192.0.0     | 64 (2° ott.)  | 4.194.302    |                                   |
| **/11** | 255.224.0.0     | 32 (2° ott.)  | 2.097.150    |                                   |
| **/12** | 255.240.0.0     | 16 (2° ott.)  | 1.048.574    |                                   |
| **/13** | 255.248.0.0     | 8 (2° ott.)   | 524.286      |                                   |
| **/14** | 255.252.0.0     | 4 (2° ott.)   | 262.142      |                                   |
| **/15** | 255.254.0.0     | 2 (2° ott.)   | 131.070      |                                   |
| **/16** | 255.255.0.0     | 256 (2° ott.) | 65.534       | Default Classe B                  |
| **/17** | 255.255.128.0   | 128 (3° ott.) | 32.766       |                                   |
| **/18** | 255.255.192.0   | 64 (3° ott.)  | 16.382       |                                   |
| **/19** | 255.255.224.0   | 32 (3° ott.)  | 8.190        |                                   |
| **/20** | 255.255.240.0   | 16 (3° ott.)  | 4.094        |                                   |
| **/21** | 255.255.248.0   | 8 (3° ott.)   | 2.046        |                                   |
| **/22** | 255.255.252.0   | 4 (3° ott.)   | 1.022        |                                   |
| **/23** | 255.255.254.0   | 2 (3° ott.)   | 510          |                                   |
| **/24** | 255.255.255.0   | 256 (3° ott.) | 254          | Default Classe C                  |
| **/25** | 255.255.255.128 | 128           | 126          |                                   |
| **/26** | 255.255.255.192 | 64            | 62           |                                   |
| **/27** | 255.255.255.224 | 32            | 30           |                                   |
| **/28** | 255.255.255.240 | 16            | 14           |                                   |
| **/29** | 255.255.255.248 | 8             | 6            |                                   |
| **/30** | 255.255.255.252 | 4             | 2            | Link Punto-Punto                  |
| **/31** | 255.255.255.254 | 2             | 0*           | Usata in rari casi (RFC 3021)     |
| **/32** | 255.255.255.255 | 1             | Host Singolo | Indirizzo di Loopback/Interfaccia |

> [!Note] Title
> $+1$ bit al prefisso = **Sottoreti raddoppiate**, **Host dimezzati**.
> $- 1$ bit al prefisso = **Sottoreti dimezzate**, **Host raddoppiati**.

___
# Esercizi
## Esercizio 1
*Indirizzo IP:* 192.168.10.0/26
*Subnet Mask (SM):* 255.255.255.192
*Trova:* l'ind. di rete e broadcast, numero di host

**Host:** $2^{(32-26)}-2 = 2^6-2 = 62$
**Indirizzo di rete:** bisogna effettuare l'and logico tra la SM e l'IP
255.255.255.11 000000
192.168.10.0 => Ind. di rete

**Indirizzo di broadcast:** 192.168.10.63
**Primo indirizzo:** 192.168.10.1
**Ultimo indirizzo:** 192.168.10.62

## Esercizio 2
*Indirizzo IP:* 192.168.1.0/24
*Subnet Mask (SM):* 255.255.255.0
*Trova:* SM, l'ind. di rete e broadcast, numero di host, range IP per host delle prime 4 sottoreti

**Bit presi in prestito:** $2^n \ge 4 \implies n = 2$
**Nuovo Prefisso:** $/24 + 2 = \mathbf{/26}$
**Nuova Subnet Mask (SM):** $/26 \implies 255.255.255.11000000 \space (255.255.255.192)$

**Host per sottorete:** $2^{(32-26)}-2 = 2^6-2 = 62$
**Incremento:** $256 - 192 = \mathbf{64}$

| \#    | Rete (/27)    | Primo  Utile  | Ultimo  Utile | Broadcast     |
| ----- | ------------- | ------------- | ------------- | ------------- |
| **1** | 192.168.1.0   | 192.168.1.1   | 192.168.1.62  | 192.168.1.63  |
| **2** | 192.168.1.64  | 192.168.1.65  | 192.168.1.126 | 192.168.1.127 |
| **3** | 192.168.1.128 | 192.168.1.129 | 192.168.1.190 | 192.168.1.191 |
| **4** | 192.168.1.192 | 192.168.1.193 | 192.168.1.254 | 192.168.1.255 |

## Esercizio 3
*Indirizzo IP:* 192.168.1.0/24
*Subnet Mask (SM):* 255.255.255.0
*Trova:* 16 sottoreti

**Bit presi in prestito:** $2^n \ge 16 \implies n = 4$
**Nuovo Prefisso:** $/24 + 4 = \mathbf{/28}$
**Nuova Subnet Mask (SM):** $/28 \implies 255.255.255.11110000 \space (255.255.255.240)$

**Host per sottorete:** $2^{(32-28)}-2 = 2^4-2 = 14$
**Incremento:** $256 - 240 = \mathbf{16}$

| \#     | Rete (/27)    | Primo  Utile  | Ultimo  Utile | Broadcast     |
| ------ | ------------- | ------------- | ------------- | ------------- |
| **1**  | 192.168.1.0   | 192.168.1.1   | 192.168.1.14  | 192.168.1.15  |
| **2**  | 192.168.1.16  | 192.168.1.17  | 192.168.1.30  | 192.168.1.31  |
| **3**  | 192.168.1.32  | 192.168.1.33  | 192.168.1.46  | 192.168.1.47  |
| **4**  | 192.168.1.48  | 192.168.1.49  | 192.168.1.62  | 192.168.1.63  |
| **5**  | 192.168.1.64  |               |               |               |
| **6**  | 192.168.1.80  |               |               |               |
| **7**  | 192.168.1.96  |               |               |               |
| **8**  | 192.168.1.112 |               |               |               |
| **9**  | 192.168.1.128 |               |               |               |
| **10** | 192.168.1.144 | 192.168.1.145 | 192.168.1.158 | 192.168.1.159 |
| **11** |               |               |               |               |
| **12** |               |               |               |               |
| **13** |               |               |               |               |
| **14** |               |               |               |               |
| **15** |               |               |               |               |
| **16** |               |               |               |               |

Per trovare l'ind. di rete di una sottorete in particolare, bisogna fare: **incremento*(numero sottorete-1)** es. 192.168.1.144 16*(10-1) = 144

## Esercizio 4
*Indirizzo IP:* 172.16.45.77/20
*Subnet Mask (SM):* 255.255.240.0 = 11111111.11111111.11110000.00000000
*Trova:* IP rete e broadcast, numero host per sottorete

**Host per sottorete:** $2^{(32-20)}-2 = 2^{12}-2 = 4094$
**Incremento:** $256 - 240 = \mathbf{16}$

**Indirizzo di rete:**
11111111.11111111.1111 0000.00000000
10110000.00010100.0010 1100.00000000
10110000.00010100.0010 0000.00000000 = 172.16.32.0 => ind. di rete

**Indirizzo di broadcast:**
10110000.00010100.0010 1111.11111111 = 172.16.47.255 => ind. di broadcast

## Esercizio 5
*Indirizzo IP:* 10.0.0.0/16
*Subnet Mask (SM):* 255.255.0.0 = 11111111.11111111.00000000.00000000
*Trova:* creare sottoreti da 1000 host, subnet mask, numero sottoreti, IP rete 1 e rete 2

**Host per sottoreti:** $1024 = 2^{10}$ potenza per quelle sottoreti
**Nuova Subnet Mask:** 10.0.0.0/22 perchè (32-10 = 22)
**Numero di sottoreti:** $(22-16) = 6$ quindi abbiamo $2^{6} = 64$ sottoreti

**Rete 1:** 10.0.0.0/22
**Rete 2:** 10.0.4.0/22

Perchè 1024 diviso 256 fa 4t
___

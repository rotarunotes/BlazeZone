Data: 2026-04-21
[](Modelli/segaSistemai/README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks
__
# Architettura e Logica delle ACL

Regole delle ACL:
1. **Top-Down Processing:** Il router scorre le regole dall'alto verso il basso. Appena trova un "match", si ferma ed esegue la policy:
	1. Permit
	2. Deny
2. **Implicit Deny:** Alla fine di ogni ACL c'è sempre una regola di defualo: `deny ip any any`. Se un pacchetto non soddisfa nessuna regola, viene scartato.
3. **Una ACL per Interfaccia/Direzione/Protocollo:** Su una singola interfaccia (es. FastEthernet 0/0) puoi avere solo una ACL in entrata (**IN**) e una in uscita (**OUT**) per l'IPv4.
    

---

## 2) Tabella Comparativa: Standard vs Estese

Ecco lo schema definitivo per non confonderle:

|**Caratteristica**|**ACL Standard**|**ACL Estese**|
|---|---|---|
|**Range Numerico**|1-99 e 1300-1999|100-199 e 2000-2699|
|**Criterio di Filtro**|Solo IP Sorgente|IP Sorg., IP Dest., Protocollo (TCP/UDP/ICMP), Porte|
|**Posizionamento**|**Vicino alla Destinazione**|**Vicino alla Sorgente**|
|**Livello ISO/OSI**|Layer 3|Layer 3 e Layer 4|

---

## 3) La Sintassi "Named" (Più moderna)

Oltre alle ACL numeriche, oggi si usano le **Named ACL**, che permettono di modificare le regole senza cancellare l'intera lista.

**Esempio di continuazione del tuo comando:**

Bash

```
R(config)# ip access-list extended MIA_RECOLA
R(config-ext-nacl)# 10 permit tcp 192.168.1.0 0.0.0.255 any eq 80
R(config-ext-nacl)# 20 deny ip any any
```

> **Nota:** Usando i numeri di sequenza (10, 20), puoi inserire una regola nel mezzo (es. la 15) in un secondo momento.

---

## 4) Argomenti Mancanti (Da approfondire)

### A. Established & Reflexive ACL (Stateful-ish)

Hai accennato al firewall **Stateful**. Nelle ACL estese Cisco, il comando chiave è `established`.

- **A cosa serve:** Permette il passaggio del traffico TCP solo se la connessione è stata iniziata dall'interno (controlla i flag ACK o RST del segmento TCP).
    
- **Comando:** `access-list 100 permit tcp any 192.168.1.0 0.0.0.255 established`
    

### B. Le Wildcard Mask Complesse

Non serve solo a "invertire la subnet". Serve a fare "matching" selettivo.

- `0.0.0.0` = Corrisponde a un **singolo host** (equivalente alla parola chiave `host`).
    
- `255.255.255.255` = Corrisponde a **chiunque** (equivalente alla parola chiave `any`).
    
- **Esercizio utile:** Come bloccheresti solo gli IP pari? (Si fa con la wildcard `0.0.0.254`).
    

### C. Operatori di Porta

Oltre a `eq` (equal), nelle estese puoi usare:

- `neq` (not equal)
    
- `gt` (greater than)
    
- `lt` (less than)
    
- `range` (es. `range 1024 5000`)
    

### D. ACL e VTY (Sicurezza del Router)

Le ACL non servono solo a filtrare il traffico degli utenti, ma anche a proteggere l'accesso al router stesso (Telnet/SSH).

Bash

```
R(config)# line vty 0 4
R(config-line)# access-class 10 in  # Applica l'ACL 10 alle connessioni remote
```

---

## 5) Errori comuni da evitare

1. **Dimenticare l'Implicit Deny:** Se scrivi solo `deny 192.168.1.1`, bloccherai anche tutto il resto del mondo! Aggiungi sempre un `permit ip any any` se vuoi bloccare solo una cosa specifica.
    
2. **Direzione In/Out:** * **IN:** Il pacchetto viene filtrato _prima_ che il router prenda la decisione di routing (risparmia CPU).
    
    - **OUT:** Il pacchetto viene filtrato _dopo_ che il router ha deciso su quale interfaccia mandarlo.
        

Hai bisogno di un esempio pratico su come configurare una regola per bloccare il DNS o il traffico web specifico?






ZANARDELLI:
servizi cloude
cablaggio strutturato
ridondanza
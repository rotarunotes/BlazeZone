Data: 2026-05-07
[Routing_Logic](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Routing_Logic
___
# Index
- [[#Single Point of Failure]]
- [[#Come funziona la ridondanza del gateway]]
___
# Single Point of Failure
In una rete tipica, i dispositivi finali (PC, server, stampanti) hanno configurato un **unico gateway predefinito** (default gateway). Se quel router cade, tutto il traffico verso l'esterno si interrompe, anche se esistono altri router funzionanti.

```
INTERNET / WAN
            |
      ______|______
     |             |
 [Router A]    [Router B] <--- Router funzionante, ma
 (Gateway)     (Inattivo)      ignorato dai PC
     | X  <-- IL GUASTO       
     |_____________|
            |
      ______|______
     |             |
 [ Switch di Rete  ]
     |      |      |
     |      |      |
  [PC 1]  [PC 2] [Server]
    |       |       |
    +-------+-------+---- Configurazione:
                          Default Gateway = Router A
```

I protocolli **FHRP** *First Hop Redundancy Protocols* risolvono questo problema creando un **gateway virtuale condiviso** tra più router fisici.

___
# Come funziona la ridondanza del gateway

Due o più router fisici si presentano ai dispositivi finali come **un unico router virtuale**, con:

- Un **IP virtuale** (*Virtual IP* — VIP): Usato come gateway dai client
- Un **MAC virtuale**: usato nelle risposte ARP

I client configurano il VIP come gateway: non sanno nulla dei router fisici sottostanti.

```
PC ──────► IP virtuale (es. 192.168.1.1)
                │
        ┌───────┴───────┐
    Router A         Router B
    (Attivo)         (Standby)
```

Se il router attivo cade, il router in standby assume automaticamente il ruolo di gateway — i client non si accorgono di nulla.
___
Data: 2026-05-08
[Inter-VLAN_Routing](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/Inter-VLAN_Routing
___
# Index
- [[#Layer 3 Switch & SVI]]
- [[#SVI]]
- [[#Confronto con Router-on-a-Stick]]
___
# Layer 3 Switch & SVI

Un **Layer 3 Switch** è uno switch con capacità di routing integrate.
Invece di mandare il traffico inter-VLAN a un router esterno, lo instrada **internamente via hardware**, questo porta a un aumento delle prestazioni.

___
# SVI

Una **SVI** *Switched Virtual Interface* è un'interfaccia virtuale associata a una VLAN.
Funge da **gateway** per tutti i dispositivi di quella VLAN, esattamente come la sub-interface nel Router-on-a-Stick, ma senza router esterno.

```
LAYER 3 SWITCH
┌─────────────────────────────┐
│ SVI VLAN 10: 192.168.10.254 │
│ SVI VLAN 20: 192.168.20.254 │  ← routing interno via hardware
│ SVI VLAN 30: 192.168.30.254 │
│                             │
│ VLAN 10  │ VLAN 20 │ VLAN 30│
└────┬─────┴────┬────┴────┬───┘
     │          │         │
   PC-A       PC-B       PC-C
```

___
# Confronto con Router-on-a-Stick

|                     | Router-on-a-Stick | L3 Switch + SVI |
| ------------------- | --------------------- | ------------------- |
| **Routing**         | Software (lento)      | Hardware (veloce)   |
| **Costo**           | Basso                 | Più alto            |
| **Collo bottiglia** | Sì (trunk unico)      | No                  |
| **Uso ideale**      | Reti piccole          | Reti medie/grandi   |
___
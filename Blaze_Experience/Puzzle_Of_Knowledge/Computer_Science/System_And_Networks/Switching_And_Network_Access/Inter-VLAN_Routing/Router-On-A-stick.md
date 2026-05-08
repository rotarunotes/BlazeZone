Data: 2026-05-08
[Inter-VLAN_Routing](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/Inter-VLAN_Routing
___
# Index
- [[#Router-on-a-Stick]]
- [[#Routing]]
- [[#Sub-interfaces]]
___
# Router-on-a-Stick

Tecnica che permette a un **singolo router** collegato a uno switch tramite **un solo cavo trunk** di instradare il traffico tra VLAN diverse.
- Si usa quando non si ha un Layer 3 switch.
___
# Routing

Le VLAN sono isolate per definizione.
Un PC in VLAN 10 **non può comunicare** con un PC in VLAN 20 senza passare per un dispositivo di Layer 3 (router o L3 switch).

```
  PC-A (VLAN 10)          PC-B (VLAN 20)
       │                        │
  ─────┴────────────────────────┴─────
  |             SWITCH                |
  ────────────────────────────────────
          (non può fare routing)
          
    VLAN 10 e VLAN 20 sono isolate
```

- Nonostante i PC siano collegati sullo stesso switch, i due dispositivi **non possono comunicare** perchè e come se si trovassero in 2 reti diverse.
___
# Sub-interfaces

Invece di usare una porta fisica del router per ogni VLAN, si crea una **sub-interface** virtuale per ciascuna VLAN, create nella stessa interfaccia fisica del router.
Ogni sub-interface è collegata sullo **stesso cavo** fisico (trunk) collegato allo switch.

```
ROUTER interfaccia g0/0
┌─────────────────────────┐
│  g0/0        (fisica)   │
│  ├── g0/0.10 (VLAN 10)  │  → 192.168.10.254
│  ├── g0/0.20 (VLAN 20)  │  → 192.168.20.254
│  └── g0/0.30 (VLAN 30)  │  → 192.168.30.254
└──────────┬──────────────┘
           │ trunk (802.1Q)
           │ un solo cavo fisico
    ┌──────┴───────┐
    │    SWITCH    │
    ├──────────────┤
    │ VLAN 10      │──── PC-A (192.168.10.1)
    │ VLAN 20      │──── PC-B (192.168.20.1)
    │ VLAN 30      │──── PC-C (192.168.30.1)
    └──────────────┘
```

- Il router fa da **gateway** per ogni VLAN. Ogni PC deve avere come default gateway **l'IP della sub-interface** della propria VLAN. Es: PC in VLAN 10 → gateway `192.168.10.254`
___
Data: 2026-05-08
[VLAN](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/VLAN
___
# Index
- [[#Access Port]]
- [[#Trunk Port]]
- [[#Schema topologia completa]]
- [[#Confronto]]
___
# Access Port

Una **Access Port** è una porta dello switch associata a **una sola VLAN**.

- Il dispositivo collegato **non sa** di essere in una VLAN
- Lo switch **aggiunge il tag** quando il frame entra, e lo **rimuove** quando esce
- Usata per collegare dispositivi finali: **PC**, **stampanti**, **server**, **telefoni IP** agli switch.

```
   PC           SWITCH
   │               │
   │─ no tag ─────►│  access port  → switch aggiunge VID=10
   │               │
   │◄─ no tag ─────│  access port  → switch rimuove il tag
   │               │
 (ignora        (gestisce
  le VLAN)       il tag)
```

___
# Trunk Port

Una **Trunk Port** è una porta che trasporta il traffico di **più VLAN contemporaneamente**, usando i tag 802.1Q per distinguerle.

- I frame viaggiano **con il tag** (tranne quelli della native VLAN)
- Usata tra **switch e switch**, o tra **switch e router** (router-on-a-stick)

```
  SWITCH A                              SWITCH B
  ┌──────────────────────────────────────────────┐
  │                  TRUNK                       │
  │  ══[tag VID=10]══════════════[tag VID=10]══  │
  │  ══[tag VID=20]══════════════[tag VID=20]══  │
  │  ══[tag VID=30]══════════════[tag VID=30]══  │
  └──────────────────────────────────────────────┘
          ↑ un solo cavo fisico, più VLAN logiche
```

___
# Schema topologia completa

```
  PC-A           SWITCH A              SWITCH B           PC-C
(VLAN 10)                                              (VLAN 10)
   │                 │                    │                 │
   │◄── access ─────►│◄───── trunk ──────►│◄── access ─────►│
   │    port         │    (VID 10, 20)    │    port         │
   │   (VLAN 10)     │                    │   (VLAN 10)     │
  PC-B               |                    |                PC-D
(VLAN 20)            |                    |             (VLAN 20)
   │                 │                    │                 │
   │◄── access ─────►│                    │◄── access ─────►│
        port                                   port
       (VLAN 20)                              (VLAN 20)
```

- PC-A e PC-C comunicano tra loro (stessa VLAN 10).
- PC-A e PC-D **non** comunicano direttamente (VLAN diverse → serve un router/L3 switch).
___
# Confronto

| Access Port       | Trunk Port                  |
| ----------------- | --------------------------- |
| Una sola VLAN     | Più VLAN contemporaneamente |
| Frame NON taggati | Frame taggati (802.1Q)      |
| Verso end-device  | Tra switch / router         |

___
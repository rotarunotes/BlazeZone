Data: 2026-05-08
[VLAN](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Switching_And_Network_Access/VLAN
___
# Index
___
# Dynamic Trunking Protocol

Protocollo **Cisco proprietario** che negozia automaticamente se una porta diventa **Access o Trunk**, senza configurazione manuale.

---

## Modalità

|Modalità|Comportamento|
|---|---|
|`dynamic desirable`|Tenta **attivamente** di formare un trunk|
|`dynamic auto`|Aspetta che sia **l'altro** ad iniziare|
|`trunk`|Forza trunk, invia DTP|
|`access`|Forza access, disabilita DTP|
|`nonegotiate`|Forza trunk, **non** invia DTP|

---

## Tabella di negoziazione

```
                  LATO B
           desirable │ auto │ trunk │ access
         ────────────┼──────┼───────┼────────
desirable │  TRUNK   │TRUNK │ TRUNK │ ACCESS
     auto │  TRUNK   │ACCESS│ TRUNK │ ACCESS
    trunk │  TRUNK   │TRUNK │ TRUNK │  ✗
```

---

## Sicurezza

> DTP può essere sfruttato in attacchi **VLAN Hopping**. Sulle porte dei dispositivi finali va **sempre disabilitato**:

```
switchport mode access
switchport nonegotiate
```
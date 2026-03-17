

## Router

### Modelli Comuni

- **Router 1841**: 2 interfacce
- **Router 2911**: 3 interfacce

> **Nota**: Quando si collegano due router tra loro (escludendo collegamento seriale), utilizzare un cavo **crossover**.

### Registro di Configurazione

```cisco
R# show version    // Mostra versione e configurazione registro

# Valori registro comuni:
0x2102 -> Avvia normalmente la configurazione
0x2142 -> Ignora la configurazione della NVRAM (recovery)
```

### Procedura di Reset Router

1. **Staccare alimentazione** tramite interruttore del router
2. **Tornare nel terminale**
3. **Interrompere fase di boot**:
   - Cisco: `CTRL + SHIFT + C`
   - Tera Term: `ALT + B`
4. Eseguire `confreg 0x2142`
5. Eseguire `reset`

Scegliere se:

```cisco
# Opzione A: Eliminare completamente la configurazione
R-1# erase startup-config

# Opzione B: Sovrascrivere la configurazione
R-1# copy running-config startup-config
```

6. **Ripristinare registro normale**: `R-1(config)# config-register 0x2102`

7. **Riavviare**: `R-1# reload`

### Routing

#### Rotte Statiche

```cisco
R# show ip route // mostra la tabella di routing
R(config)# ip route [rete_destinazione] [subnet_mask] [next_hop] [metrica]
```

> **Note sul next hop**:
>
> - Può essere un indirizzo IP (dell'interfaccia del router successivo)
> - Può essere un'interfaccia (quella di origine del router corrente)

#### Rotte Dinamiche (RIP v2)

```cisco
R(config)# router rip
R(config-router)# version 2
R(config-router)# network [rete]    // Ripetere per ogni rete connessa direttamente
```

#### Gateway of Last Resort

Rotta statica di default per tutti i pacchetti sconosciuti:

```cisco
R(config)# ip route 0.0.0.0 0.0.0.0 [next_hop]
```

### DHCP Server su Router

1. **Configurare IP sull'interfaccia del router**

```cisco
R(config)# interface fastEthernet 0/0
R(config-if)# ip address 192.168.1.254 255.255.255.0
R(config-if)# no shutdown
```

2. **Configurazione DHCP Pool**

```cisco
R(config)# ip dhcp pool [nome_pool]
R(dhcp-config)# network 192.168.1.0 // IP di rete 255.255.255.0
R(dhcp-config)# default-router 192.168.1.254 // IP dell'interfaccia router che vogliamo utilizzare
R(dhcp-config)# exit
R(config)# ip dhcp excluded-address 192.168.1.254 // escludero lo stesso ip di default-router
```

### Connessione Seriale DCE-DTE

#### Definizioni

- **DCE** (Data Communication Equipment): Fornisce il clock
- **DTE** (Data Terminal Equipment): Acquisisce il clock dal DCE

#### Procedura di Configurazione

1. **Spegnere il router**
2. **Aggiungere modulo WIC-1T** in uno slot disponibile
3. **Riaccendere il router**
4. **Collegare i router** attraverso un cavo seriale DCE o DTE (se partiamo dal router che vogliamo impostaree come DCE allora dovremo utilizzare il cavo rosso con un'orologio in basso a destra)

##### Configurazione Router DCE (Fornisce Clock)

```cisco
R-0(config)# interface serial 0/0/0
R-0(config-if)# ip address 10.0.0.1 255.255.255.0
R-0(config-if)# clock rate [lista possibili clock, es. 64000] // Imposta velocità clock
R-0(config-if)# no shutdown
```

##### Configurazione Router DTE (Riceve Clock)

```cisco
R-1(config)# interface serial 0/0/0
R-1(config-if)# ip address 10.0.0.2 255.255.255.0 // non viene impostato un clock, in quanto viene acquisito dal DCE
R-1(config-if)# no shutdown
```

> **Nota**: L'indirizzo IP del collegamento seriale (es. 10.0.0.0/24) è dedicato al cavo che collega i due router. Gli IP devono essere consecutivi sulla stessa sottorete.

---

# VLAN (Virtual LAN)

Le VLAN sono switch virtuali che permettono di segmentare logicamente la rete.

## Parametri Fondamentali

- **VID** (VLAN ID): Identificativo numerico (range: 1-4094)
  - **VLAN 1**: VLAN di default (assegnata a tutte le porte) - **Non utilizzare**
  - **VLAN 1002-1005**: Riservate dal sistema
- **VNAME**: Nome descrittivo della VLAN
- `SW# show vlan brief`: Mostra tutte le VLAN e porte assegnate

---

## VLAN Untagged (Access Mode)

```cisco
SW(config)# vlan [numero_vlan]
SW(config-vlan)# name [nome_vlan]

### Assegnazione Singola Porta
SW(config)# interface fastEthernet 0/1
SW(config-if)# switchport mode access
SW(config-if)# switchport access vlan [numero_vlan]

### Assegnazione Multiple Porte
SW(config)# interface range fastEthernet 0/1 - 10
SW(config-if-range)# switchport mode access
SW(config-if-range)# switchport access vlan [numero_vlan]
```

> **Note sui File**:
>
> - Le VLAN sono salvate in `vlan.dat`
> - La configurazione delle porte è salvata in `config.text`

## VLAN Tagged (Trunk Mode)

![img](../img/vlan-tagged.png)

Permette il passaggio di traffico di multiple VLAN attraverso un singolo collegamento.

```cisco
SW(config)# interface gigabitEthernet 0/1
SW(config-if)# switchport mode trunk
SW(config-if)# switchport trunk allowed vlan [10,20,30]    // Elenco VLAN separate da virgole
```

> **Importante**: La stessa configurazione trunk deve essere applicata su **entrambi** gli switch connessi.

## Inter VLan Routing (Routing on stick)

Si collega un cavo **Trunk** (*Routing on stick*) tra Router e Switch (contenente le VLan).
Il Router ha bisogno di essere configurato con delle **sub interface** (si comportano come delle interfaccie fisiche)

```cisco
R(config)# interface fastEthernet 0/0
R(config-if)# no shutdown

# Dichiarare una sub interface
R(config)# interface fastEthernet 0/0.10
R(config-subif)# encapsulation dot1Q 10
R(config-subif)# ip address 192.168.10.254 255.255.255.0

Altro esempio:
R(config)# interface fastEthernet 0/0.20
R(config-subif)# encapsulation dot1Q 20
R(config-subif)# ip address 192.168.20.254 255.255.255.0

Adesso il router avrà due interfaccie, di cui 2 fisiche e due virtuali.
```

L'unica VLan che transita all'interno del trunk è la VLan **nativa** (di default è la numero 1), a patto che tutti gli switch sono sincronizzati.

## VTP (VLan Trunking Protocol)
Protocollo solo per gli switch, ci permette di assegnare velocemente le VLan su tutti gli switch in trunk, però l'assegnazione delle porte fisiche deve essere fatta per ogni switch.

Configurazione:
- Conf trunk (**prerequisito**)
- vtp mode:
	- server
	- client
	- transparent
- vtp domain "string" (tutti quei dispositivi che rispondono ad un determinato server, un server controlla un solo dominio)
- vtp password

**Dominio:** è un gruppo di host o di reti.

```cisco
S# show vtp status

# VTP Server
S(config)# vtp mode server
S(config)# vtp domain Scuola
S(config)# vtp password scuola

# VTP Client
S(config)# vtp mode client
S(config)# vtp domain Scuola
S(config)# vtp password scuola
```

## DHCP Relay agent

```cisco
Configurazione all'interno del router

# Eccezione
R(config)# interface fastEthernet 0/0.10 
R(config-if)# ip helper-address 192.168.99.100 // ind. del server (è sempre lo stesso)
```


VOIP
- VLan ("voice")
- centralino (Router 2811)
- telefoni:
	- DHCP(option 150)
	- Numeri

switchport voice <Vlan>
ephone
ephone -dn (linea)
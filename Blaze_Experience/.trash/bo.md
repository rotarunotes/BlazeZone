Assolutamente. Ecco i tuoi appunti sulla configurazione **VOIP** (Voice over IP) utilizzando un router **Cisco 2811** riscritti in un formato Markdown più strutturato e leggibile.

---

## 📞 VOIP con Router Cisco 2811

Questa configurazione riguarda un'implementazione VOIP che utilizza una **VLAN dedicata** per il traffico voce.

### 1. Rete e VLAN VOIP

- **Router utilizzato:** Cisco 2811
    
- **VLAN VOIC:** La VLAN dedicata al traffico VOIP.
    
    - **Subnet:** $192.168.101.0/24$
        
- **Configurazione Switch (Switch-Telefono-PC):**
    
    - Assegna la porta che collega lo switch al telefono (che inoltra il traffico voce sulla VLAN corretta):
        
        Code snippet
        
        ```
        switchport voice vlan X
        ```
        
        _(Dove "X" è l'ID della VLAN VOIC)_
        

---

### 2. Configurazione DHCP per il VOIP (Opzione 150)

Il router 2811 viene configurato come **DHCP Server** per i telefoni IP.

Code snippet

```
router(config)# ip dhcp pool VOICE
router(dhcp-config)# network 192.168.101.0 255.255.255.0
router(dhcp-config)# option 150 ip 192.168.101.1
```

> **Nota Importante:** L'**Option 150** (nel caso di Cisco) specifica l'indirizzo IP del **Call Manager Express (CME)**, che è il **centralino** (ovvero l'interfaccia del router che gestisce il VOIP, solitamente il **gateway** della VLAN voce).

---

### 3. Configurazione del Centralino (Call Manager Express - CME)

Si accede al servizio di telefonia sul router.

Code snippet

```
router(config)# telephony-service
```

- **Indirizzo di Origine e Porta:** Definisce l'interfaccia IP e la porta TCP/UDP su cui il CME (il centralino) ascolterà le richieste dei telefoni.
    
    Code snippet
    
    ```
    router(config-telephony)# ip source-address 192.168.101.1 port 2000
    ```
    
    _(Dove $192.168.101.1$ è l'indirizzo del **gateway** che dà verso il VOIP)_
    
- **Limiti di Sistema:**
    
    Code snippet
    
    ```
    router(config-telephony)# max-dn 5
    router(config-telephony)# max-ephones 5
    ```
    
    - `max-dn`: **Massimo di numeri di telefono** (linee).
        
    - `max-ephones`: **Massimo di dispositivi fisici** (telefoni).
        

---

### 4. Creazione delle Linee Telefoniche (ephone-dn)

Le **Linee Telefoniche** (`ephone-dn`) sono l'entità astratta che corrisponde a un **numero** (il "telefono SIM").

Code snippet

```
router(config-telephony)# ephone-dn 1
router(config-ephone-dn)# number 11
router(config-ephone-dn)# exit

router(config-telephony)# ephone-dn 2
router(config-ephone-dn)# number 12
router(config-ephone-dn)# exit

router(config-telephony)# ephone-dn 3
router(config-ephone-dn)# number 21
router(config-ephone-dn)# exit

router(config-telephony)# ephone-dn 4
router(config-ephone-dn)# number 22
router(config-ephone-dn)# exit
```

---

### 5. Assegnazione Iniziale dei Telefoni Fisici (ephone)

I **Telefoni Fisici** (`ephone`) sono il dispositivo fisico effettivo.

- **Assegnazione Automatica Iniziale:** Permette ai telefoni di registrarsi inizialmente, ma l'assegnazione sarà casuale.
    
    Code snippet
    
    ```
    router(config-telephony)# auto-reg-ephone
    ```
    
- **Verifica:** Controlla i telefoni che si sono registrati (e a quali numeri MAC sono stati assegnati i numeri `ephone` casualmente).
    
    Code snippet
    
    ```
    router# show running-config
    ```
    

---

### 6. Associazione Manuale Linea-Telefono (Button Assignment)

Dopo l'assegnazione automatica casuale, si procede all'associazione **manuale** della linea (`ephone-dn`) al bottone del telefono fisico (`ephone`) per garantire la corretta numerazione.

- **Scenario Esempio:**
    
    - Telefoni Fisici: T1, T2, T3, T4
        
    - Associazioni casuali: `ephone 1` (T1), `ephone 2` (T3), `ephone 3` (T2), `ephone 4` (T4)
        
    - Linee: Linea 1 (dn 1), Linea 2 (dn 2), Linea 3 (dn 3), Linea 4 (dn 4)
        
- **Comando di Associazione:** `button 1:X`
    
    - **1:** Indica il primo bottone del telefono.
        
    - **X:** Indica il numero dell'`ephone-dn` (linea) che deve essere associato a quel bottone.
        

Code snippet

```
router(config-telephony)# ephone 1
router(config-ephone)# button 1:1  // Associa il bottone 1 alla Linea 1 (Numero 11)
router(config-ephone)# exit

router(config-telephony)# ephone 3  // Associa al telefono 3 (T2)
router(config-ephone)# button 1:2  // Associa il bottone 1 alla Linea 2 (Numero 12)
router(config-ephone)# exit

router(config-telephony)# ephone 2  // Associa al telefono 2 (T3)
router(config-ephone)# button 1:3  // Associa il bottone 1 alla Linea 3 (Numero 21)
router(config-ephone)# exit

router(config-telephony)# ephone 4
router(config-ephone)# button 1:4  // Associa il bottone 1 alla Linea 4 (Numero 22)
router(config-ephone)# exit
```
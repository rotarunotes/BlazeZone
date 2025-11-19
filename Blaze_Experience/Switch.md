# Guida Completa Cisco IOS - Networking

## Legenda

- `[]` = Parametri da sostituire con i propri valori
- `//` = Commenti esplicativi (non inserire nei comandi)
- `IP` = Gli indirizzi IP mostrati sono esempi (salvo eccezioni specifiche)

---

## Rappresentazioni di Rete

- **Internet**: Rete globale pubblica
- **Intranet**: Rete privata aziendale interna
- **Extranet**: Estensione sicura dell'intranet per accessi esterni autorizzati

| Tipo | Nome Completo             | Scala di Copertura |
| ---- | ------------------------- | ------------------ |
| PAN  | Personal Area Network     | Singola stanza     |
| LAN  | Local Area Network        | Edificio/Campus    |
| MAN  | Metropolitan Area Network | Città              |
| WAN  | Wide Area Network         | Regione/Nazione    |
| GAN  | Global Area Network       | Mondiale           |

---

## Switch

### Metodi di Accesso al Dispositivo

#### 1. Console (Out-of-band)

- Richiede cavo console dedicato
- Software di emulazione terminale (es. Tera Term)
- Funziona anche senza configurazione di rete

#### 2. SSH (In-band)

- Connessione remota sicura
- Comunicazione crittografata
- Richiede configurazione di rete preliminare

#### 3. Telnet (In-band)

- Connessione remota **non sicura**
- Solo per ambienti di test/laboratorio
- **Sconsigliato in produzione**

### Modalità Operative Cisco IOS

| Modalità             | Prompt                 | Comando di Accesso   | Descrizione                  |
| -------------------- | ---------------------- | -------------------- | ---------------------------- |
| User EXEC            | `Switch>`              | -                    | Modalità base limitata       |
| Privileged EXEC      | `Switch#`              | `enable`             | Accesso completo show/debug  |
| Global Configuration | `Switch(config)#`      | `configure terminal` | Configurazione globale       |
| Interface Config     | `Switch(config-if)#`   | `interface [tipo]`   | Configurazione interfacce    |
| Line Config          | `Switch(config-line)#` | `line [tipo] [num]`  | Configurazione linee accesso |

### Configurazioni di Sicurezza

#### Configurazione Password

```cisco
# Password accesso console
Switch(config)# line console 0
Switch(config-line)# password [tua_password]
Switch(config-line)# login

# Password modalità privilegiata
Switch(config)# enable password [password]    // Non criptata (deprecato)
Switch(config)# enable secret [password]      // Criptata (consigliato)

# Abilitare crittografia password
Switch(config)# service password-encryption
```

### Configurazione IP

```cisco
Switch(config)# interface vlan 1
Switch(config-if)# ip address [indirizzo_ip] [subnet_mask]
Switch(config-if)# no shutdown
```

### Comandi Base

```cisco
Switch(config)# hostname SW-1             // Rinomina dispositivo
Switch(config)# banner motd #[Messaggio]# // Imposta banner di benvenuto
```

### Comandi Show (Visualizzazione)

```cisco
Switch# show running-config         // Configurazione attiva (RAM)
Switch# show startup-config         // Configurazione di avvio (NVRAM)
Switch# dir flash:                  // Contenuto memoria flash
Switch# show version                // Informazioni sistema e versione
```

### Salvataggio Configurazione

```cisco
# Salva configurazione corrente come configurazione di avvio
Switch# copy running-config startup-config
```

### Ripristino da Recovery Mode

Procedura per riavviare uno switch dalla recovery e cancellare la configurazione (utile in caso di password dimenticata):

1. **Staccare l'alimentazione** cliccando il pulsante in basso a sinistra
2. **Tenere premuto** il tasto Mode dello switch
3. **Ricollegare l'alimentazione** mantenendo premuto il tasto
4. Eseguire i seguenti comandi:

```cisco
switch: flash_init
switch: delete flash:config.text OPPURE rename flash:config.text flash:config.old
switch: reset OPPURE boot
```

### TFTP (Trivial File Transfer Protocol)

Trasferimento file tra switch e server TFTP:

```cisco
# Da Switch a TFTP Server
Switch# copy flash: tftp:
Switch# copy running-config tftp:

# Da TFTP Server a Switch
Switch# copy tftp: flash:
Switch# copy tftp: running-config
Switch# copy tftp: startup-config
```

## Configurazione Utenti (Login Local)

```cisco
Switch(config)# username [nome_utente] secret [password]
```

### Configurazione Telnet

#### Modalità Base (Password Condivisa)

```cisco
Switch(config)# line vty 0 15
Switch(config-line)# password [password]
Switch(config-line)# login
```

#### Modalità Avanzata (Login Local)

```cisco
Switch(config)# line vty 0 15
Switch(config-line)# transport input telnet
Switch(config-line)# login local
```

### Configurazione SSH

```cisco
# Configurazione preliminare
Switch(config)# hostname SW-1
Switch(config)# ip domain-name [esempio.net]
Switch(config)# crypto key generate rsa
# Quando richiesto, specificare dimensione chiave (es. 2048 bit)

# Configurazione linea VTY
Switch(config)# line vty 0 15
Switch(config-line)# transport input ssh
Switch(config-line)# login local
```

### Port Security

Protezione delle porte da accessi non autorizzati:

```cisco
# Configurazione base
Switch(config)# interface fastEthernet 0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport port-security
Switch(config-if)# switchport port-security maximum [numero_max_mac]
Switch(config-if)# switchport port-security aging time [1-1440]  // 0 = default
Switch(config-if)# switchport port-security mac-address sticky
```

#### Modalità di Violazione

```cisco
# Protect: scarta pacchetti senza log
Switch(config-if)# switchport port-security violation protect

# Restrict: scarta pacchetti e registra l'evento in log
Switch(config-if)# switchport port-security violation restrict

# Shutdown: disabilita porta in caso di violazione
Switch(config-if)# switchport port-security violation shutdown
```

#### Riattivazione Porta in Shutdown

```cisco
Switch(config-if)# shutdown
Switch(config-if)# no shutdown
```

#### Comandi Show Port Security

```cisco
Switch# show mac-address-table
Switch# show port-security                    // Tutte le porte protette
Switch# show port-security interface fa0/1    // Dettagli porta specifica
```

> **Nota**: Per registrare l'indirizzo MAC nella porta, basta effettuare un ping dal dispositivo connesso.

---
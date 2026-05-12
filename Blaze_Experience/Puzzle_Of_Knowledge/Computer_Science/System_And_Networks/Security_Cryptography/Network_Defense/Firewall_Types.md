Data: 2026-05-12
[Network_Defense](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Network_Defense
___
# Index
- [[#Index]]
- [[#Firewall]]
- [[#Firewall Stateless (ACL Standard)]]
- [[#Firewall Stateful (ACL Estese)]]
	- [[#State Table]]
	- [[#Ripasso TCP stato della connesione]]
- [[#Confronto Stateless vs Stateful]]
- [[#Altri Tipi di Firewall (panoramica)]]
___
# Firewall

Un **firewall** è un sistema di sicurezza di rete che controlla il traffico di rete in **entrata** e in **uscita**, basandosi su un insieme di regole di sicurezza (Definite nelle ACL).

L'obiettivo principale è quello di creare una **barriera** tra una rete interna fidata e reti esterne non fidate (es. Internet), permettendo solo il traffico **autorizzato**.

![Schema_Firewall.png](../../../../../Setup_Archive/Viewable/Image/Computer_Science/System_And_Networks/Schema_Firewall.png)

___
# Firewall Stateless (ACL Standard)

Un firewall **stateless** (senza stato) analizza ogni pacchetto in modo **indipendente**, senza tenere memoria dei pacchetti precedenti o delle connessioni in corso.
- In fatti lavora a livello 3.
Ogni pacchetto viene valutato in base all'**header**, dalle regole configurate: ACL standard.

```
Pacchetto in arrivo ---> Analisi header ---> Match con le policy ---> ALLOW / DENY
```

**Vantaggi**:
1. Veloce ed efficiente (basso overhead)
2. Semplice da configurare

**Svantaggi**:
1. Vulnerabile ad attacchi che sfruttano il contesto (es. spoofing, frammentazione)
2. Difficile gestire protocolli dinamici (es. FTP attivo)
___
# Firewall Stateful (ACL Estese)

Un firewall **stateful** (con stato) tiene traccia dello **stato delle connessioni** attive, mantenendo una **state table** (tabella degli stati).
- In fatti lavora a livello 3 e anche e livello 4
## State Table
La state table registra le connessioni attive con informazioni come:

| IP src       | Porta src | IP dst        | Porta dst | Protocollo | Stato       |
| ------------ | --------- | ------------- | --------- | ---------- | ----------- |
| 192.168.1.10 | 54321     | 93.184.216.34 | 80        | TCP        | established |
| 192.168.1.20 | 60001     | 8.8.8.8       | 53        | ICMP       | echo_reply  |

```
Pacchetto in arrivo
       │
       ▼
 [Analisi header]
       │
       ▼
 [Controllo State Table]
    ╱             ╲
Trovato         Non trovato
   │                │
ALLOW      [Match regole (ACL estese)]
                ╱         ╲
             ALLOW        DENY
               │
         Aggiunge alla
          State Table
```

## Ripasso TCP stato della connesione

| Stato           | Descrizione                  |
| --------------- | ---------------------------- |
| SYN_SENT        | handshake avviato dal client |
| SYN_RECEIVED    | handshake in corso           |
| **ESTABLISHED** | connessione attiva           |
| FIN_WAIT        | chiusura in corso            |
| CLOSED          |  connessione terminata       |

**Vantaggi**:
1. Maggiore sicurezza rispetto allo stateless
2. Gestione automatica del traffico di ritorno (no regole simmetriche)
3. Migliore gestione dei protocolli dinamici

**Svantaggi**:
1. Maggiore utilizzo di risorse (memoria e CPU)
2. Più lento rispetto allo stateless in scenari ad altissimo traffico
3. La state table può essere bersaglio di attacchi (es. SYN flood → esaurimento della tabella)
___
# Confronto Stateless vs Stateful

| Caratteristica           | Stateless           | Stateful                |
| ------------------------ | ------------------- | ----------------------- |
| **Memoria connessioni**  | No                  | Sì (state table)        |
| **Contesto pacchetto**   | No                  | Sì                      |
| **Velocità**             | Alta                | Media                   |
| **Uso risorse**          | Basso               | Più elevato             |
| **Sicurezza**            | Base                | Elevata                 |
| **Regole bidirezionali** | Necessarie          | Non necessarie          |
| **Protocolli dinamici**  | Difficile           | Supportato              |
| **Tipico utilizzo**      | Router, edge device | Firewall aziendali, NGF |
___
# Altri Tipi di Firewall (panoramica)

```
Firewall
├── Packet Filtering (Firewall Stateless)
├── Stateful Inspection (Firewall Statefull)
├── Application Layer Firewall (Layer 7 / Proxy)
│   └── WAF (Web Application Firewall)
└── Next-Generation Firewall (NGFW)
    ├── Deep Packet Inspection (DPI)
    ├── IDS/IPS integrato
    └── Application awareness
```
___

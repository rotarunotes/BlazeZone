---
date: 2026-05-06
tags: [concept, reliability, disaster-recovery]
source_count: 1
---

# Continuità del Servizio (Business Continuity)

La **Continuità del Servizio** garantisce che un sistema IT rimanga operativo (o riprenda rapidamente) anche in caso di guasti hardware, interruzioni di rete o disastri.

## Strategie di Continuità

### 1. Ridondanza Hardware
- **[[RAID]]:** Protezione dai guasti disco (RAID 5 o RAID 10 per server critici).
- **UPS (Gruppi di Continuità):** Protezione da black-out elettrici. Menzionare SEMPRE all'esame per il CED.
- **Generatori Diesel:** Backup a lungo termine per il Data Center.
- **Link Aggregation:** Più cavi fisici aggregati su un unico link logico per fault tolerance e banda aggiuntiva.

### 2. Ridondanza di Rete
- **Dual ISP:** Due connessioni Internet da provider diversi per eliminare il Single Point of Failure sulla WAN.
- **Protocolli di ridondanza:** HSRP/VRRP per avere un gateway virtuale con failover automatico tra due router.

### 3. Backup e Recovery
- **Backup incrementale/differenziale:** Giornaliero sui dati critici.
- **Backup off-site:** Copia in Cloud o in sede geograficamente diversa.
- **RPO (Recovery Point Objective):** Quanti dati posso permettermi di perdere (es. ultime 24 ore).
- **RTO (Recovery Time Objective):** Quanto tempo posso permettermi di restare offline.

### 4. Resilienza Applicativa (dal caso Esame 2014)
- **Cache locale:** I dispositivi remoti (sensori, stazioni) salvano i dati localmente (file XML su flash) in caso di disconnessione.
- **Re-invio automatico:** Appena la connessione viene ristabilita, i dati vengono sincronizzati automaticamente con il server centrale.
- **Idempotenza:** Le operazioni di re-invio non devono creare duplicati.

### 5. [[Virtualizzazione]] e High Availability
- **Snapshot VM:** Salvataggio dello stato completo di una macchina virtuale per ripristino rapido.
- **Live Migration:** Spostamento di una VM da un server fisico a un altro senza downtime.
- **Cluster:** Più server che lavorano insieme, se uno fallisce l'altro prende il carico.

## Tips per l'Esame
> Quando la traccia chiede "garantire la continuità del servizio", devi coprire **almeno**: UPS + RAID + Backup + strategia di recovery in caso di disconnessione. Menzionare RPO/RTO è un plus che dimostra maturità progettuale.

## Fonti Collegate
- [[esame_stato_2014]]
- [[doc2_sicurezza_cloud_iot]]

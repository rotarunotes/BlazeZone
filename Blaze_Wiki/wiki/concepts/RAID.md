---
date: 2026-05-06
tags: [concept, server, fault-tolerance]
source_count: 1
---

# RAID (Redundant Array of Independent Disks)

Il **RAID** è una tecnica per combinare più dischi fisici in un'unità logica, al fine di migliorare le prestazioni, la ridondanza dei dati, o entrambe.

## Livelli RAID per l'Esame

| Livello | Come Funziona | Pro | Contro | Quando Usarlo |
|---|---|---|---|---|
| **RAID 0** (Striping) | Dati distribuiti su più dischi senza ridondanza | Massime prestazioni R/W | Nessuna sicurezza: se 1 disco muore, tutto perso | MAI per dati critici |
| **RAID 1** (Mirroring) | 2 dischi identici, uno è copia esatta dell'altro | Alta sicurezza, lettura veloce | Costo doppio, metà spazio perso | Dischi OS, dati critici piccoli |
| **RAID 5** (Parità distribuita) | Min. 3 dischi, dati + blocchi di parità distribuiti | Ottimo equilibrio spazio/sicurezza, tollera 1 guasto | Scrittura più lenta, ricostruzione lunga | **Scelta standard per server aziendali** |
| **RAID 10** (1+0) | Mirroring + Striping combinati (min. 4 dischi) | Alte prestazioni + alta sicurezza | Costoso, 50% spazio perso | Database ad alte prestazioni |

## Applicazione per la Maturità
Nel CED interno, i server con [[Virtualizzazione]] dovrebbero avere dischi in **RAID 5** (equilibrio costo/sicurezza) o **RAID 10** (se il budget lo permette e il DB è mission-critical). Citare sempre il RAID nella sezione "Business Continuity" del progetto.

## Fonti Collegate
- [[doc2_sicurezza_cloud_iot]]

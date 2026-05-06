---
date: 2026-05-06
tags: [concept, server, architecture]
source_count: 2
---

# Virtualizzazione

La **Virtualizzazione** dei server permette di creare su un singolo server fisico più macchine virtuali (VM) che condividono le risorse della stessa macchina.

## Vantaggi (da citare SEMPRE all'esame)
- **Riduzione costi** di implementazione e gestione hardware (CAPEX).
- **Riduzione consumo energetico** dell'intero Data Center.
- **Allocazione dinamica** delle risorse in tempo reale.
- **Provisioning rapido:** Riduzione drastica del tempo necessario alla messa in opera di nuovi sistemi.

## Hypervisor Comuni
- VMware ESXi (enterprise).
- Proxmox VE (open-source).

## Applicazione Tipica per la Maturità
Nel CED interno, un unico server fisico di fascia alta con dischi in RAID 5 o 10 ospita più VM:
- VM per Active Directory / LDAP.
- VM per il DBMS (SQL Server / MySQL).
- VM per il Gestionale aziendale.

Questo approccio riduce i costi, il consumo e lo spazio fisico nel CED, mantenendo l'isolamento logico tra i servizi.

## Fonti Collegate
- [[SERVER_Appunti]]
- [[server_1_slides]]

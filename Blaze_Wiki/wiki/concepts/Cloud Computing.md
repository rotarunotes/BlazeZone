---
date: 2026-05-06
tags: [concept, cloud, architecture]
source_count: 1
---

# Cloud Computing

Il **Cloud Computing** permette di spostare l'infrastruttura IT (server, storage, applicazioni) su provider esterni (AWS, Azure, Google Cloud), pagando solo per le risorse effettivamente utilizzate.

## I Tre Modelli di Servizio

| Modello | Cosa Gestisci Tu | Cosa Gestisce il Provider | Esempio |
|---|---|---|---|
| **IaaS** (Infrastructure as a Service) | OS, Runtime, App, Dati | Rete, Storage, Server, Virtualizzazione | AWS EC2, Azure VM |
| **PaaS** (Platform as a Service) | Solo il Codice e i Dati | Tutto il resto (OS, runtime, infrastruttura) | Heroku, Google App Engine |
| **SaaS** (Software as a Service) | Nulla (solo configurazione) | Tutto | Gmail, Microsoft 365, Google Docs |

## Vantaggi Chiave (da citare all'esame)
- **Scalabilità Elastica:** Aumentare/diminuire risorse on-demand (es. E-commerce a Natale → più server solo nel periodo di picco).
- **Riduzione CAPEX:** Nessun investimento iniziale in hardware proprio.
- **Alta Disponibilità:** I provider garantiscono SLA (Service Level Agreement) con uptime del 99.9%+.

## Collegamento con la Progettazione
Il Cloud è un'alternativa moderna alla Server Farm Esterna. Nella Maturità, se la traccia menziona scalabilità, picchi di traffico o budget limitato, proporre una soluzione Cloud (tipicamente IaaS per il web server + PaaS per il backend) e giustificare con i vantaggi economici e di scalabilità.

## Fonti Collegate
- [[doc2_sicurezza_cloud_iot]]

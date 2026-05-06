---
date: 2026-05-06
tags: [concept, iot, networking]
source_count: 1
---

# IoT (Internet of Things)

L'**Internet of Things** connette oggetti fisici (sensori, attuatori) a Internet per raccogliere dati, monitorare ambienti e inviare comandi in modo automatico.

## Architettura IoT a 4 Livelli

```
1. SENSORI / ATTUATORI
   Dispositivi "edge" con risorse limitate (ESP32, Arduino)
   Misurano grandezze fisiche (umidità, temperatura, pressione)
        ↓ (Wi-Fi / LoRa / Bluetooth)
2. GATEWAY
   Dispositivo intermedio (Raspberry Pi) che aggrega i dati
   e li inoltra verso il Cloud
        ↓ (Internet / MQTT)
3. CLOUD / SERVER
   Database per storicizzazione + logica di business
   Interfaccia web/app per l'utente
        ↓ (Comandi)
4. ATTUATORE
   Esegue azioni fisiche (attiva pompa, apri valvola)
```

## Protocollo MQTT (Publish/Subscribe)
- Molto più **leggero di HTTP**: ideale per dispositivi con poca batteria/CPU.
- Modello **Publish/Subscribe**: i sensori pubblicano su un "topic", i client sottoscritti ricevono i dati automaticamente.
- Broker MQTT centralizzato gestisce la distribuzione dei messaggi.

## Esempio d'Esame: Smart Agriculture
1. **Sensori** di umidità del terreno → collegati a ESP32.
2. **Gateway** (Raspberry Pi) riceve via Wi-Fi/LoRa → invia al Cloud via MQTT.
3. **Cloud** memorizza i dati → interfaccia web per l'agricoltore.
4. **Attuatore:** Se umidità < soglia → Cloud invia comando → Gateway attiva pompa irrigazione.

## Sicurezza IoT (da menzionare all'esame)
- I dispositivi IoT vanno isolati in una **[[VLAN]] dedicata** (es. VLAN 20 - Produzione/IoT).
- Comunicazioni cifrate (TLS su MQTT = MQTTS).
- Aggiornamenti firmware OTA (Over-The-Air) per patch di sicurezza.

## Fonti Collegate
- [[doc2_sicurezza_cloud_iot]]

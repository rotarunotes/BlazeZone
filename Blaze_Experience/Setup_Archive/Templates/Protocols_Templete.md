Data: <% tp.date.now() %>
[<% tp.file.folder() %>](./README.md)
#<% tp.file.folder(true) %>
___
# Index
- [[#NOME_PROTOCOLLO]]
	- [[#Panoramica]]
- [[#Versioni & Evoluzione]]
- [[#Come Funziona]]
- [[#Flusso Operativo]]
- [[#Casi d'Uso Reali]]
- [[#Limitazioni Tecniche]]
- [[#PDU & Incapsulamento]]
- [[#Struttura Del Pacchetto]]
	- [[#Header]]
	- [[#Body]]
	- [[#Flags]]
- [[#Porte e Protocolli Correlati]]
- [[#Confronto]]
- [[#Aspetti di Sicurezza]]
	- [[#Vulnerabilità Note]]
	- [[#Attacchi Comuni]]
	- [[#Contromisure]]
- [[#Comandi Cisco IOS]]
- [[#Troubleshooting]]
- [[#Note Esame]]
	- [[#Da sapere a memoria]]
	- [[#Trabocchetti frequenti]]
- [[#Quick Reference Card]]
___
# *NOME_PROTOCOLLO*
## Panoramica

| Caratteristica              | Dettaglio |
| --------------------------- | :-------: |
| **Livello OSI**             |           |
| **Porta**                   |           |
| **Scopo**                   |           |
| **RFC / Standard**          |           |
| **Tipo Connessione**        |           |
| **Affidabilità**            |           |
| **PDU (Unità Dati)**        |           |
| **Meccanismo di Controllo** |           |
___
# Versioni & Evoluzione

| Versione | Anno | Novità principali |
|----------|------|-------------------|
|          |      |                   |
|          |      |                   |
___
# Come Funziona

(spiegazione del meccanismo core — handshake, processo, fasi)
___
# Flusso Operativo

(sequenza passo-passo con diagramma ASCII dove applicabile)

```
Client                    Server
  |                          |
  |------- [MESSAGGIO] ----->|
  |                          |
  |<------ [RISPOSTA] -------|
  |                          |
```

| Fase         | \#  | Azione | Stato Client | Stato Server | Note |
| ------------ | --- | ------ | ------------ | ------------ | ---- |
| **Apertura** | 1   |        |              |              |      |
|              | 2   |        |              |              |      |
|              | 3   |        |              |              |      |
| **Dati**     | 4   |        |              |              |      |
| **Chiusura** | 5   |        |              |              |      |
|              | 6   |        |              |              |      |
|              | 7   |        |              |              |      |
|              | 8   |        |              |              |      |
___
# Casi d'Uso Reali

- **Esempio 1**: (scenario concreto — es. "quando apri Gmail, IMAP fa...")
- **Esempio 2**:
- **Esempio 3**:
___
# Limitazioni Tecniche

- (limiti strutturali, non legati alla sicurezza — es. scalabilità, overhead, NAT, compatibilità...)
-
-
___
# PDU & Incapsulamento

- **Nome PDU**: (frame / pacchetto / segmento / datagramma / messaggio...)
- **Incapsulato in**: (quale protocollo/header lo avvolge)
- **Incapsula**: (quale PDU contiene al suo interno)

```
L1 [ Header Cavo/Wi-Fi ] PDU: Bit
	L2 [ Header Ethernet ] PDU: Frame
	    L3 [ Header IP ] PDU: Pacchetto
	        L4 [ Header ] PDU: Segmento
	             L5-7 [ Payload ]
```
___
# Struttura Del Pacchetto
## Header

| Campo | Dimensione | Descrizione |
| ----- | ---------- | ----------- |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
|       |            |             |
``` schema 

```
## Body

## Flags

| Flag | Significato | Significato |
| ---- | ----------- | ----------- |
|      |             |             |
|      |             |             |
|      |             |             |
|      |             |             |
|      |             |             |
|      |             |             |
___
# Porte e Protocolli Correlati

| Porta | Livello OSI | Protocollo | Uso |
| ----- | ----------- | ---------- | --- |
|       |             |            |     |
___
# Confronto

(vs protocollo simile o alternativo — es. TCP vs UDP, HTTP vs HTTPS)

| Caratteristica | NOME_PROTOCOLLO | ALTERNATIVA |
|----------------|----------------|-------------|
|                |                |             |
|                |                |             |
|                |                |             |
___
# Aspetti di Sicurezza

## Vulnerabilità Note
## Attacchi Comuni
## Contromisure
___
# Comandi Cisco IOS

``` cisco
show ...
debug ...
```
___
# Troubleshooting

- **Sintomi comuni**:

| Sintomo / Errore | Possibili Cause Tecniche | Descrizione del Fenomeno |
| ---------------- | ------------------------ | ------------------------ |
|                  |                          |                          |
|                  |                          |                          |


- **Comandi di verifica**:
- **Cause frequenti**:

| Problema                   | Causa Tecnica                                                                       | Sintomo e Comportamento                                                                                                                          |
| -------------------------- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **MTU Mismatch**           | Differenza nella dimensione massima dei pacchetti tra due nodi.                     | I pacchetti piccoli (ACK) passano, quelli grandi vengono scartati (**Drop**) se hanno il flag **DF** (Don't Fragment).                           |
___
# Note Esame

## Da sapere a memoria

| Argomento | Dettagli Tecnici |
| --------- | ---------------- |
|           |                  |
## Trabocchetti frequenti
| Concetto Errato | Realtà Tecnica |
| --------------- | -------------- |
|                 |                |
___
# Quick Reference Card

```

```
___
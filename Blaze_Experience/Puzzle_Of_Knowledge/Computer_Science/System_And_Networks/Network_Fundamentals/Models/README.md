Data: 2026-04-21
[Network_Fundamentals](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Models
___

# Models

## PDU
Protocol Data Unit, 

- *ISO_OSI:* Modello concettuale a 7 livelli. Rappresenta il gold **standard normativo**: sebbene non sia implementato rigidamente nella pratica moderna, rimane il framework teorico assoluto per mappare, categorizzare e comprendere le funzioni di rete.

| Liv. | Nome                  | Funzione principale                                                                                                                |    PDU    |
| :--: | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | :-------: |
|  7   | **Applicazione**      | Interfaccia utente e app di rete                                                                                                   |   Dati    |
|  6   | **Presentazione**     | Traduzione, crittografia, compressione                                                                                             |   Dati    |
|  5   | **Sessione**          | Gestione dialogo e sincronizzazione                                                                                                |   Dati    |
|  4   | **Trasporto**         | Definisce i servizi per segmentare, trasferire e riasemblare i dati                                                                | Segmenti  |
|  3   | **Rete**              | Indirizzamento logico e routing                                                                                                    | Pacchetti |
|  2   | **Collegamento dati** | Accesso al mezzo, indirizzo fisico (MAC)                                                                                           |   Frame   |
|  1   | **Fisico**            | Descrivono i mezzi per attivare, mantenere e disattivare connessioni fisiche per una trasmissione di bit da e verso un dispositivo |    Bit    |

- *TCP_IP:* **L'architettura pragmatica** a 4 (o 5) livelli, si intende che è nato per risolvere problemi reali di comunicazione. Permettendo di aumentare la velocità, l'efficienza e l'implementazione pratica.

| Liv. | Nome                  | Funzione principale                                                                                                                |  PDU OSI  |
| :--: | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | :-------: |
|  4   | **Applicazione**      | Rappresenta i dati all'utente, oltre alla codifica e al controllo del dialogo                                                      |  5, 6, 7  |
|  3   | **Trasporto**         | Supporta la comunicazione tra vari dispositivi nelle diverse reti                                                                  |     4     |
|  2   | **Internet**          | Determina il migliore percorso nella rete                                                                                          |     3     |
|  1   | **Accesso alla rete** | Controlla i dispositivi hardware e i supporti che compongono la rete                                                               |   1, 2    |

___
# Indice
* [ISO_OSI](./ISO_OSI.md)
* [TCP_IP](./TCP_IP.md)
___

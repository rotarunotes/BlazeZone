Data: 2026-04-21
[Network_Fundamentals](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Models
___

# Models


> [!abstract] PDU
> 
   **Protocol Data Unit**. Rappresenta l'unità logica di dati che viene scambiata tra due dispositivi che comunicano utilizzando un determinato protocollo. 
> Ogni livello "incapsula" il pacchetto PDU, e invia i dati al livello superiore aggiungendo un proprio header.
> ```
>      OSI                    TCP/IP
>┌─────────────────┐    ┌─────────────────┐
> │  7 Applicazione │    │                 │
> ├─────────────────┤    │  4 Applicazione │
> │  6 Presentazione│    │                 │
> ├─────────────────┤    │                 │
> │  5 Sessione     │    │                 │
> ├─────────────────┼────┼─────────────────┤
> │  4 Trasporto    │    │  3 Trasporto    │
> ├─────────────────┼────┼─────────────────┤
> │  3 Rete         │    │  2 Internet     │
> ├─────────────────┼────┼─────────────────┤
> │  2 Data Link    │    │                 │
> ├─────────────────┤    │  1 Accesso rete │
> │  1 Fisico       │    │                 │
> └─────────────────┴────┴─────────────────┘
> 
>┌─────────────────────────────────────────┐
>│                 DATI                    │  ← Dati
>├────────┬────────────────────────────────┤
>│ H.Tras │            DATI                │  ← Segmento
>├────────┼────────┬───────────────────────┤
>│ H.Rete │ H.Tras │        DATI           │  ← Pacchetto
>├────────┼────────┼────────┬──────┬───────┤
>│ H.Frame│ H.Rete │ H.Tras │ DATI │Trailer│  ← Frame
>└────────┴────────┴────────┴──────┴───────┘
>                    ↓
 >           1100010101000101...              ← Bit
>```

___
# Indice
* [ISO_OSI](./ISO_OSI.md)
* [TCP_IP](./TCP_IP.md)
___

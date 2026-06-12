Data: 2026-06-11
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#Symmetric Cryptography]]
	- [[#Panoramica]]
- [[#Crittografia Simmetrica]]
	- [[#Funzionamento]]
	- [[#Robustezza Della Chiave]]
- [[#Algoritmi Comuni]]
	- [[#Data Encryption Standard]]
	- [[#Triple Data Encryption Standard]]
	- [[#Advanced Encryption Standard]]
	- [[#Rivest Cipher 4]]
- [[#Vantaggi E Svantaggi]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Symmetric Cryptography_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Crittografia a chiave singola in cui mittente e destinatario condividono lo stesso segreto |
| **Scopo** | Garantire la riservatezza dei dati ad alta velocità |
| **Dimensione Chiave** | Tipicamente da 56 a 256 bit |
| **Algoritmi Chiave** | AES, DES, 3DES, RC4 |

___
# Crittografia Simmetrica

La **crittografia simmetrica** (o a chiave privata) rappresenta il metodo crittografico più antico ed efficiente. Utilizza una **singola chiave** condivisa sia per l'operazione di cifratura che per quella di decifratura.

## Funzionamento
1. Il mittente cifra il testo in chiaro (*plaintext*) utilizzando un algoritmo simmetrico e la chiave segreta.
2. Il destinatario riceve il testo cifrato (*ciphertext*) e applica lo stesso algoritmo e la medesima chiave per riottenere il testo in chiaro.

```
                  Chiave Condivisa
                         │
                         ▼
Testo in Chiaro ──► Cifratura ──► Testo Cifrato ──► Decifratura ──► Testo in Chiaro
                                                          ▲
                                                          │
                                                   Chiave Condivisa
```

## Robustezza Della Chiave
La sicurezza di un sistema simmetrico risiede interamente nella **segretezza della chiave** e nella sua lunghezza (misurata in bit). All'aumentare dei bit della chiave, lo sforzo computazionale necessario per forzarla tramite brute force cresce in modo esponenziale.

___
# Algoritmi Comuni

## Data Encryption Standard
Il DES, *Data Encryption Standard*, è stato sviluppato negli anni '70 e adottato come standard federale USA.
- **Dimensione della chiave**: 56 bit effettivi (più 8 bit di parità).
- **Stato**: Altamente insicuro e vulnerabile ad attacchi brute force con computer moderni. Non deve essere utilizzato.

## Triple Data Encryption Standard
Il 3DES, *Triple Data Encryption Standard*, è nato per estendere la vita utile di DES senza ridisegnare l'algoritmo da zero.
- **Funzionamento**: Applica l'algoritmo DES tre volte consecutive su ogni blocco dati utilizzando due o tre chiavi differenti (operazione: cifratura, decifratura, cifratura).
- **Dimensione della chiave**: 112 o 168 bit.
- **Stato**: Deprecato a causa della sua lentezza computazionale (derivante dal triplo passaggio) e della suscettibilità ad attacchi sui blocchi di ridotte dimensioni (attacco Sweet32).

## Advanced Encryption Standard
L'AES, *Advanced Encryption Standard*, (noto inizialmente come Rijndael) è lo standard crittografico globale corrente adottato dal governo degli Stati Uniti.
- **Dimensione della chiave**: Supporta chiavi a 128, 192 e 256 bit.
- **Stato**: Estremamente sicuro ed efficiente. Rappresenta la scelta predefinita per la cifratura dei file, dei database e del traffico VPN.

## Rivest Cipher 4
Il RC4, *Rivest Cipher 4*, è un cifrario a flusso (*stream cipher*) noto per la sua velocità.
- **Funzionamento**: Cifra i dati byte per byte invece di suddividerli in blocchi.
- **Stato**: Altamente deprecato e insicuro a causa di vulnerabilità matematiche nella generazione della chiave che consentono di decifrare il traffico (es. vecchi standard WEP e prime versioni SSL).

___
# Vantaggi E Svantaggi

| Caratteristica | Vantaggi | Svantaggi |
| :--- | :--- | :--- |
| **Prestazioni** | Estremamente veloce e a basso consumo di CPU; ideale per grandi volumi di dati. | - |
| **Distribuzione delle chiavi** | - | **Il problema dello scambio delle chiavi** (key exchange problem): come trasmettere la chiave in modo sicuro all'altro host senza che venga intercettata? |
| **Scalabilità** | - | Complessa in grandi reti. Ogni coppia di utenti necessita di una chiave univoca. Il numero di chiavi cresce quadraticamente: $N(N-1)/2$. |

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Definizione** | Uso di un'unica chiave per cifrare e decifrare. |
| **Standard Attuale** | **AES** (chiave minima consigliata 128 bit, massima 256 bit). |
| **Streaming vs Block** | RC4 è a flusso; DES, 3DES, AES lavorano a blocchi di dati fissi. |
| **Formula delle chiavi** | N utenti richiedono $N(N-1)/2$ chiavi simmetriche totali. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **DES è ancora sicuro se si usano password complesse** | **FALSO**. Lo spazio delle chiavi di DES è limitato a $2^{56}$ combinazioni, forzabile in poche ore con hardware moderno indipendentemente dalla password. |
| **La crittografia simmetrica viene usata per l'autenticazione delle identità** | **FALSO**. Non fornisce non-ripudio, poiché entrambi gli host possiedono la stessa identica chiave. È utilizzata per garantire la **riservatezza** (confidentiality). |
| **AES-256 è vulnerabile se la chiave viene trasmessa in chiaro** | **VERO**. Qualsiasi cifrario simmetrico fallisce se la chiave di sessione viene intercettata durante lo scambio iniziale (problema risolto tramite la crittografia asimmetrica DH). |

___
# Quick Reference Card

```
CRITTOGRAFIA SIMMETRICA:
  - Chiave Unica per Cifratura/Decifratura
  - Veloce, efficiente per grandi Payload
  - Problema di base: Scambio sicuro della chiave iniziale

ALGORITMI SIMMETRICI:
  - DES   -> 56 bit (Insicuro)
  - 3DES  -> 168 bit (Deprecato, lento)
  - AES   -> 128, 192, 256 bit (Standard sicuro corrente)
  - RC4   -> Cifrario a flusso (Insicuro)

UTILIZZO NELLA SICUREZZA DI RETE:
  - Cifratura del tunnel IPsec (ESP usa AES)
  - Cifratura del canale dati SSL/TLS (HTTPS usa AES)
```
___
--Gemini

Data: 2026-06-12
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#Symmetric Cryptography]]
	- [[#Panoramica]]
- [[#Classificazione Dei Sistemi Crittografici]]
	- [[#Criteri Di Classificazione]]
- [[#Cifrari Storici E Classici]]
	- [[#Cifrario Di Giulio Cesare]]
	- [[#Cifrario Di Vigenère]]
	- [[#Metodo Kasiski]]
	- [[#Cifrario Di Vernam]]
	- [[#Generazione Numeri Casuali]]
	- [[#Cifrario A Matrice]]
	- [[#Disco Cifrante Di Leon Battista Alberti]]
	- [[#Enigma]]
- [[#Algoritmi Simmetrici Moderni]]
	- [[#Data Encryption Standard]]
	- [[#Funzione Di Feistel In DES]]
	- [[#Triple Data Encryption Standard]]
	- [[#International Data Encryption Algorithm]]
	- [[#Advanced Encryption Standard]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Symmetric Cryptography_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Crittografia in cui mittente e destinatario condividono lo stesso segreto (chiave K) |
| **Classificazione** | Cifrari a sostituzione e trasposizione; elaborazione a blocchi o a flusso |
| **Evoluzione** | Dai cifrari storici (Cesare, Vigenère, Alberti) al DES ed AES |
| **Standard Attuale** | AES, *Advanced Encryption Standard* |

___
# Classificazione Dei Sistemi Crittografici

I sistemi crittografici si suddividono in base ad alcune caratteristiche fondamentali di funzionamento.

## Criteri Di Classificazione
- **Tipo di operazione**:
  - **Sostituzione**: Ogni simbolo del testo in chiaro viene trasformato in un altro simbolo.
  - **Trasposizione**: I caratteri del testo in chiaro vengono riordinati (permutati) senza subire modifiche.
- **Elaborazione del testo**:
  - **A blocchi**: Il testo viene suddiviso in blocchi a lunghezza fissa (es. 64 o 128 bit) elaborati separatamente.
  - **A flusso**: Il testo viene elaborato in modo continuo con lunghezza variabile (es. byte per byte).
- **Tecnica di cifratura**:
  - **Simmetrica**: La chiave per cifrare il messaggio è identica a quella per decifrare.
  - **Asimmetrica**: La chiave per cifrare è diversa da quella per decifrare.

___
# Cifrari Storici E Classici

## Cifrario Di Giulio Cesare
È un cifrario a sostituzione monoalfabetica basato su una chiave $K$ simmetrica.
- **Algoritmo di Cifratura**: Ogni lettera del messaggio viene sostituita con la lettera che la segue di $K$ posizioni nell'alfabeto.
- **Algoritmo di Decifratura**: Ogni lettera viene sostituita con la lettera che la precede di $K$ posizioni.
- **Esempio**: Con chiave $K=5$, il messaggio `CRITTOGRAFIA` diventa `HWNYYTLWFKNF`.
- **Generalizzazione**: Permutazione casuale dell'alfabeto, in cui la chiave $K$ rappresenta la lista delle distanze associate a ciascun carattere.
- **Fragilità**: Vulnerabile ad attacchi brute force (solo 25 chiavi possibili per l'alfabeto standard) e all'analisi delle frequenze (ogni lettera viene sempre scambiata con lo stesso carattere cifrato).

## Cifrario Di Vigenère
È un cifrario a sostituzione polialfabetica con chiave $K$ simmetrica.
- **Funzionamento**: La chiave opera su un gruppo di lettere della stessa lunghezza e viene ripetuta lungo l'intero messaggio (es. chiave $K = 5\text{-}4\text{-}2$).
- **Fragilità**: La ripetizione periodica della chiave rappresenta il suo punto debole.

## Metodo Kasiski
Sviluppato da Friedrich Kasiski, è un metodo per decifrare il cifrario di Vigenère senza conoscere la chiave.
- **Rilevamento**: Nei crittogrammi lunghi si formano sequenze di caratteri uguali poste a una distanza precisa. Con alta probabilità, tale distanza coincide con la lunghezza della chiave o con un suo multiplo.
- **Attacco**: Trovata la lunghezza della chiave $N$, il crittogramma viene ricondotto a $N$ messaggi cifrati con il semplice cifrario di Giulio Cesare, facilmente violabili singolarmente.

## Cifrario Di Vernam
Rappresenta l'evoluzione estrema del cifrario di Vigenère.
- **OTP**, *One-Time-Pad*: La chiave viene utilizzata una sola volta.
- **Requisito**: La chiave deve avere lunghezza pari o superiore a quella del messaggio da trasmettere.
- **Sicurezza**: È dimostrato matematicamente che il cifrario OTP è l'unico algoritmo che garantisce **sicurezza assoluta** (a patto che le chiavi siano realmente casuali e non vengano mai riutilizzate). Risulta tuttavia scomodo per l'uso pratico su larga scala a causa della complessità di distribuzione delle chiavi.

## Generazione Numeri Casuali
Essenziale per generare le chiavi OTP o le chiavi simmetriche moderne:
- **PRNG**: Generazione di numeri pseudo-casuali tramite algoritmi deterministici.
- **Fisica Classica**: Generazione tramite fenomeni caotici macroscopici (es. lancio della moneta).
- **Fisica Quantistica**: Generazione di numeri realmente casuali sfruttando fenomeni quantistici microscopici (es. comportamento dei fotoni).

## Cifrario A Matrice
È un cifrario a trasposizione con chiave $K$ simmetrica.
- **Funzionamento**: Il testo in chiaro viene disposto in una matrice con un numero di colonne pari alla lunghezza della chiave. Le colonne vengono poi estratte e lette seguendo l'ordine alfabetico o posizionale delle lettere della chiave.
- **Esempio**: Messaggio `LEQUINTEHANNOESAMEDISTATO` con chiave `TPSIT` produce il testo cifrato `UHEDTETNMTQEOEALNNASIASIO`.

## Disco Cifrante Di Leon Battista Alberti
Inventato nel 1467, è considerato il primo sistema di cifratura polialfabetica della storia.
- **Struttura**: Composto da due dischi concentrici rotanti, uno esterno contenente un alfabeto ordinato e uno interno contenente un alfabeto disordinato. Permette la sostituzione polialfabetica a periodo irregolare tramite lettere chiave inserite nel crittogramma.
- **Indice Fisso**: Si sceglie una lettera maiuscola dell'anello esterno come indice fisso (es. indice A). La rotazione del disco interno determina il cambio dell'alfabeto di sostituzione.
- **Indice Mobile**: Si sceglie una lettera minuscola dell'anello interno come indice di riferimento mobile (es. lettera chiave g).

## Enigma
Un dispositivo elettromeccanico per cifrare e decifrare messaggi, utilizzato intensamente dalle forze armate tedesche durante la seconda guerra mondiale.
- **Logica**: Ispirata al concetto del disco cifrante, ma implementata con rotori multipli che modificavano i collegamenti elettrici a ogni digitazione. Consente oltre $158 \cdot 10^{18}$ ($158.962.555.217.826.350.000$) combinazioni di configurazione iniziale.

___
# Algoritmi Simmetrici Moderni

## Data Encryption Standard
Il DES, *Data Encryption Standard*, è un algoritmo a chiave simmetrica sviluppato nel 1976 per il governo statunitense. Cifrato per la prima volta nel 1997, è oggi considerato insicuro.

Il DES garantisce due proprietà crittografiche fondamentali:
- **Confusione**: Rende complessa la relazione tra il testo in chiaro e quello cifrato (implementata in DES tramite **sostituzioni** non-lineari).
- **Diffusione**: Distribuisce la struttura del testo in chiaro sull'intero blocco (implementata in DES tramite **permutazioni** e trasposizioni).

### Struttura E Fasi Del DES
Il DES lavora su **blocchi fissi di 64 bit** in input e utilizza una **chiave K da 64 bit** (di cui 56 bit effettivi di cifratura e 8 bit di controllo parità). Per ogni blocco il processo prevede:
1. **Fase 1 - Permutazione Iniziale (IP)**: I 64 bit del blocco vengono permutati secondo una tabella fissa.
2. **Fase 2 - Suddivisione**: Il blocco permutato viene diviso in due semiblocchi da 32 bit: Sinistro ($L_0$) e Destro ($R_0$).
3. **Fase 3 - Schedulazione della Chiave**: Dalla chiave originale a 56 bit vengono generate 16 sottochiavi $K_j$ da 48 bit l'una, tramite una matrice di permutazione $8 \times 7$ ed eliminazione di bit specifici.
4. **Fase 4 - Round di Feistel**: Si eseguono 16 round (giri) di elaborazione. In ogni round $i$:
   - Il semiblocco sinistro diventa il destro del round precedente: $L_i = R_{i-1}$.
   - Il semiblocco destro viene calcolato come: $R_i = L_{i-1} \oplus F(R_{i-1}, K_i)$.

```
   Li-1                  Ri-1
     │                     │
     │                     ├──────────┐
     │                     ▼          ▼
     │                 [   F   ]◄─── Ki (Sottochiave 48 bit)
     │                     │ (32 bit)
     ▼                     │
   (XOR)◄──────────────────┘
     │
     ▼
    Ri                    Li
```

### Funzione Di Feistel In DES
La funzione $F(R_{i-1}, K_i)$ agisce sul semiblocco destro da 32 bit e sulla sottochiave da 48 bit:
- **Matrice di Espansione**: Il semiblocco da 32 bit viene espanso a 48 bit duplicando alcuni bit intermedi.
- **XOR**: I 48 bit espansi vengono sommati (XOR) con la sottochiave $K_i$ da 48 bit.
- **8 S-Box (Substitution Box)**: I 48 bit risultanti vengono divisi in 8 blocchi da 6 bit. Ciascun blocco entra in una diversa **S-Box** (scatola di sostituzione), che sostituisce i 6 bit in input con 4 bit in output. Questa compressione rappresenta l'unica operazione **non-lineare** di DES ed costituisce il vero cuore della sua sicurezza.
- **Permutazione (P-Box)**: I 32 bit di output delle S-Box vengono permutati per diffondere i bit.

> [!NOTE] Nota
> La struttura a rete di Feistel rende il processo di cifratura e decifratura identico. L'unica differenza è che durante la decifratura le 16 sottochiavi vengono applicate in ordine inverso (da $K_{16}$ a $K_1$).

5. **Fase 5 - Scambio (Swap)**: Al termine dei 16 round, i due semiblocchi finali $L_{16}$ e $R_{16}$ vengono scambiati di posizione.
6. **Fase 6 - Permutazione Finale**: Si applica la permutazione inversa rispetto a quella iniziale ($IP^{-1}$) per ottenere il blocco cifrato da 64 bit.

## Triple Data Encryption Standard
Il 3DES, *Triple Data Encryption Standard*, applica tre volte consecutive l'algoritmo DES. Utilizza chiavi a 192 bit (168 bit effettivi). Pur estendendo la sicurezza di DES, risulta lento a causa del triplo calcolo software.

## International Data Encryption Algorithm
L'IDEA, *International Data Encryption Algorithm*, è un algoritmo simmetrico a blocchi.
- **Dettagli**: Lavora su blocchi da 64 bit con chiavi da 128 bit. Al momento non risulta violato da attacchi computazionali diretti.

## Advanced Encryption Standard
L'AES, *Advanced Encryption Standard*, è lo standard di cifratura simmetrica moderno (Rijndael).
- **Struttura**: Lavora su blocchi da 128 bit e supporta chiavi a 128, 192 e 256 bit.
- **Caratteristiche**: È veloce, leggero in termini di memoria e offre elevata sicurezza. A differenza di DES, si basa su una **rete di sostituzione e permutazione** (SPN) e non utilizza la struttura di Feistel.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Sostituzione vs Trasposizione** | La sostituzione cambia i caratteri (confusione); la trasposizione sposta le posizioni dei caratteri (diffusione). |
| **DES Parametri** | Blocco di **64 bit**, chiave di **64 bit** (56 effettivi, 8 parità), **16 round**. |
| **S-Box** | Unico elemento non-lineare di DES. Comprime 6 bit in 4 bit di output. |
| **Vernam / OTP** | Unico cifrario matematicamente sicuro in senso assoluto. Richiede chiave monouso $\ge$ lunghezza messaggio. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **AES è una variante del cifrario di Feistel** | **FALSO**. AES non utilizza la rete di Feistel. Si basa su una rete di sostituzione-permutazione (SPN) operando su matrici di byte dello stato. |
| **Il DES usa una chiave reale a 64 bit per cifrare** | **FALSO**. La chiave immessa è da 64 bit, ma 8 bit sono usati esclusivamente come controllo di parità, portando la sicurezza reale della chiave a soli **56 bit**. |
| **Il metodo Kasiski si applica a Giulio Cesare** | **FALSO**. Kasiski serve a rompere il cifrario polialfabetico di **Vigenère** individuando la lunghezza della chiave ripetuta. |

___
# Quick Reference Card

```
CIFRARI CLASSICI:
  - Giulio Cesare -> Sostituzione monoalfabetica, shift K (fragile a brute force)
  - Vigenère      -> Sostituzione polialfabetica con chiave ripetuta K
  - Metodo Kasiski-> Rompe Vigenère trovando la lunghezza chiave da ripetizioni
  - Vernam (OTP)  -> Chiave monouso lunga quanto il messaggio. Sicurezza assoluta.
  - Matrice       -> Trasposizione. Testo scritto in colonne e riletto secondo la chiave.
  - Alberti       -> Disco cifrante, prima sostituzione polialfabetica.

DES (DATA ENCRYPTION STANDARD):
  - Blocchi: 64 bit. Chiave: 56 bit reali. 16 round Feistel.
  - S-Box: 8 scatole non-lineari. Input 6 bit -> Output 4 bit (Compressione).
  - Decifratura: Algoritmo identico, sottochiavi applicate in ordine inverso.

CONFRONTO MODERNI:
  - 3DES -> 3 passaggi DES (168 bit effettivi). Sicuro ma lento.
  - IDEA -> Blocchi 64 bit, chiave 128 bit. Non violato.
  - AES  -> Blocchi 128 bit, chiavi 128/192/256 bit. SPN (no Feistel). Standard sicuro.
```
___
--Gemini

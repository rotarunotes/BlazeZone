Data: 2026-06-12
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#Asymmetric Cryptography]]
	- [[#Panoramica]]
- [[#Storia Dell'Algoritmo RSA]]
- [[#Fondamenti Matematici Ed Informatici]]
	- [[#Divisibilità]]
	- [[#Strutture Congruenti]]
	- [[#Numeri Primi]]
	- [[#Complessità Computazionale]]
- [[#Funzionamento Di RSA]]
	- [[#Definizioni E Proprietà]]
	- [[#Generazione Delle Chiavi]]
	- [[#Cifratura E Decifratura]]
- [[#Esempio Numerico Con Messaggio Zuccante]]
- [[#Protocolli Di Comunicazione Bob E Alice]]
	- [[#1. Passaggio Di Un Messaggio Segreto]]
	- [[#2. Autenticazione (Firma Digitale)]]
	- [[#3. Messaggio Segreto Autenticato]]
- [[#Altri Algoritmi Asimmetrici Semplificati]]
	- [[#Diffie-Hellman]]
	- [[#Elliptic Curve Cryptography]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Asymmetric Cryptography_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Crittografia che utilizza due chiavi matematicamente correlate: pubblica e privata |
| **Scopo principale** | Scambio sicuro delle chiavi simmetriche e autenticazione/firma |
| **Algoritmo Cardine** | RSA, *Rivest-Shamir-Adleman* (MIT, 1978) |
| **Basi Matematiche** | Differenza di complessità tra primalità e fattorizzazione |

___
# Storia Dell'Algoritmo RSA

L'algoritmo RSA prende il nome dai suoi inventori: **Ronald Rivest**, **Adi Shamir** e **Leonard Adleman**.
- **Origine**: Sviluppato nel **1978** presso il MIT (*Massachusetts Institute of Technology*), rappresentando la prima implementazione pratica della crittografia a chiave asimmetrica.
- **Evoluzione Commerciale**: Nel 1986 gli inventori fondarono la società *RSA Data Security*, divenuta poi semplicemente *RSA Security* nel 1996.

___
# Fondamenti Matematici Ed Informatici

La sicurezza e l'architettura di RSA poggiano su solide basi teoriche derivanti dall'algebra e dalla teoria dei numeri.

## Divisibilità
- **Teorema della Divisione**: Dati due interi, esistono unici quoziente e resto.
- **Identità di Bezout**: Il massimo comun divisore $\text{mcd}(a, b)$ può essere espresso come combinazione lineare minima di $a$ e $b$.
- **Algoritmo di Euclide Esteso**: Utilizzato per calcolare in modo efficiente il massimo comun divisore e gli inversi moltiplicativi modulari.

## Strutture Congruenti
- **Aritmetica Modulare**: Calcoli basati sul resto della divisione intera (modulo).
- **Teorema di Eulero**: Fondamentale per dimostrare la reversibilità delle funzioni di cifratura/decifratura e per ricavare la chiave privata.
- **Teorema Cinese del Resto**: Utilizzato per ottimizzare la velocità di calcolo dell'esponenziale modulare.

## Numeri Primi
- **Generazione e Ricerca**: Per implementare RSA è necessario generare numeri primi molto grandi. Si utilizzano generatori di input casuali combinati con test di primalità probabilistici per verificare se un numero è composto o pseudoprimo (es. **Miller-Rabin's Primality Test**).

## Complessità Computazionale
L'asimmetria di RSA si basa sulla discrepanza di tempo di calcolo tra due problemi:
1. **Primalità** (Primality): Verificare se un numero $n$ è primo è computazionalmente **semplice** (eseguibile in tempi polinomiali).
2. **Fattorizzazione** (Factoring): Dati due numeri primi grandi $p$ e $q$, calcolare il loro prodotto $n = p \cdot q$ è immediato. Al contrario, dato il prodotto $n$, ricavare i fattori primi originali $p$ e $q$ è un problema estremamente **difficile** che richiede tempi astronomici con i computer attuali.

___
# Funzionamento Di RSA

## Definizioni E Proprietà
- **M**: Rappresenta il messaggio, costituito da stringhe binarie a lunghezza fissa (es. codice ASCII dei caratteri). Per messaggi lunghi si ripete il processo di encoding a blocchi.
- **PX**: Chiave pubblica dell'utente X (distribuita a tutti).
- **SX**: Chiave segreta/privata dell'utente X (conosciuta solo da X).
- **Proprietà delle chiavi**:
  - $PX(M)$ e $SX(M)$ sono calcolabili in modo efficiente.
  - Le funzioni sono una l'inversa dell'altra: $SX(PX(M)) = PX(SX(M)) = M$.
  - Conoscendo $PX(M)$ e $PX$, è matematicamente impossibile risalire a $M$ senza possedere la chiave privata $SX$.

## Generazione Delle Chiavi
Per generare le chiavi, ciascun utente esegue questi passaggi:
1. Sceglie due numeri primi grandi distinti $p$ e $q$ (di almeno 1024 o 2048 bit).
2. Calcola il modulo $n = p \cdot q$. Il valore di $n$ definisce il dominio dei messaggi.
3. Calcola la funzione di Eulero: $\phi(n) = (p - 1)(q - 1)$.
4. Seleziona un esponente pubblico $K_p$ (piccolo) tale che sia coprimo con $\phi(n)$, ovvero: $\text{mcd}(K_p, \phi(n)) = 1$.
5. Calcola l'esponente privato $K_s$ come inverso modulare di $K_p$ rispetto a $\phi(n)$ tramite l'algoritmo di Euclide esteso:
   $$(K_s \cdot K_p) \pmod{\phi(n)} = 1$$
6. Definisce la **Chiave Pubblica**: $PX = (K_p, n)$.
7. Definisce la **Chiave Privata**: $SX = (K_s, n)$.

## Cifratura E Decifratura
- **Cifratura**: Il testo in chiaro $M$ viene cifrato calcolando la potenza modulare:
  $$C = M^{K_p} \pmod n$$
- **Decifratura**: Il testo cifrato $C$ viene decifrato calcolando:
  $$M = C^{K_s} \pmod n$$

___
# Esempio Numerico Con Messaggio Zuccante

- **Messaggio**: `Zuccante`
- **Rappresentazione binaria (MBIN)**: `0101101001110101...`
- **Fase 1**: Scegliamo due numeri primi semplici (solo a scopo didattico): $p = 17$, $q = 5$.
- **Fase 2**: Calcoliamo $n = p \cdot q = 17 \cdot 5 = 85$. Il dominio dei messaggi decimali non deve superare 85 (raggruppiamo i caratteri in blocchi da 6 bit).
- **Fase 3**: Calcoliamo $\phi(n) = (17 - 1) \cdot (5 - 1) = 16 \cdot 4 = 64$.
- **Fase 4**: Scegliamo $K_p$ tale che sia coprimo con 64. Scegliamo $K_p = 3$ (infatti $\text{mcd}(3, 64) = 1$).
- **Fase 5**: Calcoliamo l'inverso $K_s$ tale che: $(K_s \cdot 3) \pmod{64} = 1 \implies K_s = 43$.
- **Fase 6**: 
  - **Chiave Pubblica**: $PX = (3, 85)$
  - **Chiave Privata**: $SX = (43, 85)$
- **Cifratura**: Per un blocco di messaggio con valore decimale $M = 5$:
  $$C = 5^3 \pmod{85} = 125 \pmod{85} = 40$$
- **Decifratura**:
  $$M = 40^{43} \pmod{85} = 5$$

___
# Protocolli Di Comunicazione Bob E Alice

Sfruttando le proprietà delle chiavi asimmetriche, Bob e Alice possono comunicare su un canale non sicuro realizzando diversi obiettivi di sicurezza.

## 1. Passaggio Di Un Messaggio Segreto
Garantisce la **riservatezza** (confidenzialità) del messaggio.
1. Alice invia la sua chiave pubblica $P_A$ a Bob.
2. Bob cifra il messaggio $M$ con la chiave pubblica di Alice: $C = P_A(M)$.
3. Bob invia $C$ ad Alice.
4. Alice decifra $C$ con la sua chiave privata: $M = S_A(C)$.
- *Sicurezza*: Un intercettatore (Charlie) non può decifrare il messaggio poiché non possiede la chiave privata di Alice $S_A$.

## 2. Autenticazione (Firma Digitale)
Garantisce l'**autenticità** della sorgente e l'**integrità** del messaggio.
1. Bob vuole inviare un messaggio $M$ ad Alice provando la propria identità.
2. Bob cifra il messaggio con la propria chiave privata: $S_B(M)$.
3. Bob invia ad Alice il pacchetto contenente il messaggio in chiaro ed il messaggio cifrato: $\{M\ ;\ S_B(M)\}$.
4. Alice decifra $S_B(M)$ usando la chiave pubblica di Bob $P_B$ e verifica che coincida con $M$:
   $$M = P_B(S_B(M))$$
- *Sicurezza*: Charlie non può spacciarsi per Bob poiché non possiede la chiave privata $S_B$ per generare la firma corretta.

## 3. Messaggio Segreto Autenticato
Unisce **riservatezza**, **autenticità** e **integrità**.
1. Bob cifra prima il messaggio con la propria chiave privata (firma): $S_B(M)$.
2. Bob cifra l'intero pacchetto risultante con la chiave pubblica di Alice: $P_A(\{M\ ;\ S_B(M)\})$.
3. Bob invia il blocco cifrato ad Alice.
4. Alice usa la propria chiave privata $S_A$ per decifrare l'involucro esterno.
5. Alice usa la chiave pubblica di Bob $P_B$ per verificare la firma interna.
- *Sicurezza*: Solo Alice può leggere il messaggio (grazie a $S_A$) ed Alice ha la certezza matematica che provenga da Bob (grazie a $P_B$).

___
# Altri Algoritmi Asimmetrici Semplificati

## Diffie-Hellman
- **Scopo**: Protocollo matematico per concordare e scambiare in modo sicuro una chiave simmetrica (chiave di sessione) su un canale pubblico non protetto, senza trasmettere la chiave stessa.

## Elliptic Curve Cryptography
- **Scopo**: Crittografia asimmetrica basata sulle curve ellittiche. Offre livelli di sicurezza molto elevati con chiavi notevolmente più corte rispetto a RSA (es. 256 bit ECC equivalgono a 3072 bit RSA), riducendo l'overhead di calcolo.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Basi RSA** | Modulo $n = p \cdot q$; funzione $\phi(n) = (p-1)(q-1)$. |
| **Cifratura RSA** | $C = M^{Kp} \pmod n$ (con chiave pubblica). |
| **Decifratura RSA** | $M = C^{Ks} \pmod n$ (con chiave privata). |
| **Fattorizzazione** | La sicurezza si basa sulla difficoltà di trovare $p$ e $q$ a partire da $n$. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **La firma digitale si calcola cifrando con la chiave pubblica del destinatario** | **FALSO**. La firma digitale viene generata cifrando (o calcolando l'hash) con la **chiave privata del mittente**. Il destinatario userà la chiave pubblica del mittente per verificarla. |
| **Trovare numeri primi per RSA è un problema difficile (Factoring)** | **FALSO**. Trovare ed identificare numeri primi grandi (Primalità) è computazionalmente semplice tramite test come Miller-Rabin. Il problema difficile è la **fattorizzazione** (scomporre il prodotto di due primi). |
| **RSA può essere usato comodamente per cifrare file di diversi gigabyte** | **FALSO**. A causa della lentezza dell'esponenziale modulare, RSA viene usato solo per cifrare piccole stringhe (chiavi simmetriche o hash). I file grandi vengono cifrati con algoritmi simmetrici (AES). |

___
# Quick Reference Card

```
RSA (RIVEST-SHAMIR-ADLEMAN):
  - Algoritmo asimmetrico basato su chiave pubblica PX e privata SX
  - Sicurezza: Factoring (difficile) vs Primality (semplice)

GENEAZIONE CHIAVI:
  1. p, q (Numeri Primi grandi) -> n = p * q
  2. phi(n) = (p - 1) * (q - 1)
  3. Scegli Kp coprimo con phi(n) -> mcd(Kp, phi(n)) = 1
  4. Calcola Ks (inverso modulare) -> (Ks * Kp) mod [phi(n)] = 1
  5. PX = (Kp, n) ; SX = (Ks, n)

FORMULE CHIAVE:
  - Cifratura: C = M^Kp mod n
  - Decifratura: M = C^Ks mod n

PROTOCOLLI BOB & ALICE:
  - Segretezza:  Invia PA(M)           -> Decifra con SA
  - Firma:       Invia {M ; SB(M)}     -> Verifica con PB: M = PB(SB(M))
  - Combinato:   Invia PA({M ; SB(M)}) -> Decifra con SA, verifica con PB
```
___
--Gemini

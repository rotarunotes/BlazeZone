Data: 2026-06-11
[Cryptography](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Cryptography
___
# Index
- [[#Asymmetric Cryptography]]
	- [[#Panoramica]]
- [[#Crittografia Asimmetrica]]
	- [[#Funzionamento Della Coppia Di Chiavi]]
	- [[#Scambio Delle Chiavi]]
- [[#Algoritmi Comuni]]
	- [[#Rivest-Shamir-Adleman]]
	- [[#Diffie-Hellman]]
	- [[#Elliptic Curve Cryptography]]
- [[#Vantaggi E Svantaggi]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# _Asymmetric Cryptography_
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Crittografia a chiave pubblica che utilizza coppie di chiavi matematicamente correlate |
| **Scopo** | Scambio sicuro delle chiavi e firma digitale (non-ripudio) |
| **Dimensione Chiave** | Da 256 bit (ECC) a oltre 2048 bit (RSA) |
| **Algoritmi Chiave** | RSA, DH, ECC |

___
# Crittografia Asimmetrica

La **crittografia asimmetrica** (o a chiave pubblica) risolve il principale limite della crittografia simmetrica (ovvero lo scambio sicuro della chiave) utilizzando due chiavi matematicamente correlate ma distinte:
- **Chiave Pubblica**: Distribuitale liberamente a chiunque desideri comunicare con il proprietario. Viene utilizzata per cifrare i dati o per verificare le firme digitali.
- **Chiave Privata**: Custoditale gelosamente dal proprietario. Viene utilizzata per decifrare i dati cifrati con la corrispondente chiave pubblica o per generare firme digitali.

## Funzionamento Della Coppia Di Chiavi
La logica matematica garantisce che:
- Ciò che è cifrato con la **chiave pubblica** può essere decifrato solo con la corrispondente **chiave privata**.
- Ciò che è cifrato con la **chiave privata** (firma) può essere decifrato con la corrispondente **chiave pubblica** (verifica della provenienza).

```
                      Chiave Pubblica del Destinatario
                                     │
                                     ▼
Testo in Chiaro ───────────────► Cifratura ──► Testo Cifrato
                                                     │
                                                     ▼
Testo in Chiaro ◄──────────────► Decifratura ◄───────┘
                                     ▲
                                     │
                      Chiave Privata del Destinatario
```

## Scambio Delle Chiavi
Nelle comunicazioni di rete (es. SSL/TLS, IPsec), la crittografia asimmetrica viene usata all'avvio della connessione per concordare in modo sicuro la chiave simmetrica temporanea (chiave di sessione) che cifrerà l'effettivo traffico dati successivo.

___
# Algoritmi Comuni

## Rivest-Shamir-Adleman
L'RSA, *Rivest-Shamir-Adleman*, si basa sulla difficoltà matematica di fattorizzare numeri primi di grandi dimensioni.
- **Utilizzo**: Cifratura di piccoli blocchi di dati (es. scambio di chiavi simmetriche) e firme digitali.
- **Dimensione della chiave**: Richiede almeno 2048 o 4096 bit per essere considerato sicuro oggi.

## Diffie-Hellman
Il DH, *Diffie-Hellman*, è un protocollo di accordo sulle chiavi matematico.
- **Funzionamento**: Consente a due parti che non si conoscono di generare una chiave simmetrica segreta condivisa attraverso un canale non sicuro, senza trasmettere la chiave stessa sulla rete.
- **Utilizzo**: Fondamentale nella fase di negoziazione IKE, *Internet Key Exchange*, per IPsec e nel protocollo SSL/TLS.

## Elliptic Curve Cryptography
L'ECC, *Elliptic Curve Cryptography*, si basa sulle proprietà matematiche delle curve ellittiche.
- **Vantaggi**: Offre lo stesso livello di sicurezza di RSA utilizzando chiavi di dimensioni molto ridotte.
- **Esempio**: Una chiave ECC a 256 bit offre una sicurezza equivalente a una chiave RSA a 3072 bit. Questo si traduce in minore overhead di rete, calcoli più rapidi e minore utilizzo di batteria e memoria.

___
# Vantaggi E Svantaggi

| Caratteristica | Vantaggi | Svantaggi |
| :--- | :--- | :--- |
| **Scambio delle chiavi** | Risolve il problema dello scambio della chiave simmetrica senza canali fisici protetti. | - |
| **Non-ripudio** | Garantisce l'autenticità del mittente tramite la firma digitale. | - |
| **Prestazioni** | - | **Estremamente lento**: Richiede un elevato carico computazionale sulla CPU. Non è adatto per cifrare flussi massivi di dati. |
| **Dimensione Chiavi** | - | Chiavi molto lunghe (es. 2048+ bit per RSA) con conseguente aumento del payload. |

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Funzione Chiavi** | La chiave pubblica cifra; la chiave privata decifra. La chiave privata firma; la chiave pubblica verifica. |
| **Diffie-Hellman** | Non è un algoritmo di cifratura dati, ma un protocollo di **scambio/accordo sulle chiavi**. |
| **ECC** | Garantisce alta sicurezza con chiavi corte (ideale per dispositivi mobili ed IoT). |
| **Utilizzo Ibrido** | Asimmetrico all'inizio per lo scambio della chiave di sessione; simmetrico per il traffico dati reale. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **Tutto il traffico VPN è cifrato usando RSA** | **FALSO**. RSA è troppo lento. Il traffico VPN è cifrato usando la crittografia simmetrica (es. AES). RSA o DH sono usati solo per negoziare la chiave simmetrica. |
| **Un host può decifrare i dati cifrati con la propria chiave pubblica** | **FALSO**. La chiave pubblica serve solo a cifrare; una volta cifrato, il dato può essere recuperato esclusivamente tramite la chiave privata associata. |
| **La chiave privata può essere ricavata facilmente conoscendo la chiave pubblica** | **FALSO**. La relazione matematica è a senso unico (one-way function con trapdoor); calcolare la chiave privata dalla pubblica richiederebbe migliaia di anni con supercomputer. |

___
# Quick Reference Card

```
CRITTOGRAFIA ASIMMETRICA:
  - Coppia di chiavi: Pubblica (nota a tutti) e Privata (segreta)
  - Lenta, pesante sulla CPU
  - Risolve lo scambio chiavi e abilita la firma digitale (non-ripudio)

FUNZIONAMENTO:
  - Riservatezza: Cifra con Pubblica Destinatario -> Decifra con Privata Destinatario
  - Firma:        Cifra con Privata Mittente     -> Decifra con Pubblica Mittente

ALGORITMI ASIMMETRICI:
  - RSA -> Standard storico (richiede chiavi 2048+ bit)
  - DH  -> Protocollo di accordo chiave (Diffie-Hellman)
  - ECC -> Crittografia basata su curve ellittiche (chiavi corte, es. 256 bit)
```
___
--Gemini

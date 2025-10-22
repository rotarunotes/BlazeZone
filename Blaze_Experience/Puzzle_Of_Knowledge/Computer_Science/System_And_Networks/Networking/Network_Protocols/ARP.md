Data: 2025-10-22
[Network_Protocols](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Network_Protocols
___
# ARP: Address Resolution Protocol

## Cos'è l'Address Resolution Protocol (ARP)?

L’**ARP (Address Resolution Protocol)** è un protocollo fondamentale che opera all’interno di una rete locale (**LAN**).

### Scopo
Tradurre un **indirizzo IP (Livello 3)** in un **indirizzo MAC (Livello 2)**.  
Questa operazione è detta **risoluzione dell’indirizzo IP**.

---

## Perché è necessario?

Per comunicare direttamente all’interno di una LAN, due dispositivi (host) devono conoscere:

- **Indirizzo IP (logico):** per l’instradamento a livello di rete (es. `192.168.1.10`)
- **Indirizzo MAC (fisico):** per la consegna dei frame a livello di collegamento (es. `AA:BB:CC:11:22:33`)

**ARP fa da ponte tra questi due livelli.**  
Permette a un host che conosce solo l’IP di un altro di scoprirne il MAC address.

---

## Come funziona: Richiesta e Risposta

Il funzionamento si basa su:
- un meccanismo **Request/Reply**
- l’uso di una **cache locale**

---

###  1. Cache ARP (ARP Table)

Ogni host mantiene una **cache ARP**, con le associazioni IP-MAC conosciute.

**Tipi di voci:**
- **Statiche:** configurate manualmente
- **Dinamiche:** apprese automaticamente, con un **TTL** (Time To Live)

---

### 2. ARP Request (Richiesta)

Quando un host vuole inviare dati a un IP della stessa LAN, ma non ha il MAC:

1. Crea un pacchetto **ARP Request**
2. Lo invia in **broadcast** all’indirizzo MAC `FF:FF:FF:FF:FF:FF`

**Contenuto del pacchetto:**
- IP e MAC del mittente
- IP del destinatario
- MAC del destinatario: `00:00:00:00:00:00` (sconosciuto)

In questo modo, tutti i dispositivi sulla LAN possono aggiornare la propria cache con i dati del mittente.

---

### 3. ARP Reply (Risposta)

- Solo l’host che possiede l’IP richiesto risponde
- Risponde con un **ARP Reply** inviato in **unicast** al MAC del mittente

📨 **Contenuto del pacchetto:**
- IP e MAC del destinatario
- IP del mittente

Il mittente aggiorna la sua cache e può inviare i dati.

Questo processo viene usato anche per determinare l’indirizzo MAC del **gateway/router**.

---

## Struttura del Pacchetto ARP

Un pacchetto ARP è composto da due sezioni:

### Header

Contiene metadati sulla rete:

| Campo           | Descrizione                        |
|-----------------|------------------------------------|
| Hardware Type   | Tipo di rete (es. 1 = Ethernet)    |
| Protocol Type   | Tipo di protocollo (es. 0x0800 = IPv4) |
| HW Length       | Lunghezza indirizzo MAC (es. 6)    |
| Protocol Length | Lunghezza indirizzo IP (es. 4)     |
| Operation       | 1 = Request, 2 = Reply             |

### Payload

Contiene gli indirizzi IP e MAC del mittente e destinatario:

| Campo           | In una Request (da Host A)         | In una Reply (da Host B)       |
|-----------------|-------------------------------------|--------------------------------|
| S. HW. ADDR     | MAC di Host A                      | MAC di Host B                  |
| S. P. ADDR      | IP di Host A                       | IP di Host B                   |
| T. HW. ADDR     | `00:00:00:00:00:00` (sconosciuto)  | MAC di Host A                  |
| T. P. ADDR      | IP di Host B                       | IP di Host A                   |

---

## Protocolli Correlati: RARP

### Reverse ARP (RARP)

Effettua l’**operazione inversa** rispetto all’ARP:
> Dato un indirizzo MAC, restituisce l’indirizzo IP.

- Usato in passato da dispositivi senza disco per scoprire il proprio IP
- Richiedeva un **server RARP** dedicato

**RARP è obsoleto**  
Sostituito da:
- **BOOTP**
- **DHCP** (attualmente il più utilizzato)

---

## Vulnerabilità: ARP Spoofing

L’ARP **non prevede autenticazione**.

### Rischio di ARP Spoofing (o ARP Poisoning)

1. Un attaccante invia pacchetti **ARP Reply falsi**, anche se non richiesti
2. Associa **un MAC falso** a un **IP legittimo** (es. del gateway)
3. Le vittime aggiornano la cache ARP con dati falsi
4. Il traffico destinato al gateway viene inviato all’attaccante

🕵️‍♂️ Possibili attacchi:
- **Man-in-the-Middle (MitM)**
- Intercettazione o modifica dei dati

---

## Riepilogo

- **ARP traduce IP → MAC**
- Usa pacchetti **Request/Reply**
- Mantiene una **cache ARP** per efficienza
- È vulnerabile allo **spoofing**
- RARP è stato sostituito da **DHCP**

---

Data: 2025-10-22
[Network_Protocols](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Networking/Network_Protocols
___
# Domain Name System

Il **DNS** è un sistema fondamentale per Internet che consente di associare nomi di dominio (es. `google.com`) ai rispettivi indirizzi IP (es. `142.250.184.14`).

Funziona come una "rubrica" distribuita a livello globale, che consente agli utenti di utilizzare nomi mnemonici al posto di numeri complessi.

 Il DNS **definisce**:
- La struttura dei nomi
- Protocolli
- Programmi 
- Server necessari al suo funzionamento.

---
# Le 3 Macro Componenti del DNS

1) **Domain Name Space**  
   È essenzialmente l'intera struttura gerarchica che organizza tutti i nomi di dominio su Internet.

2) **Name Server**  
   I server che contengono il database distribuito dei domini e rispondono alle richieste di risoluzione.

3) **Resolver**  
   Il software client che interroga i Name Server per ottenere le informazioni DNS.

---
# Domain Name Space (Spazio dei Nomi)

Il **Domain Name Space** è una struttura logica gerarchica ad albero.
## Gerarchia:

- **Dominio Radice (Root)**  
  Rappresentato da un punto `.` alla fine di un FQDN (es. `google.com`)

- **Top-Level Domain (TLD)**  
- **Generici (gTLD):** `.com`, `.org`, `.net`  
- **Nazionali (ccTLD):** `.it`, `.fr`, `.de`

- **Dominio di Secondo Livello:**  
  Il nome scelto dall’organizzazione (es. `google` in `google.com`)

- **Sottodominio / Host (Dominio Foglia):**  
  Es. `www` in `www.google.com`

## FQDN - Fully Qualified Domain Name

È l'**indirizzo completo**: include il nome specifico del dispositivo (l'host, come `www`) e il nome del dominio a cui appartiene (come `google.com`).

## Regole di Naming:

- Ogni etichetta ≤ 63 caratteri
- Nome completo ≤ 255 caratteri
- I nomi sono **case-insensitive** (`Google.com` = `google.com`)

---
# Name Server

I **Name Server** conservano i [[#Resource Record (RR)]] del DNS e rispondono alle query.

## Root Name Server 

- Non conosce direttamente gli IP dei domini
- Sa dove si trovano i server TLD (es. `.com`)

## Name Server Autoritativo

- Contiene i record **ufficiali** di una zona (es. `google.com`)
- Fornisce risposte definitive

## Zone e Deleghe

- **Zona:** porzione del name space gestita da un server
- **Delega:** un server può delegare una zona a un altro server autoritativo

| Tipo Server | Funzione                              |
|-------------|----------------------------------------|
| Primario    | Contiene i record originali, modificabili |
| Secondario  | Copia di sola lettura per backup e bilanciamento |

---

## Resolver (Client DNS)

Il **Resolver** è il componente sul dispositivo dell’utente che invia query DNS ai Name Server.

- Integrato nel sistema operativo
- Attiva la risoluzione quando un’app (es. browser) richiede un dominio

---

# Processo di Risoluzione DNS

Esempio: `it.wikipedia.org`

1. Il resolver interroga il **Default DNS Server**
2. Se non ha la risposta in cache:
    - Interroga un **Root Server**:  
       “Dove trovo `.org`?”
    - Il Root Server risponde con gli indirizzi IP dei server TLD `.org`
    - Il resolver interroga il **TLD Server `.org`**:  
    - “Dove trovo `wikipedia.org`?”
    - Il TLD Server risponde con gli IP dei Name Server autoritativi di `wikipedia.org`
    - Il resolver interroga il server **autoritativo** di `wikipedia.org`:  
	  "Qual è l’IP di `it.wikipedia.org`?”
3. Il server autoritativo risponde con l’indirizzo IP.
4. Il DNS Server salva la risposta in cache (per il TTL) e restituisce il dato all’utente.

- **server autoritativo:** è il server DNS che possiede i **record ufficiali e definitivi** per un dominio specifico.

---
# Vantaggi del DNS

- **Nomi mnemonici:** Semplifica l'accesso a risorse di rete
- **Flessibilità:** Cambi IP gestiti centralmente, utenti inalterati
- **Aliasing:** Più nomi possono puntare allo stesso IP (es. `CNAME`)
- **Load Balancing:** DNS può restituire IP diversi per distribuire il traffico

---
# Formato Pacchetto DNS

Un pacchetto DNS include:

## Header (12 byte)

| Campo               | Descrizione                                  |
|---------------------|----------------------------------------------|
| Identificativo      | Numero per associare domanda e risposta      |
| Flag                | Parametri della query/risposta               |
| Numero Richieste    | Quante query contiene il pacchetto           |
| Numero Risposte     | Quanti Resource Record ci sono nella risposta |

## Campo Flag (16 bit)

| Flag | Descrizione                                       |
|------|---------------------------------------------------|
| QR   | 0 = Query, 1 = Reply                              |
| OpCode | 0 = Query standard, 1 = Inverse query           |
| AA   | Authoritative Answer                              |
| TC   | Truncated (messaggio tagliato)                    |
| RD   | Recursion Desired (richiesta risoluzione ricorsiva) |
| RA   | Recursion Available (il server supporta la ricorsione) |
| RCode | Codice risposta (0 = OK, 3 = Nome inesistente...) |

---

# Resource Record (RR)

I **Resource Record**  sono le singole "righe" di informazione che compongono il database del DNS

## Struttura:

| Campo     | Significato                              |
|-----------|-------------------------------------------|
| Domain Name | Nome del dominio                        |
| Type      | Tipo di record (A, AAAA, CNAME, MX...)    |
| Class     | Classe (quasi sempre IN = Internet)       |
| TTL       | Durata in secondi della cache             |
| RDLength  | Lunghezza del dato                        |
| RData     | Valore del record (es. un IP o nome)      |

---

## Tipi Comuni di Record DNS

| Tipo   | Descrizione                                                  |
|--------|--------------------------------------------------------------|
| A      | Associa un dominio a un indirizzo IPv4                      |
| AAAA   | Associa un dominio a un indirizzo IPv6                      |
| CNAME  | Alias: fa puntare un nome a un altro nome                   |
| MX     | Specifica i mail server per un dominio                      |
| NS     | Indica i Name Server autoritativi                           |
| PTR    | Risoluzione inversa (IP → nome)                             |
| TXT    | Testo libero (usato per SPF, DKIM, ecc.)                    |
| SOA    | Parametri autoritativi della zona (primario, refresh, ecc.)|

---

# DNS Inverso (Reverse DNS)

Consente di ottenere il **nome** associato a un **IP**.

## A cosa serve?
- È spesso usato per **diagnostica di rete**, **sicurezza**, **filtri antispam** e **registrazione dei log**.
- Ad esempio, un server di posta può usare il reverse DNS per verificare che l’IP del mittente corrisponda effettivamente al nome dichiarato.

## Meccanismo:

- Utilizza il dominio speciale `in-addr.arpa.` per IPv4
- L’IP è scritto **al contrario** per rispettare la gerarchia DNS
- Si usa il **record PTR**

## Esempio:

IP: 93.184.216.34  
Query DNS: 34.216.184.93.in-addr.arpa  
Risposta: example.com

___
 
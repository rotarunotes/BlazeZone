---
date: 2026-05-06
tags: [concept, security, architecture]
source_count: 4
---

# DMZ (Demilitarized Zone)

La **Demilitarized Zone** è una subnet logica o fisica posizionata tra Internet e la LAN interna protetta. Agisce come area "cuscinetto". 

## Principi di Progettazione
- **Scopo:** Ospitare i servizi esposti pubblicamente (Web Server, Mail Server, DNS esterno, E-commerce).
- **Isolamento:** Un utente che naviga su Internet ha accesso *solo* ai server in DMZ, e mai ai PC dei dipendenti o ai Database interni. Se un attaccante compromette il server web in DMZ, la compromissione non gli garantisce accesso diretto alla rete sensibile.
- **Static PAT (Port Forwarding):** I server in DMZ, pur avendo indirizzi IP privati, vengono esposti al pubblico configurando una regola statica bidirezionale sul Firewall perimetrale (es. mappare l'IP Pubblico:443 sull'IP Privato:443 del Web Server).
- **Servizi in DMZ (dalle slide):** Web Server, Mail Server, FTP Server, VoIP Server. Per sicurezza, anche i **Proxy Server** vengono posizionati in DMZ.
- **Comunicazione DMZ → LAN interna:** Se i servizi WEB/MAIL in DMZ devono accedere a database interni, la comunicazione DEVE essere controllata da un **Application Firewall**.
- **Architettura:** Realizzabile con un **singolo firewall** (a 3 interfacce: WAN, DMZ, LAN) oppure con un **doppio firewall** (zona cuscinetto fisica tra due appliance dedicate).
- **Architetture Server Farm:** In sede di esame (Maturità), una strategia brillante per *evitare* di creare una DMZ locale complessa è suggerire di spostare il Web Server in Hosting presso una Server Farm Esterna, trasferendo al provider il carico della sicurezza (e giustificando con l'aumento dei costi OPEX).

## Fonti Collegate
- [[Sicurezza_Appunti]]
- [[SERVER_Appunti]]
- [[sicurezza_di_rete_slides]]
- [[doc2_sicurezza_cloud_iot]]

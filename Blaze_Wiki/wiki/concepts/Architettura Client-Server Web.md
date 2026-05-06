---
date: 2026-05-06
tags: [concept, web, architecture]
source_count: 1
---

# Architettura Client-Server Web

L'**Architettura Client-Server** è il modello fondamentale per le applicazioni web. Il browser (client) invia richieste HTTP al server, che elabora la logica e restituisce le pagine.

## Stack LAMP (da citare all'esame)
Lo stack più classico per applicazioni web:
- **L** — Linux (sistema operativo del server)
- **A** — Apache (web server HTTP)
- **M** — MySQL / MariaDB (DBMS relazionale)
- **P** — PHP (linguaggio lato server per pagine dinamiche)

## Componenti dell'Architettura

### Lato Client (Frontend)
- **HTML5:** Struttura della pagina.
- **CSS3:** Stile e layout (responsive design per mobile).
- **JavaScript:** Logica interattiva, validazione form, richieste AJAX.

### Lato Server (Backend)
- **PHP / Python / Node.js:** Logica applicativa (autenticazione, query DB, generazione pagine dinamiche).
- **SQL:** Interrogazioni al database (SELECT, INSERT, UPDATE, DELETE).
- **Sessioni e Cookie:** Gestione autenticazione utenti (login dipendenti vs accesso pubblico).

### Protocolli
- **HTTP/HTTPS (porta 80/443):** Protocollo applicativo per la comunicazione web. HTTPS aggiunge cifratura [[SSL-TLS]].
- **XML / JSON:** Formati di scambio dati strutturati tra sistemi (es. invio classifica alla FIA).
- **REST API:** Architettura per servizi web stateless (GET, POST, PUT, DELETE).

## Design Tipico per Esame di Stato
1. **Web Server** posizionato in [[DMZ]] o in Server Farm Esterna (Hosting/[[Cloud Computing]]).
2. **Database Server** posizionato nella LAN interna protetta ([[VLAN]] dedicata).
3. Il Web Server accede al DB tramite query controllate da un **Application [[Firewall]]** (prevenzione SQL Injection).
4. Il frontend è **responsive** (accessibile da desktop e mobile).

## Fonti Collegate
- [[esame_stato_2014]]

8)Data: 2026-03-22
[](./README.md)
#Red_Lab/Fit_Blaze
___
Inizio lavoro: 20/03/2026

# Progettazione concettuale:
```
Utente:(id (PK), nome_utente, nome, cognome, password_hash)
Scheda: (id (PK), utente_id (FK), nome_scheda, data_creazione, is_active)
Allenamento_quotidiano: (id (PK), scheda_id (FK), nome_giorno)
Esercizio: (id (PK), nome_esercizio (FK), fascio_muscolare, video_url, tipologia)
Serie: (id (PK), giorno_id, esercizio_id, numero_serie, numero_ripetizioni, tempo_recupero, peso, note)
```

#### 22/03
1) Ho fatto le funzioni di fetch che mi restituiscono le liste di:
	- Utenti
	- Schede
	- Allenamento_quotidiano
	- Esercizio
	- Serie
Ma in questo modo prendo tutti i dati di tutto, invece che prendere i dati dell'utente specifico, vabbè, farò in modo che sia il server a restituirmi i dati di quello specifico utente

2)  Ho fatto le query di create table del db locale
___
# Titolo 2
___
 
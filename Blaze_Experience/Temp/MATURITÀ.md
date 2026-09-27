
- Martedì
	1. italiano
		1. Leopardi
		2. Pascoli
		3. Verga
- Mercoledì
	1. Informatica
		1. Ripasso Fast
	2. Sistemi
		1. Lettura Appunti
- Giovedì
	1. Discorso generale
	2. Italiano
		1. D'Annunzio
		2. Ungaretti
- Venerdì
	1. Inglese
		1. Presentazione
		2. Lettura appunti inglese
	2. Italiano
		1. Pirandello

# Discorso Introduzione

#### Introduzione
Buongiorno Presidente, buongiorno commissarie commissari. Vorrei iniziare questo colloquio con una breve riflessione sul percorso scolastico svolto.

#### BackGround Medie
Ho frequentato le medie a Mira, nel complesso Luigi Nono, In quegli anni ho capito che ero portato per il pensiero logico e che l'informatica sarebbe stata la mia strada. 
Per questo ho scelto di iscrivermi all'istituto tecnico C. Zuccante.

#### Le superiori
Le superiori per me non è stato solo un luogo di apprendimento disciplinare ma anche uno spazio di **crescita progressiva** in cui ho costruito **metodo**, **autonomia** e **capacità di elaborazione personale**.
- Se all'inizio il mio studio era più **mnemonico**, negli anni ho sviluppato un **approccio** più **consapevole** imparando a collegare le **conoscenze** apprese.
- Difatti un questo ultimo anno sto cercando di applicare le conoscenze informatiche apprese

#### Esperienza  
Vorrei architettare un Home Lab personale per il Self-Hosting di servizi, permettendomi di applicare le conoscenze acquisite sulla configurazione di una VPN e delle regole di NAT.

#### Argomento piaciuto
Soprattutto al triennio ho imparato ad apprezzare la Storia e Letteratura Italiana, infatti è stato interessante l'approfondimento che abbiamo fatto sulla prima guerra mondiale e Giuseppe Ungaretti.

#### Esperienze
Ho anche vissuto diverse esperienze significative:
- CERN
- Olimpiadi di informatica
- Corso ingenieria
- Certificazioni Linguistiche e tecniche


Il percorso che ho sviluppato mi ha aiutato a maturare la **consapevolezza** dei miei **punti di forza** e delle mie **difficoltà** lavorando progressivamente per migliorare.

Concludo ringraziando i professori per la loro pazienza in questi anni e per i loro insegnamenti

# Inglese

1) First I will provide a brief overview of the company
2) Second I will talk about my role and responsibilities I had
3) Third I will explain the task I had
4) Quarter I will discuss about the pros and challenges of my experience
5) Fifth, I will expose the Skills i Learned
6) And Finally, i will conclude with my reflections of the future


#### Slide 2 Company Overview

MiCROTEC is a global leader of wood's scanner industry. 
Their **mission** is to provide the technology to help customers get the most value form a single log. 

The company's headquarters is located in Bressanone, Italy, while the branch office where I worked is located here in Mestre. 
MiCROTEC operates on a **global scale**, with their main products:
- Advanced scanners for sawmills. 
- Software development for the wood processing.


#### Slide 3 My Role on the Team

During my internship, I was placed in the **Research and Development** department, also known as R&D. 
This department's main focus was designing new **technological solutions**.

My primary responsibility was to **observe** the team's workflow, 

which gave me a the **opportunity** to **understand** how a professional R&D environment operates in a real industrial company.

#### Slide 4 Description of Tasks Completed

 During my internship, I was involved in three **main tasks**. 
 1) The first was the **documentation** of the company's internal C++ **library**, called 'matcpp'. The goal was to create clear documentation to make it **easier** for other developers to use the library. 
 2) The second task was research on Industrial Wi-Fi 7, based on specific technical requirements provided by the team. 
 3) The third task involved is solving a scanner bandwidth issue


#### Slide 5 Pros and Challenges

My internship had both positive aspects and challenges.

On the positive side, I really appreciated the great relationship I had with the team. 

One of the highlights was definitely the opportunity to **physically inspect** and work on a scanner, which I found very interesting. 
 
On the other hand, I faced some challenges as well. I **didn't particularly enjoy** the documentation task for the 'matcpp' library, as I found it repetitive. I also experienced moments of stress and tiredness.

#### Skill 
Despite the challenges, this internship allowed me to develop both hard and soft skills. 

In terms of hard skills
- I learned how to analyze a scanner
- I picked up a new programming language
- I used specific professional tools
- I gained knowledge of company procedures and workflows. 
  
As for soft skills,
- I improved my ability to work in a team and collaborate with colleagues
- I developed my problem-solving and time management skills
- I learned how to communicate effectively in a professional environment
- I also became more adaptable when facing new and unexpected situations.


#### Slide 6 SFuture Reflections

To conclude, this internship was an important experience **that helped** me grow professionally. 

It helped me understand that field of industrial scanning is not the direction I want to follow in the future. 

However, this experience has solidified my decision to study Computer Engineering, a path that I am now even more motivated to follow. 

I'm grateful for everything I learned during this time at MiCROTEC.




### Generalizzazioni (IS A):
- **totale**: per ogni A esiste almeno un B o un C (una persona è per forza o maggiorenne o minorenne);
- **parziale**: esiste almeno un A che non ha la controparte (non tutti i film sono drama, non tutte le persone sono maggiorenni);
- **esclusive**: (è solo B o C);
- **sovrapposte**: (può essere sia B che C);
  
  ## Normalizzazione
La **normalizzazione** è il processo di organizzazione delle tabelle per:
- Eliminare ridondanze
- Prevenire anomalie di inserimento, aggiornamento e cancellazione
- Garantire coerenza dei dati


| Azione        | ON DELETE                              | ON UPDATE                              |
| :------------ | :------------------------------------- | :------------------------------------- |
| `CASCADE`     | Elimina i figli automaticamente        | Aggiorna i figli automaticamente       |
| `SET NULL`    | Imposta FK a `NULL` nei figli          | Imposta FK a `NULL` nei figli          |
| `SET DEFAULT` | Imposta FK al valore DEFAULT nei figli | Imposta FK al valore DEFAULT nei figli |
| `RESTRICT`    | Blocca l'operazione se esistono figli  | Blocca l'operazione se esistono figli  |
| `NO ACTION`   | Come RESTRICT (controllo a fine tx)    | Come RESTRICT (controllo a fine tx)    |

| Constraint    | Scopo                                                     | NULL consentito? |
| :------------ | :-------------------------------------------------------- | :--------------- |
| `NOT NULL`    | Obbliga la presenza di un valore                          | ❌                |
| `UNIQUE`      | Impedisce valori duplicati                                | ✅ (uno solo)     |
| `PRIMARY KEY` | Identifica univocamente ogni riga (`NOT NULL` + `UNIQUE`) | ❌                |
| `FOREIGN KEY` | Garantisce l'integrità referenziale tra tabelle           | ✅                |
| `CHECK`       | Valida i dati rispetto a una condizione logica            | ✅                |
| `DEFAULT`     | Fornisce un valore automatico se non specificato          | ✅                |
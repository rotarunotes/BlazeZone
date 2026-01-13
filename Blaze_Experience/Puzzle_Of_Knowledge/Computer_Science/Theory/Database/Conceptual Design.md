
# Ex: Agenzia immobiliare
 
Si vuole progettare il sistema informativo per la gestione di una cateagenzia immobiliare di
Milano. Gli utilizzatori del sistema informativo saranno gli agenti immobiliari dell’agenzia e
anche quelli di altre agenzie che avranno accesso a una vista opportuna (definire anche questa)
che oscura le informazioni delicate. Una vista un pochino più restrittiva sarà data anche agli
eventuali **acquirenti** e a **venditori** che vogliano farsi un’idea del mercato, e che accederanno al
sistema via Internet.
I possibili acquirenti potranno registrarsi, indicando i loro dati anagrafici e le loro esigenze in
termini di: destinazione dell’immobile (abitazione, negozio, ufficio, laboratorio) zona di preferenza
dell’immobile, metri quadrati, se è abitazione numero di servizi, prezzo massimo.
I venditori potranno anch’essi registrarsi, e segnaleranno, negli stessi termini, gli immobili che
hanno intenzione di offrire. Un venditore può figurare anche come acquirente, per esempio in caso
di permuta o perché è contemporaneamente interessato a cercare un nuovo immobile e a venderne
un altro.
Inoltre, una attività di Gestione del Personale può inserire o modificare dati sul personale
dell’agenzia (che ha una matricola, nome, cognome, indirizzo e numero di telefono, e una
specializzazione sulla tipologia dell’immobile), e assegna il personale agli immobili da curare e
seguire per tutta la durata della trattativa. Relativamente alle trattative, occorre memorizzare per
ogni immobile le offerte in corso, e la fase in cui si trova il negoziato (sospeso, offerta accettata, e
in corso di perfezionamento del contratto).
L’agenzia applica delle provvigioni differenziate al venditore e all’acquirente. Tali provvigioni
possono essere negoziate, perciò al momento della redazione dell’offerta occorre memorizzare
anche la proposta del cliente per quanto riguarda la provvigione.
 
## Documentazione
E’ necessario produrre la documentazione di progetto, composta da:
- Analisi dei requisiti
- Schema concettuale, tramite il modello E-R
- Schema logico
- La realizzazione delle le tabelle che compongono la base di dati (DDL)
- Un elenco di interrogazioni SQL ritenute significative
Data: 2026-06-08
[Blaze_Experience](Red_Lab/README.md)
#ParteTuttoDaQua
___
# Index
- [[#Struttura Del Vault Rilevata]]
- [[#Stile Di Scrittura E Formattazione Obbligatoria]]
	- [[#Struttura Dell'Intestazione]]
	- [[#Indice E Link Interni]]
	- [[#Formattazione Del Testo E Punteggiatura]]
	- [[#Tono Di Voce]]
	- [[#Risorse Multimediali E Callout]]
- [[#Regole Per I Futuri Output]]
___
# Style Guide & Vault Rules

## Struttura Del Vault Rilevata

Il Vault è organizzato come un wiki/second brain tematico strutturato gerarchicamente. Ogni cartella e sottocartella contiene un file `README.md` che funge da **MOC** (Map of Content), generato automaticamente tramite lo script di configurazione in `Setup_Archive/Templates/Index_Template.md` o `README_Template.md`, che ordina i file in base a regole personalizzate definite in `sorting-spec.md`.

Le aree principali del Vault sono organizzate come segue:

- **`Puzzle_Of_Knowledge`**: La base di conoscenza strutturata. Si divide in:
  - `Computer_Science`: Teoria, programmazione (HTML, JS, CSS, Dart, Flutter, PHP), sistemi e reti (CCNA/Networking), sistemi operativi.
  - `Math`: Analisi matematica (integrali definiti/indefiniti), probabilità, statistica, geometria.
- **`Red_Lab`**: Laboratori e progetti personali. Include progetti software (es. `Fit_Blaze`), giochi (`Giochi/Reverse`) e log di sviluppo personali.
- **`School`**: Note scolastiche suddivise per anni accademici (es. `3ID_2023-24`, `4ID_2024-25`, `5ID_2025-26`) con materie come Sistemi e TPSIT.
- **`Setup_Archive`**: La cartella di sistema che gestisce il funzionamento del Vault:
  - `Obsidian_Base`: Esempi e guide di formattazione di base.
  - `Plugin`: Configurazioni dei plugin, tra cui il calendario per la gestione di `Daily_Quest`, `Exam`, `Gym`, `Social_Event` e i log giornalieri in `Pearls/Daily`.
  - `Rules`: Regole stilistiche (`Rules.md`), scorciatoie da tastiera (`Short_Cut.md`) e questa guida (`GEMINI.md`).
  - `Templates`: I modelli per note, protocolli di rete, indici e script di collegamento.
  - `Viewable`: File media, immagini e diagrammi realizzati con Excalidraw, suddivisi tematicamente.

___

## Stile Di Scrittura E Formattazione Obbligatoria

Ogni nota all'interno delle cartelle tematiche deve rispettare regole rigide basate sull'analisi delle note esistenti:

### Struttura Dell'Intestazione
Le note non utilizzano il frontmatter standard YAML delimitato da `---`. Utilizzano invece un'intestazione testuale pulita con tag e link relativi:
```markdown
Data: YYYY-MM-DD
[NomeCartellaPadre](./README.md)
#Tag/Gerarchico/Di/Percorso
___
```
*Esempio*:
```markdown
Data: 2026-04-22
[Models](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Network_Fundamentals/Models
___
```

### Indice E Link Interni
Per le note di studio e documentazione complessa, viene inserito un indice subito dopo l'intestazione che elenca le sezioni collegate tramite link interni Obsidian:
```markdown
# Index
- [[#Titolo Sezione 1]]
	- [[#Sotto Sezione 1.1]]
- [[#Titolo Sezione 2]]
___
```
I link interni alle intestazioni usano la sintassi `[[#Nome Intestazione]]`. I sotto-elementi dell'indice sono indentati con una tabulazione.

### Formattazione Del Testo E Punteggiatura
- **Punteggiatura e Grassetto/Corsivo**: La regola cardine stabilisce che la punteggiatura (due punti, punti, virgole) non deve mai essere inclusa nei marcatori markdown di grassetto (`**`) o corsivo (`*`).
  - *Sbagliato*: `Formula di **Leibniz-Newton:**` oppure `**Attenzione.**`
  - *Corretto*: `Formula di **Leibniz-Newton**:` oppure `**Attenzione**.`
- **Titoli**: Tutti i titoli delle sezioni devono essere scritti in Title Case con le iniziali maiuscole ("Camel Case Spaziati").
  - *Sbagliato*: `# Calcolo delle aree` oppure `## Additività dell'integrale`
  - *Corretto*: `# Calcolo Delle Aree` oppure `## Additività Dell'Integrale`
- **Grassetto**: Si utilizza per le parole chiave e per evidenziare concetti importanti.
- **Corsivo**: Si utilizza esclusivamente per l'estensione degli acronimi (es. TCP, *Transmission Control Protocol*).
- **Codice**: I frammenti di codice o la sintassi di programmazione utilizzano i blocchi di codice con l'indicazione del linguaggio (es. ````Dart````) e la sintassi inline con i backtick (es. ``TCP``, ``IP``).
- **Linee Separatrici**: Per creare linee divisorie orizzontali in Markdown, utilizzare sempre tre trattini bassi (`___`).

### Tono Di Voce
Il tono si adatta al contesto della nota:
- **Didattico/Scientifico** (per `Puzzle_Of_Knowledge` e note di studio): Trattazione chiara, rigorosa, con formule matematiche in LaTeX e definizioni precise (es. "La funzione F è dunque derivabile, e quindi anche continua...").
- **Informale/Colloquiale** (per `Red_Lab` e guide rapide): Diretto, schematico, orientato all'azione e personale (es. "gigiociodgsis", "Ho fatto le funzioni di fetch", "manca user").

### Risorse Multimediali E Callout
- **Callout**: Per analogie ed esempi, si utilizzano i callout di Obsidian.
  - *Esempio*:
    ```markdown
    > [!example] Analogia
    > Immagina di voler inviare un intero libro per posta usando solo cartoline...
    ```
- **Immagini**: Le immagini e i diagrammi sono inclusi tramite i link standard markdown relativi (es. `![Struttura](Schema.png)`) oppure tramite il formato Obsidian wiki-link con parametri di dimensione (es. `![[Grafico_integrale]]` o `![[Grafico_integrale|600]]`).

___

## Regole Per I Futuri Output

Quando ricevi l'istruzione di creare o integrare una nota nel Vault, attieniti scrupolosamente ai seguenti passaggi:

1. **Analisi Della Cartella Di Destinazione**: Identifica in quale sezione del Vault risiede la nota per stabilire il tono di voce (informale/personale per i laboratori/progetti, accademico/telegrafico per le note di studio/CCNA) e il tag corretto.
2. **Generazione Dell'Intestazione**: Inserisci sempre la data corrente nel formato `Data: YYYY-MM-DD`, il link alla cartella padre `[Padre](./README.md)`, il tag della gerarchia della cartella e la riga di divisione `___`.
3. **Generazione Dell'Indice**: Se la nota è ricca di contenuti, inserisci la sezione `# Index` con i link interni alle intestazioni di primo e secondo livello prima di iniziare la stesura del contenuto.
4. **Scrittura Dei Titoli**: Assicurati che ogni intestazione (`#`, `##`, `###`) utilizzi la capitalizzazione Title Case ("Camel Case Spaziati").
5. **Controllo Della Punteggiatura E Enfasi**: Verifica attentamente che punti, due punti, virgole e punti interrogativi siano posizionati fuori dai delimitatori di grassetto `**` e corsivo `*`. Inoltre, applica il grassetto `**` per le parole chiave e il corsivo `*` esclusivamente per l'estensione degli acronimi.
6. **Formule E Codice**: Scrivi tutte le formule matematiche in LaTeX racchiuse tra `$$` per i blocchi e `$` per il testo in linea. Usa blocchi di codice specifici per i linguaggi di programmazione o i comandi Cisco.
7. **Firma Gemini**: Se hai generato risposte o note di studio complesse su richiesta diretta del client, firma i blocchi o le risposte con `--gemini` (o `--Gemini`) in fondo al testo per mantenere la tracciabilità delle note generate dall'assistente, come riscontrabile nelle note esistenti.
8. **Linee Separatrici**: Utilizza sempre tre trattini bassi (`___`) per definire tutte le linee divisorie orizzontali del documento.

Data: 2026-10-14
[Lezioni](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1/Lezioni
___
# Index
- [[#1. Intestazione Standard Di Ogni File]]
- [[#2. Index (Indice)]]
- [[#3. Struttura Gerarchica Dei Titoli]]
- [[#4. Callout (Obsidian)]]
	- [[#4.1 Tipi Di Callout Usati]]
	- [[#4.2 Formato Generale Callout]]
	- [[#4.3 Callout Annidati]]
	- [[#4.4 Regole Di Annidamento]]
	- [[#4.5 Callout Abstract/Definizione — Schemi Ricorrenti]]
	- [[#4.6 Callout Success/Dimostrazione — Schemi Ricorrenti]]
	- [[#4.7 Callout Info — Schemi Ricorrenti]]
	- [[#4.8 Callout Danger/Attenzione — Schemi Ricorrenti]]
	- [[#4.9 Callout Example — Schemi Ricorrenti]]
	- [[#4.10 Callout Note — Schemi Ricorrenti]]
- [[#5. LaTeX — Regole Generali]]
	- [[#5.1 Inline vs Display]]
	- [[#5.2 Comandi LaTeX Ricorrenti]]
	- [[#5.3 Simboli Fine Dimostrazione]]
	- [[#5.4 Annotazioni Sopra i Segni]]
	- [[#5.5 Convenzioni LaTeX Per Insiemi Numerici]]
	- [[#5.6 Formule In Blocco Con Casi]]
	- [[#5.7 Frecce e Connettivi]]
- [[#6. Tabelle Markdown]]
	- [[#6.1 Tabella Enunciato (Contesto/Ipotesi/Tesi)]]
	- [[#6.2 Tabelle Di Proprietà]]
	- [[#6.3 Tabelle Di Confronto/Riepilogo]]
- [[#7. Metodo Di Procedere — Struttura Degli Appunti Per Argomento]]
	- [[#7.1 File Argomenti (Cartella Argomenti)]]
	- [[#7.2 File Dimostrazioni]]
	- [[#7.3 File Calcolanti]]
	- [[#7.4 File Lezioni (Cartella Lezioni)]]
	- [[#7.5 File Di Supporto]]
- [[#8. Link Interni (Obsidian Wikilinks)]]
- [[#9. Separatori]]
- [[#10. Immagini]]
- [[#11. Regole Di Stile Generali]]
- [[#12. Schema Completo — Dimostrazione Per Induzione]]
- [[#13. Schema Completo — Dimostrazione Per Contraddizione]]
- [[#14. Schema Completo — Definizione Con Callout Annidati]]
- [[#15. Regole Per L'AI Che Trascrive]]
___

# 1. Intestazione Standard Di Ogni File

Ogni file **inizia sempre** con queste 4 righe (l'ordine è fisso):

```
Data: AAAA-MM-GG
[Nome_Cartella_Padre](./README.md)
#Puzzle_Of_Knowledge/Math/Analisi_1
___
```

- **Riga 1** — `Data:` seguita dalla data in formato `AAAA-MM-GG`
- **Riga 2** — Link relativo alla cartella padre in formato markdown `[Nome](./README.md)`
- **Riga 3** — Tag Obsidian con il percorso completo, separato da `/`, preceduto da `#`
- **Riga 4** — Separatore orizzontale `___` (tre underscore)

> [!danger] Attenzione!
> Il tag nella riga 3 cambia in base alla sotto-cartella:
> - File nella radice: `#Puzzle_Of_Knowledge/Math/Analisi_1`
> - File in `Lezioni/`: `#Puzzle_Of_Knowledge/Math/Analisi_1/Lezioni`
> - File in `Argomenti/`: `#Puzzle_Of_Knowledge/Math/Analisi_1/Argomenti`

___
# 2. Index (Indice)

Subito dopo l'intestazione c'è **sempre** la sezione Index:

```markdown
# Index
- [[#Titolo Sezione 1]]
	- [[#Sotto-Sezione 1.1]]
	- [[#Sotto-Sezione 1.2]]
- [[#Titolo Sezione 2]]
```

**Regole:**
1. L'indice usa `[[#Titolo]]` (wikilink con anchor alla heading)
2. Le sotto-sezioni sono indentate con **un tab**
3. Se il titolo contiene LaTeX, la forma alternativa leggibile va dopo il `|`:
   ```
   [[#Fattoriale di $n \in \mathbb{N}$: $n!$|Fattoriale di n ∈ ℕ: n!]]
   ```
4. Dopo l'index c'è **sempre** un separatore `___`

___
# 3. Struttura Gerarchica Dei Titoli

| Livello | Markdown | Uso tipico |
|---------|----------|------------|
| `#`     | H1       | Nome della macro-sezione (es. `# Numeri Naturali $\mathbb{N}$`) |
| `##`    | H2       | Sotto-argomento o singola definizione/proprietà (es. `## Ordinamento Totale`) |
| `###`   | H3       | Ulteriore dettaglio, passo di dimostrazione (es. `### Passo base ($p=1$)`) |
| `####`  | H4       | Raramente usato, solo dentro sotto-strutture di dimostrazioni complesse |

**Regole:**
- I titoli possono contenere formule LaTeX inline (`$...$`)
- Dopo un titolo `#` principale c'è spesso un callout `[!abstract] Definizione:` 
- I separatori `___` vanno usati **tra macro-sezioni** (cioè tra `#` e `#`), mai tra sotto-sezioni

___
# 4. Callout (Obsidian)

## 4.1 Tipi Di Callout Usati

| Tipo | Identificatore | Uso |
|------|---------------|-----|
| **Definizione** | `[!abstract]` o `[!Abstract]` | Definizioni formali, enunciati, teoremi |
| **Dimostrazione** | `[!success]` o `[!Success]` | Passi dimostrativi, conclusioni di prove |
| **Informazione** | `[!info]` o `[!Info]` | Note a margine, spiegazioni "in parole", chiarimenti |
| **Attenzione** | `[!danger]` o `[!Danger]` | Errori comuni, avvertimenti, contraddizioni (nell'assurdo) |
| **Esempio** | `[!example]` o `[!Example]` | Esempi concreti con numeri |
| **Nota** | `[!note]` o `[!NOTE]` | Note generiche (usato raramente) |

> [!info] Info: Capitalizzazione
> La prima lettera del tipo può essere maiuscola o minuscola indifferentemente (`[!abstract]` = `[!Abstract]`). L'utente usa entrambe le forme.

## 4.2 Formato Generale Callout

```markdown
> [!tipo] Titolo Tipo: Titolo Specifico
> Contenuto del callout
> Altra riga di contenuto
```

**Il titolo ha DUE parti separate da `:`:**
1. **Titolo del tipo** — Ripete il tipo (es. `Definizione`, `Dimostrazione`, `Info`, `Attenzione`)
2. **Titolo specifico** — Descrizione del contenuto

**Esempi di titoli reali:**
- `[!abstract] Definizione: Numeri Naturali`
- `[!abstract] Definizione: Enunciato, Assioma Di Separazione`
- `[!success] Dimostrazione: Passo base`
- `[!success] Dimostrazione: Passo induttivo`
- `[!success] Dimostrazione: Conclusione`
- `[!info] Info: In Parole`
- `[!info] Info: Perché non è ovvio`
- `[!danger] Attenzione! Condizione $\land$ Su Entrambe Le Ipotesi`
- `[!example] Esempio: Operazione Di Unione`
- `[!Example] Esempio: $f$, $g$, $h$`

> [!danger] Attenzione!
> - Per `[!danger]` il titolo usa spesso `Attenzione!` con il punto esclamativo
> - Per `[!abstract]` quando si tratta di un enunciato formale il titolo è spesso `Definizione: Enunciato, Nome Del Teorema`
> - Per `[!success]` quando è un link a un'altra dimostrazione il titolo è `Dimostrazione:` seguito dal nome, e il contenuto è un wikilink

## 4.3 Callout Annidati

I callout possono essere **annidati** con livelli multipli di `>`:

```markdown
> [!Abstract] Definizione: Definizione Esterna
> Contenuto livello 1
> > [!Info] Info:
> > Contenuto livello 2
> > > [!Example] Esempio:
> > > Contenuto livello 3
```

**Pattern tipici di annidamento:**

**Pattern 1 — Definizione con Info:**
```markdown
> [!Abstract] Definizione: Nome
> Formula principale
> > [!Info] Info:
> > Spiegazione aggiuntiva
```

**Pattern 2 — Definizione con Info e Esempio:**
```markdown
> [!Abstract] Definizione: Nome
> Formula principale
> > [!Info] Info:
> > Spiegazione
> > > [!Example] Esempio:
> > > Esempio numerico
```

**Pattern 3 — Definizione con Dimostrazione interna:**
```markdown
> [!Abstract] Definizione: Nome
> Formula principale
> > [!Success] Dimostrazione:
> > Passo 1...
> > Passo 2...
```

**Pattern 4 — Definizione con Pericolo e Info annidati:**
```markdown
> [!Abstract] Definizione: Nome
> Contenuto
> > [!Danger] Attenzione:
> > Avvertimento
> > > [!Info] Info:
> > > Dettaglio
```

**Pattern 5 — Esempio con sotto-esempio:**
```markdown
> [!Example] Esempio: Caso Principale
> Contenuto esempio
> > [!Success] Dimostrazione:
> > Prova del caso
```

## 4.4 Regole Di Annidamento

1. **Ogni livello aggiunge un `>`** — primo livello `>`, secondo `> >`, terzo `> > >`
2. **Massimo annidamento osservato**: 3 livelli (`> > >`)
3. **Le righe vuote dentro un callout** si scrivono con solo `>` (o `> >` ecc.)
4. **I callout annidati sono separati** dalla riga precedente con una riga vuota con `>`
5. **Il LaTeX inside callout** segue le stesse regole (sia inline che display)
6. **Le tabelle dentro callout** sono possibili e usate frequentemente
7. **Le immagini dentro callout** si inseriscono con `![nome](nome.png)`

## 4.5 Callout Abstract/Definizione — Schemi Ricorrenti

### Schema Enunciato Con Tabella
```markdown
> [!Abstract] Definizione: Enunciato, Nome Del Teorema
> | Parte        | Contenuto                         |
> | ------------ | --------------------------------- |
> | **Contesto** | Sia $x\in\mathbb{R}$              |
> | **Ipotesi**  | Condizione                        |
> | **Tesi**     | Ciò che si vuole dimostrare       |
```

### Schema Definizione Pura
```markdown
> [!abstract] Definizione: Nome Della Definizione
> $n, k \in \mathbb{N}$, $k \leq n$
> $$\binom{n}{k} := \frac{n!}{k!\,(n-k)!}$$
```

### Schema Definizione Con Info Annidato
```markdown
> [!abstract] Definizione: Induttiva Fattoriale
> 1. $0! := 1$
> 2. $(n+1)! := (n+1)\cdot n! \qquad \forall n\in\mathbb{N}$
>
> > [!info] Info:
> > Per induzione $n!$ è ben definito $\forall n\in\mathbb{N}$.
```

## 4.6 Callout Success/Dimostrazione — Schemi Ricorrenti

### Dimostrazione Breve (inline)
```markdown
> [!success] Dimostrazione: $\binom{n}{0}=1$
> $$\binom{n}{0}=\frac{n!}{0!\,(n-0)!}=\frac{n!}{1\cdot n!}=1$$
> $\blacksquare$
```

### Dimostrazione Estesa (multi-riga)
```markdown
> [!success] Dimostrazione: Passo induttivo
> Per dimostrare il passo induttivo partiamo dal primo membro della tesi induttiva:
> $$\sum_{i=1}^{n+1} i = \sum_{i=1}^{n} i + (n+1) \overset{\text{IP}}{=} \frac{n(n+1)}{2} + (n+1)$$
> L'ultimo membro è esattamente la tesi induttiva.
```

### Dimostrazione Come Link
```markdown
> [!Success] Dimostrazione:
> [[Dimostrazioni#2) Proprietà Di Archimede|Dimostrazione]]
```

### Conclusione Dimostrazione
```markdown
> [!success] Dimostrazione: Conclusione
> Sono verificati sia il passo base sia il passo induttivo.
> Per il principio di induzione:
> $$\{n\in\mathbb{N}\mid n\ge 1\}\subseteq A$$
> cioè la formula vale per ogni $n\ge 1$. $\blacksquare$
```

## 4.7 Callout Info — Schemi Ricorrenti

### Info Esplicativa ("In Parole")
```markdown
> [!info] Info: In Parole
> Dato un qualsiasi reale $x$ e una tolleranza $\varepsilon$, esiste un razionale...
```

### Info Tecnica
```markdown
> [!info] Info: Perché si può supporre M.C.D.$(m,n)=1$
> Ogni frazione si può ridurre ai minimi termini.
```

### Info Senza Titolo Specifico
```markdown
> [!Info] Info:
> Contenuto della nota
```

## 4.8 Callout Danger/Attenzione — Schemi Ricorrenti

### Avvertimento Generico
```markdown
> [!danger] Attenzione!
> Si parte dal **primo membro** della tesi induttiva.
```

### Avvertimento Con Titolo Lungo
```markdown
> [!danger] Attenzione! Non È Valida La Proprità Commutativa Sulla Differenza
> $A \setminus B \neq B \setminus A$
```

### Contraddizione (in dimostrazione per assurdo)
```markdown
> [!danger] Attenzione!
> $m$ e $n$ sono entrambi pari. Questo contraddice M.C.D.$(m,n)=1$. **Assurdo**.
```

## 4.9 Callout Example — Schemi Ricorrenti

```markdown
> [!example] Esempio: Operazione Di Unione
> $A = {1, 2, 3}, B = {3, 4} → A ∪ B = {1, 2, 3, 4}$
```

```markdown
> [!Example] Esempio: $f$, $g$, $h$ — suriettiva e iniettiva
> $$f: \mathbb{R} \to \mathbb{R}, \qquad x \mapsto x^2$$
> - **Non è suriettiva**: ...
```

## 4.10 Callout Note — Schemi Ricorrenti

Usato **raramente**, per note a margine generiche:
```markdown
> [!note] Intersezione e unione (diagrammi di Venn)
> - **Intersezione** $A\cap B$: la zona in comune...
```

___
# 5. LaTeX — Regole Generali

## 5.1 Inline vs Display

| Tipo | Sintassi | Quando si usa |
|------|----------|---------------|
| **Inline** | `$...$` | Dentro il testo, dentro titoli, dentro tabelle |
| **Display** | `$$...$$` | Formule importanti, definizioni formali, catene di uguaglianze |

**Regole:**
- Le **definizioni formali** sono SEMPRE in display mode `$$...$$`
- Le **formule intermedie** di una dimostrazione sono in display mode
- I **riferimenti brevi** (es. "con $n\ge 1$") sono inline
- Nei **titoli di sezione** si usa inline: `## Fattoriale di $n \in \mathbb{N}$: $n!$`
- Dentro i **callout** il display mode funziona normalmente con `$$...$$`

## 5.2 Comandi LaTeX Ricorrenti

### Insiemi numerici
```latex
\mathbb{N}    % Naturali
\mathbb{Z}    % Interi
\mathbb{Q}    % Razionali
\mathbb{R}    % Reali
\mathbb{C}    % Complessi
```

### Quantificatori e logica
```latex
\forall       % Per ogni
\exists       % Esiste
\exists!      % Esiste unico
\mid          % Tale che (barra verticale)
\Rightarrow   % Implica
\Leftarrow    % È implicato da
\Leftrightarrow  % Se e solo se
\Longrightarrow  % Implica (freccia lunga)
\neg          % Negazione
\land         % E (congiunzione)
\lor          % O (disgiunzione)
```

### Operazioni insiemistiche
```latex
\in           % Appartiene
\notin        % Non appartiene
\subseteq     % Sottoinsieme (lasco)
\subset       % Sottoinsieme proprio
\cap          % Intersezione
\cup          % Unione
\setminus     % Differenza
\times        % Prodotto cartesiano
\emptyset     % Insieme vuoto
```

### Funzioni e mappe
```latex
\to           % Freccia dominio->codominio
\mapsto       % Mappa elemento
\longmapsto   % Mappa elemento (freccia lunga)
\varphi       % Phi (nome funzione)
\psi          % Psi (nome funzione)
```

### Operatori e notazione
```latex
\sum_{i=1}^{n}    % Sommatoria
\prod_{i=1}^{n}   % Produttoria
\binom{n}{k}      % Coefficiente binomiale
\dbinom{n}{k}     % Coefficiente binomiale (display size in inline)
\frac{a}{b}       % Frazione
\dfrac{a}{b}      % Frazione display-size
\cdot             % Punto moltiplicazione
\cdots            % Puntini centrali
\dots             % Puntini
\ldots            % Puntini bassi
\qquad            % Spazio grande
\quad             % Spazio
\space            % Spazio singolo
\text{...}        % Testo dentro formula
\overset{...}{=}  % Testo sopra un operatore (usato per IP)
\underbrace{...}_{...}  % Parentesi graffa sotto
```

### Relazioni d'ordine
```latex
\le    \leq       % Minore uguale
\ge    \geq       % Maggiore uguale
\ne    \neq       % Diverso
:=                % Definito come
```

### Funzioni speciali
```latex
\lfloor x \rfloor   % Floor
\lceil x \rceil      % Ceil
\sqrt{x}             % Radice
\sup                 % Estremo superiore
\inf                 % Estremo inferiore
\max                 % Massimo
\min                 % Minimo
\mathrm{Im}          % Insieme immagine
```

### Parentesi
```latex
\left( ... \right)     % Parentesi tonde auto-size
\left\{ ... \right\}   % Parentesi graffe auto-size  
\big( ... \big)        % Parentesi grandi
\Big| ... \Big|        % Barre verticali grandi
```

## 5.3 Simboli Fine Dimostrazione

- **Q.E.D. standard**: `$\blacksquare$` — usato alla fine delle conclusioni
- Posizionamento: SEMPRE alla fine dell'ultima riga del callout di conclusione
- Esempio: `> cioè la formula vale per ogni $n\ge 1$. $\blacksquare$`

## 5.4 Annotazioni Sopra i Segni

Per indicare che un passaggio usa l'ipotesi induttiva:
```latex
\overset{\text{IP}}{=}     % Uguale con "IP" sopra
\overset{\text{IP}}{\geq}  % Maggiore-uguale con "IP" sopra
```

## 5.5 Convenzioni LaTeX Per Insiemi Numerici

- Inclusioni: `$\mathbb{N} \subseteq \mathbb{Z} \subseteq \mathbb{Q} \subseteq \mathbb{R}$`
- Esclusione: `$\mathbb{R} \setminus \mathbb{Q}$` (irrazionali)
- Con zero escluso: `$\mathbb{Q} \setminus \left\{0\right\}$`
- Semiretta: `$[0,+\infty)$`

## 5.6 Formule In Blocco Con Casi

```latex
$$
x = \sup(A)\Leftrightarrow
\begin{cases}
x \ge a \quad \forall a \in A \\
\forall \varepsilon > 0\ \ \exists\, \bar a \in A \mid \bar a > x -\varepsilon
\end{cases}
$$
```

## 5.7 Frecce e Connettivi

```latex
\Rightarrow       % ⇒ implicazione
\Longrightarrow   % ⟹ implicazione lunga
\Leftrightarrow   % ⟺ doppia implicazione
\longrightarrow   % → freccia lunga (usata per sostituzioni)
\implies          % ⇒ (alternativa)
\iff              % ⟺ (alternativa)
\boxed{...}       % Riquadro attorno alla formula (per risultati importanti)
```

___
# 6. Tabelle Markdown

## 6.1 Tabella Enunciato (Contesto/Ipotesi/Tesi)

Usata **dentro callout `[!abstract]`** per gli enunciati formali:

```markdown
> [!Abstract] Definizione: Enunciato
> | Parte        | Contenuto                         |
> | ------------ | --------------------------------- |
> | **Contesto** | Sia $x\in\mathbb{R}$              |
> | **Ipotesi**  | $x^2-2=0$                         |
> | **Tesi**     | Non esiste $x\in\mathbb{Q}$...     |
```

Variante con 3 colonne:
```markdown
| Passo | Cosa si fa |
|---|---|---|
| 1. | **Assunzione** | Si assume $A$ vera |
| 2. | **Deduzione**  | Da $A$ si ricavano passaggi... |
```

## 6.2 Tabelle Di Proprietà

```markdown
| Proprietà       | Formula                              |
| --------------- | ------------------------------------ |
| Commutativa     | $a+b=b+a$                            |
| Associativa     | $(a+b)+c=a+(b+c)$                    |
| Elemento neutro | $\exists e_0\in\mathbb{N}$ tale che... |
```

## 6.3 Tabelle Di Confronto/Riepilogo

```markdown
| Applicazione | Suriettiva | Iniettiva |
|---|:-:|:-:|
| $f: \mathbb{R} \to \mathbb{R}$ | ❌ | ❌ |
| $g: \mathbb{R} \to [0,+\infty)$ | ✅ | ❌ |
```

___
# 7. Metodo Di Procedere — Struttura Degli Appunti Per Argomento

## 7.1 File Argomenti (Cartella `Argomenti/`)

Questi sono i file **rielaborati e strutturati**. Ogni file corrisponde a un macro-argomento (es. `Insiemi.md`, `Funzioni (Applicazioni).md`, `Limiti.md`).

**Struttura tipo:**
1. Intestazione standard (Data, link, tag)
2. Index completo con sotto-sezioni
3. Separatore `___`
4. Per ogni concetto:
   - Titolo `#` o `##`
   - Callout `[!abstract] Definizione:` con la definizione formale
   - Eventuali callout annidati `[!info]`, `[!example]`, `[!danger]`
   - Se c'è una dimostrazione: callout `[!success]` con link al file `Dimostrazioni.md`
   - Separatore `___` tra macro-sezioni

**Caratteristiche:**
- Sono **puliti e strutturati**, non sono appunti grezzi
- Ogni definizione è in un callout `[!abstract]`
- Gli esempi sono in callout `[!example]`
- Le dimostrazioni brevi sono inline, quelle lunghe hanno un link a `Dimostrazioni.md`
- Le immagini sono referenziate con `![nome](nome.png)`

## 7.2 File Dimostrazioni

`Dimostrazioni.md` raccoglie **tutte le dimostrazioni** organizzate per tipo:

**Struttura:**
1. Intestazione standard
2. Index con tutti i titoli delle dimostrazioni
3. Macro-sezioni per tipo di dimostrazione:
   - `# Per Principio di Induzione`
   - `# Per Diretta`
   - `# Per Contraddizione`
   - `# Per Contrapposizione`
   - `# Per Doppia Implicazione`
4. Ogni dimostrazione segue lo **schema specifico** del metodo (vedi sezioni 12-13)

## 7.3 File Calcolanti

`Calcolanti.md` raccoglie **strumenti di calcolo** (fattoriale, coefficiente binomiale, ecc.):

**Struttura identica** ai file Argomenti, ma focalizzata su formule e proprietà con le relative dimostrazioni brevi.

## 7.4 File Lezioni (Cartella `Lezioni/`)

Questi sono gli **appunti presi a lezione**, più lineari e meno strutturati dei file Argomenti:

- Titolo: `# Analisi – Lezione N` oppure `# Analisi – Appunti`
- Separati da `---` (tre trattini) tra argomenti
- Usano meno callout e più testo discorsivo
- Servono come **fonte grezza** che poi viene rielaborata nei file Argomenti

> [!info] Info: Differenza tra Lezioni e Argomenti
> I file in `Lezioni/` sono appunti presi durante la lezione (più grezzi).
> I file in `Argomenti/` sono la rielaborazione strutturata.
> Le dimostrazioni complete vanno tutte in `Dimostrazioni.md`.

## 7.5 File Di Supporto

| File | Contenuto |
|------|-----------|
| `Simboli.md` | Tabella completa dei simboli LaTeX usati, organizzata per categoria |
| `Parole_Chiave.md` | Definizioni di termini chiave (assioma, proposizione, enunciato, teorema) |
| `Concetti_Dimostrativi.md` | Struttura dei metodi di dimostrazione con tabelle dei passi |
| `Esercizi.md` | Esercizi di ripasso |
| `Tabella_Di_Marcia.md` | Indice cronologico lezione per lezione |
| `COSE DA FARE.md` | Lista delle cose da completare |

___
# 8. Link Interni (Obsidian Wikilinks)

**Link a sezione nello stesso file:**
```markdown
[[#Nome Sezione]]
```

**Link a sezione in un altro file:**
```markdown
[[Dimostrazioni#1) L' Equazione $x^2 - 2$ Non Ha Soluzioni Razionali|Dimostrazione]]
```

**Link con testo alternativo:**
```markdown
[[#Titolo Con $LaTeX$|Titolo Leggibile]]
```

**Pattern ricorrente — Link a dimostrazione:**
```markdown
> [!Success] Dimostrazione:
> [[Dimostrazioni#2) Proprietà Di Archimede|Dimostrazione]]
```

> [!danger] Attenzione!
> Nei link con LaTeX, i caratteri speciali come `$`, `\`, `{`, `}` vengono spesso semplificati o rimossi nel link anchor. Il testo dopo `|` è la versione leggibile.

___
# 9. Separatori

| Separatore | Dove si usa |
|------------|-------------|
| `___` (3 underscore) | Tra macro-sezioni (`#`), dopo l'intestazione, dopo l'index, fine file |
| `---` (3 trattini) | Dentro i file Lezioni (tra argomenti diversi nella stessa lezione) |

**Regola:** nei file Argomenti e Dimostrazioni si usa `___`. Nei file Lezioni si usa `---`.

___
# 10. Immagini

```markdown
![Nome_Immagine.png](Nome_Immagine.png)
```

- Le immagini sono nella **stessa cartella** del file che le referenzia
- Il nome usa underscore e PascalCase: `Funzione_Floor_Ceil.png`
- Possono essere dentro callout:
  ```markdown
  > > [!Example] Esempio:
  > > ![Grafici_f_g_h_puliti.png](Grafici_f_g_h_puliti.png)
  ```

___
# 11. Regole Di Stile Generali

1. **Grassetto** per:
   - Parole chiave dentro definizioni: `**maggiorante**`, `**iniettiva**`
   - Nomi dei passi: `**Ipotesi induttiva (IP)**`, `**Tesi induttiva**`
   - Etichette: `**Contesto**`, `**Ipotesi**`, `**Tesi**`

2. **Corsivo** per:
   - Raramente usato, solo in note a margine discorsive

3. **Liste numerate** per:
   - Passi sequenziali dentro dimostrazioni: `**1. Si costruisce...**`, `**2. Si applica...**`
   - Proprietà numerate: `1.`, `2.`, ecc.

4. **Liste puntate** per:
   - Elenchi di proprietà non numerate
   - Primo/Secondo membro nelle verifiche: `- Primo membro: $...$`

5. **Formato "Passo numerato in grassetto"** dentro dimostrazioni:
   ```markdown
   **1. Si sceglie $q$ con Archimede**:
   $$\exists q \in \mathbb{N} ...$$
   
   **2. Si considera $qx$**:
   $$qx \in \mathbb{R}$$
   ```

6. **Non usare** emoji (✅, ❌ si usano solo nelle tabelle di confronto suriettiva/iniettiva).

___
# 12. Schema Completo — Dimostrazione Per Induzione

```markdown
## N) Nome Della Proprietà

### Enunciato
$\forall n\in\mathbb{N},\ n\ge p$
$$\text{Formula da dimostrare} \qquad (*)$$

### Passo base ($p=...$)

- Primo membro: $\displaystyle ...$
- Secondo membro: $\displaystyle ...$

> [!success] Dimostrazione: Passo base
> I due membri coincidono, quindi $p\in A$: il passo base è verificato.

### Passo induttivo

- **Ipotesi induttiva (IP)**: la formula vale per $n$
  $$\text{formula con } n$$
- **Tesi induttiva**: la formula vale per $n+1$

> [!info] Info: Come si scrive la tesi induttiva
> Si sostituisce $n$ con $n+1$ in $(*)$.
> ...
> **Tesi induttiva**:
> $$\text{formula con } n+1$$

> [!danger] Attenzione!
> Si parte dal **primo membro** della tesi induttiva e si arriva al **secondo**.

> [!success] Dimostrazione: Passo induttivo
> Per dimostrare il passo induttivo partiamo dal primo membro della tesi induttiva:
> $$\text{catena di uguaglianze con } \overset{\text{IP}}{=}$$
> L'ultimo membro è esattamente la tesi induttiva.

### Conclusione

> [!success] Dimostrazione: Conclusione
> Sono verificati sia il passo base sia il passo induttivo.
> Per il principio di induzione:
> $$\{n\in\mathbb{N}\mid n\ge p\}\subseteq A$$
> cioè la formula ... vale per ogni $n\ge p$. $\blacksquare$
```

___
# 13. Schema Completo — Dimostrazione Per Contraddizione

```markdown
## N) Nome Del Teorema

### Assunzione

> [!Abstract] Definizione: Enunciato
> | Parte        | Contenuto                   |
> | ------------ | --------------------------- |
> | **Contesto** | Sia $...$                   |
> | **Ipotesi**  | ...                         |
> | **Tesi**     | ...                         |

### Negazione

Si suppone per assurdo che la tesi sia falsa:
$$\text{negazione formale}$$

> [!info] Info: Perché si può supporre...
> Spiegazione della negazione

### Deduzione

**1. Primo passo**:
$$\text{formula}$$

**2. Secondo passo**:
...

### Assurdo

> [!danger] Attenzione!
> Risultato contraddittorio. **Assurdo**.

### Conclusione

> [!success] Dimostrazione: Conclusione
> L'ipotesi che ... porta a un assurdo, quindi è falsa.
> Dunque ... $\blacksquare$
```

___
# 14. Schema Completo — Definizione Con Callout Annidati

```markdown
> [!Abstract] Definizione: Nome Della Definizione
> $A \subseteq \mathbb{R}$, $A \ne \emptyset$
> 1. Prima parte della definizione: $$\text{formula}$$
> 2. Seconda parte della definizione: $$\text{formula}$$
>
> > [!Info] Info:
> > Spiegazione aggiuntiva
> > > [!Example] Esempio:
> > > Esempio concreto con numeri
>
> > [!Danger] Attenzione:
> > Cosa NON fare o errore comune
> > > [!Info] Info:
> > > Ulteriore chiarimento sul pericolo
>
> > [!Success] Dimostrazione:
> > Dimostrazione breve inline oppure:
> > [[Dimostrazioni#Titolo|Dimostrazione]]
```

___
# 15. Regole Per L'AI Che Trascrive

1. **SEMPRE** iniziare con l'intestazione standard a 4 righe
2. **SEMPRE** creare l'Index dopo l'intestazione
3. **Le definizioni formali** vanno SEMPRE in un callout `[!abstract] Definizione:`
4. **Le dimostrazioni** vanno SEMPRE in callout `[!success] Dimostrazione:`
5. **Gli avvertimenti** vanno SEMPRE in callout `[!danger] Attenzione!`
6. **Le spiegazioni "in parole"** vanno in callout `[!info] Info: In Parole`
7. **Gli esempi** vanno in callout `[!example] Esempio:`
8. **La tabella Contesto/Ipotesi/Tesi** va usata per ogni enunciato formale
9. **$\blacksquare$** va alla fine di ogni dimostrazione conclusa
10. **I separatori `___`** vanno tra macro-sezioni `#`
11. **I link alle dimostrazioni** usano il formato: `[[Dimostrazioni#Titolo|Dimostrazione]]`
12. **I passi numerati** nelle dimostrazioni usano grassetto: `**1. Descrizione**:`
13. **L'ipotesi induttiva** si abbrevia con **(IP)** e si annota con `\overset{\text{IP}}{=}`
14. **Mai** usare callout senza titolo tipo — il titolo ha SEMPRE il formato `Tipo: Titolo Specifico`
15. **Il LaTeX display** `$$...$$` va usato per tutte le formule importanti, non solo per quelle lunghe
16. **Le formule inline** $...$ vanno usate nel testo discorsivo e nei titoli
17. **Annidare i callout** quando serve spiegare o esemplificare una definizione
18. **Le dimostrazioni lunghe** vanno nel file `Dimostrazioni.md`, quelle brevi possono stare inline
19. **Il file Argomenti** deve essere autosufficiente: contiene definizioni, esempi, info. I link alle dimostrazioni puntano altrove solo se la prova è lunga
20. **Non semplificare** — ogni passaggio logico deve essere esplicitato con formule LaTeX
___

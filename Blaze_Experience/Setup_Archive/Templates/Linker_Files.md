<%*
// Configurazione: specifica eventuali percorsi da escludere (opzionale)
const excludePath = "Setup_Archive/"; 

// Recupera tutti i file Markdown (.md) del vault
const allFiles = app.vault.getMarkdownFiles();

// Filtra i file (esclude quelli nel percorso specificato e ordina alfabeticamente)
const files = allFiles
    .filter(f => !f.path.startsWith(excludePath))
    .sort((a, b) => a.basename.localeCompare(b.basename));

if (files.length === 0) {
    new Notice("Nessun file trovato nel vault.");
    return;
}

// Mostra il suggeritore con il path completo per chiarezza
const chosenFile = await tp.system.suggester(
    files.map(f => f.path), 
    files
);

if (!chosenFile) return;

// Codifica gli spazi per garantire la validità del link Markdown standard
// Sostituisce gli spazi con %20
const webSafePath = chosenFile.path.replace(/ /g, "%20");

// Output del link in formato Markdown []() partendo dalla radice
// Aggiungendo "/" all'inizio forzi la partenza dalla root in molti parser
tR += `[${chosenFile.basename}](${webSafePath})`;
%>
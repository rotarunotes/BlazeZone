<%*
// --- CONFIGURAZIONE ---
const vaultPath = "Setup_Archive/Viewable"; // Cartella radice della ricerca
const allFiles = app.vault.getFiles();

// Filtriamo i file che iniziano con il percorso specificato
const files = allFiles
  .filter(f => f.path.startsWith(vaultPath))
  .sort((a, b) => b.stat.mtime - a.stat.mtime); // Ordina per i più recenti

if (files.length === 0) {
  new Notice("Nessun file trovato in: " + vaultPath);
  return;
}

// Suggeritore: mostriamo il nome file e il percorso relativo interno
const chosenFile = await tp.system.suggester(
  files.map(f => f.path.replace(vaultPath + "/", "")),
  files
);

if (!chosenFile) return;

// --- LOGICA DEL PERCORSO RELATIVO ---
const currentFilePath = tp.file.path(true);
const targetPath = chosenFile.path;

// Funzione di Obsidian per ottenere il path relativo tra due file
const relativePath = app.metadataCache.getFirstLinkpathDest(targetPath, currentFilePath) 
  ? targetPath 
  : tp.obsidian.normalizePath(targetPath);

// Calcolo manuale del "backstep" (../) se preferisci link relativi puri al file system
const currentDepth = currentFilePath.split("/").length - 1;
const upSteps = "../".repeat(currentDepth);
const finalLink = upSteps + targetPath;

// --- FORMATTAZIONE OUTPUT ---
const isImage = ["png", "jpg", "jpeg", "gif", "webp", "svg"].includes(chosenFile.extension);
const isPdf = chosenFile.extension === "pdf";

// Se è un'immagine o PDF, aggiungiamo "!" per l'embed, altrimenti link standard
const prefix = (isImage || isPdf) ? "!" : "";
tR += `${prefix}[${chosenFile.name}](${finalLink})`;
%>
<%*
/**
 * OBSIDIAN MASTERMIND - UNIVERSAL GITHUB-FRIENDLY RELATIVE LINKER
 * Plugin richiesti: Templater
 */

// 1. Recupero di tutti i file del vault
const allFiles = app.vault.getFiles();

// 2. Interfaccia Utente: Suggester per la selezione del file
const selectedFile = await tp.system.suggester(
    (file) => `${file.basename}${file.extension !== 'md' ? '.' + file.extension : ''} (${file.path})`,
    allFiles
);

if (selectedFile) {
    const currentNotePath = tp.file.path(true);
    const targetFilePath = selectedFile.path;

    /**
     * 3. Logica di calcolo del percorso relativo
     */
    const getRelativePath = (from, to) => {
        const fromParts = from.split("/");
        const toParts = to.split("/");
        
        // Rimuoviamo il nome del file dal percorso di origine
        fromParts.pop();

        let i = 0;
        // Troviamo il punto di divergenza tra i due percorsi
        while (i < fromParts.length && i < toParts.length && fromParts[i] === toParts[i]) {
            i++;
        }

        // Calcoliamo quanti passi indietro (../) sono necessari
        const backsteps = fromParts.slice(i).map(() => "..").join("/");
        // Uniamo i passi indietro con la parte restante del percorso di destinazione
        const forwardSteps = toParts.slice(i).join("/");
        
        const finalPath = backsteps ? `${backsteps}/${forwardSteps}` : forwardSteps;
        // GitHub e i sistemi POSIX richiedono lo spazio codificato come %20
        return finalPath.replace(/ /g, "%20");
    };

    const relativePath = getRelativePath(currentNotePath, targetFilePath);

    /**
     * 4. Logica del Prefisso (Embed vs Link)
     */
    const embedExtensions = ["png", "jpg", "jpeg", "gif", "svg", "webp", "pdf"];
    const prefix = embedExtensions.includes(selectedFile.extension.toLowerCase()) ? "!" : "";

    // 5. Output finale in formato Markdown standard
    const fileName = selectedFile.basename + (selectedFile.extension !== 'md' ? '.' + selectedFile.extension : '');
    const markdownLink = `${prefix}[${fileName}](${relativePath})`;

    tR += markdownLink;
}
%>
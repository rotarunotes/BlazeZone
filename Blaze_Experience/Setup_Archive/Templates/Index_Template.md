<%*
// ============================================================
// CONFIGURAZIONE
// ============================================================
const CONFIG = {
  cartellaRadice: "",
  nomeReadme: "README.md",
  indentazione: "    ",
  mostraFileNascosti: false,
  escludiNotaCorrente: true,

  // Percorso della nota che contiene la sorting-spec (relativo alla root del vault)
  // Lascia "" per usare solo l'ordine alfabetico
  percorsoSortingSpec: "sorting-spec.md",
};

// ============================================================
// FUNZIONI PRINCIPALI
// ============================================================

const getRelativePath = (from, to) => {
  const fromParts = from.split("/");
  const toParts = to.split("/");
  fromParts.pop();
  let i = 0;
  while (i < fromParts.length && i < toParts.length && fromParts[i] === toParts[i]) {
    i++;
  }
  const backsteps = fromParts.slice(i).map(() => "..").join("/");
  const forwardSteps = toParts.slice(i).join("/");
  const finalPath = backsteps ? `${backsteps}/${forwardSteps}` : forwardSteps;
  return finalPath.replace(/ /g, "%20");
};

function ottieniCartellaRadice() {
  const vault = app.vault;
  if (CONFIG.cartellaRadice === "/") return vault.getRoot();
  if (CONFIG.cartellaRadice === "") {
    const notaCorrente = tp.file.find_tfile(tp.file.path(true));
    return vault.getAbstractFileByPath(notaCorrente.parent.path);
  }
  const cartella = vault.getAbstractFileByPath(CONFIG.cartellaRadice);
  if (!cartella) throw new Error(`Cartella non trovata: "${CONFIG.cartellaRadice}"`);
  return cartella;
}

// ============================================================
// SORTING-SPEC: PARSING E ORDINAMENTO
// ============================================================

/**
 * Legge il file sorting-spec e restituisce una mappa:
 *   { "percorso/cartella": ["README", "/sottocartella", "file", ...] }
 *
 * Gestisce sia la sintassi con target-folder globale ("*", "/*")
 * sia i target specifici per percorso esatto.
 */
async function caricaSortingSpec(percorsoSpec) {
  const fileSpec = app.vault.getAbstractFileByPath(percorsoSpec);
  if (!fileSpec) {
    console.warn(`[MOC] sorting-spec non trovata: "${percorsoSpec}"`);
    return {};
  }

  const contenuto = await app.vault.read(fileSpec);

  // Estrae il blocco frontmatter YAML grezzo
  const matchFrontmatter = contenuto.match(/^---\n([\s\S]*?)\n---/);
  if (!matchFrontmatter) return {};

  // Il valore di sorting-spec è un blocco multiriga indentato con 2 spazi
  // Estraiamo tutto ciò che segue "sorting-spec: |-" fino alla prossima chiave YAML
  const yamlRaw = matchFrontmatter[1];
  const matchSpec = yamlRaw.match(/sorting-spec:\s*\|-\n([\s\S]*?)(?=\n\S|$)/);
  if (!matchSpec) return {};

  const specRaw = matchSpec[1];

  // Splittiamo in blocchi separati da righe "  target-folder:"
  const blocchi = specRaw.split(/\n(?=  target-folder:)/);
  const mappa = {};

  for (const blocco of blocchi) {
    const matchTarget = blocco.match(/target-folder:\s*(.+)/);
    if (!matchTarget) continue;

    const cartellaTarget = matchTarget[1].trim();

    // Raccoglie le voci del blocco (righe con 4+ spazi di indentazione)
    const voci = [];
    const righe = blocco.split("\n").slice(1);
    for (const riga of righe) {
      const voce = riga.trim();
      // Ignora righe vuote, "..." (resto non specificato) e "%" (separatori)
      if (voce && voce !== "..." && voce !== "%") {
        voci.push(voce);
      }
    }

    mappa[cartellaTarget] = voci;
  }

  return mappa;
}

/**
 * Dato un percorso di cartella e la mappa della spec, restituisce
 * la lista di voci ordinata per quella cartella.
 *
 * Strategia di risoluzione (dalla più specifica alla più generica):
 *   1. Percorso esatto (es. "Puzzle_Of_Knowledge/Computer_Science")
 *   2. Pattern con wildcard "/*" (applica a tutti i figli diretti della root)
 *   3. Pattern globale "*" (applica a qualsiasi cartella)
 */
function trovaSpecPerCartella(percorsoCartella, specMappa) {
  // 1. Corrispondenza esatta
  if (specMappa[percorsoCartella]) return specMappa[percorsoCartella];

  // 2. Pattern "/*" → corrisponde a qualsiasi cartella di primo livello
  if (specMappa["/*"] && !percorsoCartella.includes("/")) {
    return specMappa["/*"];
  }

  // 3. Pattern globale "*"
  if (specMappa["*"]) return specMappa["*"];

  return null;
}

/**
 * Ordina i figli di una cartella secondo la sorting-spec.
 *
 * Nella spec:
 *   - "/sottocartella"  → identifica una cartella (prefisso "/")
 *   - "README"          → identifica un file per basename (senza estensione)
 *   - "NomeFile"        → identifica un file per basename
 *   - "..."             → segnaposto per "tutto il resto" (ordine alfabetico)
 *
 * Gli elementi non trovati nella spec vengono posizionati dove compare "..."
 * (o in fondo se "..." è assente).
 */
function ordinaConSpec(sottocartelle, files, percorsoCartella, specMappa) {
  const spec = trovaSpecPerCartella(percorsoCartella, specMappa);

  // Nessuna spec trovata → ordine alfabetico di default
  if (!spec) {
    return {
      sottocartelle: [...sottocartelle].sort((a, b) => a.name.localeCompare(b.name, "it")),
      files: [...files].sort((a, b) => a.name.localeCompare(b.name, "it")),
    };
  }

  // Posizione del segnaposto "..." nella spec (dove vanno gli elementi non listati)
  const indicePunti = spec.indexOf("...");
  const posizioneDefault = indicePunti !== -1 ? indicePunti : spec.length;

  /**
   * Calcola l'indice di posizione di un elemento nella spec.
   * Restituisce posizioneDefault se l'elemento non è listato esplicitamente.
   */
  const getPosizione = (elemento, isCartella) => {
    if (isCartella) {
      // Le cartelle nella spec sono precedute da "/" oppure scritte senza
      const idx = spec.indexOf(`/${elemento.name}`);
      if (idx !== -1) return idx;
      // Fallback: cerca anche senza prefisso "/"
      const idxNudo = spec.indexOf(elemento.name);
      if (idxNudo !== -1) return idxNudo;
    } else {
      // I file nella spec sono indicati per basename (senza .md)
      const idx = spec.indexOf(elemento.basename ?? elemento.name.replace(/\.[^.]+$/, ""));
      if (idx !== -1) return idx;
      // Fallback: cerca anche con estensione
      const idxConExt = spec.indexOf(elemento.name);
      if (idxConExt !== -1) return idxConExt;
    }
    return posizioneDefault;
  };

  const sortFn = (isCartella) => (a, b) => {
    const pa = getPosizione(a, isCartella);
    const pb = getPosizione(b, isCartella);
    if (pa !== pb) return pa - pb;
    // A parità di posizione (es. entrambi sotto "...") → alfabetico
    return a.name.localeCompare(b.name, "it");
  };

  return {
    sottocartelle: [...sottocartelle].sort(sortFn(true)),
    files: [...files].sort(sortFn(false)),
  };
}

// ============================================================
// GENERAZIONE INDICE
// ============================================================

async function generaIndice(cartella, livello, percorsoNota, specMappa) {
  const indent = CONFIG.indentazione.repeat(livello);
  let righe = [];

  const sottocartelle = [];
  const files = [];

  for (const elemento of cartella.children) {
    if (!CONFIG.mostraFileNascosti && elemento.name.startsWith(".")) continue;
    if (elemento.children !== undefined) {
      sottocartelle.push(elemento);
    } else {
      files.push(elemento);
    }
  }

  // Ordina usando la spec (o alfabeticamente se non disponibile)
  const ordinati = ordinaConSpec(sottocartelle, files, cartella.path, specMappa);

  // ----------------------------------------------------------
  // SOTTOCARTELLE
  // ----------------------------------------------------------
  for (const sotto of ordinati.sottocartelle) {
    const readme = sotto.children.find((f) => f.name === CONFIG.nomeReadme);

    let voceCartella;
    if (readme) {
      const percorsoRelativo = getRelativePath(percorsoNota, readme.path);
      const percorsoSenzaExt = percorsoRelativo.replace(/\.md$/, "");
      voceCartella = `${indent}- 📁 [${sotto.name}](${percorsoSenzaExt})`;
    } else {
      voceCartella = `${indent}- 📁 **${sotto.name}**`;
    }

    righe.push(voceCartella);

    const contenutoSotto = await generaIndice(sotto, livello + 1, percorsoNota, specMappa);
    if (contenutoSotto) righe.push(contenutoSotto);
  }

  // ----------------------------------------------------------
  // FILE
  // ----------------------------------------------------------
  const embedExtensions = ["png", "jpg", "jpeg", "gif", "svg", "webp", "pdf"];

  for (const file of ordinati.files) {
    if (file.name === CONFIG.nomeReadme) continue;
    if (CONFIG.escludiNotaCorrente && file.path === percorsoNota) continue;

    const percorsoRelativo = getRelativePath(percorsoNota, file.path);
    const ext = file.extension?.toLowerCase();
    const prefix = embedExtensions.includes(ext) ? "!" : "";

    const nomeVisualizzato = ext === "md"
      ? file.basename
      : `${file.basename}.${file.extension}`;

    const percorsoFinale = ext === "md"
      ? percorsoRelativo.replace(/\.md$/, "")
      : percorsoRelativo;

    righe.push(`${indent}- ${prefix}[${nomeVisualizzato}](${percorsoFinale})`);
  }

  return righe.join("\n");
}

// ============================================================
// PUNTO DI INGRESSO
// ============================================================
try {
  const percorsoNota = tp.file.path(true);
  const cartellaInizio = ottieniCartellaRadice();

  // Carica la mappa di ordinamento dalla sorting-spec
  const specMappa = CONFIG.percorsoSortingSpec
    ? await caricaSortingSpec(CONFIG.percorsoSortingSpec)
    : {};

  const intestazione = [
    `# Start Index`,
    "",
  ].join("\n");

  const indice = await generaIndice(cartellaInizio, 0, percorsoNota, specMappa);

  tR += intestazione + (indice || "_Nessun contenuto trovato._");

} catch (errore) {
  tR += `> [!error] Errore nella generazione del MOC\n> ${errore.message}`;
}
%>
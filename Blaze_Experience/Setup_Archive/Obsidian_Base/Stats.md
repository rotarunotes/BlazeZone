creato: 2026-05-22
up: [[Meta]]
#tipo/meta
___
## Dashboard e statistiche
Questa pagina raccoglie statistiche, metriche e informazioni dinamiche sullo stato del vault.
___

## Registro attività
```contributionGraph
title: Attività 2026
graphType: default
dateRangeValue: 180
dateRangeType: FIXED_DATE_RANGE
startOfWeek: "1"
showCellRuleIndicators: true
titleStyle:
  textAlign: left
  fontSize: 20px
  fontWeight: normal
dataSource:
  type: PAGE
  value: ""
  dateField:
    type: FILE_MTIME
  filters: []
  countField:
    type: DEFAULT
fillTheScreen: false
enableMainContainerShadow: false
fromDate: 2026-01-01
toDate: 2026-12-31
cellStyleRules:
  - id: Ocean_a
    color: "#8dd1e2"
    min: 1
    max: 2
  - id: Ocean_b
    color: "#63a1be"
    min: 2
    max: 3
  - id: Ocean_c
    color: "#376d93"
    min: 3
    max: 5
  - id: Ocean_d
    color: "#012f60"
    min: 5
    max: 9999
cellStyle:
  borderRadius: 50%
  minWidth: 10px
  minHeight: 10px

```

___

## Stato vault
### Stato generale
```dataviewjs
// SCRIPT GENERATO DA AI

const pages = dv.pages();
const allFiles = app.vault.getFiles();

// ======================
// TOTALE FILE (TUTTO IL VAULT)
// ======================
const totalFiles = allFiles.length;

// ======================
// NOTE (solo markdown)
// ======================
const notes = allFiles.filter(f => f.extension === "md");

// ======================
// ALLEGATI (tutti i NON md)
// ======================
const attachments = allFiles.filter(f => f.extension !== "md");

// ======================
// NOTE ISOLATE
// ======================
const isolated = pages.filter(p =>
  (!p.file.outlinks || p.file.outlinks.length === 0)
).length;

// ======================
// NOTE SENZA TAG
// ======================
const noTags = pages.filter(p =>
  (!p.file.tags || p.file.tags.length === 0)
).length;

// ======================
// UI
// ======================
const container = this.container;
container.innerHTML = "";

// ======================
// TABELLA (con "padding finto" nei titoli)
// ======================
const table = document.createElement("table");

table.innerHTML = `
<tr>
  <th>Categoria</th>
  <th>Conteggio</th>
</tr>

<tr>
  <td>File totali (vault)</td>
  <td>${totalFiles}</td>
</tr>

<tr>
  <td>Note totali</td>
  <td>${notes.length}</td>
</tr>

<tr>
  <td>Allegati (file non-md)</td>
  <td>${attachments.length}</td>
</tr>

<tr>
  <td>Note isolate</td>
  <td>${isolated}</td>
</tr>

<tr>
  <td>Note senza tag</td>
  <td>${noTags}</td>
</tr>
`;

container.appendChild(table);
```

### Note per sezione
#### Tabella
```dataviewjs
// SCRIPT GENERATO DA AI

const sections = [
  "1 Conoscenza",
  "2 Ricerca",
  "3 Applicazione",
  "4 Personale",
  "5 Archivio"
];

// ======================
// DATI BASE
// ======================
const data = sections.map(s => ({
  name: s,
  count: dv.pages(`"${s}"`).length
}));

const total = data.reduce((a, b) => a + b.count, 0);

// percentuali
data.forEach(d => d.perc = total ? (d.count / total * 100).toFixed(1) : 0);

// ======================
// UI CONTAINER
// ======================
const container = this.container;
container.innerHTML = "";

// ======================
// TABELLA PERCENTUALI
// ======================
const table = document.createElement("table");
table.style.marginTop = "10px";

table.innerHTML = `
<tr><th>Sezione</th><th>Note</th><th>%</th></tr>
${data.map(d => `
<tr>
<td>${d.name}</td>
<td>${d.count}</td>
<td>${d.perc}%</td>
</tr>
`).join("")}
`;

container.appendChild(table);
```

#### Grafico a barre
```dataviewjs
// SCRIPT GENERATO DA AI

const sections = [
  "1 Conoscenza",
  "2 Ricerca",
  "3 Applicazione",
  "4 Personale",
  "5 Archivio"
];

const labels = sections;
const values = sections.map(s => dv.pages(`"${s}"`).length);

const container = this.container;
container.innerHTML = "";

const canvas = document.createElement("canvas");
container.appendChild(canvas);

// carica Chart.js se non esiste
if (typeof window.Chart === "undefined") {
  const script = document.createElement("script");
  script.src = "https://cdn.jsdelivr.net/npm/chart.js";
  script.onload = () => draw();
  document.head.appendChild(script);
} else {
  draw();
}

function draw() {
  new Chart(canvas, {
    type: "bar",
    data: {
      labels,
      datasets: [{
        label: "Note per sezione",
        data: values
      }]
    }
  });
}
```

#### Grafico a torta
```dataviewjs
// SCRIPT GENERATO DA AI

const sections = [
  "1 Conoscenza",
  "2 Ricerca",
  "3 Applicazione",
  "4 Personale",
  "5 Archivio"
];

// dati
const labels = sections;
const values = sections.map(s => dv.pages(`"${s}"`).length);

// container
const container = this.container;
container.innerHTML = "";

// wrapper identico al secondo script
const wrapper = document.createElement("div");
wrapper.style.width = "350px";
wrapper.style.height = "350px";
wrapper.style.margin = "0 auto";
wrapper.style.position = "relative";
container.appendChild(wrapper);

// canvas
const canvas = document.createElement("canvas");
canvas.style.width = "100%";
canvas.style.height = "100%";
wrapper.appendChild(canvas);

// funzione disegno
function draw() {
  new Chart(canvas, {
    type: "doughnut",
    data: {
      labels,
      datasets: [{
        label: "Note per sezione",
        data: values
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "right"
        }
      }
    }
  });
}

// fallback Chart.js se non presente
if (typeof window.Chart === "undefined") {
  const script = document.createElement("script");
  script.src = "https://cdn.jsdelivr.net/npm/chart.js";
  script.onload = () => draw();
  document.head.appendChild(script);
} else {
  draw();
}
```

### Tipi di allegati
```dataviewjs
// SCRIPT GENERATO DA AI

const files = app.vault.getFiles();

// ======================
// FILTRA SOLO ALLEGATI
// ======================
const attachments = files.filter(f => f.extension !== "md");

// ======================
// RAGGRUPPA PER ESTENSIONE
// ======================
const counts = {};

for (let f of attachments) {
  const ext = (f.extension || "unknown").toLowerCase();
  counts[ext] = (counts[ext] || 0) + 1;
}

// ordina per frequenza
const sorted = Object.entries(counts)
  .sort((a, b) => b[1] - a[1]);

const labels = sorted.map(x => x[0]);
const values = sorted.map(x => x[1]);

// ======================
// UI
// ======================
const container = this.container;
container.innerHTML = "";

// wrapper più piccolo
const wrapper = document.createElement("div");
wrapper.style.maxWidth = "350px";
wrapper.style.margin = "0 auto";
container.appendChild(wrapper);

// canvas
const canvas = document.createElement("canvas");
canvas.style.maxWidth = "350px";
canvas.style.maxHeight = "350px";
wrapper.appendChild(canvas);

// ======================
// CHART
// ======================
function draw() {
  new Chart(canvas, {
    type: "doughnut",
    data: {
      labels,
      datasets: [{
        data: values
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: true,
      plugins: {
        legend: {
          position: "right"
        }
      }
    }
  });
}

// ======================
// LOAD CHART.JS SE NECESSARIO
// ======================
if (typeof window.Chart === "undefined") {
  const script = document.createElement("script");
  script.src = "https://cdn.jsdelivr.net/npm/chart.js";
  script.onload = () => draw();
  document.head.appendChild(script);
} else {
  draw();
}
```


### Analisi spazio vault
#### Spazio occupato
```dataviewjs
// SCRIPT GENERATO DA AI

const files = app.vault.getFiles();

// totale spazio vault
const totalBytes = files.reduce((sum, f) => sum + (f.stat.size || 0), 0);

// aggregazione per estensione
const stats = {};

for (let f of files) {
  const ext = (f.extension || "unknown").toLowerCase();
  const size = f.stat.size || 0;

  if (!stats[ext]) {
    stats[ext] = { count: 0, bytes: 0 };
  }

  stats[ext].count += 1;
  stats[ext].bytes += size;
}

const sorted = Object.entries(stats)
  .sort((a, b) => b[1].bytes - a[1].bytes);

function formatBytes(bytes) {
  if (!bytes) return "0 B";
  const k = 1024;
  const sizes = ["B", "KB", "MB", "GB", "TB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return (bytes / Math.pow(k, i)).toFixed(2) + " " + sizes[i];
}

const container = this.container;
container.innerHTML = "";

// spazio totale
const totalBox = document.createElement("div");
totalBox.innerHTML = `<b>Spazio totale vault:</b> ${formatBytes(totalBytes)}`;
totalBox.style.marginBottom = "10px";
container.appendChild(totalBox);

// tabella
const table = document.createElement("table");

table.innerHTML = `
<tr>
  <th>Tipo file</th>
  <th>Numero</th>
  <th>Spazio</th>
</tr>

${sorted.map(([ext, data]) => `
<tr>
  <td>.${ext}</td>
  <td>${data.count}</td>
  <td>${formatBytes(data.bytes)}</td>
</tr>
`).join("")}
`;

container.appendChild(table);
```
#### Tipi di file più pesanti
```dataviewjs
// SCRIPT GENERATO DA AI

const files = app.vault.getFiles();

// aggregazione per estensione
const stats = {};

for (let f of files) {
  const ext = (f.extension || "unknown").toLowerCase();
  const size = f.stat.size || 0;

  if (!stats[ext]) {
    stats[ext] = { bytes: 0 };
  }

  stats[ext].bytes += size;
}

const sorted = Object.entries(stats)
  .sort((a, b) => b[1].bytes - a[1].bytes);

const labels = sorted.map(x => x[0]);
const values = sorted.map(x => x[1].bytes);

// container
const container = this.container;
container.innerHTML = "";

// wrapper piccolo
const wrapper = document.createElement("div");
wrapper.style.maxWidth = "350px";
wrapper.style.margin = "0 auto";
container.appendChild(wrapper);

// canvas
const canvas = document.createElement("canvas");
canvas.style.maxWidth = "350px";
canvas.style.maxHeight = "350px";
wrapper.appendChild(canvas);

function draw() {
  new Chart(canvas, {
    type: "doughnut",
    data: {
      labels,
      datasets: [{
        data: values
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: true,
      plugins: {
        legend: {
          position: "right"
        }
      }
    }
  });
}

// load Chart.js se serve
if (typeof window.Chart === "undefined") {
  const script = document.createElement("script");
  script.src = "https://cdn.jsdelivr.net/npm/chart.js";
  script.onload = () => draw();
  document.head.appendChild(script);
} else {
  draw();
}
```
#### Top 10 file più pesanti
```dataviewjs
// SCRIPT GENERATO DA AI

const files = app.vault.getFiles();

// ======================
// FORMAT BYTES
// ======================
function formatBytes(bytes) {
  if (!bytes) return "0 B";
  const k = 1024;
  const sizes = ["B", "KB", "MB", "GB", "TB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return (bytes / Math.pow(k, i)).toFixed(2) + " " + sizes[i];
}

// ======================
// ORDINA FILE PER PESO
// ======================
const sorted = files
  .map(f => ({
    name: f.name,
    path: f.path,
    size: f.stat.size || 0,
    ext: f.extension
  }))
  .sort((a, b) => b.size - a.size)
  .slice(0, 10);

// ======================
// UI
// ======================
const container = this.container;
container.innerHTML = "";

const table = document.createElement("table");

table.innerHTML = `
<tr>
  <th>File</th>
  <th>Tipo</th>
  <th>Peso</th>
</tr>

${sorted.map(f => `
<tr>
  <td>${f.name}</td>
  <td>.${f.ext || "unknown"}</td>
  <td>${formatBytes(f.size)}</td>
</tr>
`).join("")}
`;

container.appendChild(table);
```

#### Top 10 note più pesanti
```dataviewjs
// SCRIPT GENERATO DA AI

const files = app.vault.getFiles();

// ======================
// FORMAT BYTES
// ======================
function formatBytes(bytes) {
  if (!bytes) return "0 B";
  const k = 1024;
  const sizes = ["B", "KB", "MB", "GB", "TB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return (bytes / Math.pow(k, i)).toFixed(2) + " " + sizes[i];
}

// ======================
// FILTRA SOLO NOTE MARKDOWN
// ======================
const notes = files
  .filter(f => f.extension === "md")
  .map(f => ({
    name: f.name,
    path: f.path,
    size: f.stat.size || 0
  }));

// ======================
// ORDINA PER PESO
// ======================
const sorted = notes
  .sort((a, b) => b.size - a.size)
  .slice(0, 10);

// ======================
// UI
// ======================
const container = this.container;
container.innerHTML = "";

const table = document.createElement("table");

table.innerHTML = `
<tr>
  <th>Nota</th>
  <th>Peso</th>
</tr>

${sorted.map(n => `
<tr>
  <td>${n.name}</td>
  <td>${formatBytes(n.size)}</td>
</tr>
`).join("")}
`;

container.appendChild(table);
```

___

## Attività recenti
### Ultime note modificate
```dataview
TABLE dateformat(file.mtime, "dd MMMM yyyy - HH:mm") as "Ultima modifica"
SORT file.mtime DESC
LIMIT 20
```

### Ultime note create
```dataview
TABLE dateformat(file.mtime, "dd MMMM yyyy - HH:mm") as "Creazione"
SORT file.ctime DESC
LIMIT 20
```

___

## Collegamenti
### Note con più back-links
```dataview
TABLE length(file.inlinks) as "Backlinks"
SORT length(file.inlinks) DESC
LIMIT 20
```

### Note con più out-links
```dataview
TABLE length(file.outlinks) as "Outlinks"
SORT length(file.outlinks) DESC
LIMIT 20
```

## Discarica
### Note isolate
```dataview
LIST
WHERE length(file.inlinks) = 0 AND length(file.outlinks) = 0
```

### Note senza tag
```dataview
LIST
WHERE !file.tags
```

### I più vecchi file modificati
```dataview
TABLE file.mtime as "Ultima Modifica"
SORT file.mtime ASC
LIMIT 20
```

___

## Conoscenza
...
___

## Ricerca
...
___

## Progetti 
...
___

##  Personale
...
___

## Archivio
...
___

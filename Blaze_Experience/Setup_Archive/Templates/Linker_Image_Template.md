<%*
const vaultPath = "Setup_Archive/Viewable/Image";
const imgExts = ["png", "jpg", "jpeg", "gif", "webp", "svg"];

const allFiles = app.vault.getFiles();
const images = allFiles
  .filter(f => f.path.startsWith(vaultPath) && imgExts.includes(f.extension))
  .map(f => f.path);

if (images.length === 0) {
  new Notice("Nessuna immagine trovata in " + vaultPath);
  return;
}

const chosen = await tp.system.suggester(
  images.map(p => p.replace(vaultPath + "/", "")),
  images
);

if (!chosen) return;

const depth = tp.file.path(true).split("/").length - 1;
const up = Array(depth).fill("..").join("/");
const link = (up ? up + "/" : "") + chosen;
tR += "![" + chosen.split("/").pop() + "](" + link + ")";
%>
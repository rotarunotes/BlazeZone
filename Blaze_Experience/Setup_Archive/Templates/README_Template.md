Data: <% tp.date.now() %>
[<%* const parentFolder = tp.file.find_tfile(tp.file.path(true)).parent.parent; tR += parentFolder ? parentFolder.name : "Nessun padre"; %>](./README.md)
#<% tp.file.folder(true) %>
___
# <% tp.file.folder() %>
Di cosa parla questa MOC.
___
# Indice
<%*
const activeFile = tp.file.find_tfile(tp.file.path(true));
const currentFolderObj = activeFile.parent;

const subfolders = currentFolderObj.children.filter(f => f.children !== undefined);
const files = currentFolderObj.children.filter(f => f.children === undefined && f.name !== activeFile.name);

let output = "";

if (subfolders.length > 0) { output += subfolders.map(f => `* [${f.name}](${f.name}/README.md)`).join("\n"); output += "\n"; }

if (files.length > 0) {
    output += files.map(f => `* [${f.basename}](./${f.name})`).join("\n");
}

tR += output || "_Nessun contenuto_";
%>

___

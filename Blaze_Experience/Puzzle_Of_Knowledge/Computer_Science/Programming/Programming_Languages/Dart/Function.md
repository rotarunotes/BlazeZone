Data: 2025-10-19
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Sintassi
## Normale
1. **Tipo di Ritorno**: Il tipo di dato che la funzione "restituisce" alla fine. Se non restituisce nulla, si usa void.
2. **Nome**: Il nome che userai per "chiamare" (eseguire) la funzione.
3.  **Parametri**: parametri della funzione
4. **Corpo**: Il blocco di codice (racchiuso tra parentesi graffe) che viene eseguito quando la funzione è chiamata.
5.  **Return**: La parola chiave che invia il risultato finale fuori dalla funzione.

``` Dart
//  (1)    (2)        (3)
String saluta(String nome) {
  // (4)
  String messaggio = "Ciao, $nome! Benvenuto.";
  return messaggio; // (5)
}
```

## Arrow (Funzioni abbreviate)

``` Dart
// Versione lunga:
int somma(int a, int b) {
  return a + b;
}
// Versione "Arrow":
int somma(int a, int b) => a + b;
```

## Esempi di sintassi con ?
### Operatore Ternario
- È un if.

``` Dart
// Funzione standard (lunga)
bool eMaggiorenne(int eta) {
  if (eta >= 18) {
    return true;
  } else {
    return false;
  }
}
// Funzione arrow (corta) con operatore ternario
bool eMaggiorenneArrow(int eta) => eta >= 18 ? true : false;
```

### Operatore Null-Coalescing
- Ti permette di restituire un valore di default nel caso il return della funzione dia null.

``` Dart
String? nomeUtente; // Immagina che questo valore possa essere null

// Funzione (lunga)
String getNomeDisplay() {
  if (nomeUtente != null) {
    return nomeUtente!;
  } else {
    return "Ospite";
  }
}

// Funzione arrow (corta) con operatore '??'
// "Ritorna 'nomeUtente', ma se è null, ritorna 'Ospite'"
String getNomeDisplayArrow() => nomeUtente ?? "Ospite";

void main() {
  print(getNomeDisplayArrow()); // Output: Ospite

  nomeUtente = "Mario";
  print(getNomeDisplayArrow()); // Output: Mario
}
```

### Tipo di ritorno Nullable
- Indica che la funzione potrebbe restituire null.

``` Dart
Map<int, String> utenti = {
  1: "Anna",
  2: "Bruno"
};

String? trovaUtente(int id) => utenti[id];

void main() {
  print(trovaUtente(1)); // Output: Anna
  print(trovaUtente(5)); // Output: null
}
```

## Funzioni Anonime (Lamba)
- Sono funzioni che **non hanno un nome**. Vengono usate "al volo", spesso come parametri per altre funzioni (un concetto fondamentale in Dart).

``` Dart
void main() {
  List<String> nomi = ["anna", "bruno", "carlo"];

  // Esempio: forEach vuole una funzione come parametro.
  // Noi gli passiamo una funzione anonima: (nome) { ... }
  nomi.forEach((nome) {
    print(nome.toUpperCase());
  });
}

/*
Output:
ANNA
BRUNO
CARLO
*/
```

___
# Tipi di parametri
## Parametri Posizionali Obbligatori
- Sono i parametri standard. Devi fornirli nell'ordine esatto in cui sono definiti.

``` Dart
// Sia 'nome' che 'eta' sono obbligatori
void infoPersona(String nome, int eta) {
  print("$nome ha $eta anni.");
}

infoPersona("Mario", 30); // OK
// ❌ Errore di complilazione
infoPersona(30, "Mario");
```

## Parametri Named (Nominali)
- Sono racchiusi tra { }  e sono **opzionali** per impostazione predefinita. Quando li chiami, specifichi il loro nome, quindi l'ordine non conta.
- Sono impostati a null di default.

``` Dart
// 'nome' e 'eta' sono "named" e opzionali (nullable)
void infoPersona({String? nome, int? eta}) {
  print("$nome ha $eta anni.");
}

infoPersona(eta: 30, nome: "Anna"); // OK
infoPersona(nome: "Luigi"); // OK (eta sarà null)
infoPersona(eta: 25); // OK (nome sarà null)
infoPersona(); // OK (entrambi null)
```

### Valori di default
- Puoi dare un valore predefinito a un parametro "named" per evitare che sia **null**.

``` Dart
// Se 'ruolo' non viene fornito, sarà "Utente"
void creaUtente({String ruolo = "Utente"}) {
  print("Ruolo: $ruolo");
}

creaUtente(); // Output: ruolo: Utente
creaUtente(ruolo: "Amministratore"); //ruolo: Amministratore
```

### Required
- Se vuoi che un parametro "named" sia **obbligatorio**.

``` Dart
// 'nome' è "named" ma OBBLIGATORIO
void infoPersona({required String nome, int? eta}) {
  print("$nome ha $eta anni.");
}

infoPersona(nome: "Sara"); // OK
// ❌ Errore di complilazione
infoPersona(eta: 40);
```

## Parametri Posizioni Opzionali
- Si racchiudono tra [ ]. Devono essere **nullable** o avere un valore di default.

``` Dart
void saluta(String nome, [String? saluto]) {
  saluto = saluto ?? "Ciao"; // Se saluto è null, usa "Ciao"
  print("$saluto, $nome");
}

saluta("Eva"); // Output: Ciao, Eva
saluta("Luca", "Buongiorno"); // Output: Buongiorno, Luca
```

___
# Funzioni
## print();
- Funzione di stampa
``` Dart
String nome = "Mario";
int eta = 30;
double altezza = 1.75;
// Variabili semplici con $
print("Ciao, il mio nome è $nome e ho $eta anni.");
// Espressioni complesse con ${...}
print("Il prossimo anno avrò ${eta + 1} anni.");
// Chiamata a metodi o proprietà di un oggetto
print("Il mio nome in maiuscolo è ${nome.toUpperCase()}.");
```
## .ceil()
- Arrotonda un double al primo intero superiore
``` Dart
double x = 3.1;
print(x.ceil());
```

**Output:**
``` 
4

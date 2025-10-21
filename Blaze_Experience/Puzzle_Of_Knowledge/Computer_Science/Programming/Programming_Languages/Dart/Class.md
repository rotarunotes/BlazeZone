Data: 2025-10-19
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
#  Sintassi base
``` Dart
class Veicolo {
  // Proprietà
  String marca;
  String modello;
  int anno;

  // Metodo
  void stampaDettagli() {
    print("Veicolo: $marca $modello Anno: $anno");
  } 
}
```
___
# 4 Costruttori
## Costruttori chiamato come la classe
- Il suo scopo è ricevere dei valori e assegnarli alle proprietà della classe.

``` Dart
Veicolo(String marca, String modello, int anno) {
	  this.marca = marca;
	  this.modello = modello;
	  this.anno = anno;
}

// versione corta
Veicolo(this.marca, this.modello, this.anno);

// main() 
var auto = Veicolo("Fiat", "Panda", 2023);
auto.stampaDettagli(); // Output: Veicolo: Fiat Panda Anno: 2023
```

## Costruttore col Nome
- Ti permette di creare "ricette" alternative per costruire il tuo oggetto, dando loro un nome.

``` Dart
// Usa una "initializer list" (:) per impostare i campi prima che il corpo del costruttore venga eseguito.
Veicolo.nuovo(this.marca, this.modello) : anno = DateTime.now().year; 
Veicolo.epoca(this.marca, this.modello) : anno = 1970;

// main()
var autoNuova = Veicolo.nuovo("Tesla", "Model Y");
autoNuova.stampaDettagli(); // Output: Veicolo: Tesla Model Y Anno: 2025

var autoEpoca = Veicolo.epoca("Ford", "Mustang");
autoEpoca.stampaDettagli(); // Output: Veicolo: Ford Mustang Anno: 1970
```

## Costruttore Costante
- Si usa per creare oggetti che sono **costanti a tempo di compilazione**. Per farlo, tutte le proprietà della classe devono essere **final** e il costruttore deve essere marcato come **const**.
- Questo è importantissimo in Flutter per ottimizzare le performance (i widget **const** non vengono ricostruiti inutilmente).

``` Dart
class VeicoloConst {
  // Per 'const', le proprietà DEVONO essere 'final'
  final String marca;
  final String modello;
  final int anno;
  
  // Il costruttore principale ora è 'const'
  const VeicoloConst(this.marca, this.modello, this.anno);

  // Anche i "Named" possono essere 'const'
  const VeicoloConst.epoca(this.marca, this.modello) : anno = 1970;

  void stampaDettagli() {
    print("Veicolo: $marca $modello Anno: $anno"); 
  }
}
```

## Costruttore Factory
- È un costruttore speciale che **non è obbligato a creare una nuova istanza** della sua classe.
- È molto potente e si usa principalmente per:
	1. Restituire un'istanza già esistente da una cache (Pattern Singleton).
	2. Restituire un'istanza di una **sottoclasse** (decidendo quale in base ai parametri).
	3. Gestire logica complessa prima della creazione (es. parsare un JSON).

``` Dart
void main() {
  // 1. Costruttore Generativo
  var auto = Veicolo("Fiat", "Panda", 2023);
  auto.stampaDettagli(); // Output: Veicolo: Fiat Panda (Anno: 2023)

  // 2. Costruttore "Named"
  var autoNuova = Veicolo.nuovo("Tesla", "Model Y");
  autoNuova.stampaDettagli(); // Output: Veicolo: Tesla Model Y (Anno: 2025)

  // 3. Costruttore "Factory"
  var veicoloFactory = Veicolo.daMarca("Honda", "Civic");
  veicoloFactory.stampaDettagli(); // Output: Veicolo: Honda Civic (Anno: 2024)
}

class Veicolo {
  String marca;
  String modello;
  int anno;

  // 1. Costruttore Generativo (Principale)
  Veicolo(this.marca, this.modello, this.anno);

  // 2. Costruttore "Named"
  Veicolo.nuovo(this.marca, this.modello)
      : anno = DateTime.now().year;

  // 3. Costruttore "Factory"
  factory Veicolo.daMarca(String marca, String modello) {
    if (marca == "Honda") {
      return Veicolo(marca, modello, 2024);
    } else {
      return Veicolo(marca, modello, 2022);
    }
  }

  void stampaDettagli() {
    print("Veicolo: $marca $modello (Anno: $anno)");
  }
}
```

___


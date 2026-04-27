---
toc: true
---

## Caratteristiche principali

| **Caratteristica**            | **Descrizione**                                                   |
| ----------------------------- | ----------------------------------------------------------------- |
| Esperimento aleatorio         | fenomeno il cui *esito* non può essere previsto prima che avvenga |
| Spazio campionario ($\Omega$) | insieme di tutti i possibili *esiti* di un esperimento aleatorio  |
| Evento                        | ogni sottoinsieme dello spazio campionario                        |

## Probabilità

Rapporto fra il numero dei casi favorevoli *f* e quello dei casi possibili *u*, quando sono tutti ugualmente possibili.
$$p(E)=\frac{f}{u}$$

> [!abstract] Proprietà
> - Evento certo: **$p(E) = 1$**
> - Evento contrario: **$p(\overline E)=1-p(E)$**
> - Evento impossibile: **$p(E) = 0$**
> - Un evento è compreso tra 0 e 1: **$0 \leq p(E) \leq 1$**
> - La somma della probabilità di tutti gli eventi è 1: **$p(E_1) + p(E_2) + ... + p(E_n) = 1$**
> - $se \space E_{1} \cap E_{2} = \emptyset, allora \space p(E_{1} \cup E_{2}) = p(E_{1}) + p(E_{2})$


| **Compatibili**                                                                                                                                                         | **Incompatibili**                                                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Se il verificarsi si uno ***include*** il verificarsi contemporaneo dell'altro<br>$$E_1 \cap E_2 \neq \emptyset$$                                                       | se il verificarsi di uno ***esclude*** il verificarsi contemporaneo dell'altro<br>$$E_1 \cap E_2 = \emptyset$$                                          |
| Estraiamo una pallina da un'urna contenente 12 palline<br>$E_1 =$ «esce un numero pari»<br>$E_2 =$ «esce un numero maggiore di 7»<br><br>$$E_1 \cap E_2 = {8, 10, 12}$$ | Estraiamo una pallina da un'urna contenente 12 palline<br>$E_3 =$ «esce il numero 2»<br>$E_4 =$ «esce il numero 10»<br><br>$$E_3 \cap E_4 = \emptyset$$ |

| **Dipendenti**                                                                                                                                                                                                                                                                                                                      | **Indipendenti**                                                                                                                                                                                                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Se il verificarsi di uno ***influenza*** la probabilità di verificarsi dell'altro<br>$$p(E_1\|E_2) \neq p(E_2)$$<br>$$p(E_1 \cap E_2) = p(E_1) \cdot p(E_2\|E_1)$$                                                                                                                                                                  | Se il verificarsi di uno **non *influenza*** la probabilità di verificarsi dell'altro<br>$$p(E_1\|E_2) = p(E_2)$$<br>$$p(E_1 \cap E_2) = p(E_1) \cdot p(E_2)$$                                                                                                       |
| Un'urna contiene 3 palline rosse e 2 blu. Estraggo 2 palline senza reinserimento<br><br>$E_1 =$ "la prima pallina è rossa"<br>$p(E_1) = \frac{3}{5}$<br><br>$E_2 =$ "la seconda pallina è rossa" $p(E_2\|E_1) = \frac{2}{4} = \frac{1}{2}$<br><br>$$p(E_1 \cap E_2) = \frac{3}{5} \cdot \frac{2}{4} = \frac{6}{20} = \frac{3}{10}$$ | Lancio due dadi (uno dopo l'altro)<br><br><br>$E_1 =$ "il primo dado dà 6"<br>$p(E_1) = \frac{1}{6}$<br><br>$E_2 =$ "il secondo dado dà 6"<br>$p(E_2) = \frac{1}{6}$<br><br>$$p(E_1 \cap E_2) = p(E_1) \cdot p(E_2) = \frac{1}{6} \cdot \frac{1}{6} = \frac{1}{36}$$ |

| **Discrete**                                                                                  | **Continue**                                                                                              |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Assumono un insieme finito o numerabile di valori (es. numero di teste in 10 lanci di moneta) | Assumono un numero infinito di valori all'interno di un intervallo reale (es. il tempo di attesa in coda) |

>[!warning] NOTA BENE
>Le probabilità si:
>- **sommano** quando abbiamo l'O (questo evento o l'altro);
>- **moltiplicano** quando abbiamo l'E (questo evento e l'altro).

## Teorema di Bernoulli o delle prove ripetute
$$P(k) = \binom{n}{k} p^k q^{n-k}$$
- $\binom{n}{k} = \frac{n!}{k!(n-k)!}$ è il **coefficiente binomiale** (rappresenta i modi in cui si possono combinare i successi).
- $p$ è la probabilità di **successo** in una singola prova.
- $q = (1 - p)$ è la probabilità di **insuccesso**.
- $n$ è il numero totale di prove.
- $k$ è il numero di successi desiderati ($0 \le k \le n$).

## Variabili Casuali
Funzione che associa un numero reale a ogni possibile risultato di un fenomento aleatorio

| **Valore Atteso**       | $E(X) = \sum x_i p_i$                                                                        |
| ----------------------- | -------------------------------------------------------------------------------------------- |
| **Varianza**            | $V(X) = \sum [x - E(X)]^2 \cdot f(x)$<br>$V(X) = E(X^2) - [E(X)]^2$<br><br>$\sigma^2 = V(X)$ |
| **Deviazione standard** | $\sigma = \sqrt{\sigma^2} = \sqrt{V(X)}$                                                     |

---

## Distribuzioni Discrete

| Distribuzione                         | Quando usarla                                                                                                   |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| ***Distribuzione Uniforme Discreta*** | Si usa quando ogni evento ha la stessa probabilità di verificarsi (es. lancio di un dado).                      |
| Probabilità                           | $p(X=x) = \frac{1}{n}$                                                                                          |
| Valore Atteso                         | $E(X) = \frac{n+1}{2}$                                                                                          |
| Varianza                              | $V(X) = \frac{n^2 - 1}{12}$                                                                                     |
|                                       |                                                                                                                 |
| ***Distribuzione di Bernoulli***      | Modella un singolo esperimento con due soli esiti: successo (1) o insuccesso (0).                               |
| Probabilità                           | $p(X=x) = p^x (1-p)^{1-x}$                                                                                      |
| Valore Atteso                         | $E(X) = p$                                                                                                      |
| Varianza                              | $V(X) = E(X^2) - [E(X)]^2$<br>$V(X) = p - p^2 = p(1-p)$                                                         |
|                                       |                                                                                                                 |
| ***Distribuzione Binomiale***         | Modella il numero di successi in $n$ prove indipendenti di Bernoulli.                                           |
| Probabilità                           | $p(X=x) = \binom{n}{x} p^x (1-p)^{n-x}$                                                                         |
| Valore Atteso                         | $E(X) = np$                                                                                                     |
| Varianza                              | $V(X) = np(1-p)$                                                                                                |
|                                       |                                                                                                                 |
| ***Distribuzione di Poisson***        | Usata spesso come approssimazione della binomiale quando:<br>- $n$ è molto grande<br>- $p$ è molto piccola.<br> |
| Probabilità                           | $$p(X=x) = \frac{\lambda^x e^{-\lambda}}{x!}$$                                                                  |
| Funzione di ripartizione              | $$p(X \leq x) = \sum_{k = 0}^{x} \frac{\lambda^k e^{-\lambda}}{k!}$$                                            |
| Uguaglianze                           | $E(X) = V(X) = \lambda = np$                                                                                    |


### 1. Distribuzione Uniforme Discreta
Si usa quando ogni evento ha la stessa probabilità di verificarsi (es. lancio di un dado).

| **Probabilità**   | $p(X=x) = \frac{1}{n}$      |
| ----------------- | --------------------------- |
| **Valore Atteso** | $E(X) = \frac{n+1}{2}$      |
| **Varianza**      | $V(X) = \frac{n^2 - 1}{12}$ |

### 2. Distribuzione di Bernoulli
Modella un singolo esperimento con due soli esiti: successo (1) o insuccesso (0).

| **Probabilità**   | $p(X=x) = p^x (1-p)^{1-x}$                              |
| ----------------- | ------------------------------------------------------- |
| **Valore Atteso** | $E(X) = p$                                              |
| **Varianza**      | $V(X) = E(X^2) - [E(X)]^2$<br>$V(X) = p - p^2 = p(1-p)$ |

### 3. Distribuzione Binomiale
Modella il numero di successi in $n$ prove indipendenti di Bernoulli.

| **Probabilità**   | $p(X=x) = \binom{n}{x} p^x (1-p)^{n-x}$ |
| ----------------- | --------------------------------------- |
| **Valore Atteso** | $E(X) = np$                             |
| **Varianza**      | $V(X) = np(1-p)$                        |

### 4. Distribuzione di Poisson
Usata spesso come approssimazione della binomiale quando $n$ è molto grande e $p$ è molto piccola.

| **Probabilità** | $$p(X=x) = \frac{\lambda^x e^{-\lambda}}{x!}$$ |
| --------------- | ---------------------------------------------- |
| **Uguaglianze** | $E(X) = V(X) = \lambda = np$                   |

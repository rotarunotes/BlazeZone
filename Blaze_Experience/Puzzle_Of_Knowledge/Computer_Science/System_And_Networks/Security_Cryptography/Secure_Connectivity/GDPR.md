Data: 2026-06-15
[Secure_Connectivity](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Security_Cryptography/Secure_Connectivity
___
# Index
- [[#GDPR]]
	- [[#Panoramica]]
- [[#Regolamento Generale Sulla Protezione Dei Dati]]
	- [[#Dato Personale E Categorie Particolari]]
- [[#Principi Cardine Del Trattamento]]
- [[#Ruoli E Figure Chiave]]
- [[#Diritti Dell'Interessato]]
- [[#Misure Di Sicurezza E Approccio Tecnico]]
- [[#Note Esame]]
	- [[#Da Sapere A Memoria]]
	- [[#Trabocchetti Frequenti]]
- [[#Quick Reference Card]]
___
# GDPR
## Panoramica

| Caratteristica | Dettaglio |
| :--- | :---: |
| **Definizione** | Regolamento europeo per la protezione dei dati personali e la privacy |
| **Ambito territoriale** | Applicazione a tutte le aziende che trattano dati di cittadini dell'UE |
| **Riferimento normativo** | Regolamento UE 2016/679 |
| **Misure tecnologiche chiave** | Cifratura, pseudonimizzazione, approccio by design e by default |

___
# Regolamento Generale Sulla Protezione Dei Dati

Il GDPR, *General Data Protection Regulation* (Regolamento UE 2016/679), stabilisce le regole relative alla protezione delle persone fisiche con riguardo al trattamento dei dati personali, nonché alla libera circolazione di tali dati. Si tratta di un regolamento direttamente applicabile in tutti gli Stati membri dell'Unione Europea.

## Dato Personale E Categorie Particolari
Il regolamento distingue le informazioni in base alla loro sensibilità:
- **Dato Personale**: Qualsiasi info riguardante una persona fisica identificata o identificabile (definita **Interessato**). Sono esempi il nome, l'indirizzo email, il codice fiscale o l'indirizzo IP.
- **Categorie Particolari Di Dati**: Dati personali che rivelano l'origine razziale o etnica, le opinioni politiche, le convinzioni religiose o filosofiche, l'appartenenza sindacale, nonché dati genetici, dati biometrici intesi a identificare in modo univoco una persona fisica, dati relativi alla salute o alla vita sessuale o all'orientamento sessuale della persona. Il trattamento di queste categorie è generalmente vietato, salvo specifiche eccezioni (es. consenso esplicito dell'interessato o motivi di interesse pubblico rilevante).

___
# Principi Cardine Del Trattamento

Il trattamento dei dati personali deve rispettare i seguenti principi fondamentali definiti all'Articolo 5 del regolamento:
1. **Liceità, Correttezza E Trasparenza**: Il trattamento deve fondarsi su una base giuridica valida (es. consenso, adempimento contrattuale, obbligo di legge) e deve essere comprensibile per l'interessato.
2. **Limitazione Della Finalità**: I dati devono essere raccolti per finalità determinate, esplicite e legittime, e non trattati in modo incompatibile con tali finalità.
3. **Minimizzazione Dei Dati**: I dati devono essere adeguati, pertinenti e limitati a quanto necessario rispetto alle finalità per cui sono trattati.
4. **Esattezza**: I dati devono essere esatti e, se necessario, aggiornati; i dati inesatti devono essere cancellati o rettificati tempestivamente.
5. **Limitazione Della Conservazione**: I dati devono essere conservati per un arco di tempo non superiore al conseguimento delle finalità del trattamento.
6. **Integrità E Riservatezza**: Deve essere garantita un'adeguata sicurezza dei dati personali, compresa la protezione da trattamenti non autorizzati o illeciti e dalla perdita, distruzione o danno accidentali, utilizzando misure tecniche e organizzative adeguate.
7. **Responsabilizzazione**: Il titolare del trattamento è competente per il rispetto dei principi sopra descritti e deve essere in grado di comprovarlo (principio di **Accountability**).

___
# Ruoli E Figure Chiave

Il GDPR definisce una struttura precisa di ruoli e responsabilità:
- **Interessato**: La persona fisica a cui si riferiscono i dati personali oggetto del trattamento.
- **Titolare Del Trattamento**: La persona fisica o giuridica, l'autorità pubblica, il servizio o altro organismo che, singolarmente o insieme ad altri, determina le finalità e i mezzi del trattamento di dati personali.
- **Responsabile Del Trattamento**: La persona fisica o giuridica, l'autorità pubblica, il servizio o altro organismo che tratta dati personali per conto del titolare del trattamento.
- **DPO**, *Data Protection Officer* (o RPD, *Responsabile della Protezione dei Dati*): Un consulente indipendente incaricato di monitorare l'osservanza del regolamento, fornire consulenza al titolare e fungere da punto di contatto con l'autorità di controllo. La sua designazione è obbligatoria per le autorità pubbliche e in casi di monitoraggio regolare e sistematico degli interessati su larga scala.
- **Autorità Di Controllo**: Autorità pubblica indipendente istituita da uno Stato membro (detta comunemente **Garante**) per sorvegliare l'applicazione del regolamento e tutelare i diritti degli interessati.

___
# Diritti Dell'Interessato

Gli utenti dispongono di diritti specifici per controllare come vengono gestiti i loro dati:
- **Diritto Di Accesso**: Ottenere la conferma che sia o meno in corso un trattamento di dati personali che lo riguardano e riceverne copia.
- **Diritto Di Rettifica**: Ottenere la rettifica dei dati personali inesatti senza ingiustificato ritardo.
- **Diritto Alla Cancellazione (Diritto All'Oblio)**: Ottenere la cancellazione dei propri dati personali in specifiche circostanze (es. se i dati non sono più necessari rispetto alle finalità originarie o se viene revocato il consenso).
- **Diritto Di Limitazione Del Trattamento**: Richiedere che il trattamento sia limitato a specifiche operazioni in casi definiti (es. contestazione dell'esattezza dei dati).
- **Diritto Alla Portabilità Dei Dati**: Ricevere i propri dati personali in un formato strutturato, di uso comune e leggibile da dispositivo automatico, e trasmetterli a un altro titolare senza impedimenti.
- **Diritto Di Opposizione**: Opporsi in qualsiasi momento, per motivi connessi alla sua situazione particolare, al trattamento dei dati personali che lo riguardano.

___
# Misure Di Sicurezza E Approccio Tecnico

Dal punto di vista sistemistico e di rete, il GDPR impone un approccio proattivo alla sicurezza:
- **Privacy By Design**: Integrazione delle misure di protezione dei dati fin dalla fase di progettazione di un sistema o servizio informatico.
- **Privacy By Default**: Configurazione predefinita dei sistemi volta a trattare esclusivamente i dati personali necessari per la specifica finalità del trattamento, riducendo al minimo l'esposizione iniziale dei dati.
- **Cifratura E Pseudonimizzazione**: Misure tecniche espressamente raccomandate. La cifratura garantisce la confidenzialità dei dati (es. tramite TLS per la trasmissione o AES per l'archiviazione). La pseudonimizzazione consiste nel trattamento dei dati personali in modo tale che non possano più essere attribuiti a un interessato specifico senza l'utilizzo di informazioni aggiuntive (conservate separatamente).
- **Data Breach**: Qualsiasi violazione di sicurezza che comporta accidentalmente o in modo illecito la distruzione, la perdita, la modifica, la rivelazione non autorizzata o l'accesso ai dati personali trasmessi, conservati o comunque trattati. In caso di violazione, il titolare deve notificare l'evento al Garante entro 72 ore dal momento in cui ne è venuto a conoscenza, a meno che sia improbabile che presenti un rischio per i diritti delle persone fisiche. Se il rischio è elevato, deve essere informato anche l'interessato.
- **DPIA**, *Data Protection Impact Assessment* (o Valutazione Di Impatto Sulla Protezione Dei Dati): Una procedura preventiva volta a descrivere il trattamento, valutarne la necessità e la proporzionalità, e aiutare a gestire i rischi per i diritti e le libertà delle persone fisiche derivanti dal trattamento.

___
# Note Esame

## Da Sapere A Memoria

| Argomento | Dettagli Tecnici |
| :--- | :--- |
| **Notifica Data Breach** | Deve avvenire entro **72 ore** dalla scoperta della violazione all'Autorità Garante. |
| **Pseudonimizzazione** | Riduce il rischio ma i dati rimangono considerati dati personali (a differenza dell'anonimizzazione completa, che esclude l'applicazione del GDPR). |
| **Portabilità Dei Dati** | Si applica solo ai dati trattati con mezzi automatizzati sulla base del consenso o di un contratto. |

## Trabocchetti Frequenti

| Concetto Errato | Realtà Tecnica |
| :--- | :--- |
| **I dati pseudonimizzati sono fuori dall'ambito del GDPR** | **FALSO**. I dati pseudonimizzati possono essere ricollegati all'interessato tramite informazioni aggiuntive protette, quindi sono ancora considerati dati personali e soggetti alle regole del regolamento. Solo i dati **completamente anonimizzati** (in modo irreversibile) sono esclusi dal GDPR. |
| **Il DPO deve essere nominato in qualsiasi azienda** | **FALSO**. La nomina del DPO, *Data Protection Officer*, è obbligatoria solo per soggetti pubblici, per trattamenti che richiedono il monitoraggio regolare su larga scala o per il trattamento su larga scala di categorie particolari di dati. |
| **La cifratura dei dati annulla l'obbligo di notifica di un Data Breach** | **FALSO**. La cifratura riduce drasticamente la probabilità di danno e può esentare dall'obbligo di notificare l'interessato (poiché i dati sono incomprensibili all'attaccante), ma l'obbligo di notificare il Garante entro 72 ore permane se sussiste comunque un potenziale rischio residuo. |

___
# Quick Reference Card

```
GDPR (GENERAL DATA PROTECTION REGULATION):
  - Regolamento UE 2016/679 (direttamente applicabile)
  - Protezione della privacy e dei dati personali dei cittadini UE
  - Approccio basato sul rischio e responsabilizzazione (Accountability)

PUNTI CHIAVE (LATO TECNICO):
  1. Privacy by Design     -> Protezione integrata sin dalla progettazione del sistema
  2. Privacy by Default    -> Massima tutela preimpostata di default
  3. Cifratura             -> Protezione della confidenzialità in transito (TLS) e a riposo
  4. Pseudonimizzazione    -> Separazione dei dati identificativi da quelli sostanziali
  5. Notifica Data Breach  -> Segnalazione al Garante entro 72 ore dalla scoperta
  6. DPIA                  -> Valutazione preventiva dell'impatto per trattamenti rischiosi
```
___
--Gemini

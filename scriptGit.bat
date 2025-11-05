@echo off
ECHO Esecuzione dei comandi Git...

REM 1. Aggiunge tutte le modifiche attuali
ECHO.
ECHO Esecuzione: git add .
git add .

IF ERRORLEVEL 1 (
    ECHO.
    ECHO ERRORE: git add . non è riuscito. Interruzione.
    GOTO END
)

REM 2. Esegue il commit con un messaggio predefinito
ECHO.
ECHO Esecuzione: git commit -m "Update repo"
git commit -m "Update repo"

REM Il commit fallisce se non ci sono modifiche da committare,
REM ma il push può comunque essere utile per sincronizzare.
IF ERRORLEVEL 0 (
    ECHO.
    ECHO Commit eseguito con successo.
) ELSE (
    ECHO.
    ECHO Nessuna modifica da committare o il commit è fallito. Tentativo di push.
)

REM 3. Esegue il push delle modifiche
ECHO.
ECHO Esecuzione: git push
git push

IF ERRORLEVEL 1 (
    ECHO.
    ECHO ERRORE: git push non è riuscito.
    GOTO END
)

ECHO.
ECHO ✅ Operazioni Git completate con successo!

:END
ECHO.
PAUSE
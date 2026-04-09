# Scarica la repo nel pc locale
`git clone` "url della repository"
# Per sincronizzare il file locale con GitHub
1) `git status`: Controlla se i file locali sono sincronizzati con la repo su github, controlla che anche il contenuto del file sia sincronizzato

![[Pasted image 20260331220152.png]]

2) Come si può vedere abbiamo `NuovoProgetto.txt` e `nuovoFile.txt` che non sono sincronizzati.
3) Quindi si aggiungono al commit
	- `git add .`: con `.` si indicano di aggiungere al commit **tutti** i nuovi file e file modificati, volendo si poteva specificare il file
4) Si fa un altro `git status` per controllare la situazione
![[Pasted image 20260331220606.png]]
5) Ora si crea il commit
	- `git commit -m ""` dentro "" si scrive il messaggio del commit. per esempio: "Ho aggiunto 2 nuovi file"
		1) In caso bisogna settare le credenziali sul dispositivo attraverso e ripetere git commit;
			- `git config --global user.email "tua email github"`
			- `git config --global user.name "tua username github"`
6) `git push origin`: con questo comando finiamo il processo, ora vedrai su github i file nuovi

# Per sincronizzare il file GitHub con locale
1) Avendo già la repo scaricata sul nostro pc, non server di nuovo fare `git clone ....`
2) basta lanciare `git pull origin`, e da solo scaricherà i file nuovi
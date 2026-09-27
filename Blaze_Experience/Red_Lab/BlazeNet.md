Data: 2026-07-08
[Red_Lab](./README.md)
#Red_Lab
___
# Index
___

| Guida                               | Link                                                        | Durata  | Stato  |
| ----------------------------------- | ----------------------------------------------------------- | ------- | ------ |
| Home lab start guide                | [Inglese](https://youtu.be/AtgCcMjtqF0?si=eWCJorxhUTTKdH3V) | 46:38   | Finito |
| Docker                              | [Inglese](https://youtu.be/RqTEHSBrYFw?si=5AIu9Ntp0TWmB-27) | 4:44:20 | 41:20  |
| ProxMox Setup                       | [Inglese](https://youtu.be/qmSizZUbCOA?si=tEbQzmxwB46Oq1WB) | 37:38   | Finito |
| ProxMox Post Install                | [Inglese](https://youtu.be/pcnJdJVTzc8?si=FYEruQev0k1Im1Nh) |         | Finito |
| UbuntuServer                        | [Inglese](https://youtu.be/Vwtx_dfYrtA?si=ZNeLvMKWsDcIiFqt) |         |        |
| (DDNS, Local Domains, Cloudflare) - | [Inglese](https://youtu.be/79e6KBYcVmQ?si=ZvxdBiANjCEbbMRJ) |         |        |
| NextCloud                           | [Inlgese](https://youtu.be/JOFsU0ccIlk?si=xCTzh__jaVq0JpXJ) |         | Finito |
| NextCloudPostInstall                | [Inglese](https://youtu.be/0jJPvbgksPQ?si=Ypob0Fd040WE4paK) |         | Finito |
| PiHole                              | [Inglese](https://youtu.be/d6J21MqBsDw?si=SNiZyafOHKO14Fw3) |         | Finito |



- FIRESHARE per le clip del gaming condivise 
- Il mio server deve essere anche il server VPN

Servizi
- Cloud: 
- FIlm: Jellyfin
- Foto: immich
- Servizi app con URL: DNS
- Bloccare gli ads: PI HOLE
- FIRESHARE per le clip del gaming condivise 

Sto creando un home server per poter hostare diversi servizi come:
- jellyfin
- immich
- pi hole
- Servizio drive

Sto usando un vecchio portatile più precisamente un n17c4 con un i7  di ottava generazione e 16gb di ram.
ha windows 11.

Poi ho intenzione di collegarci un DAS da 2 tera di memoria così ho più spazio nel cloud.


Vorrei sapere come devo procedere con l'Installazione di proxmox, tenendo conto che vorrei configurare i dischi esterni


- Accensione da remoto

# Stats Macchina Principale:

| Campo               | Dati                        |
| ------------------- | --------------------------- |
| Nome                | BlazeNet                    |
| IP Statico          | 192.168.1.100               |
| MAC                 | 98 : 28 : a6 : 1d : 82 : ba |
| Porta               | 8006                        |
| Unbound porta       | 5335                        |
| Unbound Interfaccia | 127.0.0.0                   |


| IPv4          | Dominio         | Porta | Percorso | Info                       | STORAGE | CORE | RAM |
| ------------- | --------------- | ----- | -------- | -------------------------- | ------- | ---- | --- |
| 192.168.1.100 | blaze.net.lan   | 8006  |          | Macchina con proxmox (pve) |         |      |     |
| 192.168.1.101 | blaze.cloud.lan |       |          | NextCloud                  |         |      |     |
| 192.168.1.102 | blaze.hole.lan  | 5335  | /admin   | pihole                     |         |      |     |
|               |                 |       |          |                            |         |      |     |



# ProxMox
## Installazione
1. Dopo aver installato ProxMox procediamo a settare nel router una DHCP reservation per il pc con ProxMox


## Setup 
### SUBSCRIPTION
Togliere la subscription nelle repository (pve).

Nell'installazione ProxMox crea un nodo che è la tuo pc dove hai scaricato ProxMox, che di solito è pve.
Come setup iniziale ProxMox crea due storage:
```
local (pve)
local-lvm (pve)
```

Togliere il messaggio al login:
``` 
shell pve
```

``` shell
cd /usr/share/javascript/proxmox-widget-toolkit/
nano proxmoxlib.js
```
ctrl-f
``` shell
checked_command
```

aggiungi sotto la funzione queste righe:

``` js
orig_cmd();
return;
```

ctrl-O; invio; ctrl-X

```shell
systemctl restart pveproxy
```
### STORAGE
Procediamo ad eliminare la `local-lvm (pve)`:
```
DataCenter -> Storage -> "local-lvm (pve)" -> remove
```

Successivamente liberiamo nel disco la partizione tramite terminale.
```
pve -> shell
```

``` shell
lvremove /dev/pve/data
```

Ci è rimasto solo lo storage `local (pve)`, possiamo notare che su questo storage non sta contenendo tutto lo spazio disponibile della macchina, per allocargli tutto il disco digitiamo questi comandi:
``` shell
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root
```
### IOMMU
Abilitare IOMMU, e poi fare il reboot

``` shell
nano /etc/default/grub
```

Aggiornare la riga così:
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
```
ctrl-O. invio, ctrl-X
``` shell
update-grub
```

Per vedere se tutto è stato abilitato
``` shell
dmesg | grep -e DMAR -e IOMMU
dmesg | grep 'remapping'
```
In sintesi, senza questa stringa nel file GRUB, Proxmox tiene per sé tutto l'hardware fisico e lo "condivide" virtualmente con le VM. Con l'IOMMU attivo, puoi "scollegare" un pezzo di hardware da Proxmox e "collegarlo" direttamente a una VM.

### ### Passaggi per ignorare la chiusura del coperchio

1. Dalla **Shell di Proxmox** (nella Web GUI o tramite SSH), apri il file di configurazione `logind.conf` usando il tuo editor: `nano /etc/systemd/logind.conf`
2. Usa le frecce della tastiera per scorrere verso il basso e cerca una riga che assomiglia a questa (probabilmente si trova verso la metà del file): `#HandleLidSwitch=suspend`
3. Devi fare due cose su quella riga: eliminare il cancelletto (`#`) iniziale per "attivarla", e cambiare la parola `suspend` in `ignore`. Alla fine, la riga deve essere esattamente questa: `HandleLidSwitch=ignore`
4. **Salva ed esci** (come abbiamo visto prima: **`Ctrl + O`**, **`Invio`**, **`Ctrl + X`**).
5. Affinché la modifica abbia effetto, devi ricaricare il servizio che gestisce queste impostazioni. Non serve riavviare tutto il server, basta digitare questo comando: `systemctl restart systemd-logind.service`


### Temperatura
``` shell
apt-get install lm-sensors
# lm-sensors must be configured, run below to configure your sensors, apply temperature offsets. Refer to lm-sensors manual for more information.
sensors-detect 
wget https://raw.githubusercontent.com/Meliox/PVE-mods/refs/heads/main/legacy-scripts/pve-mod-gui-sensors.sh
bash pve-mod-gui-sensors.sh install
# Then clear the browser cache to ensure all changes are visualized.
```
# NextCoud

Comando da runnare nella shell
```shell
bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/vm/nextcloud-vm.sh)"
```
Tutorial:
https://localhake.com/content/proxmox-nextcloud-helper-script

# PiHole
Tutorial:
https://localhake.com/content/pihole-unbound-proxmox

dopo aver eseguito i tutorial, per fa funzionare il DNS interno bisogna configurare nel router il DNS server, (pihole), e poi uno secondario dove andranno il resto delle riserver (1.1.1.1).

Su nextcloud ho dovuto anche toccare le configurazioni per permettere al nuovo dominio di essere accettato

BlockList siti publicita seria:
- [https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt](https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt)
- [https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt](https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt)


# BlazeCraft
![[Pasted image 20260719204419.png]]

Dopo l'installazione della macchina virtuale di xubuntu il prossimo passo è installare il server minecraft:

https://www.minecraft.net/it-it/download/server

si fanno tutti i passaggi per configurare il server. poi dopo aver testato una sessione del server:

Bisogna dare questi comandi 
```
sudo apt update
sudo apt install qemu-guest-agent -y
sudo systemctl enable --now qemu-guest-agent
```

- Seleziona la VM → **Options** → **QEMU Guest Agent** → Edit → spunta **Enabled**
  
  per fare vedere l'IP della vm a proxmo
  
  # Sicurezza Server Pubblico
  Sì, in linea di massima il port forwarding sul router basta per far entrare i tuoi amici da fuori — ma ci sono alcuni dettagli da sistemare, e hai ragione a pensare alla sicurezza: **una porta Minecraft esposta su internet è un bersaglio comune per bot di scanning e tentativi di attacco**, quindi vale la pena proteggerla bene.

### 1. Port forwarding sul router

Nella configurazione del router (di solito sotto "NAT", "Port Forwarding" o "Virtual Server"):

- **Porta esterna**: 25565
- **Porta interna**: 25565
- **IP interno**: `192.168.1.103` (l'IP attuale della tua VM — ricordati che può cambiare se non hai reso davvero statico quell'IP, verifica quello)
- **Protocollo**: TCP (Minecraft Java usa solo TCP, non serve UDP)

### 2. Trova il tuo IP pubblico

Gli amici si connetteranno al tuo **IP pubblico**, non a `192.168.1.103` (quello funziona solo in LAN). Trovalo con:

bash

```bash
curl ifconfig.me
```

oppure cercando "qual è il mio ip" su Google dal PC di casa.

⚠️ Se il tuo IP pubblico non è statico (la maggior parte dei contratti internet domestici ce l'ha dinamico), cambierà periodicamente e dovrai comunicare il nuovo IP agli amici ogni volta. Per risolvere, puoi usare un servizio di **DNS dinamico** (es. [DuckDNS](https://www.duckdns.org), gratuito) che ti dà un indirizzo tipo `tuoserver.duckdns.org` sempre aggiornato automaticamente.

### 3. Ora, sicurezza — limitare il traffico sulla porta esposta

Ecco le misure concrete che puoi applicare, dalla più semplice alla più efficace:

#### A. Firewall sulla VM con rate limiting (ufw)

Limita quante nuove connessioni può fare lo stesso IP in un intervallo di tempo, per bloccare scanner/bot automatici:

bash

```bash
sudo ufw limit 25565/tcp
```

Questo blocca automaticamente un IP che fa troppe connessioni in poco tempo (protezione base anti-flood).

#### B. Whitelist su Minecraft (la protezione più efficace ed essenziale)

Se giochi solo con amici specifici, **questa è la misura più importante**: attiva la whitelist così solo chi autorizzi tu può entrare, chiunque altro trovi la porta aperta viene comunque rifiutato dal gioco stesso.

In `server.properties`:

```
white-list=true
```

Poi, con il server acceso (dentro screen):

```
whitelist add NomeUtenteAmico
```

O modifica direttamente `whitelist.json` con gli username.

#### C. Fail2ban (protezione più avanzata)

Monitora i log e banna automaticamente IP che fanno troppi tentativi sospetti:

bash

```bash
sudo apt install fail2ban -y
```

Richiede una configurazione specifica per i log di Minecraft (posso aiutarti a impostarla se vuoi spingerti fin qui).

#### D. Limita la porta solo a IP specifici (se gli amici hanno IP fissi)

Se i tuoi amici hanno IP pubblici statici (raro per utenti domestici, ma capita), puoi restringere ulteriormente sul router il forwarding solo a quegli IP sorgente — ma è un'opzione poco pratica se gli IP cambiano spesso.

#### E. Cambia la porta di default (sicurezza tramite offuscamento, minore ma utile)

Molti bot scansionano automaticamente la porta 25565 standard. Cambiandola (es. `35789`) in `server.properties` (`server-port=35789`) e nel port forwarding, riduci drasticamente gli scan automatici casuali — non è una vera sicurezza, ma abbassa il "rumore di fondo" di tentativi random.

---

**La combinazione più efficace e semplice per il tuo caso**: whitelist attiva (B) + rate limit su ufw (A). Ti serve anche fail2ban (C), o per ora ti bastano queste due?

## DNS DINAMICO
Ecco il tutorial completo per configurare DuckDNS sulla tua VM.

### 1. Crea l'account DuckDNS

1. Vai su [duckdns.org](https://www.duckdns.org)
2. Fai login con Google, GitHub, Twitter o Reddit (non serve creare un account separato)
3. Una volta dentro, nella pagina principale trovi il campo **"sub domain"** — scegli un nome, ad esempio:

```
   blazecraftpc
```

Questo diventerà `blazecraftpc.duckdns.org`  
4. Clicca **"add domain"**

### 2. Copia il tuo token

In alto nella pagina, sotto al tuo account, vedrai un **token** tipo:

```
a1b2c3d4-e5f6-7890-abcd-1234567890ab
```

Copialo, ti servirà tra poco.

### 3. Verifica che punti al tuo IP pubblico

Nella riga del dominio che hai creato, dovresti già vedere il tuo IP pubblico attuale rilevato automaticamente. Se è corretto, bene — ma ora dobbiamo automatizzare l'aggiornamento, perché quell'IP può cambiare in qualsiasi momento (IP dinamico del tuo provider internet).

### 4. Crea lo script di aggiornamento sulla VM

bash

```bash
mkdir ~/duckdns
cd ~/duckdns
nano duck.sh
```

Contenuto (sostituisci `TUO_DOMINIO` e `TUO_TOKEN` con i tuoi dati):

bash

```bash
echo url="https://www.duckdns.org/update?domains=TUO_DOMINIO&token=TUO_TOKEN&ip=" | curl -k -o ~/duckdns/duck.log -K -
```

Esempio concreto:

bash

```bash
echo url="https://www.duckdns.org/update?domains=blazecraftpc&token=a1b2c3d4-e5f6-7890-abcd-1234567890ab&ip=" | curl -k -o ~/duckdns/duck.log -K -
```

Salva (Ctrl+O, Invio, Ctrl+X).

### 5. Rendi eseguibile lo script

bash

```bash
chmod 700 duck.sh
```

### 6. Testalo manualmente

bash

```bash
./duck.sh
cat duck.log
```

Se vedi scritto `OK`, ha funzionato. Se vedi `KO`, controlla che dominio e token siano corretti.

### 7. Automatizza l'aggiornamento con cron

Così se il tuo IP pubblico cambia, DuckDNS si aggiorna da solo senza che tu debba pensarci:

bash

```bash
crontab -e
```

Aggiungi questa riga (aggiorna ogni 5 minuti):

```
*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
```

### 8. Configura il port forwarding sul router usando il dominio (non serve, ma per chiarezza)

Il port forwarding resta configurato sull'IP interno della VM come prima (`192.168.1.103:25565`) — DuckDNS serve solo a far sì che i tuoi amici, invece di doverti chiedere ogni volta il tuo IP pubblico aggiornato, si connettano sempre a:

```
blazecraftpc.duckdns.org:25565
```

E questo indirizzo punterà sempre al tuo IP pubblico corrente, anche se cambia.

### 9. Comunica l'indirizzo agli amici

Da ora, i tuoi amici useranno:

```
blazecraftpc.duckdns.org
```

(o con porta esplicita se non è la default: `blazecraftpc.duckdns.org:25565`)

---

Vuoi che ti aiuti anche a verificare che il port forwarding sul router sia impostato correttamente, o procediamo con whitelist e sicurezza della porta come accennato prima?
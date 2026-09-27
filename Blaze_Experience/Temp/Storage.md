Data: 2026-07-08
[Blaze_Experience](Red_Lab/README.md)
#Blaze_Experience
___
# Index
- [[#Storage E Backup]]
	- [[#Guide Video]]
	- [[#Navigazione]]
	- [[#Proxmox Come NAS]]
	- [[#Passaggi Post-Installazione (Opzionali)]]
	- [[#Creare Pool ZFS]]
	- [[#Creare Container Usando Pool ZFS]]
___
# Storage E Backup

In questa nota vado a definire le mie soluzioni di **storage** e **backup** per tutti i servizi e le piattaforme che girano nel mio homelab. Al momento gestisco tutto tramite Proxmox e PBS (*Proxmox Backup Server*). Anche se soluzioni come Unraid o TrueNAS sono fantastiche, negli anni ho capito che Proxmox è una bomba per gestire lo storage, le condivisioni di rete e i backup.

> [!note] Nota
> Di recente sono passato a Unraid su una macchina separata per le condivisioni e lo storage principale. Comunque, questa guida va benissimo anche per una soluzione basata interamente su Proxmox. Nelle prossime settimane aggiornerò questa pagina per aggiungere altre opzioni di storage e spiegare come montare al meglio le condivisioni NFS (*Network File System*) su Proxmox.
___
## Guide Video

Questo file serve come compagno e supporto alla mia video guida ufficiale!

[![](https://raw.githubusercontent.com/TechHutTV/homelab/refs/heads/main/storage/part1_thumbnail.webp)](https://youtu.be/qmSizZUbCOA)
___
## Navigazione

- [Applicazioni](https://github.com/TechHutTV/homelab/tree/main/apps): Lista di tutte le app e i servizi.
- [Home Assistant](https://github.com/TechHutTV/homelab/tree/main/homeassistant): Servizi per la domotica e automazioni.
- [Media Server](https://github.com/TechHutTV/homelab/tree/main/media): Plex, Jellyfin, la suite ``*arr`` e altro ancora.
- [Monitoraggio Server](https://github.com/TechHutTV/homelab/tree/main/monitoring): Grafici e visualizzazioni per Unraid, Proxmox e altro.
- [Videosorveglianza](https://github.com/TechHutTV/homelab/tree/main/surveillance): Soluzione NVR (*Network Video Recorder*) Frigate con Coral TPU (*Tensor Processing Unit*).
- **Storage**: Soluzione attuale per archiviazione e backup.
- [Gestione Proxy](https://github.com/TechHutTV/homelab/tree/main/proxy): Nginx Proxy Manager, DDNS (*Dynamic Domain Name System*) con Cloudflare, domini locali e altro.
___
## Proxmox Come NAS

La mia configurazione attuale prevede un singolo server con 3 drive NVMe (*Non-Volatile Memory Express*) e un gruppo di hard disk in configurazione ZFS (*Zettabyte File System*). Questi sono uniti in pool ZFS separati: uno per gli HDD (*Hard Disk Drive*) chiamato ``vault`` (storage principale di massa) e uno per gli SSD (*Solid State Drive*) chiamato ``flash`` (per container e dischi delle macchine virtuali). 

Qualsiasi sia la tua configurazione, puoi seguire tranquillamente questa guida. Consiglio comunque di usare almeno un SSD NVMe da almeno 512 GB como disco di boot (se non hai altri SSD NVMe) e almeno 2 HDD per l'archiviazione dei dati.
___
## Passaggi Post-Installazione (Opzionali)

### Script Di Post-Installazione Della Community Proxmox

Il modo più veloce per gestire i compiti post-installazione è usare lo [Script Di Post-Installazione Proxmox VE](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install) dal progetto dei community scripts. Esegui questo comando direttamente nella shell di Proxmox:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/post-pve-install.sh)"
```

Questo script disabiliterà i repository enterprise, aggiungerà quelli gratuiti, rimuoverà il banner di avviso della sottoscrizione e aggiornerà il sistema. Ti guiderà passo dopo passo in modo interattivo.

### Procedura Manuale: Disabilitare I Repository Enterprise

Se preferisci fare tutto a mano:
1. Vai su ``Nodo > Repository`` e disabilita i repository enterprise.
2. Clicca su ``Aggiungi`` e abilita il repository senza sottoscrizione (*no-subscription*). Infine, vai su ``Aggiornamenti > Ricarica``.
3. Aggiorna il sistema cliccando su ``Aggiorna `` sopra la pagina delle impostazioni dei repository.

![](https://raw.githubusercontent.com/TechHutTV/homelab/refs/heads/main/storage/1_proxmox-repos.jpeg)

### Eliminare local-lvm E Ridimensionare local (Installazione Pulita)

> [!warning] Attenzione
> Questa procedura dà per scontata un'installazione pulita senza impostazioni avanzate di storage durante il setup. Vedi questo [problema](https://github.com/TechHutTV/homelab/issues/19).

Il mio disco di boot è piccolo e faccio girare tutti i container e i dischi delle macchine virtuali su un pool di storage separato. Quindi la partizione LVM (*Logical Volume Manager*) per me non è necessaria e rimarrebbe inutilizzata. Se fai girare tutto sullo stesso disco di boot per avere uno storage veloce, salta questo passaggio. Inoltre ti consiglio di dare un'occhiata a questo [video](https://www.youtube.com/watch?v=czQuRgoBrmM) per capire meglio come funziona LVM prima di fare qualsiasi cosa.

1. Rimuovi manualmente ``local-lvm`` dall'interfaccia web sotto ``Datacenter > Storage``.
2. Esegui i seguenti comandi da ``Nodo > Shell``:
   ```bash
   lvremove /dev/pve/data
   lvresize -l +100%FREE /dev/pve/root
   resize2fs /dev/mapper/pve-root
   ```
3. Verifica che la partizione di storage locale stia usando tutto lo spazio disponibile. Se necessario, riassegna lo storage per i container e le VM (*Virtual Machine*).

### Assicurarsi Che IOMMU Sia Abilitato

Abilita IOMMU (*Input-Output Memory Management Unit*) nella configurazione di GRUB (*Grand Unified Bootloader*) da ``Nodo > Shell``:

```bash
nano /etc/default/grub
```

Troverai la riga con ``GRUB_CMDLINE_LINUX_DEFAULT="quiet"``. Tutto quello che devi fare è aggiungere ``intel_iommu=on`` oppure ``amd_iommu=on`` a seconda del processore del tuo sistema:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
```

![](https://raw.githubusercontent.com/TechHutTV/homelab/refs/heads/main/storage/2_proxmox-iommu.jpeg)

Poi esegui il comando seguente e riavvia il sistema:

```bash
update-grub
```

Ora controlla che tutto sia effettivamente abilitato:

```bash
dmesg | grep -e DMAR -e IOMMU
dmesg | grep 'remapping'
```

> [!note] iGPU Intel Più Recenti (Serie N100/N150)
> Se vedi ``DMAR: Skip IOMMU disabling for graphics`` nell'output di ``dmesg`` o manca ``renderD128`` in ``/dev/dri/``, il tuo kernel potrebbe essere troppo vecchio. La iGPU (*Integrated Graphics Processing Unit*) Intel N150 (8086:46d4) richiede il kernel 6.9+ per avere il supporto corretto dei driver. Il kernel di default di Proxmox potrebbe essere più vecchio, ma puoi installarne uno più recente:
> 
> ```bash
> apt install pve-kernel-6.14
> ```
> 
> Dopo il riavvio, verifica con ``ls /dev/dri/``: dovresti vedere ``card1`` e ``renderD128``. Vedi il [problema #44](https://github.com/TechHutTV/homelab/issues/44) per maggiori dettagli e approcci alternativi con il passthrough LXC (*Linux Containers*).

Puoi approfondire come abilitare il passthrough PCI (*Peripheral Component Interconnect*) [qui](https://pve.proxmox.com/wiki/PCI_Passthrough).
___
## Creare Pool ZFS

Per prima cosa andiamo a creare due pool ZFS. Un pool chiamato ``tank``, che serve per i set di dati più grandi come media, immagini e archivi. Poi creeremo un pool ``flash``, dedicato ai file system radice delle macchine virtuali e dei container. Questo è il modo in cui li ho nominati io, ma tu puoi chiamarli come preferisci.

Inizia controllando i dischi per verificare che siano tutti presenti sotto ``Nodo > Dischi``. Ricordati di inizializzare (``wipe``) tutti i dischi che vuoi usare. Fai molta attenzione perché questo cancellerà ogni dato presente sui dischi, quindi assicurati di non avere dati importanti e fai un backup se necessario.

![](https://raw.githubusercontent.com/TechHutTV/homelab/refs/heads/main/storage/3_proxmox-wipe-disk.jpeg)

Ora, nella barra laterale di Proxmox, vai su ``Dischi > ZFS > Crea: ZFS``. Si aprirà la schermata per creare un nuovo pool ZFS.

In questa schermata dovrebbero apparire tutti i tuoi dischi. Seleziona quelli che vuoi inserire nel pool e imposta il livello RAID (*Redundant Array of Independent Disks*) (nel mio caso RAIDZ per il pool vault e mirror per il pool flash) e la compressione (io la lascio attiva su ``on``). Assicurati di spuntare la casella ``Aggiungi a Storage``. In questo modo i pool saranno disponibili da subito ed eviterai di usare file ``.raw`` rispetto alla mia vecchia configurazione in cui aggiungevo le directory.

![](https://raw.githubusercontent.com/TechHutTV/homelab/refs/heads/main/storage/4_proxmox-mirror-nvme.jpeg)
___
## Creare Container Usando Pool ZFS

Ora è il momento di mettere in pratica questi...
___
--Gemini

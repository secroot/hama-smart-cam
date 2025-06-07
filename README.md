# HAMA SMART CAMERA 1080p HD-00176652 FW v3.10.79 auf ak3918ev330
# IP-Cam Exploit & Patch Zusammenfassung

Diese Datei dokumentiert die manuelle Patching- und Debugging-Methode für die HAMA IP-Kamera
auf Basis des Anyka SDK. Sie enthält sowohl technische Details als auch visuelle Debug-Daten.

---

## 🔍 Patchstatus & Setup

# Kamera Patchstatus & Installationsweg 

## Setup-Methode

Die Kamera wurde manuell mit einer RTSP-fähigen Version von `anyka_ipc` gepatcht.

### Vorgehen:

1. **Firmwarebasis und SD-Kartenlayout**
   - Eigene SD-Struktur mit `/mnt/busybox-pwn`, `hack.sh`, `anyka_ipc_rtsp`, `custom.sh`
   - FAT32 formatierte SD-Karte
   - Eigene `httpd.conf` und `log_parser.sh`

2. **Patchquelle**
   - Vorgegangen nach Anleitung *Option 3* von Guino's Repo:
     https://github.com/guino/LSC1080P

3. **Binärpatch-Vorgehen**
   - Original `anyka_ipc` extrahiert über `binwalk -e -M` aus 2.10.36 OTA
   - Pfad: `_165966791961ed11009a7.bin.extracted/_usr.sqsh4.extracted/squashfs-root/bin/anyka_ipc`
   - Ebenso extrahiert: `libavssdkbeta.so` aus `.../lib/`
   - Beide Dateien wurden auf der SD-Karte abgelegt
   - Patch erfolgte über: https://www.marcrobledo.com/RomPatcher.js/
   - `anyka_ipc_rtsp` wurde erzeugt und korrekt umbenannt
   - Datei wurde per SD-Card eingebunden und über `hack.sh` ersetzt

4. **Besonderheiten**
   - Kamera bootet mit modifizierter `hack.sh`
   - Telnetd und BusyBox laufen manuell gestartet (Port 31337)
   - RTSP läuft erfolgreich über Port 554
   - Webinterface aktiv unter Port 8080 (`busybox httpd`)

## Verwendete Tools & Methoden

- **Binwalk**: Firmware extrahieren
- **RomPatcher.js**: Patchvorgang des Binaries
- **BusyBox statisch ARMv5**: auf SD-Karte eingebunden
- **Telnetd**: über `busybox-pwn` manuell aktiviert
- **HTTPD**: über BusyBox auf Port 8080 aktiv

## Relevante Pfade (SD & System)

```
/tmp/sd/anyka_ipc_rtsp
/tmp/sd/libavssdkbeta.so
/tmp/sd/hack.sh
/tmp/sd/httpd.conf
/tmp/sd/log_parser.sh
/tmp/sd/custom.sh
/mnt/busybox-pwn
/usr/bin/anyka_ipc
/usr/lib/libavssdkbeta.so
/lib/libuClibc-1.0.28.so
```

## Hinweise

- `/mnt/busybox-pwn` ersetzt Systemtools temporär
- LD_LIBRARY_PATH um `/tmp/sd` erweitert
- Kamera nutzt SD-Card-Dateien bevorzugt beim Vorhandensein
- Logik in `hack.sh` prüft und ersetzt `anyka_ipc` via `mount --bind`

---

## 🐚 Session Snapshot & Laufzeitumgebung

#  IP-Cam Exploit Session Snapshot (Busybox, Telnet, Shared Libs)

##  Systeminfo & Grundlagen

- **CPU**: ARM926EJ-S (ARMv5TEJ)
- **Firmware**: Anyka SDK
- **Init-Binary**: `/usr/bin/anyka_ipc`
- **Patch-Mechanik**: `/tmp/sd/hack.sh`
- **Filesystem**: `tmpfs` gemounted auf `/tmp`
- **BusyBox**: Eigener ARMv5-static build (`busybox-pwn`)

---

##  Deploy & Exploit Steps

###  Eigene BusyBox
- Cross-compiled: `armv5te`, static
- Deployment via `docker cp`  SD-Karte  `/mnt/busybox-pwn`
- Telnetd geffnet auf Port **31337**:  
  ```sh
  /mnt/busybox-pwn telnetd -l /bin/sh -p 31337
  ```

###  Shell Setup
- `hack.sh` mounted `/tmp/sd`, bind-mounted `anyka_ipc_rtsp`
- System wird ber `mount --bind` modifiziert
- Custom RTSP-Binary gestartet mit Logger:
  ```sh
  /tmp/sd/anyka_ipc_rtsp 2>&1 | /tmp/sd/log_parser.sh /dev/null
  ```

---

##  Speicher & Laufzeitinfos

###  Libraries laut `/proc/PID/maps`
```plaintext
/lib/
 libuClibc-1.0.28.so
 libgcc_s.so.1
 libstdc++.so.6.0.20

/usr/lib/
 libavssdkbeta.so
```

> `LD_LIBRARY_PATH` zeigt zustzlich auf `/tmp/sd`

---

##  Accounts & Sicherheit

- Live `/etc/passwd`:
  ```plaintext
  root:x:0:0:root:/:/bin/sh
  daemon:x:1:1:daemon:/usr/sbin:/bin/sh
  ```
- Gert ldt `passwd`/`shadow` von SD-Karte, wenn vorhanden:
  - Beispielpfad: `/etc/config/passwd`

---

##  Relevante Pfade & Tools

###  Firmware Dump
- Pfadbeispiel intern: `/mnt/dump/mtd*.bin` bzw. `/tmp/sd/dump/mtd*.bin`
- Tools fr Dump-Handling:
  - `binwalk -e firmware.bin`
  - `unsquashfs` / `sasquatch`
  - `dd if=raw_flash.bin bs=1 skip=... count=... | xxd`

###  Libraries & Kernelmodule
- Shared Objects: `/lib/*.so*`, `/usr/lib/*.so*`
- Kernelmodule: `/usr/modules/*.ko`

###  Runtime Injection & Tools
- Telnet (default port 23/24, custom 31337)
- Busybox Deployment via:
  ```sh
  ./busybox-pwn --install -s /mnt/bbox-bin
  export PATH=/mnt/bbox-bin:$PATH
  ```

---

## Relevante Pfade
/etc/config/passwd`
/etc/passwd`
/lib/
/lib/*.so*`
/mnt/bbox-bin
/mnt/busybox-pwn
/mnt/busybox-pwn`
/mnt/dump/mtd*.bin`
/proc/PID/maps`
/tmp/sd/anyka_ipc_rtsp
/tmp/sd/dump/mtd*.bin`
/tmp/sd/hack.sh`
/tmp/sd/log_parser.sh
/tmp/sd`
/tmp`
/usr/bin/anyka_ipc`
/usr/lib/
/usr/lib/*.so*`
/usr/modules/*.ko`
/usr/sbin

## Verwendete grep/find/strings-Befehle


---




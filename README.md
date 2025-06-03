# 🕵️‍♀️ hama-smart-cam – Hacking Journey

Dieses Repository dokumentiert den Versuch, eine Hama Smart Cam mit einem Anyka AK39XXEV330 SoC und Tuya-Firmware zu reverse-engineeren und möglicherweise zu kompromittieren.

## 🎯 Gerätedetails & Technische Daten

* **Modell:** Hama Smart Cam (Discounter-Modell)
* **CPU:** ANYKA AK39XXEV330 (ID 0x20160101) [cite: 6, 39, 65, 95, 148, 175, 205, 242, 256, 285, 310, 327, 343, 368, 392]
* **RAM:** 64 MiB DRAM [cite: 1, 37, 143, 252, 265, 281, 294, 306, 319, 322, 339, 388]
* **Flash-Speicher:** `xm25qh64c` SPI-Flash, 16 MiB (16384 Kbytes) [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* **Kernel:** Linux version 4.4.192V2.1 (Buildroot 2018.02.7_V1.0.03-g9ff3371) [cite: 5, 38, 147, 255, 268, 284, 297, 309, 326, 342, 364, 383, 391]
* **Bootloader:** U-Boot 2013.10.0-V3.1.28_bchV1.0.00 (Apr 12 2023) [cite: 1, 37, 143, 252, 265, 281, 294, 306, 319, 322, 339, 388]
* **WLAN-Modul:** Nutzt `rtl8188ftv` Treiber (Modul wird entladen/geladen) [cite: 17, 50, 160, 223, 280, 338, 354]
* **MAC-Adresse:** Fixiert auf `78:22:88:B8:21:11` [cite: 17, 160]
* **SD-Karten-Support:** Ja, erwartet SD-Karte für Firmware-Updates und Konfigurationsdateien (`/mnt` als Mountpoint erwartet) [cite: 16, 49, 158, 279, 337, 353]
* **Kamera-Sensor:** SC2336 (Mipi-Treiber im Einsatz) [cite: 15, 48, 157, 278, 336, 352]

### 💾 Partitionen (auf dem SPI-Flash)

* `0x000000000000-0x000000032000 : "UBOOT"` [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x000000032000-0x000000033000 : "ENV"` [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x000000033000-0x000000034000 : "ENVBK"` [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x000000034000-0x000000040000 : "DTB"` [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x000000040000-0x0000001c0000 : "KERNEL"` [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x0000001c0000-0x0000002c0000 : "ROOTFS"` (SquashFS, Read-Only) [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x0000002c0000-0x000000300000 : "CONFIG"` (JFFS2) [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]
* `0x000000300000-0x000000800000 : "APP"` (JFFS2) [cite: 11, 44, 153, 261, 274, 290, 303, 315, 332, 348, 397]

## 📡 Netzwerk & Dienste

* **Cloud-Plattform:** Tuya-basiert (intensive Kommunikation mit `a2.tuyaeu.com`, `m2.tuyaeu.com`, `baal.tuyaeu.com`) [cite: 95, 96, 132, 134, 137, 139, 205, 206, 241, 242, 246]
* **RTC (Real-Time Communication):** Nutzt Tuya P2P RTC SDK (Version 0xf4030305) [cite: 133, 241]
* **Video-Encoding:** AKV Encoder Lib V3.0.29 (AVC_MAIN Profile, VBR, 1920x1080@15fps und 640x360@15fps) [cite: 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 251, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382]
* **Audio-Encoding/Decoding:** AAC, MP3, G711 Codecs unterstützt [cite: 26, 27, 28, 59, 60, 61, 169, 170, 171, 362, 363, 364]
* **ONVIF:** Startet `onvif_start.sh` [cite: 17, 160]
* **DHCP-Client:** Nutzt `udhcpc` [cite: 113, 114, 115, 121, 223, 224, 225, 230]
* **Kein Ethernet** festgestellt [cite: 3, 145, 253, 266, 282, 295, 307, 320, 323, 331, 340, 350, 389]
* **Zugewiesene IP-Adresse:** `192.168.2.160` (via DHCP) [cite: 126, 234]

## ❌ Bisherige Hacking-Versuche & Herausforderungen

1.  **U-Boot-Interrupt via UART:**
    * Versuche mit `Enter`, `Space`, `Ctrl+C`, `Esc` per PySerial-Skript (Multithreaded Spammer/Reader) scheiterten.
    * **Hypothese:** Extrem kurzes oder nicht-existenter Boot-Delay; möglicherweise unbekannte/spezifische Tastenfolge.
    * Die Kamera bootet konsequent in den Kernel, bevor der U-Boot-Prompt abgefangen werden kann.
2.  **Physikalischer SPI-Flash-Dump:**
    * Identifiziert als beste Methode für vollen Firmware-Zugriff.
    * **Aktuell ausgeschlossen** als Option.
3.  **SD-Karten-Shell-Hack (generisch):**
    * Die `EseeCloud`-spezifischen SD-Karten-Hacks sind für diese Tuya-Kamera nicht direkt anwendbar.
    * Fokus stattdessen auf Tuya-spezifische SD-Karten-Verhaltensweisen, basierend auf Bootlog-Fehlern.

## 📝 Wichtige Beobachtungen & Fehlermeldungen aus dem Bootlog

* **`rm: can't remove '/etc/config/shadow': No such file or directory`**: Deutet auf einen fehlenden Shadow-Datei hin, was auf Authentifizierungsprobleme oder eine unvollständige Konfiguration hindeuten könnte. [cite: 16, 49, 159, 279, 337, 353]
* **`dd: can't open '/mnt/_ak39_factory.ini': No such file or directory`** und ähnliche für `_ht_ap_mode.conf`, `_ht_av_tuning.conf`, `ftp_config.ini`, sowie `The Version Path "/mnt" Is Not Exist *.bin.`:
    * **Hypothese:** Die Kamera sucht aktiv nach diesen Dateien auf einer gemounteten SD-Karte (`/mnt`). [cite: 16, 49, 159, 279, 337, 353]
* **SD-Karte wird erkannt und initialisiert:** Nach dem Einlegen einer FAT32-formatierten SD-Karte (auch einer großen 500GB-Karte) wird diese vom U-Boot erkannt und initialisiert (`mmc_start_init: init OK!`, `cdh:sd card, mmc->capacity_user:0x7760000000 blocks!`, `cdh:test_part_dos DOS_MBR ok!`). Zuvor gab es Fehler bei der Initialisierung der MMC-Schnittstelle (`Bad device mmc 0`). [cite: 3, 4, 145, 146, 253, 254, 266, 267, 282, 283, 307, 308, 320, 321, 324, 325, 340, 341, 390]
* **Neue SD-Karten-Fehlermeldung:** `reading ht_recover_fw.conf` und `** Unable to read file ht_recover_fw.conf ** ht_recover_fw.conf not found` ist eine neue Erkenntnis, sobald eine SD-Karte erkannt wird. [cite: 4, 37]
* **LED-Fehler:** Skripte (`blue_led.sh`, `red_led.sh`, `state_led.sh`) können `/sys/class/leds/*/brightness` nicht erstellen/schreiben. [cite: 84, 96, 195, 206]
* **App-Verbindungsprobleme:** "Kamera verhält sich abnormal", "Check_Buffer not enough buffer_size", "ice 1 keepalive failed", "speaker not start", "CTRL VIDEO START failed".
    * **Ursache:** Bestimmte Hardware (Kamera-Sensor, Motoren, Lautsprecher/Mikrofon) ist nicht angeschlossen oder initialisiert. Die Kamera versucht dennoch, zu kommunizieren. [cite: 134, 135, 137, 241, 242, 244, 245]
* **Log-Upload-Fehler:** `upload loq seq /etc/config/logseq0 fail -926` deutet auf Tuya-Log-Upload-Versuche hin. [cite: 139, 246]

## 🚀 Nächste Schritte (Aktueller Plan)

1.  **SD-Karten-Analyse (Fortgeschritten - `ht_recover_fw.conf`)**:
    * **Ziel:** Herausfinden, welches Format `ht_recover_fw.conf` erwartet, um möglicherweise eine Firmware-Recovery oder Shell-Zugriff zu triggern.
    * **Aktion:** Erstelle die leere Datei `ht_recover_fw.conf` auf der bereits verwendeten FAT32-formatierten SD-Karte, zusammen mit den anderen bereits bekannten leeren Dateien (`_ak39_factory.ini`, `_ht_ap_mode.conf`, `_ht_av_tuning.conf`, `ftp_config.ini`, `firmware.bin`/`update.bin`).
    * SD-Karte einlegen, Kamera starten und den seriellen Output (Minicom) genauestens auf neue Fehlermeldungen überprüfen, die das erwartete Format verraten könnten.

2.  **Netzwerk-Scanning (Nmap)**:
    * **Ziel:** Offene Ports und aktive Dienste auf der Kamera identifizieren (Telnet, SSH, FTP, ONVIF).
    * **Aktion:** Führe einen umfassenden Nmap-Scan auf der ermittelten IP-Adresse der Kamera (`192.168.2.160`) durch:
        ```bash
        nmap -p- -sV -sC -O 192.168.2.160
        ```
    * Besonderes Augenmerk auf Port 23 (Telnet) und ONVIF-spezifische Ports.



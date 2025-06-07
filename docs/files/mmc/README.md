# mmc

SD-Karten-Mountpunkt für die Hama Smart Cam. Hier liegen Skripte und Dateien, mit denen über die SD-Karte Root-Zugriff, Einstellungen, Hacks und verschiedene Anpassungen an der Kamera vorgenommen werden können.

**Wichtige Dateien und Funktionen:**
- `_ht_ap_mode.conf`: (Konfigurationsdatei, vermutlich für AP-Modus)
- `custom.sh`: Custom-Skript – wird beim Booten von der SD ausgeführt, um individuelle Anpassungen zu laden.
- `hack.sh`: Haupt-Hackskript, setzt Root-Rechte und führt Anpassungen durch.
- `hostapd`: Binary für den Aufbau eines eigenen WLAN-Access-Points.
- `httpd.conf`: Konfiguration für den eingebetteten Webserver.
- `index.html`, `ptz.html`, `upload.html`: Webseiten für die Steuerung und Datei-Upload/Download.
- `log_parser.sh`: Script zum Auswerten von Logdateien.
- `mosquitto_pub`: MQTT-Client für das Senden von Nachrichten (z.B. für Automatisierung).
- `motor`: Binary zur Motorsteuerung der Kamera.
- `offline.sh`: Script, um die Kamera offline zu schalten/halten.
- `hosts`: Angepasste Hosts-Datei.
- `cgi-bin/`: Ordner für CGI-Skripte zur Websteuerung.

**Hinweis:**  
Viele Dateien sind als "Wächter" (Trigger für Hacks oder Schutz vor Überschreiben) gedacht und werden beim Booten von der Kamera automatisch ausgeführt, sofern sie auf der SD-Karte liegen.
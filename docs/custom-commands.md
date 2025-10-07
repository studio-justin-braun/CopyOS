# CopyOS Custom-Kommandos

CopyOS bietet eine kleine Auswahl deutschsprachiger Komfortbefehle, die auf BusyBox und Coreutils aufsetzen. Ziel ist es, dass auch Nutzer:innen mit minimaler Terminal-Erfahrung vertraute Begriffe vorfinden.

| Befehl           | Funktion                                                            | Implementierungsidee |
|------------------|----------------------------------------------------------------------|----------------------|
| `zeig [pfad]`    | Verzeichnisinhalte farbig auflisten (wie `ls`)                       | Wrapper um `ls --group-directories-first --color=auto` |
| `zu <pfad>`      | Wechselt das aktuelle Verzeichnis                                    | Shell-Funktion, die `cd` ausführt und anschließend eine neue `ash`-Instanz startet |
| `laufwerke`      | Listet alle Blockgeräte inkl. Größe, Typ, Mountpoint                 | `lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL,MODEL` |
| `sicherung-start`| Startet den interaktiven Sicherungsdialog erneut                      | Aufruf von `/usr/local/bin/copyos-launcher` |
| `hilfe`          | Zeigt eine Übersicht aller CopyOS-Kommandos                          | Anzeige eines formatierten Textblocks |
| `logbuch`        | Öffnet das jüngste Sicherungsprotokoll in `less`                      | `less /var/log/copyos/latest.log` |

## Beispiel: `zeig`
```sh
#!/bin/sh
exec ls --group-directories-first --color=auto "$@"
```

## Einbindung
1. Skripte in `/usr/local/bin` ablegen.
2. Mit `chmod +x` ausführbar machen.
3. Über `/etc/profile.d/copyos.sh` Begrüßungsnachricht setzen:
   ```sh
   echo "Willkommen bei CopyOS. Verfügbare Befehle: zeig, zu, laufwerke, sicherung-start, hilfe, logbuch"
   ```

## Tests
- Unit-Tests via `shunit2` für Wrapper-Skripte.
- Manuelle Tests im Fallback-Terminal.

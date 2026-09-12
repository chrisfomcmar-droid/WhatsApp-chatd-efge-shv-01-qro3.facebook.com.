# fix-kanel — notas

Nota: Se ha eliminado la entrada "chatd-edge-shv-01-qro3.facebook.com" de las listas de bloqueo porque interfería con WhatsApp. Antes de modificar archivos se crean backups (*.bak.TIMESTAMP).

Ejecuta el script para limpiar los ficheros de bloqueo en el repositorio (solo modifica archivos dentro del repositorio):

```bash
./scripts/clean-blocked-host.sh
```

Si necesitas restaurar alguna copia de seguridad, busca los archivos `*.bak.TIMESTAMP` creados por el script.

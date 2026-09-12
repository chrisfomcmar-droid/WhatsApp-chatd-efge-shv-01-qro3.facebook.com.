#!/usr/bin/env bash
# Limpia entradas que coincidan con el dominio dado en los archivos de bloqueo del repo
TARGET="chatd-edge-shv-01-qro3.facebook.com"
FILES=( "./hosts" "./blocklist.txt" ./blocklists/*.txt )

set -euo pipefail

echo "Buscando y limpiando entradas para: $TARGET"
for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    if grep -qF "$TARGET" "$f"; then
      echo "  Limpiando $f"
      # crear backup
      cp "$f" "$f.bak.$(date +%s)"
      # eliminar líneas que contengan el dominio
      grep -vF "$TARGET" "$f" > "$f.tmp" && mv "$f.tmp" "$f"
    fi
  fi
done

echo "Hecho. Se han creado copias de seguridad .bak.TIMESTAMP para cualquier archivo modificado." 

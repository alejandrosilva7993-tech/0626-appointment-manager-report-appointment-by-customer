#!/bin/bash
cd "$(dirname "$0")"
PORT=8081

if lsof -iTCP:"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Puerto $PORT ya en uso. Abriendo navegador..."
  open "http://localhost:$PORT/system-usage-by-customer.html"
  exit 0
fi

echo "Iniciando servidor en http://localhost:$PORT"
python3 -m http.server "$PORT" &
SERVER_PID=$!
sleep 1
open "http://localhost:$PORT/system-usage-by-customer.html"
echo "Servidor activo (PID $SERVER_PID). Cierra esta ventana o presiona Ctrl+C para detener."
wait $SERVER_PID

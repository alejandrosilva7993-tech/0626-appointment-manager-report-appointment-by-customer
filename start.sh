#!/bin/bash
cd "$(dirname "$0")"
PORT=8081

if lsof -iTCP:"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Puerto $PORT ya en uso."
  echo "Abrir: http://localhost:$PORT/system-usage-by-customer.html"
  exit 0
fi

echo "Servidor: http://localhost:$PORT/system-usage-by-customer.html"
python3 -m http.server "$PORT"

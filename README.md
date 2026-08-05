# System Usage by Customer — Appointment Manager

Prototipo HTML estático para la HU **Reports > System Usage by Customer**. Vista de reporte para clientes con métricas de citas y puntualidad por customer seleccionado.

## Ejecución local

**Opción recomendada (macOS):** haz doble clic en [`start.command`](start.command). Inicia el servidor y abre el navegador automáticamente.

**Opción terminal:**

```bash
cd ~/Documents/0626-appointment\ manager-report-appointment\ by\ customer
./start.sh
```

Abrir manualmente: [http://localhost:8081/system-usage-by-customer.html](http://localhost:8081/system-usage-by-customer.html)

> **Importante:** no abras el `.html` directamente desde Finder (`file://`). Este prototipo requiere un servidor local para cargar Flatpickr y los estilos PrimeNG correctamente.

## Stack

- PrimeNG theme `lara-light-blue` v17.18 + `primeng.min.css` (CDN)
- PrimeIcons
- Flatpickr (selector de fechas)
- **Chart.js v4** — gráfica de barras horizontal apilada por estatus (como System Usage Report)
- JavaScript vanilla con datos mock

## Flujo

1. Seleccionar **Customer** (obligatorio), **Start Date** y **End Date** (obligatorios).
2. Pulsar **Search** (habilitado solo con criterios válidos).
3. Durante la búsqueda aparece un loader que bloquea la interacción.
4. Si no hay datos → mensaje **MSG047**.
5. Si hay datos → sección **Information by Customer** + botón **Export to Excel** (UI only, sin descarga).

## Validaciones

| Campo | Regla |
|-------|-------|
| Customer | Obligatorio; solo customers con status Active |
| Start Date | Obligatorio, ≤ hoy |
| End Date | Obligatorio, ≥ Start Date |
| Rango | Máximo 31 días |

## MSG047 (texto exacto)

```
No results found

No information was found for the entered criteria.

Please try again.
```

## Escenarios de prueba

| Escenario | Customer | Rango | Resultado esperado |
|-----------|----------|-------|-------------------|
| Datos completos | Fast Cargo SA | Últimos 7 días | Card con citas + porcentajes de puntualidad |
| Otro customer | Southern Shipping | Últimos 7 días | Datos distintos, % recalculados |
| Sin datos (MSG047) | No Appointments Ltd | Cualquier rango válido | Panel "No results found" |
| Customer requerido | (vacío) | — | Search deshabilitado |
| Rango inválido | Cualquiera | > 31 días | Search deshabilitado + error inline |

## Colores de estado

Ver [`colores-estados-citas.html`](colores-estados-citas.html).

| Estado | HEX |
|--------|-----|
| Created | `#334155` |
| Confirmed | `#15803d` |
| Rejected | `#b91c1c` |
| Completed | `#7e22ce` |

## Porcentajes de puntualidad

Calculados sobre citas **Completed** del customer en el periodo:

| Métrica | Fórmula |
|---------|---------|
| Ahead of schedule | `completedAhead / completedTotal × 100` |
| On time | `completedOnTime / completedTotal × 100` |
| Late | `completedLate / completedTotal × 100` |

Si `completedTotal === 0`, los tres porcentajes muestran `0.0%`.

## Homologación Appointment Manager

Estilos alineados con [`0626-appointment-manager-report-system`](../0626-appointment-manager-report-system):

- Tokens CSS PrimeNG (`--text-color`, `--primary-color`, etc.)
- Botones, inputs, cards y loader consistentes
- Barra de criterios compacta con sticky tras primera búsqueda

# Our Software

| Piece | Where | What | Code |
|---|---|---|---|
| **Tablet UI** | On-board tablet, Fully Kiosk | Face + dashboard, one HTML file | [`assets/software/robot-ui.html`](assets/software/robot-ui.html) |
| **Remote dashboard** | Laptop browser | Task scheduler, video, voice, MQTT control | [`../../software/`](../../software/) (Vite + React 19 + TS) |
| **Boot daemon** | Tablet, Android init | Dual-network ([Tablet & Network](05-tablet-and-network.md)) | [`assets/tablet-network/`](assets/tablet-network/) |

## Tablet UI — `robot-ui.html`

Single-file HTML, ~4800 lines, no build. Loaded full-screen by Fully Kiosk.

What it does: MACS face (animated SVG), ElevenLabs voice agent, Gemini Live orchestrator (voice → mission plans), rosbridge client (`ws://192.168.20.22:9090/`), MQTT bridge to HiveMQ, dashboard tab with map and manual drive.

Run locally:

```powershell
start "" "assets/software/robot-ui.html"
```

Push to tablet: see ADB section in [Tablet & Network](05-tablet-and-network.md).

Notes: tablet is only 2 GB RAM, keep it lean. MQTT connect on eduroam takes 10–90 s (DPI) — connect eagerly on page load.

## Remote dashboard — React

Vite + React 19 + TypeScript at [`../../software/`](../../software/). Entry: [`../../software/App.tsx`](../../software/App.tsx).

Pages: Dashboard (task scheduler), Communication (Daily.co video), Interactive AI (LLM chat), Admin, Orders.

Deps: `@google/genai`, `@elevenlabs/react`, `@daily-co/daily-js`, `mqtt`, `socket.io-client`.

Run:

```powershell
cd ../../software
npm install
# GEMINI_API_KEY in .env.local
npm run dev
```

## How they connect

```
React dashboard ──MQTT/WSS──► HiveMQ ──MQTT/TLS──► Tablet ──rosbridge──► Chassis
```

The tablet bridges the robot LAN (rosbridge) to the internet (MQTT). The dashboard never talks to rosbridge directly — it works from anywhere with internet.

# References & Files

Everything inside `assets/` and `report/` lives in this guide folder — share the folder, share the docs.

## FYP report

Full LaTeX source and compiled PDF embedded in [`report/`](report/).

- [`report/main.pdf`](report/main.pdf) — compiled report
- [`report/main.tex`](report/main.tex) — root LaTeX file
- [`report/sections/`](report/sections/) — per-chapter sources
- [`report/figures/`](report/figures/) — figures used in the report
- [`report/references/`](report/references/), [`report/bib/`](report/bib/) — bibliography

Chapters:

1. Introduction
2. Literature Review
3. System Conceptual Design
4. Requirement Specification
5. System Implementation
6. Conclusions & Future Work

## Robot manuals — `assets/manuals/`

- [`iMRP500_user_manual.pdf`](assets/manuals/iMRP500_user_manual.pdf) — original Chinese user manual
- [`iMRP500_SPEC.pdf`](assets/manuals/iMRP500_SPEC.pdf) — spec sheet
- [`upper_computer_protocol_translated.pdf`](assets/manuals/upper_computer_protocol_translated.pdf) — WebSocket protocol (read this one)
- [`upper_computer_protocol_original.pdf`](assets/manuals/upper_computer_protocol_original.pdf) — original Chinese

## Reverse-engineering notes — `assets/notes/`

- [`reverse-engineering.md`](assets/notes/reverse-engineering.md) — topics, services, examples
- [`protocol-analysis-log.md`](assets/notes/protocol-analysis-log.md) — long session log of how we cracked it

## Vendor app — `assets/apk/`

- [`DeploymentTool.apk`](assets/apk/DeploymentTool.apk) — install per [Quick Start](01-quick-start.md)

## Tablet network — `assets/tablet-network/`

- [`README.md`](assets/tablet-network/README.md), [`DUAL_NETWORK_SETUP.md`](assets/tablet-network/DUAL_NETWORK_SETUP.md), [`DEPLOY.md`](assets/tablet-network/DEPLOY.md)
- [`dual_network.sh`](assets/tablet-network/dual_network.sh), [`dual_network.rc`](assets/tablet-network/dual_network.rc), [`ipconfig.txt`](assets/tablet-network/ipconfig.txt)

## Our software — `assets/software/`

- [`robot-ui.html`](assets/software/robot-ui.html) — tablet app
- [`TABLET_HANDOFF.md`](assets/software/TABLET_HANDOFF.md) — ADB cheat sheet

The React dashboard is large and lives in the repo at [`../../software/`](../../software/) — not duplicated here.

## Renders — `assets/renders/`

- [`engineering-drawing.png`](assets/renders/engineering-drawing.png) — overall dimensions
- [`front-render-1.png`](assets/renders/front-render-1.png), [`front-render-2.png`](assets/renders/front-render-2.png) — front renders
- [`back-view-tray.png`](assets/renders/back-view-tray.png) — rear tray
- [`viewing-angle.png`](assets/renders/viewing-angle.png) — 40° tilt justification
- [`acrylic-dimensions.png`](assets/renders/acrylic-dimensions.png) — acrylic cut sheet

Full 3D source (Fusion 360 `.f3z`, STEP, meshes — 361 MB) is too large to embed; lives at [`../../hardware/3d-models/`](../../hardware/3d-models/).

## Videos

The 13-min walkthrough is on YouTube: <https://www.youtube.com/watch?v=H_J-rPhog4M>. Vendor clips are embedded in [`assets/videos/`](assets/videos/). See [Videos](08-videos.md).

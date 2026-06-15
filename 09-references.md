# References & Files

Everything inside `assets/` and `report/` lives in this guide — share the folder, share the docs. Directory listings are linked to GitHub since the live site can't auto-list folders.

## FYP report

Full LaTeX source and compiled PDF embedded in [`report/`](https://github.com/oulla898/tamra-amr-guide/tree/main/report).

- [`report/main.pdf`](report/main.pdf) — compiled report
- [`report/main.tex`](report/main.tex) — root LaTeX file
- [`report/sections/`](https://github.com/oulla898/tamra-amr-guide/tree/main/report/sections) — per-chapter sources
- [`report/figures/`](https://github.com/oulla898/tamra-amr-guide/tree/main/report/figures) — figures used in the report
- [`report/references/`](https://github.com/oulla898/tamra-amr-guide/tree/main/report/references), [`report/bib/`](https://github.com/oulla898/tamra-amr-guide/tree/main/report/bib) — bibliography

Chapters:

1. Introduction
2. Literature Review
3. System Conceptual Design
4. Requirement Specification
5. System Implementation
6. Conclusions & Future Work

## Robot manuals — `assets/manuals/`

> **Heads up on filenames.** The vendor's `upper_computer_protocol_translated.pdf` is **not** a translation of the protocol — it's a Google-translated version of the chassis hardware manual. The actual API spec is `upper_computer_protocol_original.pdf` (Chinese).

- [`upper_computer_protocol_original.pdf`](assets/manuals/upper_computer_protocol_original.pdf) — **API spec** (WebSocket / rosbridge protocol, Chinese)
- [`upper_computer_protocol_translated.pdf`](assets/manuals/upper_computer_protocol_translated.pdf) — Chassis User Manual, machine-translated to English
- [`iMRP500_datasheet.pdf`](assets/manuals/iMRP500_datasheet.pdf) — datasheet
- [`iMRP500_SPEC.pdf`](assets/manuals/iMRP500_SPEC.pdf) — short spec sheet
- [`tablet-spec.docx`](assets/manuals/tablet-spec.docx) / [`tablet-spec-english.docx`](assets/manuals/tablet-spec-english.docx) — RK3566 tablet spec

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

The React dashboard is large and lives in the main project repo's `software/` folder — not duplicated here.

## Renders — `assets/renders/`

- [`engineering-drawing.png`](assets/renders/engineering-drawing.png) — overall dimensions
- [`front-render-1.png`](assets/renders/front-render-1.png), [`front-render-2.png`](assets/renders/front-render-2.png) — front renders
- [`back-view-tray.png`](assets/renders/back-view-tray.png) — rear tray
- [`viewing-angle.png`](assets/renders/viewing-angle.png) — 40° tilt justification
- [`acrylic-dimensions.png`](assets/renders/acrylic-dimensions.png) — acrylic cut sheet

Full 3D source (Fusion 360 `.f3z`, STEP, meshes — 361 MB) is too large to embed; lives in the main project repo's `hardware/3d-models/` folder.

## Videos

The 13-min walkthrough is on YouTube: <https://www.youtube.com/watch?v=H_J-rPhog4M>. Vendor clips are at [`assets/videos/`](https://github.com/oulla898/tamra-amr-guide/tree/main/assets/videos). See [Videos](08-videos.md).

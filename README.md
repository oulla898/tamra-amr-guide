# Tamra — Guide

> 🌐 **Live site:** <https://tamra-docs.vercel.app>

A short, hands-on guide to **Tamra (تمرة)**, an autonomous service robot built on the iMRP500 chassis.

## For developers (or your AI agent)

If you're writing software for the robot, you don't need to read most of this guide. Drop these into Claude / ChatGPT / your editor's AI and ask whatever you want — it'll have enough context to write working code:

| What | Why |
|---|---|
| 📗 [Upper-Computer Protocol (中文)](assets/manuals/upper_computer_protocol_original.pdf) | The actual WebSocket API spec. Chinese, but agents read it fine. |
| 🔧 [API summary + reverse-engineering notes](assets/notes/reverse-engineering.md) | Our distilled notes: topics, services, code snippets we verified against the live robot. |
| 📘 [Chassis User Manual (English, machine-translated)](assets/manuals/upper_computer_protocol_translated.pdf) | Hardware reference. Despite the filename, this is the chassis user manual translated by Google, not the protocol. |
| 📄 [iMRP500 Data Sheet](assets/manuals/iMRP500_datasheet.pdf) | One-page hardware overview. |

For tablet work, also grab the [tablet spec](assets/manuals/tablet-spec.docx). Everything else (ADB, dual-network daemon) is advanced — only when you need it.

Every page has a **📋 Copy page** button (top-right) that puts the raw markdown on your clipboard, ready to paste into an agent.

## ▶ Watch this first — 13-minute walkthrough

The single best thing for anyone new to the robot. Covers power-on, cables, tablet, apps, shutdown — all of it.

<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 1em 0;">
  <iframe
    src="https://www.youtube.com/embed/H_J-rPhog4M"
    title="TAMRA — 13-minute walkthrough"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    allowfullscreen
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border-radius: 6px;"></iframe>
</div>

Direct link: <https://www.youtube.com/watch?v=H_J-rPhog4M>

## Read in order (for humans)

| # | Page | |
|---|------|---|
| 1 | [Quick Start](01-quick-start.md) | 15 min: power on, install vendor app, map, drop waypoints, drive |
| 2 | [Meet the Robot](02-meet-the-robot.md) | Parts, cables, kill switch |
| 3 | [First Power-On](03-first-power-on.md) | The exact start sequence |
| 4 | [Mapping & Waypoints](04-mapping-and-waypoints.md) | Vendor DeploymentTool workflow |
| 5 | [Tablet & Network](05-tablet-and-network.md) | Dual-network, ADB, your laptop ↔ robot |
| 6 | [Our Software](06-our-software.md) | The tablet HTML app and the React dashboard |
| 7 | [Talking to the Robot](07-talking-to-the-robot.md) | rosbridge — topics, services, snippets |
| 8 | [Videos](08-videos.md) | 13-min walkthrough + vendor clips |
| 9 | [References & Files](09-references.md) | Index of every file |

## Safety

The kill switch is the big red button on the back of the body. Press it → wheels go free, robot is pushable. Press again to re-arm.

## Credits

Almoulla Talal Almaawali & Abdulmunim Khamis Albusaidi · Supervisor: Dr. Ahmed Chehib Ammari · Sultan Qaboos University · SQU Undergraduate Research Fund UF/ENG/ECE/25/326 · 2025–2026.

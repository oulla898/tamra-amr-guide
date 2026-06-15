# Tamra — Guide

> 🌐 **Live site:** <https://tamra-docs.vercel.app>

A short, hands-on guide to **Tamra (تمرة)**, an autonomous service robot built on the iMRP500 chassis.

## For developers (or your AI agent)

If you're writing software for the robot, you don't need to read most of this guide. Drop these into Claude / ChatGPT / your editor's AI and ask whatever you want — it'll have enough context to write working code:

| What | Why |
|---|---|
| 📗 [Protocol — English](assets/manuals/upper_computer_protocol_translated.pdf) | The official WebSocket API spec. Read this one. |
| 📕 [Protocol — Original (中文)](assets/manuals/upper_computer_protocol_original.pdf) | The Chinese original, for when the translation is ambiguous. |
| 🔧 [API summary + reverse-engineering notes](assets/notes/reverse-engineering.md) | Topics, services, code snippets we figured out by probing the live robot. |
| 📘 [iMRP500 user manual](assets/manuals/iMRP500_user_manual.pdf) | Hardware reference (Chinese). |

For tablet work, also grab the [tablet spec](assets/manuals/tablet-spec.docx). Everything else (ADB, dual-network daemon) is advanced — only when you need it.

Every page has a **📋 Copy page** button (top-right) that puts the raw markdown on your clipboard, ready to paste into an agent.

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

## Walkthrough

A 13-minute video covering everything you need to operate the robot: <https://www.youtube.com/watch?v=H_J-rPhog4M>

## Safety

The kill switch is the big red button on the back of the body. Press it → wheels go free, robot is pushable. Press again to re-arm.

## Credits

Almoulla Talal Almaawali & Abdulmunim Khamis Albusaidi · Supervisor: Dr. Ahmed Chehib Ammari · Sultan Qaboos University · SQU Undergraduate Research Fund UF/ENG/ECE/25/326 · 2025–2026.

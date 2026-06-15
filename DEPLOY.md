# Deploying the Guide

This folder is a static site. No build step. Drop it on anything that serves static files.

## Vercel

From this folder:

```powershell
npx vercel
# or
npx vercel --prod
```

Vercel will pick up `vercel.json` (clean URLs, asset caching) and serve `index.html` at the root. The markdown files are fetched client-side and rendered.

## GitHub Pages

Push this folder to a repo, then in **Settings → Pages**, point Pages at the folder (either the repo root if you push only `guide/`, or `/docs/guide` if pushing the whole project).

## Just opening the file

The markdown is fetched with `fetch()`, which most browsers block on `file://`. To preview locally, run any static server from this folder:

```powershell
python -m http.server 8080
# then http://localhost:8080/
```

## Editing

Edit the `.md` files. The site loads them at runtime — no rebuild needed. Refresh the page.

## What's served

- `index.html` — the shell with navigation
- `README.md` and `01-…09-*.md` — the guide pages
- `assets/` — APK, manuals, notes, scripts, software, renders, vendor videos
- `report/` — LaTeX sources + `main.pdf`

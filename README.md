# Pablo Travesso: links

Personal link page for **Pablo Travesso**, Oracle DBA (also PostgreSQL and MySQL).

**Live:** https://ptravesso-dba.github.io

The links are shown as the result of a SQL*Plus query (`SELECT channel, destination, status FROM pablo.links`) over a field of embers that drift up from a bonfire, link up like a schema graph and gather around the cursor. Clicking the background sends up sparks.

## Stack

- One static HTML file, no build dependencies or frameworks: hand-written HTML, CSS and a small canvas script.
- Fonts: Cinzel and JetBrains Mono (Google Fonts).
- Respects `prefers-reduced-motion` (the scene slows down instead of stopping).
- English and Portuguese, toggled in the top-right corner.

## Files

| Path | What it is |
|---|---|
| `src/links.html` | Source (an HTML fragment). |
| `build.sh` | Wraps the source into the standalone `index.html`. |
| `index.html` | Generated page served by GitHub Pages. Do not edit by hand. |
| `tools/serve.ps1` | Tiny local static server for previews (`http://localhost:8765`). |
| `src/head-site.html` | Favicon and share-card tags added only to the hosted page. |
| `assets/` | Favicon, touch icon and the 1200×630 share card (`og.png`). |
| `tools/og/` | Templates and `render.ps1`, which regenerates the share card and touch icon with headless Edge. |

## Update

```bash
bash build.sh
git commit -am "..." && git push
```

# Touch This — Team Dashboard

Live site: **https://harit556.github.io/touch-this/**

`index.html` is a deployed copy of the source dashboard, which lives in Harit's
Obsidian vault at `🧠 wiki/health/touch-this-dashboard.html`. That vault file is
the source of truth; this repo only hosts the public copy.

## Updating

Edit the vault file (or ask Claude to add a week's result, try scorers and MVP),
then from this folder run:

```bash
./deploy.sh "Add Season 2 week 1 vs <opponent>"
```

That copies the latest vault file in as `index.html`, commits, and pushes.
GitHub Pages rebuilds automatically, usually within a minute.

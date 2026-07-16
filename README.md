# Touch This

The stats dashboard for **Touch This**, a mixed touch rugby team playing the GO Mammoth league on Wednesday nights at Wandsworth Common Northside Field in southwest London.

### Live site: https://harit556.github.io/touch-this/

It tracks the team across every season: fixtures and results, the live league table, the playoffs, weekly attendance, try scorers, MVP awards, and a full write up for every match. It updates each week as results come in.

Two seasons are loaded so far:

* **Early Summer 2026** (finished): 7th of 7 in the league, then 6th overall after the playoffs. Winless, but the tries per game grew every week.
* **Late Summer 2026** (in progress): the current campaign, and the one that ended the wait. The first ever win came in week 3, 4 to 3 against Tag Me If You Can on 15 July, decided by the last play of the game.

## What is inside

The dashboard has five tabs, each with a toggle to switch season:

* **Overview** is the game day hub: the next match with a live countdown, the venue and kickoff, the head to head record against that opponent, recent form, the last result, and a ribbon that counted the wait for the first ever win until it landed.
* **Fixtures** lists every game across both seasons, filterable by season and competition. Tap a played game for its match report: score, try scorers, MVP, conditions, and the memorable moments.
* **Players** is a weekly attendance register (a dot per game) grouped by role (co captains, core team, ringers), with each player's nickname and nationality flag, plus the try scorers board and the MVP awards, each with a short citation for why they won it.
* **Standings** shows the full league table (played, won, drawn, lost, tries for and against, points) followed by the playoff bracket and final placings.
* **Stats** is the club wide numbers: games, win rate, tries scored and conceded, records (best attacking game, narrowest and heaviest defeats), the leaderboards, and a "by the numbers" summary, filterable by season or all time.

One league quirk to know: one try equals one point, so a team's tries are its match score, and the try scorers board is also the points board.

## How it is built

One self contained `index.html` file. No build step, no frameworks, no dependencies. All the data lives in a single `TT` JavaScript object inside the page, and everything (tables, leaderboards, head to head records, form guides, stats) is computed from it in the browser. Open the file anywhere and it works, even offline.

## Repository

* `index.html` is the dashboard, a deployed copy of the source.
* `deploy.sh` copies the source in, commits, pushes, and waits for the GitHub Pages build to confirm it went live.
* `.nojekyll` tells GitHub Pages to serve the file as is rather than running it through Jekyll. Do not remove it, or the build fails.

The source of truth is the original in Harit's Obsidian vault at `🧠 wiki/health/touch-this-dashboard.html`. This repository only hosts the public copy that GitHub Pages serves.

## Updating each week

Edit the vault file (or ask Claude to add the week's result, attendance, try scorers and MVP), then from this folder run:

```bash
./deploy.sh "Late Summer week 2 vs Wandsworth Wasps"
```

That copies the latest vault file in as `index.html`, commits, pushes, and then waits for the Pages build so a failed build is never mistaken for a live one. The site rebuilds in about a minute.

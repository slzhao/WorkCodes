# How WorkCodes was designed

A record of the decisions behind this repo and why they were made, so that work can
continue on another machine without the original conversation. `README.md` is the
rules as they stand now; this file is where they came from and what was rejected.

**Written 2026-11-12** (Shilin Zhao with Claude), from the discussion that set the repo up.

---

## The problem

`WorkRecords` tracks projects: background, collaborators, tasks, decisions. It had no
home for the code. Code was ending up in three kinds of places — ACCRE scratch folders
under `/nobackup`, loose files on the Windows PC, and nowhere at all — with no way to
get from a project record to the code that produced its results.

`WorkCodes` is that home. Two repos rather than one, because records change in meetings
and code changes at the keyboard, and mixing them makes the history of each harder to read.

## Decisions

### 1. Three levels: PI / project / files, flat inside the project

`<PI>/<project>/<dated files>`, mirroring the WorkRecords folder layout.

No subfolders inside a project, and no split by file type. The usual research-compendium
layout (Marwick et al. 2018, *Packaging data analytical work reproducibly*; `rrtools`)
separates reusable code in `R/` from analysis notebooks in `analysis/`, and that was
proposed first. **Rejected** as too much structure for projects of this size, where a
project is typically three to six report files and nothing is reused across them.

The asset folders a report template brings with it (`report-assets/`, `data/`) are not a
violation of this — they belong to the tooling, not to how the analyses are organised.

### 2. Dated filenames, same stem for a new version

`YYYYMMDD_short_name.qmd`, with the **start** date, and the same name stem reused when a
file is a later version of an earlier analysis.

Dating buys something git does not: the sequence of what was done is visible by listing one
folder, without running `git log`. The cost is near-duplicate files, which is why old files
are never edited to fix them — a changed analysis gets a new date, and the project README
marks the old one `superseded by <date>`. Reusing the stem is what makes a flat folder
readable as a history rather than a pile.

**Rejected:** `2026-11-12_` with hyphens, proposed first and withdrawn. The WorkRecords
`CLAUDE.md` already says not to mix hyphens and underscores in a name, and the compact
8-digit form obeys that rule. Both sort correctly, so this is consistency, nothing more.

`snake_case` over `camelCase` for the name part, to match the record filenames
(`beacon_pilot.md`, `pf5_lung_proteomics_signature.md`). Cosmetic, but one scheme is
easier to follow than two.

### 3. The link between a record and its code

Written on both sides, keyed on `project_id`:

| Side | What carries the link |
|---|---|
| Record (`WorkRecords/<PI>/<project>.md`) | a `## Code` section pointing at the folder |
| Code folder | `project_id` in its `README.md`, and in each file's header comment |

Keyed on `project_id` rather than folder name alone so a rename does not silently break it.

Not every record has code — grants, papers and meeting-only projects never will — and not
every bit of code has a record. **The two sides are deliberately not required to line up
one to one**, and a folder with no counterpart is not a problem to fix.

### 4. Where the repo lives

Cloned on the Windows PC, cqs4 and the MacBook Air, synced through GitHub, the same as
WorkRecords. Location was considered and judged not to matter, since git is the transport.

The one consequence that does matter: **data is not synced.** A file that runs on cqs4 will
not find its data on the MacBook. So each project README records the data path per machine,
and files set the data directory once at the top instead of hard-coding paths.

### 5. Data never enters the repo

`.gitignore` blocks analysis objects (`.rds`, `.RData`, `.h5ad`, `.adat`, …), `data/`
directories, knit caches and anything matching `*_api_key*`. A committed data file stays in
git history permanently even after deletion, which is why this is a rule and not a habit.

Knitted `.html` **is** committed — it is the thing that gets sent to a PI, so it belongs
with the code that made it.

### 6. Reports come from the `reporttemplates` package

New report files are created with `reporttemplates::new_report()` (Shilin's own package,
v0.2.0, installed locally), not written from scratch, so every report gets the house look.
It also drops `report-assets/` into the project folder; that folder is committed, because
without it the report will not render on another machine.

### 7. Projects with their own repository stay out

An R package, or anything that needs its own git history, keeps its own repo. Its folder
here holds a README with the repo URL and nothing else. Those are explicitly not what this
repo is for.

### 8. No `CLAUDE.md` in this repo

Claude is not run with this repo as its working directory — analysis files are written in
RStudio by hand. Claude works from `WorkRecords`, whose `CLAUDE.md` carries the rules for
maintaining both repos. This file and `README.md` are written for a human reader first.

## How the two repos are kept in step

Claude is asked, from a `WorkRecords` session, to create a project folder and its README.
Analysis files are then written directly in RStudio, following the naming rule, each with
the header comment block. Nobody reports files one at a time: the next time Claude is asked
anything about that project, it lists the folder, picks up whatever is new, and updates the
project README table and the record's `## Code` section.

## Still open

- No project has real data in it yet, so the per-machine data path convention is written
  down but not yet tested on cqs4 or the MacBook.
- Only `evan_beacon_pilot` exists. The other projects get folders as they need them, not
  in a bulk pass.
- Whether the knitted `.html` stays committed once reports start carrying large embedded
  figures. `embed-resources: true` in the Quarto template makes a single self-contained
  file, which is convenient to send and large to store. Revisit if a report passes ~20 MB.

# WorkCodes

Analysis code for the projects tracked in [WorkRecords](https://github.com/slzhao/WorkRecords).

`WorkRecords` holds *what a project is and what has to happen*.
`WorkCodes` holds *the code that does it*. One repo per purpose, linked by `project_id`.

The rules are below. Why they were chosen, and what was rejected, is in
[DESIGN.md](DESIGN.md) — read that before changing any of them.

Cloned on the Windows PC, cqs4 and the MacBook Air, synced through GitHub.
**Run `git pull` before working and `git push` after**, the same as WorkRecords.

## Layout

```
WorkCodes/
├── README.md
├── DESIGN.md
├── .gitignore
└── <PI>/                     # same PI/person folders as WorkRecords; General/ for no PI
    └── <project>/            # same name as the project's .md file in WorkRecords
        ├── README.md         # the index: what each file is, and which is current
        ├── 20261112_*.qmd    # analysis files, flat and dated
        ├── report-assets/    # stylesheets and helpers from reporttemplates (committed)
        └── data/             # input data (never committed)
```

A project folder's name matches its record's filename, so `Evan/beacon_pilot/`
goes with `WorkRecords/Evan/beacon_pilot.md` (`project_id: evan_beacon_pilot`).
The `project_id` is written in the project README and in each file's header, so the
link survives a rename.

Analysis files sit flat in the project folder — they are not split into subfolders by
type or by stage. `report-assets/` and `data/` are the only subfolders, and they come
from the report template rather than from how the work is organised.

Not every record has code (grants, papers) and not every bit of code has a record.
That is expected — the folders do not have to line up one to one.

## Creating a new report

Use the house template rather than writing a file from scratch, so every report gets the
same look. From inside the project folder, in R:

```r
reporttemplates::new_report("20261112_data_processing", style = "quarto")
```

That writes `20261112_data_processing.qmd` and, if they aren't there already,
`report-assets/` and an example `data/`. It leaves existing files alone, so running it
again for the next report in the same project is safe.

The template hides R code in the output. `echo: true` in the header turns it back on as
folded code with a Code menu.

## File naming

```
YYYYMMDD_short_name.qmd
```

| Part | Rule | Example |
|---|---|---|
| Date | 8 digits, no separators. The date the file was **started**. | `20261112` |
| Name | lowercase `snake_case`, 1-3 words, says what the file does | `data_processing` |
| Extension | `.qmd` for reports (the house default), else `.Rmd`, `.R`, `.py`, `.sh` | `.qmd` |

Reuse the **same name stem** when a file is a new version of an earlier analysis.
That is what turns a flat folder into a readable history:

```
20261112_data_processing.qmd
20261112_data_analysis_report.qmd
20270216_data_analysis_report.qmd    <- same stem = new version of the report
```

Keep the stem vocabulary small and reuse it across projects:

| Stem | For |
|---|---|
| `data_processing` | load, clean, QC, build the object to analyze |
| `data_analysis_report` | the analysis and figures you would show someone |
| `figures` | figure-only reruns for a paper or slides |
| `scratch` | exploration not meant to be kept |

Old files are never edited to "fix" them — a changed analysis gets a new date and
a new file, and the project README marks the old one `superseded by <date>`.

## The header block in every file

Directly under the YAML header, a comment block saying which project the file belongs to
and what it is for. A comment rather than visible text, so it never appears in the report:

```
<!--
project_id: evan_beacon_pilot
record:     WorkRecords/Evan/beacon_pilot.md
purpose:    Load the SomaScan and SomaKrex iOme exports, QC them, and build the
            analysis object for the 3 groups.
status:     current
-->
```

In a `.R` or `.py` file, the same five lines as ordinary `#` comments.

`status:` is `current` or `superseded by <YYYYMMDD>`. With this block and a real `title:`,
the project README and the WorkRecords entry can be kept up to date without reading
the code.

## What is committed, and what is not

| Committed | Not committed |
|---|---|
| `.qmd`, `.Rmd`, `.R`, `.py`, `.sh` | any data file (see `.gitignore`) |
| the knitted `.html` next to its source | `data/` folders |
| `report-assets/` — reports will not render without it | knit caches (`*_files/`, `*_cache/`) |
| project `README.md` | anything with a key or password in it |

Data lives on the cluster or the PC, never here, and GitHub does not sync it.
Each project README records the data path per machine, because a file that runs
on cqs4 will not find its data on the MacBook. Set the data directory once at the top
of a file rather than hard-coding paths.

## Projects with their own repository

An R package or anything that needs its own git stays in its own repository.
Its folder here holds a README with the repo URL and nothing else.

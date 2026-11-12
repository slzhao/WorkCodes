# WorkCodes

Analysis code for the projects tracked in [WorkRecords](https://github.com/slzhao/WorkRecords).

`WorkRecords` holds *what a project is and what has to happen*.
`WorkCodes` holds *the code that does it*. One repo per purpose, linked by `project_id`.

Cloned on the Windows PC, cqs4 and the MacBook Air, synced through GitHub.
**Run `git pull` before working and `git push` after**, the same as WorkRecords.

## Layout

```
WorkCodes/
├── README.md
├── .gitignore
└── <PI>/                  # same PI/person folders as WorkRecords; General/ for no PI
    └── <project>/         # same name as the project's .md file in WorkRecords
        ├── README.md      # the index: what each file is, and which is current
        └── <files>        # flat, dated, no subfolders
```

A project folder's name matches its record's filename, so `Evan/beacon_pilot/`
goes with `WorkRecords/Evan/beacon_pilot.md` (`project_id: evan_beacon_pilot`).
The `project_id` is written in the project README, so the link survives a rename.

Not every record has code (grants, papers) and not every bit of code has a record.
That is expected — the folders do not have to line up one to one.

## File naming

```
YYYYMMDD_short_name.Rmd
```

| Part | Rule | Example |
|---|---|---|
| Date | 8 digits, no separators. The date the file was **started**. | `20261103` |
| Name | lowercase `snake_case`, 1-3 words, says what the file does | `data_processing` |
| Extension | `.Rmd`, `.R`, `.py`, `.sh` | `.Rmd` |

Reuse the **same name stem** when a file is a new version of an earlier analysis.
That is what turns a flat folder into a readable history:

```
20261103_data_processing.Rmd
20261103_data_analysis_report.Rmd
20270216_data_analysis_report.Rmd    <- same stem = new version of the report
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

## What goes in a file

RStudio's YAML header plus one sentence is enough:

```yaml
---
title: "Beacon pilot - analysis report"
date: "2026-11-03"
output: html_document
---

Purpose: rerun DE with the new normalization; Fig 2 redone at Evan's request.
```

A real `title:` and a `Purpose:` line. With those, the project README and the
WorkRecords entry can be kept current without reading the code.

## What is committed, and what is not

| Committed | Not committed |
|---|---|
| `.Rmd`, `.R`, `.py`, `.sh` | any data file (see `.gitignore`) |
| the knitted `.html` next to its `.Rmd` | knit caches (`*_files/`, `*_cache/`) |
| project `README.md` | anything with a key or password in it |

Data lives on the cluster or the PC, never here, and GitHub does not sync it.
Each project README records the data path per machine, because a file that runs
on cqs4 will not find its data on the MacBook.

## Projects with their own repository

An R package or anything that needs its own git stays in its own repository.
Its folder here holds a README with the repo URL and nothing else.

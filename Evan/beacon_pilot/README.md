# BEACON Pilot - code

| | |
|---|---|
| `project_id` | `evan_beacon_pilot` |
| Record | [WorkRecords/Evan/beacon_pilot.md](https://github.com/slzhao/WorkRecords/blob/main/Evan/beacon_pilot.md) |
| PI | Evan Brittain |
| Status | active - processing report in progress, data downloaded 2026-11-13 |

Background, collaborators, tasks and decisions live in the record. This file is
only the index of the code in this folder.

## Data

| | |
|---|---|
| Source | SomaLogic dashboard (Shilin has access; DUA completed 2026-10-30) |
| Downloaded to | WorkFiles (OneDrive) `Evan/beacon_pilot/data/`, 2026-11-13 |
| MacBook path | `~/Library/CloudStorage/OneDrive-VUMC/WorkFiles/Evan/beacon_pilot/data/` (the report's `workDir`) |
| Linux path (cqs4) | *to be filled in* (OneDrive does not sync to cqs4) |
| Windows path | *to be filled in* (`X:` = `/nobackup`) |

32 BioVU plasma samples, 3 groups (`SSc`, `Raynaud's`, `RheuCtls`), two platforms
(SomaScan v5.0; Sengenics KREX i-Ome, IgA and IgG). All 3 pairwise comparisons are of interest. See the
record for what is confirmed and what is still being checked.

Set the data directory once at the top of each file rather than hard-coding paths,
so the same file runs on the PC and on cqs4.

## Files

Newest first. `current` = the version to use; `superseded by <date>` = kept as a record.

| File | What it does | Status |
|------|--------------|--------|
| `20261112_data_processing.qmd` | Load the SomaScan and SomaKrex iOme exports, QC them, build the analysis object | current - in progress; reads the SomaScan ADATs from WorkFiles |

`report-assets/` holds the stylesheets and helpers that came with the report template and
is committed. The input data stay in WorkFiles, not in this folder.

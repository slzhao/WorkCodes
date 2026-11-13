# PSORC Paraneoplastic Syndromes Study - code

| | |
|---|---|
| `project_id` | `bo_psorc_paraneoplastic_syndromes` |
| Record | [WorkRecords/Bo/psorc_paraneoplastic_syndromes.md](https://github.com/slzhao/WorkRecords/blob/main/Bo/psorc_paraneoplastic_syndromes.md) |
| PI | Harold "Bo" N. Lovvorn, III, M.D. |
| Status | active - first report in progress (reads the raw export, Table 1 of all variables) |

Background, collaborators, tasks and decisions live in the record. This file is
only the index of the code in this folder.

## Data

| | |
|---|---|
| Source | PSORC PNS dataset, forwarded by Maddie Peters (PSORC, Cincinnati Children's) on 2026-10-01 |
| Project files folder | OneDrive `WorkFiles/Bo/psorc_paraneoplastic_syndromes/` - `data/` for the dataset, `manuscript/` for drafts |
| MacBook path | `~/Library/CloudStorage/OneDrive-VUMC/WorkFiles/Bo/psorc_paraneoplastic_syndromes/data` |
| Windows path | `%OneDriveCommercial%\WorkFiles\Bo\psorc_paraneoplastic_syndromes\data` - *not yet checked on the PC* |
| Linux path (cqs4) | *none - OneDrive is not synced to cqs4* |

Neuroblastoma patients from PSORC. Primary exposure: PNS yes vs. no (expected ~5-10%).
Secondary exposure: `timing_symptom_onset` (1, 2, 3). See the record for the planned
contrasts and key variables.

`data_dir` is set once in each file's setup chunk, picking the path for the machine it runs on.

## Files

Newest first. `current` = the version to use; `superseded by <date>` = kept as a record.

| File | What it does | Status |
|------|--------------|--------|
| `20261112_data_analysis_report.qmd` | Load the PSORC PNS dataset, define the PNS and `timing_symptom_onset` exposures, build Table 1 of the key variables | current - in progress: reads the raw export and gives a Table 1 of all variables (edits and knitted `.html` not yet committed, 2026-11-12) |

`report-assets/` holds the stylesheets and helpers that came with the report template and
is committed; `data/` holds the input files and is never committed. The `data/` folder
here holds only the template's example file - the real data is in OneDrive (above).

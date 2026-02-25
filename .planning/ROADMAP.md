# Roadmap: Reddit AI-in-Healthcare ABSA Pipeline

## Milestone: v1.0 — End-to-End Pipeline + Shiny Dashboard
**Phases:** 01 → 04
**Status:** Planning

---

## Phase 01 — Foundation & Data Preprocessing
**Goal:** Clean, filter, and contextually enrich raw Reddit CSV data so it is ready for LLM classification.

| Plan | Description | Status |
|------|-------------|--------|
| 01-01 | R project setup — package dependencies, config file, folder structure, helper utilities | ☐ Pending |
| 01-02 | Data loading + initial filtering — date (≥ 2020), deduplication, minimum text length | ☐ Pending |
| 01-03 | Thread reconstruction — link comments to parent posts/comments via `parent_id`/`link_id` | ☐ Pending |
| 01-04 | LLM relevance classification — Claude via ellmer, thread context injected for comments | ☐ Pending |
| 01-05 | GPTZero AI-detection filtering — API integration, batching, quota tracking, output flag | ☐ Pending |

**Output:** `data/processed/filtered_dataset.rds` — clean, relevant, human-authored records with thread context attached

---

## Phase 02 — ABSA Labelling
**Goal:** Use Claude (via ellmer) to assign aspect labels to each discussion excerpt using the hybrid taxonomy.

| Plan | Description | Status |
|------|-------------|--------|
| 02-01 | Aspect taxonomy definition + LLM prompt design — structured JSON output, few-shot examples | ☐ Pending |
| 02-02 | ABSA pipeline execution — batch LLM calls, rate-limit handling, cost estimation, checkpointing | ☐ Pending |
| 02-03 | Aspect normalisation — deduplicate novel aspects, map to canonical labels, produce final labelled dataset | ☐ Pending |

**Output:** `data/processed/absa_labelled.rds` — each record with one or more aspect labels, including novel aspects flagged for review

---

## Phase 03 — Transformer Inference (Python)
**Goal:** Run sentiment and emotion prediction via HuggingFace transformer models in a standalone Python script.

| Plan | Description | Status |
|------|-------------|--------|
| 03-01 | Python inference script — environment setup, batch inference for both models, output to parquet | ☐ Pending |
| 03-02 | Results integration into R — read parquet, merge with ABSA dataset, validate join integrity | ☐ Pending |

**Output:** `data/processed/full_pipeline_output.rds` — complete dataset with aspect labels + sentiment + emotion scores

---

## Phase 04 — Shiny Dashboard
**Goal:** Build an interactive local Shiny app for exploring results by subreddit, keyword, aspect, sentiment, and emotion.

| Plan | Description | Status |
|------|-------------|--------|
| 04-01 | Data preparation layer — pre-compute aggregations, summary tables, and lookup structures | ☐ Pending |
| 04-02 | Shiny app skeleton — UI layout (bslib/shinydashboard), module structure, server scaffold | ☐ Pending |
| 04-03 | Filter panels + reactive data — subreddit, keyword, aspect, sentiment, emotion, date range | ☐ Pending |
| 04-04 | Core visualisations — sentiment distribution, emotion breakdown, aspect frequency, trends over time | ☐ Pending |
| 04-05 | Text drill-down + polish — record-level browser, aspect highlight, export button, final integration | ☐ Pending |

**Output:** Working local Shiny app (`app/`) readable from `data/processed/full_pipeline_output.rds`

---

## Milestone Completion Checklist: v1.0

- [ ] All 13 plans complete (SUMMARY.md exists for each)
- [ ] `data/processed/full_pipeline_output.rds` exists and is valid
- [ ] Shiny app launches with `shiny::runApp("app/")` without errors
- [ ] All filters are functional and reactive
- [ ] Pipeline is documented with a `PIPELINE_GUIDE.md` (run order, config, quotas)
- [ ] Git tag: `v1.0`

---

## Planned Future Iterations (v1.1+)

- Expand Shiny dashboard with more complex drill-down views
- Add inter-rater reliability evaluation for LLM labels
- Explore deployment to shinyapps.io
- Add thread/network visualisation
- Support comparison across different time periods

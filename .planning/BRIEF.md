# Reddit AI-in-Healthcare ABSA Pipeline + Shiny Dashboard

**One-liner**: An end-to-end R pipeline that filters, classifies, and performs aspect-based sentiment and emotion analysis on Reddit discussions about AI in healthcare, visualised in an interactive Shiny dashboard.

## Problem

Researchers studying public and clinical opinion on AI in healthcare have access to large volumes of Reddit discussion data, but it is unstructured, noisy, and contains irrelevant or AI-generated content. Manually analysing sentiment and aspect-level opinion at scale is infeasible. This pipeline automates the full workflow — from raw CSV through filtering, ABSA labelling, and transformer-based sentiment/emotion prediction — and surfaces results in a navigable dashboard.

## Success Criteria

- [ ] Raw Reddit CSVs are loaded, deduplicated, date-filtered (≥ 2020), and thread-reconstructed
- [ ] LLM (Claude via ellmer) correctly classifies discussion relevance using full thread context (not just comment text in isolation)
- [ ] GPTZero API filters out likely AI-generated content within the 300k words/month quota
- [ ] LLM assigns aspect labels from a hybrid taxonomy (seed list + novel aspect discovery)
- [ ] Python batch inference script produces sentiment (cardiffnlp/twitter-roberta) and emotion (SamLowe/roberta-go_emotions) labels for all records
- [ ] Shiny dashboard supports drill-down filtering by subreddit, search keyword, aspect, sentiment, emotion, and date
- [ ] Full pipeline is reproducible and documented with clear run instructions

## Constraints

- Primary language: R (with one standalone Python script for transformer inference)
- LLM: Claude (Anthropic) via `ellmer` R package
- GPTZero: 300k words/month API quota — batching and quota tracking required
- Transformer models: `cardiffnlp/twitter-roberta-base-sentiment-latest` (sentiment), `SamLowe/roberta-base-go_emotions` (emotion)
- Data: 5,000–50,000 Reddit records in CSV format (ID, timestamp, subreddit, keyword, text, type flag, score)
- Deployment: Local only (personal machine)
- Thread context: Comments must be evaluated for relevance using parent post/comment context

## Seed Aspect Taxonomy (Hybrid)

Initial aspects (LLM may extend this list):
- **Accuracy & Reliability** — diagnostic performance, errors, hallucinations, false positives/negatives
- **Privacy & Data Security** — patient data, HIPAA, data governance, consent
- **Ethics & Bias** — algorithmic fairness, equity, representativeness
- **Regulation & Policy** — FDA, oversight, legal frameworks, liability
- **Job Impact & Workflow** — clinician roles, automation, efficiency, resistance
- **Patient Outcomes & Safety** — direct clinical risk and benefit, harm reduction
- **Trust & Adoption** — public/clinical trust, scepticism, barriers to uptake
- **Cost & Accessibility** — healthcare costs, access disparities, resource constraints

## Out of Scope (v1.0)

- Real-time Reddit data collection (data already collected)
- Deployment to shinyapps.io or any hosted environment
- Inter-rater reliability / human validation of LLM labels
- Fine-tuning of transformer models
- Multi-language support (English only)
- Network/thread visualisation (beyond basic drill-down)

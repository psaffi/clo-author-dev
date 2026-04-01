# CLAUDE.MD -- Applied Econometrics Research with Claude Code

<!-- HOW TO USE: Replace [BRACKETED PLACEHOLDERS] with your project info.
     Customize Beamer environments for your talk preamble.
     Keep this file under ~150 lines — Claude loads it every session.
     See the guide at https://hugosantanna.github.io/clo-author/ for full documentation. -->

**Project:** Securities Lending and Information Acquisition 
**Institution:** CUNEF Universidad
**Branch:** main

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- compile and confirm output at the end of every task
- **Single source of truth** -- Paper `main.tex` is authoritative; talks and supplements derive from it
- **Quality gates** -- weighted aggregate score; nothing ships below 80/100; see `quality.md`
- **Worker-critic pairs** -- every creator has a paired critic; critics never edit files
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong → right` to MEMORY.md

---

## Research Summary

**Question:** Do mutual funds use the equity lending market to acquire information about short-sale demand and trade on it?

**Setting:** German open-end equity mutual funds (320 funds, 36 families, Dec 2014--Dec 2018) using Bundesbank Investment Fund Statistics (IFS) with security-level lending data.

**Key findings:** Active funds reduce positions in stocks they lend by ~0.33 pp when lending increases. The effect is amplified when a mandatory short-position disclosure follows (interaction: -0.80 to -0.86). Passive funds show no reaction (placebo). Information flows most strongly through same-manager fund lending; within-family spillovers exist but are weaker. The effect is stronger in concentrated lending markets.

**Authors:** Greppmair, Jank, Saffi, Sturgess

---

## Folder Structure

```
[YOUR-PROJECT]/
├── CLAUDE.MD                    # This file
├── .claude/                     # Rules, skills, agents, hooks
├── Bibliography_base.bib        # Centralized bibliography
├── Paper/                       # Main LaTeX manuscript (source of truth)
│   ├── main.tex                 # Primary paper file
│   └── sections/                # Section-level .tex files
├── Talks/                       # Derivative Beamer presentations
│   ├── job_market_talk.tex      # 45-60 min, full results
│   ├── seminar_talk.tex         # 30-45 min, standard seminar
│   ├── short_talk.tex           # 15 min, conference session
│   └── lightning_talk.tex       # 5 min, spiel/elevator pitch
├── Data/                        # Project data
│   ├── raw/                     # Original untouched data (often gitignored)
│   └── cleaned/                 # Processed datasets ready for analysis
├── Output/                      # Intermediate results (logs, temp files)
├── Figures/                     # Final figures (.pdf, .png) referenced in paper
├── Tables/                      # Final tables (.tex) referenced in paper
├── Supplementary/               # Online appendix and supplements
├── Replication/                 # Replication package for deposit
├── Preambles/header.tex         # LaTeX headers / shared preamble
├── scripts/                     # Analysis code (R, Stata, Python, Julia)
├── quality_reports/             # Plans, session logs, reviews, scores
├── explorations/                # Research sandbox (see rules)
├── templates/                   # Session log, quality report templates
└── master_supporting_docs/      # Reference papers and data docs
```

---

## Commands

```bash
# Paper compilation (3-pass, XeLaTeX only)
cd Paper && TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
BIBINPUTS=..:$BIBINPUTS bibtex main
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex

# Talk compilation
cd Talks && TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode talk.tex
```

---

## Quality Thresholds

| Score | Gate | Applies To |
|-------|------|------------|
| 80 | Commit | Weighted aggregate (blocking) |
| 90 | PR | Weighted aggregate (blocking) |
| 95 | Submission | Aggregate + all components >= 80 |
| -- | Advisory | Talks (reported, non-blocking) |

See `quality.md` for weighted aggregation formula.

---

## Skills Quick Reference

| Command | What It Does |
|---------|-------------|
| `/new-project [topic]` | Full pipeline: idea → paper (orchestrated) |
| `/discover [mode] [topic]` | Discovery: interview, literature, data, ideation |
| `/strategize [question]` | Identification strategy or pre-analysis plan |
| `/analyze [dataset]` | End-to-end data analysis |
| `/write [section]` | Draft paper sections + humanizer pass |
| `/review [file/--flag]` | Quality reviews (routes by target: paper, code, peer) |
| `/revise [report]` | R&R cycle: classify + route referee comments |
| `/talk [mode] [format]` | Create, audit, or compile Beamer presentations |
| `/submit [mode]` | Journal targeting → package → audit → final gate |
| `/tools [subcommand]` | Utilities: commit, compile, validate-bib, journal, etc. |

---

<!-- CUSTOMIZE: Replace the example entries below with your own
     Beamer environments for talks. 

## Beamer Custom Environments (Talks)

| Environment       | Effect        | Use Case       |
|-------------------|---------------|----------------|
| `[your-env]`      | [Description] | [When to use]  |

--- -->

## Current Project State

| Component | File | Status | Description |
|-----------|------|--------|-------------|
| Paper | `Paper/main.tex` | draft | Securities lending information acquisition — full paper |
| Data | `Data/` | external | Bundesbank IFS, Datastream, IHS Markit, Morningstar |
| Tables | `Tables/` | complete | Tables 1-9 (desc stats + regressions) |
| Replication | `Replication/` | not started | Stata-based analysis |
| Talks | `Talks/` | not started | -- |

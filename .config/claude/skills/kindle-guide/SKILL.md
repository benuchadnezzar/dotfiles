---
name: kindle-guide
description: Builds a short, practical syntax/reference guide as a Kindle-sized PDF and emails it straight to the user's Kindle. Use whenever the user invokes /kindle-guide, or asks for a "guide", "cheat sheet", "reference", or "PDF" for a library, tool, or language, especially if they mention their Kindle or want something to read offline. Takes a single argument: the topic (e.g. a package, framework, or language name).
argument-hint: [topic]
---

# Kindle Guide

Turns `$ARGUMENTS` (the topic — a library, framework, tool, or language name) into a short, practical PDF reference and emails it to the user's Kindle.

Follow these steps **in order**. Do not skip the ambiguity check, and do not proceed past it if it fires.

## Step 1 — Check for ambiguity FIRST

Before doing anything else, consider whether the topic name plausibly refers to more than one distinct thing a developer might mean — e.g. a name that exists as both a Python package and a Neovim/vim plugin, or as tools in two different ecosystems (a JS library and an unrelated CLI tool, a Rust crate and a Ruby gem, etc.).

If there's genuine ambiguity:
- List the plausible candidates you found, each with a one-line description of what it actually is.
- Ask the user which one they meant.
- **Stop here.** Do not search for a resource, do not generate a guide, do not send an email. Wait for their reply, then restart from Step 2 with the disambiguated topic.

If the topic is a single well-known thing (e.g. "pandas", "Streamlit", "Plotly", "scikit-learn"), there's nothing to check — proceed directly to Step 2.

## Step 2 — Look for an existing authoritative resource

Before writing anything yourself, search for an **official, already-downloadable PDF** for this topic — something the maintaining project or org explicitly publishes for offline reading (e.g. an official cheat sheet, an official reference card, a project's own PDF manual). Good search terms: `"<topic> official cheat sheet pdf"`, `"<topic> reference card pdf"`, `"<topic> documentation pdf download"`.

**Important distinction — read carefully:**
- ✅ If you find a PDF the source itself hosts and intends people to download (e.g. RStudio/Posit's official cheat sheets, a language's own downloadable manual) — fetch that PDF file directly and use it as-is.
- ❌ Do NOT scrape an HTML documentation page and convert its content into a PDF yourself, even if it looks "official." Rendering someone else's page into a new PDF is reproducing their copyrighted material, not sourcing an existing download. If all you can find is a doc **site** (not a doc the project publishes as a PDF), treat that as "no existing resource" and go to Step 3 instead.

If you find a genuine existing PDF: download it, and skip Step 3 entirely.

If you don't find one: proceed to Step 3.

## Step 3 — Write an original guide

If no existing downloadable PDF was found, write one from scratch, in your own words, following this shape (see `references/guide-structure.md` for the full template and section-by-section guidance):

1. Short intro — what the tool is, what it's for, one or two things worth knowing before diving in
2. Core feature sections, each with a couple of runnable code examples — not exhaustive parameter listings, just the 80% people actually use
3. A "Common Pitfalls" section — the mistakes that actually trip people up, not generic advice
4. A "Quick Reference" table at the end — task-to-syntax lookup

Keep it scannable and short — aim for the same depth as previous guides in this vein (roughly 10-20 pages once rendered), not a comprehensive manual.

Build the PDF using the pipeline and CSS in `references/pdf-build.md` — it's sized for a Kindle screen (4.8in × 6.5in pages), so don't reinvent the page size or styling from scratch.

## Step 4 — Name the file and send it

Name the output file `<topic-slug>-guide.pdf` (lowercase, hyphenated — e.g. `pandas-guide.pdf`, `scikit-learn-guide.pdf`). This is also the filename that will show up on the Kindle, so keep it recognizable.

Send it using the bundled script:

```bash
uv run scripts/send_to_kindle.py /path/to/<topic-slug>-guide.pdf --env .env
```

The script reads `KINDLE_EMAIL` and SMTP settings from a `.env` file (see `.env.example` for the required keys — the user needs to fill this in once, with their own Send-to-Kindle address and an SMTP account). If `.env` is missing or incomplete, the script will fail with a clear message about which keys are missing — surface that to the user rather than guessing values.

## Step 5 — Report back

Tell the user, clearly and briefly:
- **The exact filename** you sent (so they can find it on their Kindle by name).
- **Whether you sent an existing official PDF or one you wrote** — don't leave this ambiguous. E.g. "Sent the official Posit/RStudio cheat sheet for `readr`" vs. "Wrote and sent an original `plotly-guide.pdf`."

That's the whole loop: disambiguate → search for an existing PDF → write one only if nothing official exists → name it clearly → send it → tell the user exactly what happened.

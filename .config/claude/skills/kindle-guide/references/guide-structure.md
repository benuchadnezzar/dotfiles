# Guide Structure Template

Use this shape for any originally-written guide (Step 3 of SKILL.md). It's the structure used for the Mermaid, Pandas, Streamlit, Plotly, and scikit-learn guides.

## Introduction
- One paragraph: what the tool is, what problem it solves, how it's typically imported/invoked.
- If relevant, one or two "know this before you start" notes — the kind of thing that saves someone from a confusing first hour (e.g. Streamlit's script-reruns-on-every-interaction behavior, Mermaid's `-->` token needing no internal space).
- If there's a well-known adjacent tool people confuse this with, or a common "is X still the right choice" question, address it briefly and honestly rather than ignoring it.

## Core sections (one per major feature area)
- Organize by the natural conceptual chunks of the tool (e.g. for a plotting library: basic charts, customization, combining/layering, exporting).
- Each section: a short paragraph of explanation, then a runnable code example — not a parameter reference. Prefer 2-4 short examples over one long one.
- Use tables for anything enumerable (arrow types, shape codes, argument options) rather than prose lists — much faster to scan on a Kindle.
- Keep total depth to "productive fast," not "comprehensive manual" — this mirrors a practical cheat sheet, not the official docs. It's fine, and expected, to leave out advanced/rare features; don't try to cover everything.

## Common Pitfalls
- 4-6 bullets, each naming a specific mistake and the fix — not generic advice.
- Pull these from what actually confuses newcomers (a known gotcha, a common error message, a subtle behavior that isn't obvious from the syntax alone), not filler.

## Quick Reference
- A single table: task in plain English → the code for it.
- This is the page the user will flip back to after the first read-through, so keep entries short and copy-pasteable.

## Length target
Aim for output that renders to roughly 10-20 pages at the Kindle page size described in `pdf-build.md`. If a topic is naturally bigger than that (e.g. it has several genuinely distinct major use cases), it's fine to run longer — but don't pad a simple topic out to hit a page count.

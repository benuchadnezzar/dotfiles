# Building the Kindle-sized PDF

This is the exact pipeline used for earlier guides in this series (Mermaid, Pandas, Streamlit, Plotly, scikit-learn). Reuse it as-is.

## 1. Write the content as Markdown

Standard Markdown, with a YAML title block at the top:

```markdown
---
title: "<Topic>: A Practical Syntax Guide"
author: "Compiled for Kindle reading"
date: "<current month, year>"
---

# Introduction
...
```

## 2. Convert Markdown to standalone HTML with pandoc

```bash
pandoc <topic>-guide.md -o <topic>-guide.html --standalone \
  --highlight-style=tango \
  --metadata title="<Topic>: A Practical Syntax Guide"
```

## 3. Inject Kindle-friendly CSS

Pandoc's default `--standalone` output includes a `<style>` block sized for desktop reading. Replace it with the block below — small page-friendly font, tighter margins, code blocks that wrap instead of overflowing:

```css
html {
  color: #111;
  background-color: #fff;
}
body {
  margin: 0 auto;
  max-width: 100%;
  padding: 14px 16px;
  hyphens: auto;
  overflow-wrap: break-word;
  text-rendering: optimizeLegibility;
  font-kerning: normal;
  font-family: Georgia, "Times New Roman", serif;
  font-size: 15px;
  line-height: 1.5;
}
h1 { font-size: 1.5em; margin-top: 1.2em; page-break-before: always; }
h1:first-of-type { page-break-before: avoid; }
h2 { font-size: 1.2em; margin-top: 1em; }
h3 { font-size: 1.05em; }
pre {
  background: #f2f2f2;
  border: 1px solid #ccc;
  border-radius: 3px;
  padding: 8px;
  font-size: 12px;
  white-space: pre-wrap;
  word-wrap: break-word;
  line-height: 1.35;
}
code {
  font-family: "DejaVu Sans Mono", monospace;
  font-size: 12px;
}
table {
  border-collapse: collapse;
  width: 100%;
  font-size: 13px;
  margin: 0.8em 0;
}
th, td {
  border: 1px solid #999;
  padding: 4px 8px;
  text-align: left;
}
th { background: #eee; }
```

Use `str_replace` (or equivalent) to swap pandoc's default `<style>` block for this one in the generated HTML file — don't hand-build the HTML from scratch.

## 4. Render to PDF at Kindle page size

```bash
wkhtmltopdf --page-width 4.8in --page-height 6.5in \
  --margin-top 8mm --margin-bottom 8mm --margin-left 8mm --margin-right 8mm \
  --enable-local-file-access \
  <topic>-guide.html <topic-slug>-guide.pdf
```

If `wkhtmltopdf` isn't available in this environment, `pandoc ... --pdf-engine=weasyprint` with the same CSS is the fallback — check what's actually installed first (`which wkhtmltopdf weasyprint pandoc`) rather than assuming.

## 5. Sanity-check before sending

```bash
python3 -c "
from pypdf import PdfReader
r = PdfReader('<topic-slug>-guide.pdf')
print('Pages:', len(r.pages))
print(r.pages[0].extract_text()[:300])
"
```

Confirm the page count looks reasonable (roughly 10-20 pages for a guide of this depth) and the extracted text isn't garbled before moving on to sending it.

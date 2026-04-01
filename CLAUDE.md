# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal website for Akash Kulgod (dogl.uk), built with Jekyll and the Minima theme. Deployed via GitHub Pages.

## Development Commands

```bash
bundle install                # Install dependencies
bundle exec jekyll serve      # Local dev server with auto-reload (localhost:4000)
bundle exec jekyll build      # Production build
bundle exec jekyll clean      # Clean generated files
```

Note: `_config.yml` changes require a server restart — Jekyll does not hot-reload config.

## Architecture

- **Theme overrides**: `_includes/` contains custom `head.html` (JSON-LD structured data, meta tags), `footer.html` (social links, Tally feedback form), and `social.html` (Font Awesome icon list). These override the Minima theme defaults.
- **Plugins**: jekyll-feed (RSS), jekyll-seo-tag (SEO metadata), jekyll-sitemap (XML sitemap) — all via the `github-pages` gem.
- **Content pages**: Root-level markdown files (`about.markdown`, `writing.markdown`, `bookshelf.markdown`, `photos.markdown`, `poetry.markdown`, `journal.markdown`). Navigation is configured via `header_pages` in `_config.yml`.
- **Posts**: Standard Jekyll `_posts/` directory with `YYYY-MM-DD-title.markup` naming.
- **Assets**: `photos/` for photography page images, `posts_assets/` for blog post media.
- **Generated output**: `_site/` is auto-generated — never edit directly.

## Journal Workflow

When the user says "ship journal" followed by a date (e.g. "ship journal today", "ship journal 04022026", "ship journal yesterday"):

1. Parse the date input (supports: "today", "yesterday", ddmmyyyy format like "04022026", or natural language like "4 feb 2026")
2. Convert to YYYY-MM-DD display format
3. Check if entry exists in `journal.markdown` — if not, add a new `## YYYY-MM-DD` section at the top (after the TOC div) and add a date link to the jump-to TOC
4. Ask the user what they want to write for that date
5. Add their content under the date heading
6. Run: `git add journal.markdown && git commit -m "ship journal" && git push origin`

If user just says "ship journal" without a date, assume "today".

There is also a `journal.sh` bash script that does the same workflow interactively from the terminal.

## Howl Workflow

`/howl` is a custom skill that takes a blog post and generates platform-adapted versions for X, LinkedIn, Instagram, and Substack Notes. Invoked as `/howl [post-identifier]` (e.g. `/howl dogs-as-deep-tech`, `/howl latest`).

- Output is saved to `/Users/ask/gitcat/howl/{slug}/` with one file per platform (`x.md`, `linkedin.md`, `instagram.md`, `substack.md`, `meta.md`)
- Substack (tumbles.run) is the canonical "read more" destination linked from all social posts
- Each social post is self-contained but signals the full essay is available on Substack
- The skill handles distribution assist (clipboard, compose URLs) to get as close to "paste and send" as possible
- Full spec lives in `.claude/commands/howl.md`

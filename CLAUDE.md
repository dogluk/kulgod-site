# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll static site generator project using the default Minima theme. The site structure follows Jekyll conventions with posts in `_posts/`, site configuration in `_config.yml`, and generated output in `_site/`.

## Development Commands

### Local Development
```bash
# Install dependencies
bundle install

# Start development server with auto-reload
bundle exec jekyll serve

# Build the site for production
bundle exec jekyll build

# Clean generated files
bundle exec jekyll clean
```

### Content Management
- Posts are created in `_posts/` directory with naming format: `YEAR-MONTH-DAY-title.MARKUP`
- Pages can be created as markdown files in the root directory
- All content files use YAML front matter for metadata

## Project Structure

- `_config.yml` - Main site configuration
- `_posts/` - Blog posts (markdown files)
- `_site/` - Generated static site (auto-generated, do not edit)
- `photos/` - Photo assets for the photography section
- `about.markdown` - About page
- `index.markdown` - Homepage
- `photos.markdown` - Photography page
- `writing.markdown` - Writing page with Substack integration
- `Gemfile` - Ruby gem dependencies

## Key Configuration

- Theme: Minima (Jekyll's default theme)
- Plugins: jekyll-feed (for RSS feed generation)
- The site is configured for local development by default

## Development Notes

- Jekyll automatically regenerates the site when files change during `bundle exec jekyll serve`
- The `_config.yml` file requires server restart when modified
- Generated site files in `_site/` should not be manually edited as they are overwritten on each build

## Journal Workflow

When the user says "ship journal" followed by a date (e.g. "ship journal today", "ship journal 04022026", "ship journal yesterday"):

1. Parse the date input (supports: "today", "yesterday", ddmmyyyy format like "04022026", or natural language like "4 feb 2026")
2. Convert to YYYY-MM-DD display format
3. Check if entry exists in `journal.markdown` - if not, add a new `## YYYY-MM-DD` section at the top (after TOC) and add date link to the jump-to TOC
4. Ask the user what they want to write for that date
5. Add their content under the date heading
6. Run: `git add journal.markdown && git commit -m "ship journal" && git push origin`

If user just says "ship journal" without a date, assume "today".
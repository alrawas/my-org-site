# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal blog/website built with Emacs Org Mode. Content is authored as `.org` files, exported to HTML via Emacs's `ox-publish`, and deployed to GitHub Pages.

## Build

```sh
./build.sh            # runs: emacs -Q --script build-site.el
```

Requires `emacs` (or `emacs-nox`) installed. The build installs the `htmlize` package into `.packages/` on first run.

## How It Works

- `content/` — Org Mode source files (`.org`). Add new pages here.
- `build-site.el` — Emacs Lisp build script that configures `ox-publish` to convert `content/*.org` → `public/*.html`. Uses [Simple.css](https://simplecss.org) for styling.
- `public/` — Generated HTML output (gitignored). Do not edit directly.
- `.packages/` — Emacs package cache (gitignored).

## Deployment

Pushing to `main` triggers `.github/workflows/publish.yml`, which builds the site and deploys `public/` to the `gh-pages` branch via `JamesIves/github-pages-deploy-action`.

## Adding Content

Create a new `.org` file in `content/`. The build recursively publishes all `.org` files. Link between pages with relative paths (e.g., `[[./Emacs.org][Emacs]]`).

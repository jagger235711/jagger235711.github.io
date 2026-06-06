# Contributing

## Repository layout

- `docs/`: blog content repository (`blog-content`) as a Git submodule
- `mkdocs.yml`, `requirements.txt`: MkDocs configuration and dependencies
- `overrides/`: theme overrides
- `scripts/`: local development helpers
- `.github/workflows/publish_docs.yml`: CI/CD deployment workflow

## One-time setup

```bash
git submodule sync --recursive
git submodule update --init --recursive
```

## Content workflow

1. Enter content repository:

   ```bash
   cd docs
   ```

2. Add/edit posts, then commit and push in `blog-content`.

3. Back in main repository root, update submodule pointer:

   ```bash
   cd ..
   ./scripts/sync-content.sh
   git add docs
   git commit -m "chore: update blog content submodule"
   ```

## Local preview

```bash
pip install -r requirements.txt
mkdocs serve
```

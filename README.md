# repo-health-bot seed idea

Use this as the first project theme for the self-improvement loop.

Initial feature:

- Scan a repository.
- Count TODO/FIXME comments.
- Detect common project metadata files.
- Emit a Markdown health report.

First improvement candidates are intentionally simple:

- Add a JSON output mode.
- Add ignore patterns.
- Improve README examples.
- Add support for another metadata file.
- Make output sorting deterministic.

## Quick start

```bash
python -m pip install -e .
python repo_health_bot.py .
python repo_health_bot.py . --json
python -m maintainer_bot.cli smoke-check
```

## Self-improvement loop

This repository now includes an eval-driven maintainer/docs bot layer.

Start here:

- `docs/AFTER_PUSH_MANUAL.md`: what to do next after this commit is pushed
- `docs/SELF_IMPROVING_PROJECT_GUIDE.md`: full self-improving project guide
- `docs/ADDITIONAL_AUTOMATION.md`: PR summary, docs patch candidate, and status dashboard workflows
- `docs/COMMANDS.md`: local CLI commands
- `docs/PROJECT_STATUS.md`: generated project status dashboard

Recommended first GitHub Actions run order:

1. `Sync Labels`
2. `Weekly Health`
3. `Docs Bot Eval`
4. `Status Dashboard`

Then open an `Eval failure` issue to verify that the bot creates an eval PR.

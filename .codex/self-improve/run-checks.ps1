$ErrorActionPreference = "Stop"

git diff --check
python -m unittest discover -s tests
python repo_health_bot.py . | Out-Null
python repo_health_bot.py . --json | Out-Null
python -m maintainer_bot.cli validate-evals
python -m maintainer_bot.cli smoke-check

# repo-health-bot Knowledge Base

`repo-health-bot` is a small repository health report generator and a seed project for a self-improving maintainer/docs loop.

The main product CLI scans a repository, counts files and text lines, detects metadata files, finds TODO/FIXME comments, and emits a Markdown or JSON health report.

## Installation

Install the project locally with:

```bash
python -m pip install -e .
```

The project requires Python 3.10 or newer.

The package exposes two CLI entry points:

- `repo-health-bot`
- `maintainer-bot`

## Running Repository Health Reports

Run the repository health report in Markdown mode:

```bash
python repo_health_bot.py .
```

Run the repository health report in JSON mode:

```bash
python repo_health_bot.py . --json
```

After editable installation, the script entry point can also be used:

```bash
repo-health-bot .
```

## Running Documentation Evals

Run documentation evaluation without an API key:

```bash
python -m maintainer_bot.cli eval-docs --dry-run
```

Run documentation evaluation with the OpenAI API:

```bash
python -m maintainer_bot.cli eval-docs
```

The OpenAI API mode requires `OPENAI_API_KEY`.

## Self-Improvement Policy

The bot must not push directly to `main`.

The bot should create pull requests for proposed changes.

External pull requests must not receive repository secrets.

Changes that delete or weaken eval cases require human review.

## Issue Triage

The bot can suggest issue labels such as:

- `bug`
- `docs`
- `enhancement`
- `question`
- `security`

Security reports should be handled carefully and should not be disclosed publicly if they contain sensitive details.

## Contribution Workflow

Contributors should open a pull request.

Pull requests should include a short summary, verification steps, and any relevant eval result.

## Improvement Loop

The improvement loop is:

1. Capture a failure.
2. Add or update an eval case.
3. Run the eval suite.
4. Generate an improvement proposal.
5. Open a pull request.
6. Merge only after human review.

## Local Verification

Run the core local checks:

```bash
python -m unittest discover -s tests
python repo_health_bot.py .
python repo_health_bot.py . --json
python -m maintainer_bot.cli smoke-check
```

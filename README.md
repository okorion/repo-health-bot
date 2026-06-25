# repo-health-bot seed idea

Use this as the first project theme for the self-improvement loop.

Initial feature:

- Scan a repository.
- Count TODO/FIXME comments.
- Detect common project metadata files.
- Emit a Markdown health report.

## CLI usage

Scan the current directory and print a Markdown report:

```bash
python repo_health_bot.py
```

Scan a specific repository path:

```bash
python repo_health_bot.py path/to/repo
```

Print the same report data as JSON for scripts:

```bash
python repo_health_bot.py path/to/repo --json
```

The Markdown report includes repository totals, detected metadata files, and a
TODO/FIXME detail section when matching lines are found. JSON output uses the
same data model with these top-level fields:

```json
{
  "root": "...",
  "file_count": 0,
  "text_file_count": 0,
  "line_count": 0,
  "metadata_files": [],
  "todo_hits": [
    {
      "path": "README.md",
      "line": 1,
      "text": "TODO: example"
    }
  ]
}
```

First improvement candidates are intentionally simple:

- Add a JSON output mode.
- Add ignore patterns.
- Improve README examples.
- Add support for another metadata file.
- Make output sorting deterministic.

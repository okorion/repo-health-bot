# 앞으로 진행하면 되는 매뉴얼

이 문서는 이번 변경분을 push한 뒤 사용자가 진행하면 되는 순서입니다.

## 1. GitHub 설정 확인

GitHub repository에서 다음을 확인합니다.

Settings > Actions > General:

- Actions permissions: Allow all actions and reusable workflows
- Workflow permissions: Read repository contents and packages permissions
- Allow GitHub Actions to create and approve pull requests: enabled

Settings > Branches:

- `main` branch protection rule 추가
- Require a pull request before merging
- Require approvals: 1
- Require status checks to pass before merging

API 기반 eval을 사용할 경우:

Settings > Secrets and variables > Actions:

- Repository secret: `OPENAI_API_KEY`
- Repository variable: `OPENAI_MODEL`, for example `gpt-5.5`

API 키가 없어도 dry-run 루프는 동작합니다.

## 2. 첫 Actions 실행 순서

Actions 탭에서 아래 순서로 수동 실행합니다.

1. `Sync Labels`
2. `Weekly Health`
3. `Docs Bot Eval` with `use_openai=false`
4. `Status Dashboard`

기대 결과:

- 라벨이 생성됩니다.
- CI와 health check가 통과합니다.
- `docs/PROJECT_STATUS.md` 갱신 PR이 생성될 수 있습니다.

## 3. 테스트 이슈 만들기

GitHub Issues에서 새 이슈를 만듭니다.

제목:

```text
Docs typo in README
```

본문:

```text
The installation guide has a typo.
```

기대 결과:

- `Issue Triage` workflow가 실행됩니다.
- `docs` 라벨이 붙습니다.

## 4. 첫 eval 추가 루프 확인

새 이슈를 만들고 `Eval failure` 템플릿을 선택합니다.

예시:

```text
Suggested eval id: health-json-001
User question: How do I run repo-health-bot in JSON mode?
Required answer content:
- python repo_health_bot.py . --json
Forbidden answer content:
- npm install
```

기대 결과:

- `Eval From Issue` workflow가 실행됩니다.
- `evals/docs_qa.jsonl`을 수정하는 PR이 생성됩니다.
- PR을 사람이 검토한 뒤 merge합니다.

## 5. eval PR merge 후 개선 루프

eval PR을 merge한 뒤 Actions에서 실행합니다.

1. `Docs Bot Eval`
2. 실패가 있으면 `Self Improve Docs Proposal`
3. 누락 문서가 명확하면 `Docs Patch Candidate`

`Docs Patch Candidate`가 만든 문구는 초안입니다. 그대로 merge하지 말고 문장과 위치를 사람이 정리하세요.

## 6. 매주 운영 루틴

매주 한 번:

1. 최근 실패 답변이나 헷갈린 이슈를 1-3개 고릅니다.
2. `Eval failure` 이슈로 등록합니다.
3. 생성된 eval PR을 리뷰하고 merge합니다.
4. `Docs Bot Eval`을 실행합니다.
5. 실패가 있으면 proposal 또는 docs patch candidate PR을 만듭니다.
6. 사람이 실제 문서/프롬프트/코드 변경 PR을 작성합니다.

## 7. 로컬에서 확인할 명령

```bash
python -m pip install -e .
python -m unittest discover -s tests
python repo_health_bot.py .
python repo_health_bot.py . --json
python -m maintainer_bot.cli smoke-check
python -m maintainer_bot.cli validate-evals
```

PowerShell:

```powershell
.\.codex\self-improve\run-checks.ps1
```

## 8. 다음 개발 후보

작게 진행할 후보:

- JSON 출력 예시를 README에 더 자세히 추가
- ignore pattern을 CLI 옵션으로 받기
- health report에 file extension summary 추가
- TODO/FIXME 결과를 정렬/필터링하는 옵션 추가
- eval case를 20개 이상으로 늘리기

원칙:

- 기능 변경 전 eval 또는 이슈를 먼저 추가합니다.
- 봇은 main에 직접 push하지 않습니다.
- 자동 생성 PR은 사람이 리뷰한 뒤 merge합니다.

# Git Workflow Guide
> Git workflow with branching strategy, commit conventions, PR template, and common operations
> 브랜칭 전략, 커밋 컨벤션, PR 템플릿, 자주 쓰는 Git 명령어 가이드

**Category**: Dev Methodology | **Tags**: git, branching, commits, pull-request, workflow | **Difficulty**: Beginner

## Preview
```
main ─────●──────●──────●──────●─────
           \    /        \    /
feature/x   ●──●    fix/y ●──●
```

## Quick Start
```bash
# Start new feature
git checkout -b feature/add-user-auth
# ... make changes, commit often ...
git push -u origin feature/add-user-auth
# Open PR on GitHub, get review, merge

# Sync with main
git checkout main && git pull
git checkout feature/my-branch && git rebase main
```

## Branching Strategy

### Trunk-Based Development (Recommended for Small Teams)

```
main (production-ready, always deployable)
  |
  +-- feature/add-user-auth     (short-lived, 1-3 days max)
  +-- fix/login-redirect-loop   (bug fixes)
  +-- chore/upgrade-deps        (maintenance)
```

### Branch Naming Convention

| Prefix | Purpose | Example |
|--------|---------|---------|
| `feature/` | New functionality | `feature/add-payment-flow` |
| `fix/` | Bug fixes | `fix/null-pointer-on-login` |
| `chore/` | Maintenance, deps | `chore/upgrade-react-19` |
| `docs/` | Documentation | `docs/update-api-reference` |
| `refactor/` | Code restructuring | `refactor/extract-auth-service` |
| `test/` | Adding tests | `test/user-service-edge-cases` |
| `hotfix/` | Critical prod fix | `hotfix/payment-timeout` |

### Rules

```
1. main is always deployable (protected, requires PR)
2. Feature branches are short-lived (merge within 1-3 days)
3. No direct commits to main (always via PR)
4. Delete branches after merge
5. Rebase before merge to keep history clean
```

## Commit Message Convention

### Format: Conventional Commits

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | `feat(auth): add OAuth2 Google login` |
| `fix` | Bug fix | `fix(api): handle null user in GET /profile` |
| `docs` | Documentation | `docs(readme): add deployment instructions` |
| `style` | Formatting only | `style: fix indentation in user_service.py` |
| `refactor` | Code restructuring | `refactor(db): extract query builder class` |
| `test` | Adding tests | `test(auth): add edge cases for token expiry` |
| `chore` | Build/tooling | `chore(deps): upgrade fastapi to 0.110` |
| `perf` | Performance | `perf(query): add index on users.email` |
| `ci` | CI/CD changes | `ci: add Python 3.12 to test matrix` |

### Good vs Bad Commit Messages

```bash
# BAD
git commit -m "fix bug"
git commit -m "update code"
git commit -m "WIP"
git commit -m "changes"

# GOOD
git commit -m "fix(auth): prevent token refresh race condition"
git commit -m "feat(api): add pagination to GET /users endpoint"
git commit -m "refactor(db): replace raw SQL with SQLAlchemy ORM"
git commit -m "test(payment): add Stripe webhook signature verification test"
```

## Pull Request Template

Save as `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Summary
<!-- What does this PR do? Why? -->

## Changes
- [ ] Change 1
- [ ] Change 2

## Type
- [ ] Feature
- [ ] Bug fix
- [ ] Refactor
- [ ] Documentation
- [ ] CI/CD

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing performed

## Screenshots
<!-- For UI changes, add before/after screenshots -->

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-reviewed my own code
- [ ] No new warnings introduced
- [ ] Documentation updated (if applicable)
- [ ] Database migration included (if applicable)

## Related Issues
<!-- Closes #123, Fixes #456 -->
```

## Common Git Operations

### Daily Workflow

```bash
# Start your day: sync with remote
git checkout main
git pull --rebase

# Create feature branch
git checkout -b feature/my-feature

# Work, commit frequently
git add -p                          # Stage interactively (review each hunk)
git commit -m "feat(scope): description"

# Push and create PR
git push -u origin feature/my-feature
gh pr create --title "feat: my feature" --body "Description here"
```

### Sync and Rebase

```bash
# Update feature branch with latest main
git checkout main
git pull --rebase
git checkout feature/my-feature
git rebase main

# If conflicts arise:
# 1. Fix conflicts in editor
# 2. git add <resolved-files>
# 3. git rebase --continue
```

### Fix Mistakes

```bash
# Amend last commit (before push)
git add .
git commit --amend --no-edit

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Discard all local changes
git checkout -- .

# Interactive rebase (squash commits before PR)
git rebase -i HEAD~3
# Change 'pick' to 'squash' for commits to combine
```

### Useful Aliases

```bash
# Add to ~/.gitconfig
[alias]
  co = checkout
  br = branch
  ci = commit
  st = status
  lg = log --oneline --graph --decorate --all -20
  unstage = reset HEAD --
  last = log -1 HEAD --stat
  amend = commit --amend --no-edit
  wip = !git add -A && git commit -m "WIP: work in progress"
  undo = reset --soft HEAD~1
```

## Customization Guide
- **Branch strategy**: For larger teams, consider Gitflow (develop + release branches)
- **Commit hooks**: Add `commitlint` + `husky` for automatic commit message validation
- **PR size**: Aim for <400 lines changed per PR (easier to review, faster to merge)
- **Squash policy**: "Squash and merge" keeps main history clean; "Rebase and merge" preserves individual commits
- **Protected branches**: Enable "Require PR reviews" and "Require status checks" on main

## 2026 Trend Notes
- Trunk-based development is the dominant strategy for teams practicing continuous delivery
- Conventional Commits enable automatic changelog generation and semantic versioning
- GitHub CLI (`gh`) is faster than web UI for creating PRs and checking CI status
- `git add -p` (interactive staging) encourages reviewing changes before committing
- Ship/Show/Ask framework: trivial changes (typos, deps) can merge without review

# Code Review Checklist
> Comprehensive code review checklist covering security, performance, readability, and testing
> 보안, 성능, 가독성, 테스트를 다루는 종합 코드 리뷰 체크리스트

**Category**: Dev Methodology | **Tags**: code-review, security, performance, quality, checklist | **Difficulty**: Intermediate

## Preview
```
PR Review Checklist:
[x] Security: No secrets in code
[x] Performance: No N+1 queries
[x] Readability: Clear naming
[x] Testing: Edge cases covered
[x] Architecture: Follows patterns
```

## Quick Start
```bash
# 1. Copy this file into your repository as .github/PULL_REQUEST_TEMPLATE.md
# 2. Or use as a reference during manual code reviews
# 3. Customize by removing/adding items relevant to your project
```

## Full Checklist

### Security Review

```markdown
## Security
- [ ] **No hardcoded secrets** (API keys, passwords, tokens) in code or comments
- [ ] **Input validation** on all user-provided data (request body, query params, headers)
- [ ] **SQL injection prevention** - using parameterized queries or ORM, not string concatenation
- [ ] **XSS prevention** - output encoding/escaping in templates and API responses
- [ ] **Authentication check** - protected routes require valid session/token
- [ ] **Authorization check** - user can only access their own resources (no IDOR)
- [ ] **Rate limiting** applied to public-facing endpoints
- [ ] **Sensitive data** not logged (passwords, tokens, PII)
- [ ] **CORS configured** correctly (not wildcard `*` in production)
- [ ] **Dependencies** have no known vulnerabilities (`npm audit` / `pip audit`)
```

### Performance Review

```markdown
## Performance
- [ ] **No N+1 queries** - use eager loading / joins for related data
- [ ] **Database indexes** exist for columns used in WHERE/ORDER BY/JOIN
- [ ] **Pagination** implemented for list endpoints (not returning all records)
- [ ] **Caching** applied where appropriate (Redis, in-memory, HTTP cache headers)
- [ ] **No blocking operations** in async code paths
- [ ] **Batch operations** used instead of loops for bulk DB writes
- [ ] **Image/asset optimization** - compressed, lazy-loaded, appropriate format
- [ ] **No memory leaks** - event listeners cleaned up, connections closed
- [ ] **Query performance** - complex queries tested with EXPLAIN ANALYZE
- [ ] **Bundle size** not significantly increased (check with `npm run analyze`)
```

### Readability & Maintainability

```markdown
## Readability
- [ ] **Clear naming** - variables/functions describe what they do, not how
- [ ] **No magic numbers** - constants extracted with descriptive names
- [ ] **Functions are small** - each does one thing (<30 lines preferred)
- [ ] **No deep nesting** - max 3 levels of indentation (use early returns)
- [ ] **Comments explain WHY**, not what (code should be self-documenting)
- [ ] **Consistent style** - follows project conventions (linter passes)
- [ ] **No dead code** - removed unused imports, functions, variables
- [ ] **Error messages** are helpful and actionable for debugging
- [ ] **Type annotations** present for function signatures (Python, TypeScript)
- [ ] **DRY principle** - no copy-pasted code blocks (extract shared logic)
```

### Testing

```markdown
## Testing
- [ ] **Tests exist** for new functionality (not just happy path)
- [ ] **Edge cases** covered (empty input, null, boundary values, large data)
- [ ] **Error cases** covered (invalid input, network failure, timeout)
- [ ] **Tests are independent** - no shared state, no execution order dependency
- [ ] **Test names** describe the scenario: `test_expired_token_returns_401`
- [ ] **No flaky tests** - deterministic, no `time.sleep()` or random data
- [ ] **Mocks used appropriately** - external services mocked, business logic tested directly
- [ ] **Coverage maintained** - no significant drop in overall coverage percentage
- [ ] **Integration tests** for new API endpoints or database queries
- [ ] **Regression test** added if this PR fixes a bug
```

### Architecture & Design

```markdown
## Architecture
- [ ] **Follows existing patterns** - consistent with project's architecture
- [ ] **Separation of concerns** - business logic not mixed with I/O or presentation
- [ ] **Interface boundaries** - modules communicate through defined APIs, not internal state
- [ ] **Error handling strategy** - consistent use of exceptions/error types
- [ ] **Backwards compatible** - existing API contracts not broken (or migration provided)
- [ ] **Database migration** included if schema changed (reversible, tested)
- [ ] **Feature flag** used for incomplete features in production code
- [ ] **Documentation updated** - README, API docs, architecture docs reflect changes
- [ ] **No circular dependencies** - clean import graph
- [ ] **Configuration externalized** - env vars or config files, not hardcoded values
```

### PR Quality

```markdown
## PR Quality
- [ ] **PR is focused** - single concern, not mixing refactoring with features
- [ ] **Commit messages** are descriptive and follow conventions
- [ ] **PR description** explains what changed and why
- [ ] **Screenshots/recordings** included for UI changes
- [ ] **Breaking changes** documented in PR description
- [ ] **Deployment steps** documented if manual steps required
- [ ] **Rollback plan** considered for risky changes
```

## Review Decision Framework

| Finding | Severity | Action |
|---------|----------|--------|
| Security vulnerability | **BLOCKER** | Must fix before merge |
| Broken tests | **BLOCKER** | Must fix before merge |
| N+1 query or major perf issue | **HIGH** | Should fix before merge |
| Missing error handling | **HIGH** | Should fix before merge |
| Missing test for new feature | **MEDIUM** | Fix before merge or create follow-up ticket |
| Naming/readability issue | **LOW** | Suggest improvement, approve if minor |
| Style preference | **NIT** | Comment as "nit:", don't block merge |

## PR Comment Templates

```markdown
# Approving with minor suggestions
LGTM! A few minor suggestions but nothing blocking.

# Requesting changes
Great progress! I found a few issues that should be addressed before merging:
1. **[Security]** API key exposed in line 42 - move to environment variable
2. **[Performance]** N+1 query in `get_users()` - use eager loading
Please address these and I'll re-review.

# Nit comment
nit: Consider renaming `data` to `user_profiles` for clarity.
(Non-blocking, feel free to address or ignore.)
```

## Customization Guide
- **Remove irrelevant items**: If your project is backend-only, remove "bundle size" and "image optimization"
- **Add project-specific checks**: Add items for your framework (Django migrations, React hooks rules)
- **Severity levels**: Adjust based on team agreement (some teams block on missing tests, others don't)
- **Automation**: Move checks that can be automated to CI (linting, type checking, security scanning)
- **PR template**: Save the markdown sections as `.github/PULL_REQUEST_TEMPLATE.md` for automatic inclusion

## 2026 Trend Notes
- AI-assisted code review (GitHub Copilot, CodeRabbit) handles boilerplate checks; human review focuses on design and logic
- "Ship/Show/Ask" framework: not every PR needs a review (trivial changes can self-merge)
- Trunk-based development reduces PR size, making reviews faster and more effective
- Security scanning in CI (Snyk, Dependabot) catches vulnerability issues automatically
- Review comments as "blocking" vs "non-blocking" improves team velocity

# Security Audit Checklist
> Security audit checklist based on OWASP Top 10: auth, input validation, secrets, and infrastructure
> OWASP Top 10 기반 보안 감사 체크리스트: 인증, 입력 검증, 시크릿, 인프라

**Category**: Refactoring | **Tags**: security, owasp, authentication, encryption, audit | **Difficulty**: Advanced

## Preview
```
Security Audit Score: 85/100
[PASS] Authentication & Authorization
[PASS] Input Validation & Injection
[WARN] Secrets Management (1 issue)
[PASS] Data Protection
[PASS] Infrastructure Security
```

## Quick Start
```bash
# 1. Review each section against your codebase
# 2. Mark items as PASS, WARN, or FAIL
# 3. Prioritize CRITICAL items (immediate fix required)
# 4. Schedule HIGH items for next sprint
# Run automated checks where possible:
npm audit        # Node.js dependency vulnerabilities
pip audit        # Python dependency vulnerabilities
```

## Full Checklist

### 1. Authentication & Authorization (OWASP A01, A07)

```markdown
## Authentication

### Password Security
- [ ] **[CRITICAL]** Passwords hashed with bcrypt/argon2 (NOT md5/sha256)
- [ ] **[CRITICAL]** Minimum password length: 8 characters
- [ ] **[HIGH]** Password complexity requirements (or NIST: length > complexity)
- [ ] **[HIGH]** Account lockout after 5 failed attempts (with cooldown, not permanent)
- [ ] **[MEDIUM]** Breached password check (Have I Been Pwned API)

### Session Management
- [ ] **[CRITICAL]** Session tokens are cryptographically random (min 128 bits)
- [ ] **[CRITICAL]** Session invalidated on logout (server-side)
- [ ] **[HIGH]** Session timeout: 30 min idle, 24 hour absolute
- [ ] **[HIGH]** New session ID issued after login (prevent session fixation)
- [ ] **[MEDIUM]** Concurrent session limit (or notify on new login)

### JWT (if applicable)
- [ ] **[CRITICAL]** JWT secret is strong (256+ bits random)
- [ ] **[CRITICAL]** Algorithm specified explicitly (HS256/RS256, not "none")
- [ ] **[HIGH]** Short expiry (15 min access token, 7 day refresh token)
- [ ] **[HIGH]** Refresh token rotation (one-time use)
- [ ] **[MEDIUM]** JWT stored in httpOnly cookie (not localStorage)

### Authorization
- [ ] **[CRITICAL]** Every API endpoint checks authorization (not just authentication)
- [ ] **[CRITICAL]** No IDOR: users cannot access other users' resources by changing IDs
- [ ] **[HIGH]** Role-based access control (RBAC) enforced server-side
- [ ] **[HIGH]** Admin endpoints on separate route with extra auth checks
- [ ] **[MEDIUM]** Principle of least privilege applied to service accounts
```

### 2. Input Validation & Injection (OWASP A03)

```markdown
## Input Validation

### SQL Injection
- [ ] **[CRITICAL]** All DB queries use parameterized queries / ORM (no string concatenation)
- [ ] **[CRITICAL]** No raw SQL with user input
- [ ] **[HIGH]** Database user has minimal permissions (no DROP, no GRANT)

### XSS (Cross-Site Scripting)
- [ ] **[CRITICAL]** All user input escaped/encoded in HTML output
- [ ] **[CRITICAL]** Content-Security-Policy header set (restricts inline scripts)
- [ ] **[HIGH]** `httpOnly` flag on all cookies containing tokens
- [ ] **[HIGH]** React/Vue/Angular auto-escaping relied upon (no `dangerouslySetInnerHTML`)

### Command Injection
- [ ] **[CRITICAL]** No shell commands constructed from user input
- [ ] **[CRITICAL]** No `eval()`, `exec()`, or `Function()` with user input
- [ ] **[HIGH]** Subprocess calls use array form (not shell string)

### File Upload
- [ ] **[HIGH]** File type validated server-side (not just extension)
- [ ] **[HIGH]** File size limited (max 10MB or appropriate)
- [ ] **[HIGH]** Uploaded files stored outside web root (or in S3)
- [ ] **[MEDIUM]** Filename sanitized (no path traversal: `../../etc/passwd`)
- [ ] **[MEDIUM]** Antivirus scan on uploads (ClamAV or cloud service)

### General Validation
- [ ] **[HIGH]** Schema validation on all API inputs (Zod, Pydantic, Joi)
- [ ] **[HIGH]** Request size limits set (body, headers, URL length)
- [ ] **[MEDIUM]** Allow-list validation preferred over deny-list
- [ ] **[MEDIUM]** Unicode normalization applied before validation
```

### 3. Secrets Management (OWASP A02)

```markdown
## Secrets

### Storage
- [ ] **[CRITICAL]** No secrets in source code (API keys, passwords, tokens)
- [ ] **[CRITICAL]** No secrets in git history (run `git log -p | grep -i "password\|secret\|key"`)
- [ ] **[CRITICAL]** `.env` file in `.gitignore`
- [ ] **[HIGH]** Secrets in environment variables or vault (not config files)
- [ ] **[HIGH]** Production secrets different from development

### Rotation
- [ ] **[HIGH]** API keys rotatable without downtime
- [ ] **[MEDIUM]** Secret rotation schedule documented (quarterly recommended)
- [ ] **[MEDIUM]** Automated secret scanning in CI (GitHub Secret Scanning, Gitleaks)

### Logging
- [ ] **[CRITICAL]** Secrets never logged (mask patterns: sk-*, API keys, tokens)
- [ ] **[HIGH]** PII (email, phone, SSN) masked in logs
- [ ] **[MEDIUM]** Log access restricted to authorized personnel
```

### 4. Data Protection (OWASP A02, A04)

```markdown
## Data Protection

### Encryption
- [ ] **[CRITICAL]** HTTPS everywhere (no HTTP in production)
- [ ] **[CRITICAL]** TLS 1.2+ only (TLS 1.0/1.1 disabled)
- [ ] **[HIGH]** Sensitive data encrypted at rest (database-level or application-level)
- [ ] **[HIGH]** Strong cipher suites (ECDHE, AES-256-GCM)
- [ ] **[MEDIUM]** HSTS header set (Strict-Transport-Security)

### Data Handling
- [ ] **[HIGH]** PII minimization: collect only what's needed
- [ ] **[HIGH]** Data retention policy: auto-delete old data
- [ ] **[MEDIUM]** Backups encrypted and access-controlled
- [ ] **[MEDIUM]** Data export/deletion capability (GDPR right to erasure)

### API Security
- [ ] **[HIGH]** Rate limiting on all endpoints (per IP and per user)
- [ ] **[HIGH]** CORS configured with specific origins (not `*` in production)
- [ ] **[HIGH]** API responses don't leak internal info (stack traces, DB schemas)
- [ ] **[MEDIUM]** Request/response size limits set
- [ ] **[MEDIUM]** API versioning to prevent breaking changes
```

### 5. Infrastructure & Dependencies (OWASP A05, A06, A08)

```markdown
## Infrastructure

### Dependencies
- [ ] **[HIGH]** `npm audit` / `pip audit` shows 0 critical vulnerabilities
- [ ] **[HIGH]** Dependency updates automated (Dependabot, Renovate)
- [ ] **[MEDIUM]** Lock file committed (package-lock.json, requirements.txt with pinned versions)
- [ ] **[MEDIUM]** Minimal dependencies (no unused packages)

### Server/Container
- [ ] **[HIGH]** Non-root user in Docker containers
- [ ] **[HIGH]** Base images regularly updated (Alpine/Distroless preferred)
- [ ] **[HIGH]** No unnecessary ports exposed
- [ ] **[MEDIUM]** Security headers set (X-Frame-Options, X-Content-Type-Options)
- [ ] **[MEDIUM]** Container resource limits (CPU, memory) prevent DoS

### Security Headers Checklist
| Header | Value | Purpose |
|--------|-------|---------|
| `Strict-Transport-Security` | `max-age=31536000; includeSubDomains` | Force HTTPS |
| `X-Content-Type-Options` | `nosniff` | Prevent MIME sniffing |
| `X-Frame-Options` | `DENY` or `SAMEORIGIN` | Prevent clickjacking |
| `Content-Security-Policy` | `default-src 'self'` | Prevent XSS |
| `Referrer-Policy` | `strict-origin-when-cross-origin` | Control referrer info |
| `Permissions-Policy` | `camera=(), microphone=()` | Restrict browser features |
```

## Automated Security Tools

| Tool | Type | Integration |
|------|------|-------------|
| **Gitleaks** | Secret scanning | CI pre-commit hook |
| **Snyk** | Dependency vulnerabilities | GitHub integration |
| **OWASP ZAP** | Dynamic application security testing | CI or manual |
| **Semgrep** | Static analysis (SAST) | CI action |
| **Trivy** | Container image scanning | CI action |
| **npm audit / pip audit** | Package vulnerabilities | CI step |

## Severity & Response Time

| Severity | Response Time | Example |
|----------|--------------|---------|
| **CRITICAL** | Fix immediately (same day) | SQL injection, hardcoded secrets, auth bypass |
| **HIGH** | Fix within 1 week | Missing rate limiting, weak password policy |
| **MEDIUM** | Fix within 1 month | Missing security headers, verbose error messages |
| **LOW** | Fix in next quarter | Minor info disclosure, cosmetic security improvements |

## Customization Guide
- **Stack-specific**: Add checks for your framework (Django CSRF, Rails strong params)
- **Compliance**: Add GDPR/HIPAA/SOC2-specific items if applicable
- **Automated**: Move items to CI wherever possible (Gitleaks, npm audit, Semgrep)
- **Regular cadence**: Run full audit quarterly; dependency checks weekly
- **Incident response**: Add your team's incident response procedure reference

## 2026 Trend Notes
- Supply chain attacks (compromised npm/PyPI packages) are the top threat
- Passkeys (WebAuthn) are replacing passwords for consumer apps
- Zero-trust architecture assumes breach; verify every request
- AI-powered vulnerability scanning catches more complex patterns
- SBOM (Software Bill of Materials) required for government/enterprise contracts

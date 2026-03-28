# TemplateClaw Agent API

## For AI Agents (Claude, GPT, etc.)

### Quick Access
```
# Lightweight catalog (metadata only, fast)
GET https://jeromwolf.github.io/templateclaw/api.json

# Full catalog (includes template content)
GET https://jeromwolf.github.io/templateclaw/api-full.json

# Individual template (raw MD)
GET https://jeromwolf.github.io/templateclaw/templates/{filename}.md
```

### Usage Examples

#### Fetch catalog and find a template:
```python
import requests
catalog = requests.get("https://jeromwolf.github.io/templateclaw/api.json").json()
landing_templates = [t for t in catalog["templates"] if t["category"] == "landing-pages"]
```

#### Download and use a template:
```python
template = requests.get("https://jeromwolf.github.io/templateclaw/templates/saas-landing.md").text
# Parse and customize the template code
```

#### Use with Claude Code:
```
WebFetch https://jeromwolf.github.io/templateclaw/api.json "List all dashboard templates"
WebFetch https://jeromwolf.github.io/templateclaw/templates/admin-dashboard.md "Get the full admin dashboard template code"
```

### Categories
- **dashboard** (4 templates)
- **project-setup** (7 templates)
- **dev-methodology** (5 templates)
- **landing-pages** (5 templates)
- **components** (8 templates)
- **refactoring** (3 templates)

### All Templates (32)
- `admin-dashboard.md` — Admin Dashboard [dashboard]
- `agent-integration-guide.md` — Agent Integration Guide [project-setup]
- `agents-md-template.md` — AGENTS.md Template [project-setup]
- `analytics-dashboard.md` — Analytics Dashboard [dashboard]
- `api-design.md` — REST API Design Guide [dev-methodology]
- `app-landing.md` — Mobile App Landing Page [landing-pages]
- `card-components.md` — Card Components [components]
- `cicd-setup.md` — CI/CD Pipeline Setup [dev-methodology]
- `claude-md-template.md` — CLAUDE.md Template [project-setup]
- `code-review-checklist.md` — Code Review Checklist [dev-methodology]
- `community-templates-guide.md` — Community Templates Guide [project-setup]
- `crm-dashboard.md` — CRM Dashboard [dashboard]
- `db-migration.md` — Database Migration Guide [refactoring]
- `docker-compose-template.md` — Docker Compose Template [project-setup]
- `env-template.md` — Environment Variables Template [project-setup]
- `footer-components.md` — Footer Components [components]
- `form-components.md` — Form Components [components]
- `git-workflow.md` — Git Workflow Guide [dev-methodology]
- `hero-components.md` — Hero Section Components [components]
- `modal-components.md` — Modal Components [components]
- `monitoring-dashboard.md` — System Monitoring Dashboard [dashboard]
- `navigation-components.md` — Navigation Components [components]
- `performance-checklist.md` — Performance Optimization Checklist [refactoring]
- `portfolio-landing.md` — Developer Portfolio Landing Page [landing-pages]
- `pricing-components.md` — Pricing Table Components [components]
- `product-landing.md` — Product Launch Landing Page [landing-pages]
- `readme-template.md` — README Template [project-setup]
- `saas-landing.md` — SaaS Landing Page [landing-pages]
- `security-audit.md` — Security Audit Checklist [refactoring]
- `startup-landing.md` — Startup Pitch Landing Page [landing-pages]
- `table-components.md` — Table Components [components]
- `tdd-guide.md` — TDD Workflow Guide [dev-methodology]

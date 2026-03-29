<p align="center">
  <img src="https://img.shields.io/badge/templates-32-7C3AED?style=for-the-badge" alt="32 Templates" />
  <img src="https://img.shields.io/badge/skills-7-EC4899?style=for-the-badge" alt="7 Skills" />
  <img src="https://img.shields.io/badge/cost-$0-10B981?style=for-the-badge" alt="Free" />
  <img src="https://img.shields.io/badge/license-MIT-3B82F6?style=for-the-badge" alt="MIT" />
</p>

<h1 align="center">TemplateClaw</h1>

<p align="center">
  <strong>32 production-ready templates as Claude Code skills.</strong><br/>
  Type a slash command. Get a complete landing page, dashboard, or project setup.<br/>
  No npm install. No build step. Just <code>/templateclaw</code>.
</p>

<p align="center">
  <a href="https://jeromwolf.github.io/templateclaw/">Browse Templates</a> ·
  <a href="#install">Install</a> ·
  <a href="#skills">Skills</a> ·
  <a href="#api">Agent API</a>
</p>

---

## Why TemplateClaw?

Every new project starts the same way: you need a landing page, a dashboard, a README, CI/CD config, and you spend hours googling and copy-pasting.

**TemplateClaw turns that into a single command.**

| Without TemplateClaw | With TemplateClaw |
|---------------------|-------------------|
| Google "modern landing page template 2026" | `/templateclaw-landing saas` |
| Search "admin dashboard glassmorphism" | `/templateclaw-dashboard admin` |
| Copy README from another project and edit | `/templateclaw-setup readme` |
| Write CI/CD from scratch every time | `/templateclaw-dev cicd` |
| Look up TDD best practices again | `/templateclaw-dev tdd` |

---

## Install

### As a Claude Code Plugin (recommended)

```bash
# Add the marketplace
/plugin marketplace add jeromwolf/templateclaw

# Install
/plugin install templateclaw
```

That's it. 7 new slash commands are now available in your Claude Code session.

### Manual (copy skills to your project)

```bash
git clone https://github.com/jeromwolf/templateclaw.git
cp -r templateclaw/skills/ .claude/skills/
```

### CLI (no Claude Code needed)

```bash
curl -fsSL https://jeromwolf.github.io/templateclaw/install.sh | bash
templateclaw list
templateclaw get saas-landing
```

---

## Skills

| Skill | What it does | Example |
|-------|-------------|---------|
| `/templateclaw` | Interactive project scaffolding | `/templateclaw "SaaS with auth"` |
| `/templateclaw-landing` | Generate landing pages (5 styles) | `/templateclaw-landing portfolio` |
| `/templateclaw-dashboard` | Generate dashboards (4 styles) | `/templateclaw-dashboard analytics` |
| `/templateclaw-ui` | Generate UI components (8 types) | `/templateclaw-ui cards,forms,nav` |
| `/templateclaw-setup` | Project setup files | `/templateclaw-setup all` |
| `/templateclaw-dev` | Dev methodology guides | `/templateclaw-dev tdd` |
| `/templateclaw-refactor` | Refactoring checklists | `/templateclaw-refactor security` |

### Quick Examples

**Scaffold a complete SaaS project:**
```
/templateclaw "Build a SaaS analytics dashboard with landing page"
```
Claude generates: landing page + dashboard + README + CLAUDE.md + Docker Compose + CI/CD pipeline.

**Generate a landing page:**
```
/templateclaw-landing saas
```
Output: A complete, responsive HTML page with glassmorphism design, hero section, pricing table, and CTA — ready to deploy.

**Set up a new project:**
```
/templateclaw-setup all
```
Output: README.md, CLAUDE.md, AGENTS.md, .env.example, docker-compose.yml — customized to your tech stack.

---

## Templates

32 templates across 6 categories, all following 2026 design trends:

| Category | Count | Includes |
|----------|-------|----------|
| **Landing Pages** | 5 | SaaS, Portfolio, Product, Startup, App |
| **Dashboard** | 4 | Admin, Analytics, Monitoring, CRM |
| **UI Components** | 8 | Cards, Forms, Nav, Modal, Table, Hero, Footer, Pricing |
| **Dev Methodology** | 5 | TDD, CI/CD, Code Review, Git Workflow, API Design |
| **Project Setup** | 7 | README, CLAUDE.md, AGENTS.md, .env, Docker, Agent Guide, Contributing |
| **Refactoring** | 3 | Performance, Security Audit, DB Migration |

### Design

- **Theme**: Dark (#0A0E1A) + Violet (#7C3AED) + Pink (#EC4899) gradients
- **Effects**: Glassmorphism, aurora animations, hover micro-interactions
- **Framework**: Tailwind CSS (CDN, no build step)
- **Responsive**: Mobile-first, 3→2→1 column grid
- **Accessible**: Semantic HTML, ARIA labels, keyboard navigation

Browse all templates with live previews: **[jeromwolf.github.io/templateclaw](https://jeromwolf.github.io/templateclaw/)**

---

## Agent API

TemplateClaw is **AI Agent native**. Any AI coding assistant can use our templates programmatically.

### Endpoints

| Endpoint | Description |
|----------|-------------|
| [`/api.json`](https://jeromwolf.github.io/templateclaw/api.json) | Lightweight catalog (metadata only) |
| [`/api-full.json`](https://jeromwolf.github.io/templateclaw/api-full.json) | Full catalog with template content |
| [`/templates/{name}.md`](https://jeromwolf.github.io/templateclaw/templates/) | Individual template files |

### Use in CLAUDE.md

Add this to any project's `CLAUDE.md` to give your AI agent access:

```markdown
## Templates
When creating UI components or project files, fetch templates from TemplateClaw:
- API: https://jeromwolf.github.io/templateclaw/api.json
- Get template: https://jeromwolf.github.io/templateclaw/templates/{filename}
```

### Cross-Tool Compatibility

TemplateClaw skills follow the [Agent Skills open standard](https://agentskills.io), compatible with:
- Claude Code
- OpenAI Codex
- Gemini CLI
- Cursor
- Any tool supporting the Agent Skills spec

---

## Auto-Update Pipeline

TemplateClaw automatically evolves:

```
Weekly: Scan design/dev trends (DuckDuckGo)
     → Claude Haiku analyzes trends
     → Generates 3 new templates
     → Rebuilds site
     → Deploys to GitHub Pages
     → Telegram notification
```

New templates appear automatically. No manual updates needed.

---

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

**Quick start:**
1. Fork this repo
2. Add a template to `templates/your-template.md` following the [template format](CONTRIBUTING.md#template-format)
3. Open a PR

**Good first issues:** Check the [Issues](https://github.com/jeromwolf/templateclaw/issues) tab.

---

## License

MIT — use these templates in any project, commercial or personal.

---

<p align="center">
  <sub>Built with the automated pipeline from <a href="https://github.com/jeromwolf/flux-openclaw">flux-openclaw</a></sub>
</p>

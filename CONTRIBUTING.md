# Contributing to TemplateClaw

Thank you for your interest in contributing to TemplateClaw! This guide explains how to add new templates, report issues, and submit pull requests.

## Table of Contents

- [Adding a Template](#adding-a-template)
- [Template Format Specification](#template-format-specification)
- [Pull Request Process](#pull-request-process)
- [Code of Conduct](#code-of-conduct)
- [Development Setup](#development-setup)

---

## Adding a Template

### Step 1: Create a Markdown File

Create a new `.md` file in `trading/templateclaw/content/`:

```
trading/templateclaw/content/your-template-name.md
```

**Naming convention:** Use lowercase kebab-case. The filename becomes the template identifier.

Examples:
- `saas-landing.md`
- `admin-dashboard.md`
- `form-components.md`
- `git-workflow.md`

### Step 2: Follow the Template Format

Every template file must include the metadata header. See [Template Format Specification](#template-format-specification) below.

### Step 3: Test Your Template

```bash
# Build the site to verify your template is parsed correctly
python3 -m trading.templateclaw.template_engine --build

# Check the status to see your template listed
python3 -m trading.templateclaw.template_engine --status
```

### Step 4: Submit a PR

See [Pull Request Process](#pull-request-process).

---

## Template Format Specification

Every template file **must** follow this exact format:

```markdown
# Template Title

> One-line description of what this template provides.

**Category**: Landing Pages | **Tags**: html, css, responsive | **Difficulty**: beginner

---

## Overview

Brief explanation of the template purpose and when to use it.

## Code

\```html
<!-- Your template code here -->
\```

## Usage Notes

- How to customize
- Key variables to change
- Dependencies if any

## Variations

Optional section for alternative approaches.
```

### Required Fields

| Field | Format | Description |
|-------|--------|-------------|
| **Title** | `# Title` (H1) | First H1 heading in the file |
| **Description** | `> Description` | First blockquote line |
| **Category** | `**Category**: name` | One of the valid categories |
| **Tags** | `**Tags**: tag1, tag2` | Comma-separated, lowercase |
| **Difficulty** | `**Difficulty**: level` | beginner, intermediate, or advanced |

### Valid Categories

| Category | Slug | Description |
|----------|------|-------------|
| Landing Pages | `landing-pages` | Landing page templates and layouts |
| Dashboard | `dashboard` | Admin and analytics dashboards |
| Components | `components` | Reusable UI components |
| Dev Methodology | `dev-methodology` | Development workflows and processes |
| Project Setup | `project-setup` | Project scaffolding and configuration |
| Refactoring | `refactoring` | Code improvement patterns and checklists |

### Difficulty Levels

| Level | When to Use |
|-------|-------------|
| `beginner` | Simple, minimal dependencies, easy to understand |
| `intermediate` | Moderate complexity, some patterns required |
| `advanced` | Complex architecture, deep knowledge needed |

### Tags Guidelines

- Use lowercase
- Prefer existing tags when possible
- Common tags: `html`, `css`, `javascript`, `tailwind`, `react`, `responsive`, `accessibility`, `dark-mode`, `api`, `database`, `docker`, `ci-cd`, `testing`
- Maximum 8 tags per template

---

## Pull Request Process

### Before Submitting

1. Verify your template follows the [format specification](#template-format-specification)
2. Run the build to confirm no parsing errors
3. Check that the template appears correctly in the generated site

### PR Template

When creating a pull request, include:

```markdown
## New Template: [template-name]

**Category:** [category]
**Difficulty:** [level]

### Description
Brief description of what this template provides.

### Checklist
- [ ] Follows the template format specification
- [ ] Includes meaningful description and tags
- [ ] Code is tested and functional
- [ ] Site builds successfully with `--build`
- [ ] No duplicate of existing template
```

### Review Criteria

PRs are reviewed for:

- **Format compliance**: Metadata header is correct and complete
- **Quality**: Code is clean, well-commented, and functional
- **Originality**: Not a duplicate of an existing template
- **Usefulness**: Provides real value for developers
- **Category fit**: Placed in the correct category

---

## Code of Conduct

### Our Standards

- Be respectful and constructive
- Welcome newcomers and help them contribute
- Focus on the work, not the person
- Accept constructive criticism gracefully
- Prioritize the community's best interest

### Unacceptable Behavior

- Harassment, trolling, or personal attacks
- Publishing others' private information
- Spam or self-promotion unrelated to the project

### Enforcement

Violations can be reported via GitHub issues. Maintainers will review and take appropriate action.

---

## Development Setup

### Prerequisites

- Python 3.8+
- Git

### Local Development

```bash
# Clone the repository
git clone https://github.com/jeromwolf/templateclaw.git
cd templateclaw

# Navigate to templateclaw
cd trading/templateclaw

# Build the site
python3 -m trading.templateclaw.template_engine --build

# View status
python3 -m trading.templateclaw.template_engine --status
```

### Directory Structure

```
trading/templateclaw/
  content/              # Template MD files go here
  templates/            # HTML site template
  template_engine.py    # Build engine
  scanner.py            # Template scanner
  deployer.py           # GitHub Pages deployer
  templateclaw-cli.sh   # CLI tool
  install.sh            # CLI installer
  CONTRIBUTING.md       # This file
```

### Build Output

The build generates files in `data/templateclaw/`:

```
data/templateclaw/
  index.html            # Static site
  catalog.json          # Full catalog
  api.json              # Lightweight API
  api-full.json         # Full API with content
  AGENT_README.md       # Agent integration docs
  templates/            # Downloadable MD files
  templateclaw-cli.sh   # CLI (for GitHub Pages)
  install.sh            # Installer (for GitHub Pages)
```

---

## Questions?

Open a GitHub issue or reach out in the discussions tab. We are happy to help!

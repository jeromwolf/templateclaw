# Community Templates Guide

> Complete guide for contributing templates to TemplateClaw, including format specification and best practices.

**Category**: Project Setup | **Tags**: contributing, templates, open-source, documentation, guide | **Difficulty**: beginner

---

## Overview

This guide explains how to create and contribute templates to the TemplateClaw ecosystem. Whether you are building a landing page template, a dashboard layout, or a development workflow guide, this document covers the format, conventions, and submission process.

## Template Format Specification

Every TemplateClaw template is a single Markdown file with a structured header:

```markdown
# Template Title

> One-line description of what this template provides.

**Category**: Landing Pages | **Tags**: html, css, responsive | **Difficulty**: beginner

---

## Overview

Brief explanation of the template purpose and when to use it.

## Code

<!-- Your actual template code goes here in fenced code blocks -->

## Usage Notes

- How to customize the template
- Key variables or sections to modify
- Any dependencies required

## Variations

Optional: alternative implementations or configurations.
```

### Required Metadata Fields

| Field | Syntax | Values |
|-------|--------|--------|
| Title | `# Title` (first H1) | Descriptive name |
| Description | `> Description` (first blockquote) | Single line, under 100 chars |
| Category | `**Category**: Name` | See categories below |
| Tags | `**Tags**: tag1, tag2` | Comma-separated, lowercase, max 8 |
| Difficulty | `**Difficulty**: level` | beginner, intermediate, advanced |

### Valid Categories

| Category Name | Description | Example Templates |
|---------------|-------------|-------------------|
| Landing Pages | Marketing and product landing pages | SaaS landing, portfolio, startup |
| Dashboard | Admin panels and analytics dashboards | Admin dashboard, analytics, CRM |
| Components | Reusable UI building blocks | Cards, forms, modals, navigation |
| Dev Methodology | Development processes and workflows | TDD guide, code review, git workflow |
| Project Setup | Scaffolding, configuration, tooling | Docker compose, CI/CD, env templates |
| Refactoring | Code improvement patterns | Performance checklist, security audit |

## Creating a Template

### Step 1: Choose a Name

Use lowercase kebab-case for the filename:

```
my-template-name.md
```

Good names:
- `saas-landing.md` (clear, descriptive)
- `admin-dashboard.md` (specific)
- `form-components.md` (category-obvious)

Avoid:
- `template1.md` (meaningless)
- `my_awesome_page.md` (use kebab-case, not snake_case)

### Step 2: Write the Content

Start with the metadata header, then organize into clear sections:

```markdown
# React Data Table Component

> Sortable, filterable data table with pagination for React applications.

**Category**: Components | **Tags**: react, table, pagination, sorting | **Difficulty**: intermediate

---

## Overview

A production-ready data table component with built-in sorting,
filtering, and pagination. Designed for admin dashboards and
data-heavy applications.

## Code

\```jsx
import React, { useState, useMemo } from 'react';

function DataTable({ data, columns, pageSize = 10 }) {
  const [sortKey, setSortKey] = useState(null);
  const [page, setPage] = useState(0);

  // ... implementation
}

export default DataTable;
\```

## Usage Notes

- Pass `data` as an array of objects
- `columns` defines visible fields and their headers
- Override `pageSize` for custom pagination
- Add `onRowClick` prop for row interaction

## Variations

### Minimal Version (no pagination)
\```jsx
// Simplified version for small datasets
\```

### With Server-Side Pagination
\```jsx
// Version that calls API for each page
\```
```

### Step 3: Validate

Place your file in `trading/templateclaw/content/` and run:

```bash
python3 -m trading.templateclaw.template_engine --status
```

Verify your template appears in the count and correct category.

### Step 4: Build and Check

```bash
python3 -m trading.templateclaw.template_engine --build
```

Open `data/templateclaw/index.html` in a browser to preview.

## Quality Guidelines

### Do

- Write clear, concise descriptions
- Include working code examples
- Add usage notes for customization
- Use appropriate difficulty levels
- Tag with relevant technologies

### Do Not

- Submit templates with broken code
- Duplicate existing templates
- Use excessive tags (max 8)
- Include external dependencies without noting them
- Add personal branding in the template content

## Template Ideas

Looking for inspiration? Here are some templates the community needs:

**Landing Pages:**
- E-commerce product page
- Event/conference landing
- Mobile app download page
- Non-profit organization page

**Dashboards:**
- Real-time monitoring dashboard
- Project management board
- Financial reporting dashboard
- IoT device dashboard

**Components:**
- Notification system
- File upload with preview
- Multi-step wizard form
- Command palette (Cmd+K)

**Dev Methodology:**
- API versioning guide
- Microservices communication patterns
- Error handling best practices
- Logging and observability setup

**Project Setup:**
- Monorepo configuration
- Kubernetes deployment template
- Terraform infrastructure template
- GitHub Actions workflow collection

## Getting Help

If you have questions about contributing:

1. Check existing templates in `trading/templateclaw/content/` for reference
2. Open a GitHub issue with the `template-question` label
3. Review the CONTRIBUTING.md file for PR guidelines

Every contribution makes TemplateClaw more useful for the developer community. Thank you!

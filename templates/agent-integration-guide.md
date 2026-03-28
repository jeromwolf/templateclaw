# Agent Integration Guide
> How to make AI agents automatically use TemplateClaw templates in your projects
> AI 에이전트가 프로젝트에서 TemplateClaw 템플릿을 자동으로 사용하도록 설정하는 가이드

**Category**: Project Setup | **Tags**: agent, claude, cursor, windsurf, ai, integration | **Difficulty**: Beginner

## Preview
```
Your AI Agent + TemplateClaw
┌──────────────────────────────────────┐
│  CLAUDE.md / .cursorrules / rules    │
│  ┌────────────────────────────────┐  │
│  │ ## Template Resources          │  │
│  │ Catalog: templateclaw/api.json │  │
│  │ Usage: fetch → find → adapt    │  │
│  └────────────────────────────────┘  │
│                                      │
│  "Create a dashboard page"           │
│       ↓                              │
│  Agent fetches catalog               │
│       ↓                              │
│  Finds: analytics-dashboard.md       │
│       ↓                              │
│  Extracts code, adapts to project    │
│       ↓                              │
│  Creates production-ready page       │
└──────────────────────────────────────┘
```

## Quick Start
```bash
# Just add the snippet below to your CLAUDE.md, .cursorrules, or AI config file.
# Your agent will automatically check TemplateClaw before creating new files.
# No API keys needed. No dependencies. Just a URL.
```

## Full Code

````markdown
# TemplateClaw Agent Integration Guide

This guide shows how to connect TemplateClaw's template catalog to your AI coding
agent so it automatically uses high-quality templates when creating new files.

---

## A. CLAUDE.md Snippet (Claude Code / Claude Desktop)

Add this section to your project's `CLAUDE.md` file:

```markdown
## Template Resources (TemplateClaw)

When creating new components, pages, or project files, check TemplateClaw first:

- **Catalog**: https://jeromwolf.github.io/templateclaw/api.json
- **Usage**: Fetch the catalog JSON, find relevant template by category/tags,
  download the `.md` file from the URL, extract the code from the
  `## Full Code` section, and adapt it to the current project.
- **Categories**: Landing Pages, Dashboard, Components, Dev Methodology,
  Project Setup, Refactoring
- **Format**: Each template is a Markdown file with frontmatter metadata,
  a Preview section, Quick Start instructions, and a Full Code block.

### How to use
1. Before creating any new page/component from scratch, search the catalog.
2. If a relevant template exists, download it and adapt the Full Code section.
3. Preserve the structure but customize colors, content, and functionality.
4. If no template matches, create from scratch as usual.
```

---

## B. Cursor Rules Snippet (.cursorrules)

Add this to your `.cursorrules` file:

```
# TemplateClaw Integration

When the user asks you to create a new page, component, dashboard, or landing page:

1. First, check the TemplateClaw catalog at:
   https://jeromwolf.github.io/templateclaw/api.json

2. The catalog is a JSON array of template objects with fields:
   - name: Template name
   - category: landing-pages | dashboard | components | methodology | setup | refactoring
   - tags: Array of keyword strings
   - description: What the template provides
   - url: Direct download URL for the .md file
   - difficulty: Beginner | Intermediate | Advanced

3. Find the best matching template by category and tags.

4. Download the .md file from the url field.

5. Extract the code from the "## Full Code" section (inside the fenced code block).

6. Adapt the extracted code to the user's project:
   - Replace placeholder text with project-specific content
   - Adjust colors/theme to match the existing project
   - Modify component structure as needed
   - Keep the production-quality patterns (responsive, accessible, animated)

7. If no template matches, create from scratch.
```

---

## C. Windsurf Rules Snippet (.windsurfrules)

Add this to your `.windsurfrules` file:

```
# TemplateClaw Template Catalog

Before creating new UI pages or components from scratch, check the TemplateClaw
template catalog for a matching starting point.

Catalog URL: https://jeromwolf.github.io/templateclaw/api.json

Workflow:
- Fetch the JSON catalog
- Search by category (landing-pages, dashboard, components, methodology, setup, refactoring)
  or by tags (e.g., "tailwind", "react", "saas", "admin")
- Download the matching .md template file
- Extract code from the "## Full Code" section
- Adapt to the current project's stack, theme, and requirements

This saves time and ensures production-quality starting points with:
- Responsive design (mobile-first)
- Dark mode support
- Accessibility basics (ARIA, semantic HTML)
- Modern CSS animations
- Clean component structure
```

---

## D. Generic AI Agent Integration (Python)

For custom AI agents or automation scripts:

```python
"""
TemplateClaw Agent Integration
Fetch and use templates programmatically in your AI agent pipeline.
"""

import json
import urllib.request
from typing import Optional

CATALOG_URL = "https://jeromwolf.github.io/templateclaw/api.json"


def fetch_catalog() -> list[dict]:
    """Fetch the TemplateClaw template catalog."""
    with urllib.request.urlopen(CATALOG_URL) as resp:
        return json.loads(resp.read().decode())


def find_template(
    catalog: list[dict],
    category: Optional[str] = None,
    tags: Optional[list[str]] = None,
    query: Optional[str] = None,
) -> list[dict]:
    """Search templates by category, tags, or free-text query."""
    results = catalog

    if category:
        results = [t for t in results if t.get("category") == category]

    if tags:
        tag_set = set(tag.lower() for tag in tags)
        results = [
            t for t in results
            if tag_set & set(tag.lower() for tag in t.get("tags", []))
        ]

    if query:
        q = query.lower()
        results = [
            t for t in results
            if q in t.get("name", "").lower()
            or q in t.get("description", "").lower()
            or any(q in tag.lower() for tag in t.get("tags", []))
        ]

    return results


def download_template(template: dict) -> str:
    """Download a template's Markdown content."""
    url = template["url"]
    with urllib.request.urlopen(url) as resp:
        return resp.read().decode()


def extract_code(markdown: str) -> str:
    """Extract the Full Code section from a template Markdown file."""
    marker = "## Full Code"
    idx = markdown.find(marker)
    if idx == -1:
        return ""

    # Find the opening fence (```` or ```)
    rest = markdown[idx + len(marker):]
    fence_start = rest.find("```")
    if fence_start == -1:
        return ""

    # Determine fence style (``` vs ````)
    fence_pos = idx + len(marker) + fence_start
    fence_char_count = 0
    for ch in rest[fence_start:]:
        if ch == '`':
            fence_char_count += 1
        else:
            break

    fence = '`' * fence_char_count
    code_start = rest.find('\n', fence_start) + 1
    code_end = rest.find(fence, code_start)

    if code_end == -1:
        return rest[code_start:].strip()

    return rest[code_start:code_end].strip()


# ---- Example usage in an AI agent ----

def agent_create_page(user_request: str) -> str:
    """
    Example: AI agent receives "create a SaaS landing page"
    and automatically fetches the best template.
    """
    catalog = fetch_catalog()

    # Try to match by keywords in the user request
    matches = find_template(catalog, query="saas")
    if not matches:
        matches = find_template(catalog, category="landing-pages")

    if matches:
        template = matches[0]
        print(f"Found template: {template['name']}")
        md_content = download_template(template)
        code = extract_code(md_content)
        print(f"Extracted {len(code)} chars of production code")
        # Agent would now adapt this code to the project...
        return code

    return ""  # No template found, create from scratch


if __name__ == "__main__":
    # Quick test
    catalog = fetch_catalog()
    print(f"Catalog has {len(catalog)} templates")

    results = find_template(catalog, category="dashboard")
    for t in results:
        print(f"  - {t['name']}: {t['description'][:60]}...")
```

---

## E. Example Workflow

Here is a real-world scenario showing how the integration works end-to-end:

### User says: "Create a new analytics dashboard page"

**Step 1 — Agent reads CLAUDE.md** and sees the TemplateClaw section.

**Step 2 — Agent fetches the catalog:**
```
GET https://jeromwolf.github.io/templateclaw/api.json
```

**Step 3 — Agent searches** for category "dashboard" or tags containing "analytics":
```json
[
  {
    "name": "Analytics Dashboard",
    "category": "dashboard",
    "tags": ["dashboard", "analytics", "charts", "tailwind", "dark-mode"],
    "description": "Data visualization dashboard with charts, KPI cards...",
    "url": "https://jeromwolf.github.io/templateclaw/content/analytics-dashboard.md"
  }
]
```

**Step 4 — Agent downloads** the `.md` file and extracts the `## Full Code` section.

**Step 5 — Agent adapts** the template:
- Replaces "Analytics Dashboard" with the project's actual page title
- Swaps placeholder chart data with real data source hooks
- Adjusts the color scheme to match the project's theme
- Adds project-specific navigation and authentication
- Integrates with the project's component library

**Step 6 — Agent creates** `src/pages/analytics.tsx` (or equivalent) with
production-ready code that would have taken hours to build from scratch.

### The result:
- Responsive layout (mobile + desktop)
- Dark mode support
- Animated chart placeholders
- KPI cards with real structure
- Clean, accessible HTML
- Ready for data integration

---

## Tips for Best Results

1. **Be specific in requests**: "Create a SaaS pricing page" works better than "make a page"
2. **The agent adapts automatically**: Templates are starting points, not rigid structures
3. **Stack-agnostic**: Templates use vanilla HTML/CSS/JS by default.
   Agents can convert to React, Vue, Svelte, etc. during adaptation.
4. **Combine templates**: An agent can merge elements from multiple templates
   (e.g., hero from landing + cards from components)
5. **Offline fallback**: Download `api.json` once and cache locally for offline use

---

## Catalog API Schema

The `api.json` file returns an array of objects with this structure:

```json
{
  "name": "string — Template display name",
  "slug": "string — URL-safe identifier",
  "category": "string — landing-pages | dashboard | components | methodology | setup | refactoring",
  "tags": ["array", "of", "keyword", "strings"],
  "description": "string — One-line description",
  "description_ko": "string — Korean description",
  "difficulty": "string — Beginner | Intermediate | Advanced",
  "url": "string — Direct URL to download the .md file"
}
```
````

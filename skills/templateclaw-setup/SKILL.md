---
name: templateclaw-setup
description: "Generate project setup files — README.md, CLAUDE.md, AGENTS.md, .env template, Docker Compose. Best practices for modern development teams and AI-assisted coding."
allowed-tools: Read, Write, Edit, Glob
argument-hint: "[file: readme|claude-md|agents-md|env|docker|all]"
---

# TemplateClaw — Project Setup Generator

Generate production-quality project setup files following 2026 best practices.

## When Invoked

1. If argument provided (e.g., `/templateclaw-setup readme`), generate that file
2. If "all", generate all setup files for the current project
3. If no argument, detect the project type from existing files and suggest what's missing

## Available Setup Files

### README.md
Structure:
```markdown
# Project Name
> One-line description

[Badges: CI, coverage, license, version]

[Screenshot/GIF placeholder]

## What it does
[2-3 sentences]

## Quick Start
[One-liner install + run]

## Features
[Bulleted list]

## Architecture
[Brief diagram or description]

## Development
[Setup, test, lint commands]

## Contributing
[Link to CONTRIBUTING.md]

## License
[MIT/Apache/etc.]
```

**Adapt to project**: Detect language from package.json/pyproject.toml/Cargo.toml and use appropriate commands.

### CLAUDE.md (AI Agent Instructions)
Structure:
```markdown
# Project Guide for AI Agents

## Project Overview
[What this project does, tech stack]

## Architecture
[Directory structure, key modules, data flow]

## Development Rules
[Coding conventions, naming, patterns]

## Testing
[How to run tests, coverage expectations]

## Common Tasks
[Frequent operations with exact commands]

## Do's and Don'ts
[Explicit rules for the AI agent]
```

**Key principle**: CLAUDE.md is for AI agents working on the project. Include concrete commands, file paths, and rules — not prose.

### AGENTS.md (Multi-Agent Documentation)
Structure:
```markdown
# Agent Hierarchy

## Primary Agent
- Role, capabilities, tools

## Specialist Agents
- Per-domain agent definitions

## Coordination
- How agents communicate
- Task delegation rules

## Boundaries
- What each agent can/cannot modify
```

### .env Template (.env.example)
- Group by service (DB, API, Auth, etc.)
- Include descriptions as comments
- Use placeholder values (never real secrets)
- Reference to secrets manager if applicable
```env
# === Database ===
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
DATABASE_POOL_SIZE=10  # Max concurrent connections

# === Authentication ===
JWT_SECRET=your-secret-here  # Generate: openssl rand -hex 32
JWT_EXPIRY=24h
```

### Docker Compose (docker-compose.yml)
- Multi-stage Dockerfile reference
- Service definitions (app, db, redis, etc.)
- Health checks
- Volume mounts for persistence
- Environment variable references from .env
- Network isolation
- Development overrides (docker-compose.override.yml)

## Auto-Detection

When no argument is given, check for:
- `package.json` → Node.js project setup
- `pyproject.toml` / `requirements.txt` → Python project setup
- `Cargo.toml` → Rust project setup
- `go.mod` → Go project setup
- Existing files → suggest only what's missing

## Output

Write files directly to the project root. If a file already exists, show a diff preview and ask before overwriting.

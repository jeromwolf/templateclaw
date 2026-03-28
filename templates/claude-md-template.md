# CLAUDE.md Template
> CLAUDE.md template for AI-assisted development with project structure, rules, and patterns
> AI 지원 개발을 위한 CLAUDE.md 템플릿 (프로젝트 구조, 규칙, 패턴)

**Category**: Project Setup | **Tags**: claude, ai, llm, cursor, windsurf, development | **Difficulty**: Beginner

## Preview
```
CLAUDE.md - Your AI assistant's project guide
├── Project Overview
├── Architecture & Structure
├── Key Patterns & Rules
├── Commands & Testing
└── What NOT to Do
```

## Quick Start
```bash
# 1. Copy the template below to CLAUDE.md in your project root
# 2. Fill in your project-specific details
# 3. The AI assistant reads this file automatically for context
# Works with: Claude Code, Cursor, Windsurf, Copilot Workspace
```

## Full Code

````markdown
# [PROJECT_NAME] - Development Guide

This document provides context for AI assistants working on this codebase.

---

## Project Overview

**What**: [One sentence describing what this project does]
**Stack**: [e.g., Next.js 15 + TypeScript + PostgreSQL + Tailwind CSS]
**Status**: [Production / Beta / Development]

### Key URLs
- Production: https://app.example.com
- Staging: https://staging.example.com
- API Docs: https://api.example.com/docs

---

## Architecture

### Tech Stack

| Layer | Technology | Notes |
|-------|-----------|-------|
| Frontend | Next.js 15 (App Router) | React Server Components preferred |
| Styling | Tailwind CSS v4 | Using `@theme` for design tokens |
| Backend | FastAPI / Next.js API Routes | REST, OpenAPI spec |
| Database | PostgreSQL 16 | Drizzle ORM, migrations in `drizzle/` |
| Auth | NextAuth.js v5 | OAuth2 (Google, GitHub) |
| Deployment | Vercel | Auto-deploy on push to main |
| CI/CD | GitHub Actions | Lint + Test + Build on PR |

### Directory Structure

```
src/
├── app/                # Next.js App Router pages
│   ├── (auth)/         # Auth-related routes (grouped)
│   ├── (dashboard)/    # Dashboard routes (grouped)
│   ├── api/            # API routes
│   └── layout.tsx      # Root layout
├── components/         # Reusable UI components
│   ├── ui/             # Primitive components (Button, Input, Card)
│   └── features/       # Feature-specific components
├── lib/                # Shared utilities
│   ├── db.ts           # Database client
│   ├── auth.ts         # Auth configuration
│   └── utils.ts        # General utilities
├── services/           # Business logic (no framework deps)
├── types/              # TypeScript type definitions
└── hooks/              # Custom React hooks
```

### Key Files
- `src/lib/db.ts` - Database connection and Drizzle client
- `src/lib/auth.ts` - NextAuth configuration
- `drizzle/schema.ts` - Database schema definition
- `src/services/` - Core business logic (test these heavily)

---

## Rules and Patterns

### DO

```
- Use TypeScript strict mode (no `any` types)
- Use Server Components by default, Client Components only when needed
- Write business logic in `services/` (framework-agnostic, testable)
- Use Drizzle ORM for all database queries (no raw SQL)
- Follow existing file naming: kebab-case for files, PascalCase for components
- Add `"use client"` directive only when using hooks, events, or browser APIs
- Handle errors with try-catch and return proper HTTP status codes
- Use environment variables via `process.env` (validated in `src/lib/env.ts`)
```

### DO NOT

```
- Do NOT use `any` type - use `unknown` and narrow types
- Do NOT put business logic in API routes - use services layer
- Do NOT use `useEffect` for data fetching - use Server Components or SWR
- Do NOT modify the database schema without creating a migration
- Do NOT hardcode URLs, API keys, or configuration values
- Do NOT skip error handling - every API route needs try-catch
- Do NOT add dependencies without checking bundle size impact
- Do NOT use default exports (use named exports for better refactoring)
```

### Code Style

```typescript
// Component pattern
export function UserCard({ user }: { user: User }) {
  return (
    <div className="rounded-xl border p-4">
      <h3 className="font-semibold">{user.name}</h3>
    </div>
  );
}

// Service pattern
export async function createUser(data: CreateUserInput): Promise<User> {
  const validated = createUserSchema.parse(data);
  const user = await db.insert(users).values(validated).returning();
  return user[0];
}

// API route pattern
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const user = await createUser(body);
    return Response.json(user, { status: 201 });
  } catch (error) {
    if (error instanceof ZodError) {
      return Response.json({ error: error.issues }, { status: 400 });
    }
    return Response.json({ error: "Internal server error" }, { status: 500 });
  }
}
```

---

## Commands

```bash
# Development
npm run dev           # Start dev server (http://localhost:3000)
npm run build         # Production build
npm run start         # Start production server

# Testing
npm test              # Run all tests
npm run test:watch    # Watch mode
npm run test:coverage # Coverage report (target: 80%)

# Database
npm run db:generate   # Generate migration from schema changes
npm run db:migrate    # Run pending migrations
npm run db:studio     # Open Drizzle Studio (visual DB browser)

# Quality
npm run lint          # ESLint check
npm run lint:fix      # ESLint auto-fix
npm run typecheck     # TypeScript type checking
```

---

## Database

### Schema Change Workflow
1. Edit `drizzle/schema.ts`
2. Run `npm run db:generate` to create migration
3. Review generated SQL in `drizzle/migrations/`
4. Run `npm run db:migrate` to apply
5. Test with `npm run db:studio`

### Key Tables
- `users` - User accounts (id, email, name, role)
- `projects` - User projects (id, user_id, name, status)
- `api_keys` - API keys (id, user_id, key_hash, last_used)

---

## Testing Strategy

| Type | Location | Command | Coverage Target |
|------|----------|---------|----------------|
| Unit | `tests/unit/` | `npm test` | 80% for services |
| Integration | `tests/integration/` | `npm run test:integration` | Key API routes |
| E2E | `tests/e2e/` | `npm run test:e2e` | Critical user flows |

### Test file naming: `[module].test.ts`

---

## Environment Variables

```bash
# Required
DATABASE_URL=          # PostgreSQL connection string
NEXTAUTH_SECRET=       # Random 32+ char secret
NEXTAUTH_URL=          # http://localhost:3000 (dev)

# OAuth (at least one required)
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
GITHUB_ID=
GITHUB_SECRET=

# Optional
LOG_LEVEL=info         # debug, info, warn, error
SENTRY_DSN=            # Error tracking
ANALYTICS_ID=          # PostHog/Plausible
```

---

## Common Tasks

### Add a new API endpoint
1. Create service function in `src/services/`
2. Add API route in `src/app/api/`
3. Add validation schema with Zod
4. Write test in `tests/`
5. Update OpenAPI spec if applicable

### Add a new database table
1. Add table definition in `drizzle/schema.ts`
2. Run `npm run db:generate`
3. Review and run migration
4. Create service functions for CRUD
5. Write tests

### Add a new page
1. Create route in `src/app/(section)/page.tsx`
2. Use Server Components for data fetching
3. Create feature components in `src/components/features/`
4. Add to navigation if needed
````

## Customization Guide
- **Stack**: Replace Next.js/TypeScript examples with your actual stack (Python/Django, Go/Gin, etc.)
- **Rules**: Add project-specific rules (e.g., "always use UTC for timestamps")
- **Commands**: Update with your actual dev/test/build commands
- **Schema**: Document your actual database tables
- **Patterns**: Add code patterns specific to your architecture

## 2026 Trend Notes
- CLAUDE.md is becoming the standard for AI-assisted development context files
- Structured rules (DO/DON'T) are more effective than prose for LLM comprehension
- Including code patterns with examples helps AI produce consistent code
- Database schema documentation prevents column name mismatches (common AI error)
- Command reference eliminates guesswork for AI agents running builds/tests

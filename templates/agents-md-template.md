# AGENTS.md Template
> AGENTS.md template for documenting codebase for AI agents (architecture, modules, dependencies)
> AI 에이전트를 위한 코드베이스 문서화 템플릿 (아키텍처, 모듈, 의존성)

**Category**: Project Setup | **Tags**: agents, ai, documentation, codebase, architecture | **Difficulty**: Beginner

## Preview
```
AGENTS.md - Codebase map for AI agents
├── System Architecture
├── Module Index (per directory)
├── Data Flow
├── Key Abstractions
└── Gotchas & Known Issues
```

## Quick Start
```bash
# 1. Copy the template below to AGENTS.md in your project root
# 2. Fill in each section with your codebase details
# 3. AI agents read this file for deep codebase understanding
# 4. Update when architecture changes significantly
```

## Full Code

````markdown
# AGENTS.md - Codebase Documentation for AI Agents

> This file provides a structured map of the codebase for AI agents.
> Last updated: [DATE]

---

## System Overview

**Purpose**: [What this system does in 1-2 sentences]
**Architecture**: [Monolith / Microservices / Serverless / Monorepo]
**Primary Language**: [TypeScript / Python / Go / etc.]
**Entry Points**: [Where execution begins]

```
[User] --> [API Gateway] --> [Service Layer] --> [Database]
                |                   |
                |                   +--> [External APIs]
                |
                +--> [WebSocket] --> [Real-time Updates]
```

---

## Module Index

### `/src/app/` - Application Layer
| File/Dir | Purpose | Key Exports |
|----------|---------|-------------|
| `layout.tsx` | Root layout, providers, global styles | `RootLayout` |
| `page.tsx` | Home page | `HomePage` |
| `api/users/route.ts` | User CRUD endpoints | `GET`, `POST` |
| `api/auth/[...nextauth]/route.ts` | Authentication handler | NextAuth config |
| `(dashboard)/` | Dashboard route group | Protected pages |

### `/src/services/` - Business Logic
| File | Purpose | Key Functions |
|------|---------|---------------|
| `user-service.ts` | User management logic | `createUser()`, `findUser()`, `updateUser()` |
| `auth-service.ts` | Authentication & authorization | `verifyToken()`, `hasPermission()` |
| `billing-service.ts` | Subscription & payment logic | `createSubscription()`, `processPayment()` |
| `notification-service.ts` | Email & push notifications | `sendEmail()`, `sendPush()` |

### `/src/lib/` - Shared Infrastructure
| File | Purpose | Key Exports |
|------|---------|-------------|
| `db.ts` | Database client (Drizzle ORM) | `db` instance |
| `auth.ts` | NextAuth configuration | `authOptions` |
| `redis.ts` | Redis client for caching | `redis` instance |
| `logger.ts` | Structured logging (Pino) | `logger` |
| `env.ts` | Environment variable validation | `env` (typed) |

### `/src/components/` - UI Components
| Dir | Purpose | Component Count |
|-----|---------|----------------|
| `ui/` | Primitive components (Button, Input, Card) | ~20 |
| `features/` | Feature-specific composites | ~15 |
| `layouts/` | Page layout wrappers | ~5 |

### `/drizzle/` - Database
| File | Purpose |
|------|---------|
| `schema.ts` | Table definitions (source of truth) |
| `migrations/` | SQL migration files (auto-generated) |

---

## Data Flow

### Request Lifecycle
```
1. HTTP Request arrives
2. Middleware: auth check, rate limiting, logging
3. API Route: parse input, validate with Zod
4. Service Layer: business logic, DB queries
5. Response: serialize, send JSON
```

### Authentication Flow
```
1. User clicks "Sign in with Google"
2. NextAuth redirects to Google OAuth
3. Callback: Google returns tokens
4. NextAuth creates/updates user in DB
5. Session JWT set in cookie
6. Subsequent requests: JWT verified in middleware
```

### Data Persistence
```
Write Path:  Service -> Drizzle ORM -> PostgreSQL
Read Path:   Service -> Redis Cache (hit?) -> Drizzle ORM -> PostgreSQL
Cache TTL:   5 minutes for user data, 1 hour for static config
```

---

## Key Abstractions

### Service Pattern
All business logic lives in `/src/services/`. Services are:
- **Framework-agnostic**: No Next.js imports, no React
- **Testable**: Accept dependencies as parameters
- **Type-safe**: Input/output typed with Zod schemas

```typescript
// Pattern:
export async function createResource(
  input: CreateResourceInput,  // Zod-validated
  ctx: { db: Database; user: User }  // Injected dependencies
): Promise<Resource> {
  // Business logic here
}
```

### Error Handling
Custom error classes in `src/lib/errors.ts`:
- `NotFoundError` -> 404
- `ValidationError` -> 400
- `UnauthorizedError` -> 401
- `ForbiddenError` -> 403

API routes catch these and return appropriate HTTP status codes.

### Database Patterns
- All queries go through Drizzle ORM (no raw SQL)
- Soft deletes: `deleted_at` column (not actual DELETE)
- Timestamps: `created_at`, `updated_at` auto-managed
- IDs: `cuid2` format (e.g., `usr_abc123xyz`)

---

## Dependencies Map

```
src/app/api/* -----> src/services/*  (business logic)
src/services/* ----> src/lib/db.ts   (database)
src/services/* ----> src/lib/redis.ts (caching)
src/app/**    -----> src/components/* (UI)
src/components/* --> src/hooks/*      (state)
src/lib/env.ts ----> .env            (config)
```

### External Services
| Service | Used By | Purpose |
|---------|---------|---------|
| PostgreSQL | `src/lib/db.ts` | Primary data store |
| Redis | `src/lib/redis.ts` | Cache, rate limiting |
| Stripe | `src/services/billing-service.ts` | Payments |
| Resend | `src/services/notification-service.ts` | Transactional email |
| PostHog | `src/lib/analytics.ts` | Product analytics |

---

## Gotchas & Known Issues

### Things AI Agents Should Know

1. **Database column naming**: Uses `snake_case` in DB, `camelCase` in TypeScript. Drizzle handles the mapping automatically.

2. **Auth session**: `getServerSession()` must be called in Server Components. Use `useSession()` only in Client Components.

3. **Environment variables**: Client-side env vars must be prefixed with `NEXT_PUBLIC_`. Server-only vars are NOT accessible in browser.

4. **Import paths**: Use `@/` alias (maps to `src/`). Example: `import { db } from '@/lib/db'`

5. **Testing database**: Tests use a separate test database. Run `npm run db:test:setup` before first test run.

6. **Rate limiting**: API routes have rate limiting middleware. Test with `X-RateLimit-*` headers.

7. **Soft deletes**: When querying, always filter `WHERE deleted_at IS NULL` unless explicitly including deleted records.

---

## Conventions

| Area | Convention |
|------|-----------|
| Files | `kebab-case.ts` |
| Components | `PascalCase.tsx` |
| Functions | `camelCase` |
| Constants | `SCREAMING_SNAKE_CASE` |
| DB tables | `snake_case` (plural: `users`, `projects`) |
| DB columns | `snake_case` |
| Env vars | `SCREAMING_SNAKE_CASE` |
| CSS classes | Tailwind utility classes (no custom CSS unless necessary) |
| Git branches | `feature/`, `fix/`, `chore/` prefix |
| Commits | Conventional Commits format |
````

## Customization Guide
- **Architecture diagram**: Replace the ASCII diagram with your actual system topology
- **Module index**: Add all directories with their purposes and key exports
- **Data flow**: Document your specific request lifecycle, auth flow, and caching strategy
- **Dependencies map**: Show how modules depend on each other
- **Gotchas**: List every non-obvious thing that an AI agent might get wrong
- **Update frequency**: Re-generate after major architecture changes

## 2026 Trend Notes
- AGENTS.md is emerging as the standard for AI agent codebase documentation
- Module index with key exports helps agents find the right file to edit
- Data flow diagrams prevent agents from implementing logic in the wrong layer
- Gotchas section is the highest-ROI content (prevents repeated AI mistakes)
- Dependency maps help agents understand impact radius of changes

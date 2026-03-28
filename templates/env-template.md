# Environment Variables Template
> Comprehensive .env template organized by category: database, auth, APIs, feature flags
> 카테고리별 정리된 .env 템플릿: 데이터베이스, 인증, API, 기능 플래그

**Category**: Project Setup | **Tags**: env, configuration, secrets, environment, dotenv | **Difficulty**: Beginner

## Preview
```
.env.example
├── App Config (PORT, ENV, URL)
├── Database (PostgreSQL, Redis)
├── Auth (JWT, OAuth)
├── API Keys (Stripe, Resend, OpenAI)
├── Storage (S3, Cloudflare R2)
├── Feature Flags
└── Monitoring (Sentry, PostHog)
```

## Quick Start
```bash
# 1. Copy the template below to .env.example in your project root
# 2. Copy .env.example to .env and fill in real values
# 3. NEVER commit .env to git (add to .gitignore)
cp .env.example .env
# Fill in your values...
```

## Full Code

### .env.example

```bash
# ============================================
# Application
# ============================================
NODE_ENV=development                  # development | staging | production
PORT=3000                             # Server port
APP_URL=http://localhost:3000         # Public-facing URL
APP_NAME="My App"                     # Display name
LOG_LEVEL=info                        # debug | info | warn | error

# ============================================
# Database
# ============================================
# PostgreSQL
DATABASE_URL=postgresql://user:password@localhost:5432/myapp_dev
DATABASE_POOL_SIZE=10                 # Connection pool size
DATABASE_SSL=false                    # true in production

# Redis (caching, sessions, rate limiting)
REDIS_URL=redis://localhost:6379
REDIS_PREFIX=myapp:                   # Key prefix for namespacing

# SQLite (alternative for simple apps)
# SQLITE_PATH=./data/app.db

# ============================================
# Authentication
# ============================================
# JWT
JWT_SECRET=change-me-to-a-random-64-char-string
JWT_EXPIRY=7d                         # Token expiration (1h, 7d, 30d)

# NextAuth / Auth.js
NEXTAUTH_SECRET=change-me-to-a-random-32-char-string
NEXTAUTH_URL=http://localhost:3000

# Google OAuth
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# GitHub OAuth
GITHUB_ID=
GITHUB_SECRET=

# Apple OAuth
APPLE_ID=
APPLE_SECRET=

# ============================================
# API Keys - Third Party Services
# ============================================
# Payments (Stripe)
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Email (Resend)
RESEND_API_KEY=re_...
EMAIL_FROM="App Name <noreply@yourdomain.com>"

# AI / LLM
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
# GOOGLE_AI_API_KEY=AIza...

# Search
# ALGOLIA_APP_ID=
# ALGOLIA_API_KEY=

# ============================================
# Storage
# ============================================
# AWS S3 / Cloudflare R2
S3_BUCKET=myapp-uploads
S3_REGION=us-east-1
S3_ACCESS_KEY=
S3_SECRET_KEY=
S3_ENDPOINT=                          # Set for R2: https://ACCOUNT.r2.cloudflarestorage.com

# Local uploads (development)
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=10485760                # 10MB in bytes

# ============================================
# External APIs
# ============================================
# Webhook URLs
WEBHOOK_SECRET=whsec_change_me
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...

# Rate Limiting
RATE_LIMIT_WINDOW=60000              # 1 minute in ms
RATE_LIMIT_MAX=100                   # Max requests per window

# ============================================
# Feature Flags
# ============================================
FEATURE_NEW_DASHBOARD=false           # Enable new dashboard UI
FEATURE_AI_ASSISTANT=true             # Enable AI assistant
FEATURE_DARK_MODE=true                # Enable dark mode toggle
FEATURE_BETA_API=false                # Enable beta API endpoints
FEATURE_MAINTENANCE_MODE=false        # Show maintenance page

# ============================================
# Monitoring & Analytics
# ============================================
# Error tracking (Sentry)
SENTRY_DSN=https://abc@sentry.io/123
SENTRY_ENVIRONMENT=development

# Analytics (PostHog)
NEXT_PUBLIC_POSTHOG_KEY=phc_...
NEXT_PUBLIC_POSTHOG_HOST=https://us.posthog.com

# Uptime monitoring
# BETTERUPTIME_API_KEY=

# ============================================
# CI/CD (usually set in GitHub Actions secrets)
# ============================================
# VERCEL_TOKEN=
# VERCEL_ORG_ID=
# VERCEL_PROJECT_ID=
# CODECOV_TOKEN=
# DEPLOY_SSH_KEY=
```

### .gitignore entries

```bash
# Add to .gitignore (CRITICAL)
.env
.env.local
.env.*.local
*.pem
*.key
data/kis_token.json
```

### Validation Script (TypeScript)

```typescript
// src/lib/env.ts - Validate environment variables at startup
import { z } from 'zod';

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'staging', 'production']).default('development'),
  PORT: z.coerce.number().default(3000),
  APP_URL: z.string().url(),
  DATABASE_URL: z.string().min(1, 'DATABASE_URL is required'),
  JWT_SECRET: z.string().min(32, 'JWT_SECRET must be at least 32 characters'),
  REDIS_URL: z.string().optional(),
  STRIPE_SECRET_KEY: z.string().optional(),
  RESEND_API_KEY: z.string().optional(),
  LOG_LEVEL: z.enum(['debug', 'info', 'warn', 'error']).default('info'),
});

export const env = envSchema.parse(process.env);
export type Env = z.infer<typeof envSchema>;
```

### Validation Script (Python)

```python
# src/config.py - Validate environment variables at startup
import os
from dataclasses import dataclass

@dataclass
class Config:
    app_env: str = "development"
    port: int = 3000
    app_url: str = "http://localhost:3000"
    database_url: str = ""
    jwt_secret: str = ""
    redis_url: str = ""
    log_level: str = "info"

    def __post_init__(self):
        self.app_env = os.getenv("NODE_ENV", self.app_env)
        self.port = int(os.getenv("PORT", self.port))
        self.app_url = os.getenv("APP_URL", self.app_url)
        self.database_url = os.getenv("DATABASE_URL", "")
        self.jwt_secret = os.getenv("JWT_SECRET", "")
        self.redis_url = os.getenv("REDIS_URL", "")
        self.log_level = os.getenv("LOG_LEVEL", self.log_level)

        if not self.database_url:
            raise ValueError("DATABASE_URL is required")
        if len(self.jwt_secret) < 32:
            raise ValueError("JWT_SECRET must be at least 32 characters")

config = Config()
```

## Customization Guide
- **Remove unused services**: Delete sections for services you don't use (e.g., no Stripe if no payments)
- **Add project-specific vars**: Add your custom environment variables to the appropriate section
- **Multi-environment**: Create `.env.development`, `.env.staging`, `.env.production` for environment-specific values
- **Docker**: Map env vars in `docker-compose.yml` using `env_file: .env`
- **Validation**: Always validate at startup - fail fast if required variables are missing
- **Prefix convention**: Use `NEXT_PUBLIC_` for client-accessible vars in Next.js

## 2026 Trend Notes
- Zod validation of environment variables at startup catches misconfig early
- Feature flags in env vars enable trunk-based development with gradual rollout
- Separate `.env.example` (committed) from `.env` (gitignored) is the universal pattern
- `NEXT_PUBLIC_` prefix convention prevents accidental secret exposure in browser bundles
- Comments in .env.example serve as documentation for team members

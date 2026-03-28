# Database Migration Guide
> Database migration guide: schema versioning, rollback strategies, and zero-downtime migrations
> 데이터베이스 마이그레이션 가이드: 스키마 버전 관리, 롤백 전략, 무중단 마이그레이션

**Category**: Refactoring | **Tags**: database, migration, schema, rollback, zero-downtime | **Difficulty**: Advanced

## Preview
```
Migration Workflow:
1. Write migration (up + down)
2. Review SQL diff
3. Test on staging
4. Apply to production (zero-downtime)
5. Verify and monitor
```

## Quick Start
```bash
# Choose your migration tool:

# Python (Alembic)
pip install alembic
alembic init migrations
alembic revision --autogenerate -m "add users table"
alembic upgrade head

# Node.js (Drizzle)
npx drizzle-kit generate
npx drizzle-kit migrate

# Node.js (Knex)
npx knex migrate:make add_users_table
npx knex migrate:latest

# Go (golang-migrate)
migrate create -ext sql -dir migrations add_users_table
migrate -path migrations -database $DATABASE_URL up
```

## Migration Fundamentals

### Migration File Structure

```
migrations/
├── 001_create_users.sql          # or .py, .ts, .js
├── 002_add_email_index.sql
├── 003_create_orders.sql
├── 004_add_user_preferences.sql
└── 005_rename_email_to_login.sql
```

### Every Migration Has Up + Down

```sql
-- migrations/001_create_users.sql

-- UP: Apply this migration
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'viewer',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- DOWN: Rollback this migration
DROP TABLE IF EXISTS users;
```

```sql
-- migrations/002_add_user_preferences.sql

-- UP
ALTER TABLE users ADD COLUMN preferences JSONB DEFAULT '{}';
ALTER TABLE users ADD COLUMN last_login_at TIMESTAMPTZ;

-- DOWN
ALTER TABLE users DROP COLUMN IF EXISTS preferences;
ALTER TABLE users DROP COLUMN IF EXISTS last_login_at;
```

## Zero-Downtime Migration Patterns

### Pattern 1: Add Column (Safe)

Adding a nullable column is always safe (no lock, no rewrite).

```sql
-- SAFE: Add nullable column
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- SAFE: Add column with default (PostgreSQL 11+ doesn't rewrite table)
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT true;
```

### Pattern 2: Rename Column (3-Step Deploy)

Renaming a column requires a multi-step approach to avoid downtime.

```sql
-- Step 1 (Deploy 1): Add new column, copy data
ALTER TABLE users ADD COLUMN login_email VARCHAR(255);
UPDATE users SET login_email = email;
CREATE INDEX idx_users_login_email ON users(login_email);

-- Step 2 (Deploy 2): Update application to use both columns
-- Write to BOTH old and new columns
-- Read from NEW column

-- Step 3 (Deploy 3): Drop old column after all code uses new column
ALTER TABLE users DROP COLUMN email;
ALTER TABLE users RENAME COLUMN login_email TO email;
```

### Pattern 3: Add NOT NULL Constraint (3-Step)

```sql
-- Step 1: Add column as nullable with default
ALTER TABLE users ADD COLUMN department VARCHAR(100) DEFAULT 'general';

-- Step 2: Backfill existing rows (in batches to avoid long locks)
UPDATE users SET department = 'general'
WHERE department IS NULL
LIMIT 1000;  -- Repeat until all rows updated

-- Step 3: Add NOT NULL constraint after all rows have values
ALTER TABLE users ALTER COLUMN department SET NOT NULL;
```

### Pattern 4: Create Index Concurrently

```sql
-- UNSAFE (locks table during build):
CREATE INDEX idx_users_name ON users(name);

-- SAFE (doesn't lock reads or writes):
CREATE INDEX CONCURRENTLY idx_users_name ON users(name);

-- Note: CONCURRENTLY cannot run inside a transaction
```

### Pattern 5: Large Table Changes (Expand/Contract)

For large tables (1M+ rows), use the expand-contract pattern:

```
Phase 1 (Expand):
  - Add new column/table
  - Dual-write: old AND new
  - Backfill old data to new structure

Phase 2 (Contract):
  - Switch reads to new structure
  - Stop writing to old structure
  - Drop old column/table
```

## Rollback Strategies

### Automatic Rollback Script

```bash
#!/bin/bash
# rollback.sh - Rollback last migration

set -e

echo "Rolling back last migration..."

# Alembic (Python)
alembic downgrade -1

# Knex (Node.js)
# npx knex migrate:rollback

# golang-migrate
# migrate -path migrations -database $DATABASE_URL down 1

echo "Rollback complete. Verify data integrity:"
echo "  psql -c 'SELECT count(*) FROM users;'"
```

### Pre-Migration Checklist

```markdown
## Before Running Migration

- [ ] Migration tested on staging with production-like data
- [ ] DOWN migration tested (actually rolled back and verified)
- [ ] Backup taken: `pg_dump -Fc myapp > backup_$(date +%Y%m%d).dump`
- [ ] Application code compatible with both old and new schema
- [ ] No long-running transactions that could block migration
- [ ] Monitoring dashboards open (error rate, latency, DB metrics)
- [ ] Team notified in Slack/Discord
- [ ] Rollback plan documented and ready
```

### Recovery Commands

```bash
# PostgreSQL backup before migration
pg_dump -Fc -h localhost -U postgres myapp > backup_20260328.dump

# Restore from backup (nuclear option)
pg_restore -h localhost -U postgres -d myapp --clean backup_20260328.dump

# Check migration status
alembic current              # Current revision
alembic history              # All revisions
alembic heads                # Latest revision

# Rollback last N migrations
alembic downgrade -1         # Rollback 1
alembic downgrade -3         # Rollback 3
alembic downgrade base       # Rollback ALL (dangerous!)
```

## Migration Rules

| Rule | Description |
|------|-------------|
| **Always reversible** | Every UP has a DOWN. Test both directions. |
| **One change per migration** | Don't mix table creation with data transformation. |
| **Forward-only in production** | Never edit an applied migration. Create a new one. |
| **Idempotent** | Use `IF NOT EXISTS` / `IF EXISTS` to handle re-runs. |
| **No data loss** | Never DROP a column with data until verified unnecessary. |
| **Batch large updates** | Update 1,000 rows at a time, not millions at once. |
| **Test with production data** | Staging should mirror production volume. |
| **Lock monitoring** | Watch for long-running locks during migration. |

## Common Mistakes

| Mistake | Consequence | Prevention |
|---------|-------------|------------|
| Adding NOT NULL without default | Table locked during rewrite | Add as nullable first, then set NOT NULL |
| Dropping column before code change | Application errors | Remove code references first, then drop column |
| Running migration during peak traffic | Timeouts, locks | Schedule during low-traffic window |
| No backup before migration | Data loss on failure | Always `pg_dump` before risky migrations |
| Editing applied migration | Schema drift between environments | Create new migration instead |
| Large UPDATE without batching | Transaction log bloat, locks | Batch in 1,000-row chunks |

## Tool-Specific Examples

### Alembic (Python/SQLAlchemy)

```python
# migrations/versions/001_create_users.py
from alembic import op
import sqlalchemy as sa

def upgrade():
    op.create_table(
        'users',
        sa.Column('id', sa.UUID(), primary_key=True, server_default=sa.text('gen_random_uuid()')),
        sa.Column('email', sa.String(255), nullable=False, unique=True),
        sa.Column('name', sa.String(255), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.func.now()),
    )
    op.create_index('idx_users_email', 'users', ['email'])

def downgrade():
    op.drop_table('users')
```

### Drizzle (TypeScript)

```typescript
// drizzle/schema.ts
import { pgTable, uuid, varchar, timestamp } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: varchar('email', { length: 255 }).notNull().unique(),
  name: varchar('name', { length: 255 }).notNull(),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
});

// Generate migration: npx drizzle-kit generate
// Apply migration: npx drizzle-kit migrate
```

## Customization Guide
- **ORM**: Replace examples with your ORM (Django, TypeORM, Prisma, GORM)
- **Database**: Adjust SQL syntax for MySQL, SQLite, or MongoDB
- **CI integration**: Add migration check to CI (`alembic check` or `drizzle-kit check`)
- **Approval process**: Require DBA review for migrations touching large tables
- **Monitoring**: Add alerting for migration duration exceeding threshold

## 2026 Trend Notes
- Schema-as-code (Drizzle, Prisma) auto-generates migrations from type definitions
- Blue-green database deployments enable zero-downtime schema changes
- PostgreSQL 16+ handles ADD COLUMN with DEFAULT without table rewrite
- Feature flags control which schema version the application uses during transition
- Online DDL tools (gh-ost, pt-online-schema-change) for MySQL large table migrations

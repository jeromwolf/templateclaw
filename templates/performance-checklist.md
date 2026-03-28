# Performance Optimization Checklist
> Performance checklist covering frontend, backend, database, caching, and infrastructure
> 프론트엔드, 백엔드, 데이터베이스, 캐싱, 인프라를 다루는 성능 최적화 체크리스트

**Category**: Refactoring | **Tags**: performance, optimization, caching, database, frontend | **Difficulty**: Advanced

## Preview
```
Performance Audit:
[x] Frontend: Images optimized, JS split
[x] Backend: N+1 eliminated, async I/O
[x] Database: Indexes added, queries analyzed
[x] Caching: Redis layer, HTTP headers set
[x] Infra: CDN, compression, edge deploy
```

## Quick Start
```bash
# 1. Use this checklist during performance audits
# 2. Check items relevant to your stack
# 3. Prioritize items by impact (marked with impact level)
# Measure first, optimize second - always benchmark before and after
```

## Full Checklist

### Frontend Performance

```markdown
## Frontend (Browser)

### Critical Rendering Path
- [ ] **[HIGH]** Bundle size analyzed (webpack-bundle-analyzer / vite-plugin-visualizer)
- [ ] **[HIGH]** Code splitting: route-based lazy loading (`React.lazy`, dynamic `import()`)
- [ ] **[HIGH]** Tree shaking enabled (ES modules, sideEffects: false in package.json)
- [ ] **[MEDIUM]** Critical CSS inlined, non-critical CSS deferred
- [ ] **[MEDIUM]** Font loading optimized (`font-display: swap`, preloaded, subset)
- [ ] **[LOW]** Third-party scripts loaded async or deferred

### Images & Media
- [ ] **[HIGH]** Images in modern format (WebP/AVIF with fallback)
- [ ] **[HIGH]** Responsive images (`srcset`, `sizes` attributes or Next/Image)
- [ ] **[HIGH]** Lazy loading for below-fold images (`loading="lazy"`)
- [ ] **[MEDIUM]** Image dimensions specified (prevents layout shift, CLS)
- [ ] **[MEDIUM]** SVG used for icons (not PNG icon sprites)
- [ ] **[LOW]** Video: poster image set, not auto-playing on mobile

### JavaScript
- [ ] **[HIGH]** No blocking JavaScript in `<head>` (use `defer` or `async`)
- [ ] **[HIGH]** Heavy computations moved to Web Workers
- [ ] **[MEDIUM]** Debounce/throttle on scroll, resize, and input handlers
- [ ] **[MEDIUM]** Virtual scrolling for long lists (>100 items)
- [ ] **[MEDIUM]** No memory leaks (event listeners cleaned up, intervals cleared)
- [ ] **[LOW]** `requestAnimationFrame` used for animations (not setInterval)

### Core Web Vitals Targets
| Metric | Target | Measures |
|--------|--------|----------|
| LCP (Largest Contentful Paint) | < 2.5s | Loading speed |
| FID (First Input Delay) | < 100ms | Interactivity |
| CLS (Cumulative Layout Shift) | < 0.1 | Visual stability |
| TTFB (Time to First Byte) | < 800ms | Server response |
```

### Backend Performance

```markdown
## Backend (Server)

### API Response Time
- [ ] **[HIGH]** Response time p95 < 200ms for simple reads, < 1s for complex
- [ ] **[HIGH]** N+1 queries eliminated (use eager loading, DataLoader pattern)
- [ ] **[HIGH]** Async I/O for all external calls (DB, HTTP, file system)
- [ ] **[MEDIUM]** Connection pooling for database (pool size = CPU cores * 2 + 1)
- [ ] **[MEDIUM]** Response compression (gzip/brotli) enabled at proxy level
- [ ] **[MEDIUM]** Pagination on all list endpoints (max 100 items per page)

### Concurrency
- [ ] **[HIGH]** No blocking operations in async handlers
- [ ] **[MEDIUM]** Worker processes = CPU cores (uvicorn, gunicorn, PM2)
- [ ] **[MEDIUM]** Background jobs for heavy processing (Celery, BullMQ, Temporal)
- [ ] **[LOW]** Rate limiting per client to prevent abuse

### Data Serialization
- [ ] **[MEDIUM]** Only return needed fields (no `SELECT *` to API response)
- [ ] **[MEDIUM]** JSON serialization optimized (orjson for Python, fast-json-stringify for Node)
- [ ] **[LOW]** Consider Protocol Buffers for internal service communication
```

### Database Performance

```markdown
## Database

### Indexing
- [ ] **[HIGH]** Indexes on all columns used in WHERE clauses
- [ ] **[HIGH]** Indexes on all columns used in JOIN conditions
- [ ] **[HIGH]** Composite indexes for multi-column queries (order matters)
- [ ] **[MEDIUM]** Partial indexes for filtered queries (e.g., active users only)
- [ ] **[LOW]** Unused indexes removed (they slow down writes)

### Query Optimization
- [ ] **[HIGH]** Slow queries identified (`pg_stat_statements`, slow query log)
- [ ] **[HIGH]** EXPLAIN ANALYZE run on all complex queries
- [ ] **[MEDIUM]** Batch inserts/updates instead of row-by-row loops
- [ ] **[MEDIUM]** COUNT queries avoided on large tables (use estimates or cache)
- [ ] **[MEDIUM]** Subqueries replaced with JOINs where beneficial

### Schema Design
- [ ] **[HIGH]** Proper data types (don't store numbers as strings)
- [ ] **[MEDIUM]** Denormalization where read performance is critical
- [ ] **[MEDIUM]** Archive old data to separate tables/partitions
- [ ] **[LOW]** UUID v7 used for sortable primary keys (not UUID v4)

### Connection Management
- [ ] **[HIGH]** Connection pooling (PgBouncer, built-in ORM pooling)
- [ ] **[MEDIUM]** Read replicas for read-heavy workloads
- [ ] **[LOW]** Statement-level connection pooling for high concurrency
```

### Caching Strategy

```markdown
## Caching

### Application Cache
- [ ] **[HIGH]** Hot data cached in Redis/Memcached (user sessions, config)
- [ ] **[HIGH]** Cache invalidation strategy defined (TTL, event-based, or both)
- [ ] **[MEDIUM]** Cache-aside pattern implemented (check cache -> miss -> query DB -> set cache)
- [ ] **[MEDIUM]** Cache stampede prevention (locking, probabilistic early expiration)
- [ ] **[LOW]** Multi-level cache (in-memory L1 -> Redis L2 -> DB)

### HTTP Caching
- [ ] **[HIGH]** Static assets: `Cache-Control: public, max-age=31536000, immutable`
- [ ] **[HIGH]** API responses: `Cache-Control` headers set appropriately
- [ ] **[MEDIUM]** ETag/Last-Modified for conditional requests (304 Not Modified)
- [ ] **[MEDIUM]** CDN configured for static assets and cacheable API responses
- [ ] **[LOW]** `stale-while-revalidate` for non-critical data freshness

### Cache TTL Guidelines
| Data Type | TTL | Strategy |
|-----------|-----|----------|
| Static assets (JS, CSS, images) | 1 year | Immutable, bust via filename hash |
| User session | 24 hours | Refresh on activity |
| API config/settings | 5 minutes | TTL + event invalidation |
| Search results | 1-5 minutes | TTL only |
| User profile | 5 minutes | Invalidate on update |
| Dashboard metrics | 30 seconds | Short TTL, background refresh |
```

### Infrastructure

```markdown
## Infrastructure

### CDN & Edge
- [ ] **[HIGH]** CDN for static assets (CloudFront, Cloudflare, Vercel Edge)
- [ ] **[HIGH]** Brotli/gzip compression at CDN level
- [ ] **[MEDIUM]** Edge functions for geo-specific logic (redirects, A/B tests)
- [ ] **[LOW]** Image CDN with auto-format and resize (Cloudinary, imgix)

### Monitoring
- [ ] **[HIGH]** APM tool installed (Datadog, New Relic, or open-source alternatives)
- [ ] **[HIGH]** Alerting on p95 latency spikes and error rate increases
- [ ] **[MEDIUM]** Real User Monitoring (RUM) for frontend performance
- [ ] **[MEDIUM]** Database query performance tracked (slow query alerts)
- [ ] **[LOW]** Synthetic monitoring for critical user flows
```

## Measurement Tools

| Category | Tool | Purpose |
|----------|------|---------|
| Frontend | Lighthouse | Overall web performance score |
| Frontend | WebPageTest | Detailed waterfall analysis |
| Frontend | Chrome DevTools Performance | Runtime performance profiling |
| Backend | `wrk` or `k6` | HTTP load testing |
| Database | `EXPLAIN ANALYZE` | Query execution plan |
| Database | `pg_stat_statements` | Slow query identification |
| Caching | `redis-cli INFO` | Cache hit rate monitoring |
| Full stack | Datadog / Grafana | End-to-end APM |

## Customization Guide
- **Stack-specific**: Remove sections not relevant to your stack (no frontend for API-only projects)
- **Priority order**: Address HIGH items first - they typically yield the biggest improvements
- **Baseline first**: Always measure current performance before optimizing
- **One change at a time**: Measure impact of each optimization individually
- **Regression prevention**: Add performance budgets to CI (Lighthouse CI, bundle size limits)

## 2026 Trend Notes
- Core Web Vitals directly impact SEO rankings (Google)
- Edge computing (Vercel Edge, Cloudflare Workers) reduces latency globally
- UUID v7 (time-sortable) is replacing UUID v4 for better index performance
- Brotli compression offers 15-20% better compression than gzip
- Streaming SSR (React Server Components) reduces TTFB for dynamic pages

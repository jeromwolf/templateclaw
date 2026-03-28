# Docker Compose Template
> Docker Compose setup with web app, PostgreSQL, Redis, and Nginx reverse proxy with health checks
> 웹앱, PostgreSQL, Redis, Nginx 리버스 프록시 + 헬스 체크가 포함된 Docker Compose 설정

**Category**: Project Setup | **Tags**: docker, compose, postgresql, redis, nginx, devops | **Difficulty**: Intermediate

## Preview
```
                    :80/:443
                       |
                    [Nginx]
                       |
                    [Web App] :3000
                    /       \
              [PostgreSQL]  [Redis]
                :5432        :6379
```

## Quick Start
```bash
# 1. Copy docker-compose.yml and related configs to your project root
# 2. Create .env file with required variables
# 3. Run:
docker compose up -d
docker compose logs -f web
# 4. Access: http://localhost (via Nginx) or http://localhost:3000 (direct)
```

## Full Code

### docker-compose.yml

```yaml
# docker-compose.yml
version: "3.9"

services:
  # ============================================
  # Web Application
  # ============================================
  web:
    build:
      context: .
      dockerfile: Dockerfile
      target: production
    container_name: app-web
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
      PORT: 3000
      DATABASE_URL: postgresql://${DB_USER:-postgres}:${DB_PASSWORD:-postgres}@db:5432/${DB_NAME:-myapp}
      REDIS_URL: redis://redis:6379
    env_file:
      - .env
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    networks:
      - app-network
    deploy:
      resources:
        limits:
          cpus: "1.0"
          memory: 512M

  # ============================================
  # PostgreSQL Database
  # ============================================
  db:
    image: postgres:16-alpine
    container_name: app-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: ${DB_USER:-postgres}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-postgres}
      POSTGRES_DB: ${DB_NAME:-myapp}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-postgres} -d ${DB_NAME:-myapp}"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network
    deploy:
      resources:
        limits:
          cpus: "0.5"
          memory: 256M

  # ============================================
  # Redis Cache
  # ============================================
  redis:
    image: redis:7-alpine
    container_name: app-redis
    restart: unless-stopped
    command: redis-server --appendonly yes --maxmemory 128mb --maxmemory-policy allkeys-lru
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network
    deploy:
      resources:
        limits:
          cpus: "0.25"
          memory: 128M

  # ============================================
  # Nginx Reverse Proxy
  # ============================================
  nginx:
    image: nginx:alpine
    container_name: app-nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/certs:/etc/nginx/certs:ro
    depends_on:
      web:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 5s
      retries: 3
    networks:
      - app-network

volumes:
  postgres_data:
    driver: local
  redis_data:
    driver: local

networks:
  app-network:
    driver: bridge
```

### Dockerfile (Multi-stage)

```dockerfile
# Dockerfile
# Stage 1: Dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --production=false

# Stage 2: Build
FROM node:20-alpine AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Stage 3: Production
FROM node:20-alpine AS production
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 appuser

COPY --from=build --chown=appuser:nodejs /app/.next/standalone ./
COPY --from=build --chown=appuser:nodejs /app/.next/static ./.next/static
COPY --from=build --chown=appuser:nodejs /app/public ./public

USER appuser
EXPOSE 3000
ENV HOSTNAME=0.0.0.0
CMD ["node", "server.js"]
```

### Python Dockerfile Alternative

```dockerfile
# Dockerfile (Python/FastAPI)
FROM python:3.12-slim AS base

WORKDIR /app
RUN adduser --system --uid 1001 appuser

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ src/

USER appuser
EXPOSE 8000
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
```

### Nginx Configuration

```nginx
# nginx/nginx.conf
events {
    worker_connections 1024;
}

http {
    upstream app {
        server web:3000;
    }

    # Rate limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=30r/s;

    # Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml;
    gzip_min_length 1000;

    server {
        listen 80;
        server_name _;

        # Health check endpoint (for Docker)
        location /health {
            access_log off;
            return 200 "ok";
        }

        # Proxy to app
        location / {
            limit_req zone=api burst=50 nodelay;
            proxy_pass http://app;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_read_timeout 86400;
        }

        # Static files caching
        location /_next/static {
            proxy_pass http://app;
            expires 365d;
            add_header Cache-Control "public, immutable";
        }
    }
}
```

### Database Init Script

```sql
-- init.sql (runs on first container creation)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Create application schema
-- (Your migration tool should handle actual tables)
```

### Useful Commands

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f web
docker compose logs -f db

# Restart a single service
docker compose restart web

# Run database migrations
docker compose exec web npm run db:migrate

# Access PostgreSQL CLI
docker compose exec db psql -U postgres -d myapp

# Access Redis CLI
docker compose exec redis redis-cli

# Full cleanup (removes volumes too)
docker compose down -v

# Rebuild after code changes
docker compose build web && docker compose up -d web
```

## Customization Guide
- **Ports**: Change exposed ports if 80/3000/5432/6379 conflict with local services
- **Database**: Replace PostgreSQL with MySQL (`image: mysql:8`) or MongoDB (`image: mongo:7`)
- **Cache**: Replace Redis with Memcached or remove if not needed
- **SSL**: Add Let's Encrypt with certbot sidecar for HTTPS
- **Scaling**: Use `docker compose up -d --scale web=3` for multiple app instances
- **Monitoring**: Add Prometheus + Grafana services for observability
- **CI**: Use the same `docker-compose.yml` in GitHub Actions for integration tests

## 2026 Trend Notes
- Health checks with `condition: service_healthy` ensure proper startup ordering
- Multi-stage Docker builds reduce image size by 60-80%
- Alpine-based images are standard for smaller footprint
- Resource limits (`deploy.resources.limits`) prevent container resource abuse
- Non-root user (`USER appuser`) is a security best practice
- Redis `maxmemory-policy: allkeys-lru` prevents OOM in containers

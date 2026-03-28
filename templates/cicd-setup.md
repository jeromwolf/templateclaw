# CI/CD Pipeline Setup
> CI/CD pipeline with GitHub Actions: lint, test, build, deploy stages with secrets management
> GitHub Actions CI/CD 파이프라인: 린트, 테스트, 빌드, 배포 단계 + 시크릿 관리

**Category**: Dev Methodology | **Tags**: cicd, github-actions, deployment, automation, devops | **Difficulty**: Intermediate

## Preview
```
Push/PR -> Lint -> Test -> Build -> Deploy
  |         |       |       |         |
  |       ESLint  pytest   Docker   Vercel/
  |       Black   Jest     Image    AWS/GCP
  |
  +-> On PR: test only
  +-> On main: test + deploy
```

## Quick Start
```bash
# 1. Create .github/workflows/ directory in your repo
# 2. Copy the YAML file below
# 3. Configure secrets in GitHub: Settings > Secrets > Actions
# 4. Push to main or open a PR to trigger the pipeline
```

## Full Code

### GitHub Actions - Full Pipeline

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

env:
  PYTHON_VERSION: "3.12"
  NODE_VERSION: "20"

jobs:
  # ============================================
  # Stage 1: Lint & Format Check
  # ============================================
  lint:
    name: Lint & Format
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ env.PYTHON_VERSION }}
          cache: pip

      - name: Install linters
        run: pip install ruff black mypy

      - name: Run Ruff (lint)
        run: ruff check . --output-format=github

      - name: Run Black (format check)
        run: black --check --diff .

      - name: Run MyPy (type check)
        run: mypy src/ --ignore-missing-imports
        continue-on-error: true  # Optional: make strict later

  # ============================================
  # Stage 2: Test
  # ============================================
  test:
    name: Test (Python ${{ matrix.python-version }})
    runs-on: ubuntu-latest
    needs: lint
    strategy:
      matrix:
        python-version: ["3.11", "3.12"]
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: testdb
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
          cache: pip

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install pytest pytest-cov pytest-asyncio

      - name: Run tests with coverage
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/testdb
        run: |
          pytest tests/ -v \
            --cov=src \
            --cov-report=xml \
            --cov-report=term-missing \
            --cov-fail-under=80

      - name: Upload coverage
        if: matrix.python-version == '3.12'
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          file: coverage.xml

  # ============================================
  # Stage 3: Build
  # ============================================
  build:
    name: Build Docker Image
    runs-on: ubuntu-latest
    needs: test
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    permissions:
      packages: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            ghcr.io/${{ github.repository }}:latest
            ghcr.io/${{ github.repository }}:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # ============================================
  # Stage 4: Deploy
  # ============================================
  deploy:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: build
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    environment:
      name: production
      url: https://your-app.example.com

    steps:
      - uses: actions/checkout@v4

      # Option A: Deploy to Vercel
      - name: Deploy to Vercel
        if: false  # Enable by changing to true
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: --prod

      # Option B: Deploy to AWS via SSH
      - name: Deploy to server
        uses: appleboy/ssh-action@v1
        with:
          host: ${{ secrets.DEPLOY_HOST }}
          username: ${{ secrets.DEPLOY_USER }}
          key: ${{ secrets.DEPLOY_SSH_KEY }}
          script: |
            cd /opt/app
            docker pull ghcr.io/${{ github.repository }}:latest
            docker compose up -d --force-recreate
            docker system prune -f

  # ============================================
  # Stage 5: Post-Deploy Health Check
  # ============================================
  healthcheck:
    name: Post-Deploy Health Check
    runs-on: ubuntu-latest
    needs: deploy
    steps:
      - name: Wait for deployment
        run: sleep 30

      - name: Check health endpoint
        run: |
          STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://your-app.example.com/health)
          if [ "$STATUS" != "200" ]; then
            echo "Health check failed with status $STATUS"
            exit 1
          fi
          echo "Health check passed (HTTP $STATUS)"
```

### Secrets Configuration

```bash
# Required GitHub Secrets (Settings > Secrets > Actions):

# For testing
CODECOV_TOKEN          # Codecov upload token

# For Docker registry (auto-provided)
# GITHUB_TOKEN         # Built-in, no setup needed

# For deployment (choose one):
# Vercel
VERCEL_TOKEN           # Vercel API token
VERCEL_ORG_ID          # Vercel organization ID
VERCEL_PROJECT_ID      # Vercel project ID

# SSH Deploy
DEPLOY_HOST            # Server IP/hostname
DEPLOY_USER            # SSH username
DEPLOY_SSH_KEY         # SSH private key (ed25519)
```

### Companion Dockerfile

```dockerfile
# Dockerfile
FROM python:3.12-slim AS base

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ src/
COPY config/ config/

EXPOSE 8000
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Customization Guide
- **Language**: Replace Python steps with Node.js (`npm ci`, `npm test`), Go (`go test ./...`), or Rust (`cargo test`)
- **Database**: Change PostgreSQL service to MySQL, Redis, or MongoDB
- **Deploy target**: Enable Vercel, AWS, GCP, or Railway deploy step
- **Branch strategy**: Add staging environment for `develop` branch
- **Notifications**: Add Slack/Discord webhook step on failure
- **Caching**: The `cache: pip` and Docker `cache-from: type=gha` speed up builds significantly

## 2026 Trend Notes
- `concurrency` with `cancel-in-progress` prevents wasted CI minutes on rapid pushes
- Docker BuildKit cache via GitHub Actions cache (`type=gha`) is now standard
- GitHub Container Registry (ghcr.io) eliminates need for Docker Hub
- Health check after deploy catches deployment failures before users see them
- Multi-Python version matrix ensures compatibility across versions

---
description: Create optimized Docker configurations with multi-stage builds and security hardening
argument-hint: [application tech stack and deployment target]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "deployment"
last_updated: "2025-09-08"

Create optimized Docker configuration for: $ARGUMENTS

Docker optimization strategy:
1. **Multi-Stage Build Optimization**: Minimize production image size
   - Use appropriate base images (Alpine, distroless, scratch)
   - Implement multi-stage builds for dependency separation
   - Optimize layer caching for faster builds
   - Remove unnecessary files and dependencies
   - Use specific version tags for reproducible builds

2. **Node.js Application Optimization**:

```dockerfile
# Build stage
FROM node:18-alpine AS builder

# Install dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Build application
COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine AS production
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

WORKDIR /app
COPY --from=builder --chown=nextjs:nodejs /app/dist ./
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./package.json

USER nextjs
EXPOSE 3000
ENV NODE_ENV=production

CMD ["npm", "start"]
```

3. **Python Application Optimization**:

```dockerfile
# Build stage
FROM python:3.11-slim AS builder

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.11-slim AS production

# Create non-root user
RUN useradd --create-home --shell /bin/bash app
USER app
WORKDIR /home/app

# Copy dependencies and application
COPY --from=builder --chown=app:app /root/.local /home/app/.local
COPY --chown=app:app . .

# Update PATH
ENV PATH=/home/app/.local/bin:$PATH

EXPOSE 8000
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

4. **Security Hardening**: Implement security best practices
- Use non-root users for application execution
- Scan images for vulnerabilities with Trivy or Snyk
- Remove shell access and unnecessary tools
- Use distroless or minimal base images
- Set up proper file permissions and ownership
- Configure security context and capabilities

5. **Performance Optimization**: Optimize runtime performance
- Configure appropriate resource limits and requests
- Implement health checks for container orchestration
- Use init systems for proper signal handling
- Configure logging and monitoring
- Optimize startup time and resource usage

6. **Development vs Production**: Environment-specific configurations
- Development Dockerfile with hot reloading
- Production Dockerfile with optimized builds
- Docker Compose for development environments
- Environment variable management
- Volume mounting strategies

Docker Compose configuration:

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.prod
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=${DATABASE_URL}
    depends_on:
      - db
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: postgres:15-alpine
    environment:
      - POSTGRES_DB=${POSTGRES_DB}
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
```

Build optimization techniques:
- Use .dockerignore to exclude unnecessary files
- Leverage BuildKit for advanced caching
- Implement multi-platform builds for different architectures
- Use cache mounts for package managers
- Optimize layer ordering for cache efficiency

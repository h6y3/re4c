---
description: Deploy full stack application to Railway with database and monitoring setup
argument-hint: [application stack and requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "deployment"
last_updated: "2025-09-08"

Deploy full stack application to Railway: $ARGUMENTS

Railway deployment configuration:
1. **Service Configuration**: Set up Railway services
   - Configure web service for frontend/API
   - Set up database service (PostgreSQL, MySQL, Redis)
   - Configure background worker services if needed
   - Set up monitoring and logging services
   - Configure service networking and communication

2. **Database Setup**: Configure managed database
   - Create PostgreSQL or MySQL database instance
   - Configure connection pooling for optimal performance
   - Set up database migrations and seeding
   - Configure backup and restore procedures
   - Set up database monitoring and alerting
   - Configure read replicas for scaling

3. **Environment Management**: Configure environment variables
   - Set up production environment variables
   - Configure database connection strings
   - Set up API keys and external service credentials
   - Configure logging and monitoring tokens
   - Set up feature flags and configuration

4. **Build and Deployment**: Optimize build process
   - Configure Dockerfile for optimal builds
   - Set up multi-stage builds for smaller images
   - Configure build caching for faster deployments
   - Set up automatic deployments from Git
   - Configure deployment triggers and conditions

5. **Networking and Domains**: Configure public access
   - Set up custom domain with SSL certificates
   - Configure load balancing and traffic routing
   - Set up CDN integration for static assets
   - Configure rate limiting and DDoS protection
   - Set up health checks and monitoring endpoints

6. **Scaling and Performance**: Configure autoscaling
   - Set up horizontal pod autoscaling
   - Configure CPU and memory limits
   - Set up database connection pooling
   - Configure caching strategies (Redis)
   - Set up performance monitoring and alerting

Railway configuration files:
1. `railway.json` configuration:

```json
{
  "build": {
    "builder": "DOCKERFILE",
    "buildCommand": "npm run build"
  },
  "deploy": {
    "startCommand": "npm start",
    "healthcheckPath": "/health",
    "restartPolicyType": "ON_FAILURE"
  }
}
```

2. `Dockerfile` for production:

```dockerfile
FROM node:18-alpine AS base

# Install dependencies
FROM base AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Build application
FROM base AS builder
WORKDIR /app
COPY . .
RUN npm ci && npm run build

# Production image
FROM base AS runner
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY package*.json ./

EXPOSE 3000
CMD ["npm", "start"]
```

3. Database migration scripts
4. Environment variable templates
5. Health check endpoints
6. Monitoring and logging configuration
7. Backup and restore procedures
8. Scaling policies and limits
9. Security configuration
10. Cost optimization settings

Deployment workflow:
- Connect Railway to GitHub repository
- Configure automatic deployments on main branch
- Set up preview deployments for pull requests
- Configure environment-specific variables
- Set up database and external service connections
- Configure monitoring and alerting
- Test deployment and rollback procedures

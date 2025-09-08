---
description: Optimize and deploy Next.js application to Vercel with performance optimization
argument-hint: [deployment environment and configuration]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "deployment"
last_updated: "2025-09-08"

Deploy to Vercel for: $ARGUMENTS

Deployment optimization:
1. **Build Optimization**: Prepare application for production
   - Run bundle analysis to identify optimization opportunities
   - Implement code splitting and lazy loading for optimal performance
   - Optimize images with Next.js Image component
   - Configure caching strategies for static assets
   - Minimize JavaScript bundle sizes
   - Implement service worker for offline capability

2. **Environment Configuration**: Set up environment variables
   - Configure production environment variables in Vercel dashboard
   - Set up database connection strings for production
   - Configure API keys and external service credentials
   - Set up monitoring and analytics tokens
   - Configure feature flags for gradual rollouts

3. **Domain and SSL Setup**: Configure custom domains
   - Set up custom domain with proper DNS configuration
   - Configure SSL certificates with automatic renewal
   - Set up subdomain routing for different environments
   - Configure CDN settings for global performance
   - Set up redirect rules for SEO and user experience

4. **Serverless Function Optimization**: Configure Edge functions
   - Optimize serverless functions for cold start performance
   - Configure function regions for global distribution
   - Set up function timeout and memory limits
   - Implement caching for frequently accessed data
   - Configure database connection pooling for serverless

5. **Preview Deployments**: Set up branch previews
   - Configure automatic preview deployments for feature branches
   - Set up preview environment variables
   - Configure preview domain patterns
   - Set up integration with GitHub for PR previews
   - Configure preview deployment notifications

6. **Monitoring and Analytics**: Production monitoring setup
   - Configure Vercel Analytics for performance monitoring
   - Set up Web Vitals tracking for Core Web Vitals
   - Configure error tracking with Sentry or similar
   - Set up uptime monitoring and alerting
   - Configure performance budgets and alerts

Vercel configuration files:
1. `vercel.json` configuration:

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "installCommand": "npm ci",
  "functions": {
    "app/api/**/*.ts": {
      "runtime": "nodejs18.x",
      "maxDuration": 30
    }
  },
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        }
      ]
    }
  ],
  "redirects": [
    {
      "source": "/old-page",
      "destination": "/new-page",
      "permanent": true
    }
  ]
}
```

2. Environment variable configuration
3. Build and deployment scripts
4. Performance monitoring setup
5. Error tracking integration
6. Backup and rollback procedures
7. Blue-green deployment strategy
8. Database migration coordination
9. Post-deployment validation scripts
10. Performance benchmarking automation

Deployment checklist:
- [ ] Bundle analysis completed and optimized
- [ ] Environment variables configured
- [ ] Database migrations applied
- [ ] SSL certificates configured
- [ ] CDN settings optimized
- [ ] Monitoring and alerting set up
- [ ] Performance budgets configured
- [ ] Rollback plan documented
- [ ] Team notification sent

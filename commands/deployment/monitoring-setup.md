---
description: Set up comprehensive monitoring and observability for production applications
argument-hint: [monitoring scope and requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "deployment"
last_updated: "2025-09-08"

Set up comprehensive monitoring for: $ARGUMENTS

Monitoring architecture:
1. **Application Performance Monitoring (APM)**:
   - Implement distributed tracing with Jaeger or Zipkin
   - Set up performance monitoring with New Relic or DataDog
   - Configure error tracking with Sentry
   - Monitor response times and throughput
   - Track database query performance
   - Monitor external API dependencies

2. **Infrastructure Monitoring**:
   - Set up system metrics with Prometheus and Grafana
   - Monitor CPU, memory, disk, and network usage
   - Track container and Kubernetes metrics
   - Monitor database performance and connections
   - Set up log aggregation with ELK Stack or Fluentd
   - Configure alerting with AlertManager

3. **User Analytics and Behavior Tracking**:
   - Implement user session recording with LogRocket or FullStory
   - Set up conversion funnel tracking
   - Monitor Core Web Vitals and user experience metrics
   - Track user journey and behavior patterns
   - Implement A/B testing and feature flag analytics

4. **Uptime and Health Monitoring**:
   - Set up uptime monitoring with Pingdom or StatusCake
   - Configure health check endpoints for all services
   - Monitor SSL certificate expiration
   - Set up synthetic transaction monitoring
   - Configure global monitoring from multiple locations

5. **Business Metrics Dashboard**:
   - Track key business KPIs and metrics
   - Monitor revenue and conversion rates
   - Set up custom alerts for business-critical events
   - Create executive dashboards for stakeholders
   - Implement real-time business intelligence

Monitoring implementation:
1. **Prometheus Configuration**:

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "alert_rules.yml"

scrape_configs:
  - job_name: 'nodejs-app'
    static_configs:
      - targets: ['localhost:3000']
    metrics_path: '/metrics'
    scrape_interval: 5s

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['localhost:9093']
```

2. **Grafana Dashboard Configuration**:
- Application performance dashboard
- Infrastructure metrics dashboard
- Business metrics dashboard
- Error rate and response time panels
- Database performance panels
- Custom alerting rules

3. **Sentry Error Tracking**:

```javascript
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 0.1,
  environment: process.env.NODE_ENV,
  beforeSend(event) {
    // Filter sensitive data
    if (event.user) {
      delete event.user.email;
    }
    return event;
  }
});
```

4. **Health Check Endpoints**:

```javascript
app.get('/health', async (req, res) => {
  const health = {
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    checks: {
      database: await checkDatabase(),
      redis: await checkRedis(),
      external_api: await checkExternalAPI()
    }
  };

  const isHealthy = Object.values(health.checks).every(check => check.status === 'ok');
  res.status(isHealthy ? 200 : 503).json(health);
});
```

5. **Log Configuration**:

```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: { service: 'my-app' },
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' }),
    new winston.transports.Console({
      format: winston.format.simple()
    })
  ]
});
```

Alert configuration:
- High error rate alerts (>5% for 5 minutes)
- Response time degradation (>2s for 95th percentile)
- Database connection issues
- Disk space warnings (>80% usage)
- Memory usage alerts (>85% for 10 minutes)
- SSL certificate expiration warnings (30 days)
- Custom business metric thresholds

Dashboard setup:
- Real-time application metrics
- Infrastructure resource utilization
- Error tracking and debugging info
- User experience and performance metrics
- Business KPI tracking

---
description: Universal CLAUDE.md - Production-Ready Development Standards
argument-hint: [args]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

# Universal CLAUDE.md - Production-Ready Development Standards

*Synthesized from 47+ production-tested development commands and best practices*

## Core Development Philosophy

### Production-First Mindset
- Every implementation must be production-ready, not a prototype
- Build for scale, security, and maintainability from day one
- Implement comprehensive error handling and graceful degradation
- Design for observability and debugging from the start

### Quality-Driven Development
- **Type Safety**: Use strong typing systems (TypeScript, type hints, generics)
- **Validation**: Comprehensive input validation and sanitization at all boundaries
- **Testing**: Multi-layer testing strategy (unit → integration → E2E)
- **Code Review**: Mandatory peer review with focus on security and maintainability

### Automation-First Approach
- **CI/CD**: Automated testing, security scanning, and deployment pipelines
- **Quality Gates**: Pre-commit hooks for formatting, linting, and security checks
- **Documentation**: Auto-generated API docs, type definitions, and architectural diagrams
- **Monitoring**: Automated alerting, performance monitoring, and error tracking

## Universal Architecture Principles

### System Design
1. **Separation of Concerns**: Clear boundaries between presentation, business logic, and data layers
2. **Domain-Driven Design**: Organize code around business domains, not technical layers
3. **Dependency Injection**: Use IoC containers and dependency injection patterns
4. **Event-Driven Architecture**: Decouple components using events and message passing
5. **API-First Design**: Design APIs before implementing, use OpenAPI specifications

### Scalability Patterns
1. **Stateless Design**: Services should be stateless to enable horizontal scaling
2. **Connection Pooling**: Efficient resource management for databases and external services
3. **Caching Strategy**: Multi-level caching (CDN, application, database) with proper invalidation
4. **Circuit Breaker**: Fail-fast patterns for external service dependencies
5. **Rate Limiting**: Protect APIs from abuse and ensure fair usage

### Data Architecture
1. **Schema Design**: Normalized schemas with proper indexing and constraints
2. **Data Validation**: Strong validation at database, API, and UI layers
3. **Audit Trails**: Track data changes for compliance and debugging
4. **Data Retention**: Clear policies for data lifecycle and privacy compliance
5. **Backup Strategy**: Automated backups with tested restore procedures

## Security-by-Design Standards

### Authentication & Authorization
```
Multi-Factor Authentication: Required for admin accounts, optional for users
Session Management: Secure token-based auth with refresh token rotation
Role-Based Access Control: Fine-grained permissions with principle of least privilege
API Security: Rate limiting, CORS policies, request validation
```

### Data Protection
```
Encryption at Rest: All sensitive data encrypted in database
Encryption in Transit: TLS 1.3 for all network communications
Input Sanitization: XSS, SQL injection, and CSRF protection
Security Headers: Comprehensive HTTP security headers configuration
```

### Vulnerability Management
```
Dependency Scanning: Automated vulnerability scanning in CI/CD
Security Audits: Regular penetration testing and code security reviews
Incident Response: Defined procedures for security incident handling
Compliance: GDPR, CCPA, and industry-specific compliance requirements
```

## Development Workflow Standards

### Git Workflow
```bash
# Branch Naming Convention
feature/[ticket-id]-brief-description
bugfix/[ticket-id]-brief-description
hotfix/[ticket-id]-brief-description

# Commit Message Format (Conventional Commits)
type(scope): brief description

body (optional): detailed description

footer (optional): breaking changes, references
```

### Code Quality Standards
```
Line Length: 100 characters maximum
Indentation: 2 spaces (JavaScript/TypeScript), 4 spaces (Python), language-specific
Naming: camelCase (JS/TS), snake_case (Python), PascalCase (classes/types)
Comments: JSDoc/docstrings for public APIs, inline for complex logic only
```

### Testing Strategy
```
Unit Tests: 80%+ coverage for business logic
Integration Tests: API endpoints, database operations, external integrations  
E2E Tests: Critical user journeys and workflows
Performance Tests: Load testing for scalability validation
Security Tests: Vulnerability scanning and penetration testing
```

## Language-Specific Best Practices

### TypeScript/JavaScript
```typescript
// Strict TypeScript configuration
{
  "strict": true,
  "exactOptionalPropertyTypes": true,
  "noUncheckedIndexedAccess": true,
  "noImplicitReturns": true
}

// Error handling
interface Result<T, E = Error> {
  success: boolean;
  data?: T;
  error?: E;
}

// API response patterns
interface APIResponse<T> {
  success: boolean;
  data?: T;
  error?: {
    code: string;
    message: string;
    details?: unknown;
  };
  meta?: {
    pagination?: PaginationMeta;
    requestId: string;
  };
}
```

### Python
```python
# Type hints and validation
from typing import Optional, List, Dict, Any
from pydantic import BaseModel, validator

class UserCreate(BaseModel):
    email: str
    password: str
    
    @validator('email')
    def validate_email(cls, v):
        # Email validation logic
        return v

# Error handling
from dataclasses import dataclass
from typing import Union

@dataclass
class Success:
    data: Any

@dataclass  
class Error:
    message: str
    code: str

Result = Union[Success, Error]
```

### Database (SQL)
```sql
-- Schema design principles
CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Proper indexing
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Row Level Security (PostgreSQL)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY users_own_data ON users 
    FOR ALL USING (auth.uid() = id);
```

## Performance Optimization Standards

### Frontend Performance
```
Code Splitting: Route-based and component-based splitting
Bundle Analysis: Regular bundle size monitoring and optimization
Image Optimization: WebP format, responsive images, lazy loading
Caching: Service workers, HTTP caching, CDN optimization
Core Web Vitals: LCP < 2.5s, FID < 100ms, CLS < 0.1
```

### Backend Performance
```
Database Optimization: Proper indexing, query optimization, connection pooling
API Optimization: Pagination, response compression, efficient serialization
Caching: Redis/Memcached for frequently accessed data
Monitoring: APM tools for performance bottleneck identification
Load Testing: Regular performance testing under realistic load
```

### Infrastructure Optimization
```
CDN: Global content distribution for static assets
Auto-scaling: Horizontal scaling based on metrics
Resource Monitoring: CPU, memory, disk, and network monitoring
Cost Optimization: Resource right-sizing and usage optimization
```

## Deployment & DevOps Standards

### CI/CD Pipeline
```yaml
# Essential pipeline stages
stages:
  - lint          # Code formatting and style checks
  - test          # Unit, integration, and E2E tests
  - security      # Vulnerability scanning and SAST
  - build         # Application build and optimization
  - deploy        # Deployment to staging/production
  - monitor       # Post-deployment monitoring and alerts
```

### Environment Management
```
Development: Local development with hot reloading
Testing: Automated testing environment with CI/CD
Staging: Production-like environment for final testing  
Production: Highly available, monitored production environment

Configuration: Environment variables for all configuration
Secrets: Encrypted secrets management (never in code)
Database: Separate databases per environment
```

### Monitoring & Observability
```
Logging: Structured logging with correlation IDs
Metrics: Business metrics, technical metrics, infrastructure metrics
Tracing: Distributed tracing for complex request flows
Alerting: Proactive alerting on SLA violations
Dashboards: Real-time visibility into system health
```

## Documentation Standards

### Code Documentation
```
README: Project overview, setup instructions, basic usage
API Documentation: OpenAPI/Swagger specs with examples
Architecture: System design, data flow, integration patterns
Runbooks: Deployment, monitoring, incident response procedures
```

### Process Documentation
```
Development Workflow: Git workflow, code review process, testing strategy
Security Procedures: Security policies, incident response, compliance
Operations: Deployment procedures, monitoring setup, troubleshooting
Team Knowledge: Decision records, lessons learned, best practices
```

## Error Handling & Resilience

### Error Handling Patterns
```typescript
// Structured error handling
class AppError extends Error {
  constructor(
    message: string,
    public code: string,
    public statusCode: number = 500,
    public isOperational: boolean = true
  ) {
    super(message);
    this.name = this.constructor.name;
  }
}

// Async error wrapper
async function withErrorHandling<T>(
  operation: () => Promise<T>
): Promise<Result<T>> {
  try {
    const data = await operation();
    return { success: true, data };
  } catch (error) {
    logger.error('Operation failed', { error: error.message });
    return { 
      success: false, 
      error: {
        message: error.message,
        code: error.code || 'UNKNOWN_ERROR'
      }
    };
  }
}
```

### Resilience Patterns
```typescript
// Circuit breaker implementation
class CircuitBreaker {
  private failures = 0;
  private lastFailureTime?: number;
  private state: 'closed' | 'open' | 'half-open' = 'closed';
  
  async execute<T>(operation: () => Promise<T>): Promise<T> {
    if (this.state === 'open') {
      if (Date.now() - this.lastFailureTime! > this.timeout) {
        this.state = 'half-open';
      } else {
        throw new Error('Circuit breaker is open');
      }
    }
    
    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }
}
```

## Team Collaboration Standards

### Code Review Process
```
Review Criteria:
- Functionality: Does the code meet requirements?
- Security: Are there any security vulnerabilities?
- Performance: Are there any performance issues?
- Maintainability: Is the code readable and maintainable?
- Testing: Are there adequate tests?

Review Timeline:
- Small changes (< 100 lines): 24 hours
- Medium changes (100-500 lines): 48 hours  
- Large changes (> 500 lines): 72 hours
```

### Knowledge Sharing
```
Documentation: Living documentation updated with code changes
Tech Talks: Regular presentations on new technologies and patterns
Code Reviews: Knowledge transfer through collaborative review
Pair Programming: Knowledge sharing through collaborative coding
Retrospectives: Regular reflection and process improvement
```

## Technology Stack Recommendations

### Frontend Stack
```
Framework: Next.js (React), Vue.js (Nuxt), or SvelteKit
Language: TypeScript with strict configuration
Styling: Tailwind CSS with design system components
State Management: Zustand, Redux Toolkit, or built-in state
Testing: Vitest/Jest + Testing Library + Playwright
```

### Backend Stack  
```
Runtime: Node.js (TypeScript), Python (FastAPI), or Go
Database: PostgreSQL with proper ORM (Prisma, SQLAlchemy, GORM)
Authentication: Supabase Auth, Auth0, or custom JWT implementation
API Design: RESTful APIs with OpenAPI documentation
Message Queue: Redis, AWS SQS, or RabbitMQ for async processing
```

### Infrastructure Stack
```
Deployment: Vercel, Netlify, AWS, or Google Cloud
Database: Managed PostgreSQL (Supabase, AWS RDS, Google Cloud SQL)
Monitoring: DataDog, New Relic, or Grafana + Prometheus
Error Tracking: Sentry, Bugsnag, or Rollbar
CI/CD: GitHub Actions, GitLab CI, or CircleCI
```

## Implementation Checklist

### Project Setup
- [ ] Initialize git repository with proper .gitignore
- [ ] Set up package management with lock files
- [ ] Configure TypeScript/language tooling with strict settings
- [ ] Set up linting and formatting (ESLint, Prettier, etc.)
- [ ] Configure pre-commit hooks for quality gates
- [ ] Set up testing framework and initial test structure
- [ ] Configure CI/CD pipeline with quality gates
- [ ] Set up monitoring and error tracking

### Security Setup
- [ ] Configure HTTPS/TLS for all environments
- [ ] Set up proper authentication and authorization
- [ ] Implement input validation and sanitization
- [ ] Configure security headers and CORS policies
- [ ] Set up vulnerability scanning in CI/CD
- [ ] Implement audit logging for sensitive operations
- [ ] Configure secrets management
- [ ] Set up backup and disaster recovery procedures

### Performance Setup  
- [ ] Configure caching at multiple layers
- [ ] Set up database indexing and query optimization
- [ ] Implement code splitting and lazy loading
- [ ] Configure CDN and asset optimization
- [ ] Set up performance monitoring and alerting
- [ ] Implement rate limiting and DDoS protection
- [ ] Configure auto-scaling based on metrics

### Documentation Setup
- [ ] Write comprehensive README with setup instructions
- [ ] Document API endpoints with examples
- [ ] Create architecture diagrams and documentation
- [ ] Set up auto-generated documentation
- [ ] Document deployment and operational procedures
- [ ] Create troubleshooting and runbook documentation

## Success Metrics

### Technical Metrics
```
Uptime: 99.9% availability target
Performance: Sub-second response times for 95% of requests
Security: Zero high-severity vulnerabilities in production
Quality: 80%+ test coverage with high-quality tests
```

### Process Metrics  
```
Development Velocity: Consistent feature delivery pace
Code Review: Average review turnaround < 24 hours
Bug Rate: Low post-deployment defect rate
Team Satisfaction: High developer experience scores
```

### Business Metrics
```
User Experience: High user satisfaction scores
Feature Adoption: Strong uptake of new features
System Reliability: Minimal service disruptions
Cost Efficiency: Optimal resource utilization
```

---

## Implementation Notes

This universal CLAUDE.md represents synthesized best practices from 47+ production-tested development commands. It provides language-agnostic principles while remaining specific enough for practical implementation.

### Adaptation Guidelines
- **Language-Specific**: Adapt syntax and tooling to your technology stack
- **Scale-Appropriate**: Apply practices proportional to project complexity
- **Team-Contextual**: Adjust processes to fit team size and experience
- **Domain-Specific**: Consider industry-specific requirements (healthcare, finance, etc.)

### Evolution Strategy
- **Regular Updates**: Review and update practices quarterly
- **Community Input**: Incorporate feedback from development teams
- **Technology Changes**: Adapt to new tools and framework updates
- **Lessons Learned**: Update based on production experiences and incidents

This document serves as a living standard that should evolve with your team's experience and the broader software development ecosystem.

---
description: Analyze and review application architecture with scalability and security assessment
argument-hint: [architecture scope and focus areas]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "validation"
last_updated: "2025-09-08"

Conduct architecture review for: $ARGUMENTS

Architecture analysis framework:
1. **System Architecture Assessment**:
   - Analyze overall system design and component interactions
   - Evaluate service boundaries and domain separation
   - Review data flow and communication patterns
   - Assess scalability and performance characteristics
   - Identify single points of failure and bottlenecks
   - Review deployment and infrastructure patterns

2. **Code Structure and Organization**:
   - Evaluate component coupling and cohesion
   - Review dependency management and layering
   - Assess code organization and module boundaries
   - Analyze design patterns and architectural decisions
   - Review error handling and resilience patterns
   - Evaluate testing strategy and coverage

3. **Database and Data Architecture**:
   - Review database schema design and relationships
   - Analyze query performance and indexing strategies
   - Evaluate data consistency and transaction patterns
   - Review caching strategies and data access patterns
   - Assess data security and privacy compliance
   - Analyze backup and disaster recovery procedures

4. **API Design and Integration**:
   - Review RESTful API design and consistency
   - Evaluate authentication and authorization patterns
   - Analyze API versioning and backward compatibility
   - Review external service integration patterns
   - Assess API documentation and developer experience
   - Evaluate rate limiting and security measures

5. **Security Architecture Review**:
   - Analyze authentication and session management
   - Review authorization and access control patterns
   - Evaluate input validation and sanitization
   - Assess data encryption and storage security
   - Review security headers and HTTPS configuration
   - Analyze vulnerability management processes

Architecture review process:
1. **Documentation Analysis**:
   - Review existing architecture documentation
   - Analyze system diagrams and component relationships
   - Evaluate API specifications and contracts
   - Review deployment and infrastructure documentation
   - Assess monitoring and logging strategies

2. **Code Review and Analysis**:

```bash
# Analyze code complexity and dependencies
find . -name "*.ts" -o -name "*.js" | head -20 | xargs wc -l
npx madge --circular src/
npx dependency-cruiser --validate src/
```

3. **Performance Analysis**:
- Review application performance metrics
- Analyze database query performance
- Evaluate caching effectiveness
- Review resource utilization patterns
- Assess scalability bottlenecks

4. **Security Assessment**:
- Perform threat modeling exercise
- Review security controls and measures
- Analyze attack surface and vulnerabilities
- Evaluate compliance requirements
- Assess incident response procedures

Architecture review deliverables:
1. **Current State Assessment**:

```markdown
## System Overview

- **Application Type**: Full-stack web application
- **Technology Stack**: Next.js, FastAPI, PostgreSQL, Redis
- **Deployment**: Kubernetes on AWS
- **Team Size**: 8 developers

## Strengths

- Well-defined API boundaries
- Comprehensive test coverage (85%)
- Modern CI/CD pipeline
- Good monitoring and alerting

## Areas for Improvement

- Database queries need optimization
- Frontend bundle size is large (2MB)
- Authentication system needs modernization
- Caching strategy needs improvement
```

2. **Recommendations and Roadmap**:
- Prioritized list of improvements
- Implementation timeline and effort estimates
- Risk assessment and mitigation strategies
- Technology upgrade recommendations
- Team training and knowledge transfer needs

3. **Architecture Decision Records (ADRs)**:
- Document significant architectural decisions
- Record context, options, and rationale
- Track consequences and follow-up actions
- Enable future decision-making reference

Quality metrics to evaluate:
- Code complexity and maintainability scores
- Test coverage and quality metrics
- Performance benchmarks and SLA compliance
- Security vulnerability assessment
- Technical debt measurement

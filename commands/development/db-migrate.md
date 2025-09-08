---
description: Manage database migrations and schema evolution with rollback capabilities
argument-hint: [migration requirements and changes]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Create database migration for: $ARGUMENTS

Migration strategy:
- Framework-agnostic migration scripts
- Forward and rollback migration procedures
- Data migration scripts with validation
- Schema change impact analysis
- Multi-environment migration coordination
- Migration dependency management
- Database backup before major migrations
- Migration testing in isolated environments
- Performance impact assessment for large tables
- Index management during migrations
- Constraint validation and error handling

Implementation includes:
1. Migration script templates for common operations
2. Rollback procedures for each migration
3. Data migration scripts with validation
4. Migration testing framework
5. Database backup automation before migrations
6. Migration performance monitoring
7. Schema change documentation
8. Migration dependency tracking
9. Environment-specific migration configurations
10. Migration status tracking and reporting
11. Automated migration validation
12. Post-migration verification scripts
13. Migration scheduling for production deployments
14. Emergency rollback procedures

Best practices:
- Always create backward-compatible changes when possible
- Test migrations on production-like data
- Monitor migration performance and impact
- Implement proper error handling and logging
- Use transactions for atomic migrations
- Validate data integrity before and after migrations

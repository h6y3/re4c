---
description: Set up NeonDB PostgreSQL integration with connection pooling and migrations
argument-hint: [database schema requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Set up NeonDB PostgreSQL integration for: $ARGUMENTS

NeonDB configuration:
- Connection string management for multiple environments
- Connection pooling configuration for serverless functions
- Prisma or Drizzle ORM setup with NeonDB compatibility
- Database migration strategy with version control
- Seed data scripts for development and testing
- Backup and restore procedures automation
- Connection error handling and retry logic
- Environment variable management for database credentials
- SSL/TLS configuration for secure connections
- Query optimization for serverless cold starts

Implementation includes:
1. Database schema design with relationships
2. Connection pooling configuration (PgBouncer-compatible)
3. ORM setup (Prisma or Drizzle) with NeonDB optimizations
4. Migration scripts with rollback capabilities
5. Seed data and test fixtures
6. Connection utility functions with error handling
7. Environment-specific database configurations
8. Backup automation scripts
9. Performance monitoring queries
10. Database health check endpoints
11. Connection pool monitoring
12. Query optimization guidelines
13. Index strategies for common queries
14. Database security configuration

Serverless optimizations:
- Connection pool sizing for Lambda functions
- Query caching strategies
- Connection reuse patterns
- Cold start optimization
- Timeout and retry configuration
- Connection pool warming techniques
- Database connection monitoring

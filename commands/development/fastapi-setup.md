---
description: Create production-ready FastAPI application with modern tooling and deployment
argument-hint: [application requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Create FastAPI application for: $ARGUMENTS

Application structure:
- Domain-driven design with clear separation of concerns
- SQLAlchemy 2.0 with async support and Alembic migrations
- Pydantic V2 models for request/response validation
- JWT authentication with refresh token rotation
- Dependency injection system for services and repositories
- Comprehensive error handling and custom exceptions
- Request/response middleware for logging and monitoring
- CORS configuration for frontend integration
- OpenAPI documentation with custom schemas
- Background tasks with Celery or FastAPI BackgroundTasks
- Database connection pooling and session management
- Async/await patterns throughout the codebase

Implementation includes:
1. Project structure with apps and domain modules
2. Database models with relationships and constraints
3. Pydantic schemas with validation rules
4. Repository pattern for data access
5. Service layer for business logic
6. Authentication and authorization system
7. API routes with proper HTTP status codes
8. Middleware for logging, CORS, and security
9. Comprehensive test suite with pytest-asyncio
10. Docker configuration with multi-stage builds
11. Kubernetes manifests for deployment
12. CI/CD pipeline with GitHub Actions
13. Environment configuration management
14. Monitoring and logging setup

Security features:
- Password hashing with bcrypt
- JWT token validation and refresh
- Input validation and sanitization
- SQL injection prevention
- Rate limiting and DDoS protection
- Security headers configuration

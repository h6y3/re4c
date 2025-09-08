---
description: Create Next.js API routes with production-ready patterns for Vercel deployment
argument-hint: [API endpoint specification]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Create Next.js API route for: $ARGUMENTS

Implementation requirements:
- Proper HTTP method handling (GET, POST, PUT, DELETE, PATCH)
- Request validation using Zod schemas
- TypeScript interfaces for request/response types
- Comprehensive error handling with appropriate status codes
- Database integration patterns (Prisma/Drizzle ORM if detected)
- Environment variable validation and management
- CORS configuration for cross-origin requests
- Rate limiting implementation for production
- Request logging and monitoring hooks
- Authentication middleware integration (NextAuth.js if detected)
- API response caching strategies for Vercel Edge
- Serverless function optimization for cold starts

Include:
1. API route implementation with all HTTP methods
2. Zod validation schemas for request/response
3. TypeScript type definitions
4. Error handling middleware
5. Integration tests using Supertest or similar
6. API documentation with examples
7. Environment variable configuration guide
8. Deployment optimization notes for Vercel

Security considerations:
- Input sanitization and validation
- SQL injection prevention
- XSS protection headers
- Rate limiting and DoS protection

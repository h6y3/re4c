---
description: Comprehensive Vercel deployment compatibility scanner with auto-fix capabilities
argument-hint: [target files/directories or 'full project scan']
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "deployment"
last_updated: "2025-09-08"

# Comprehensive Claude Code Command for Vercel Deployment Compatibility Scanning

## Claude Code command syntax and structure fundamentals

Claude Code uses a markdown-based custom command system where commands are stored as `.md` files in either `.claude/commands/` (project-specific) or `~/.claude/commands/` (user-specific). Commands use front matter for configuration and support dynamic arguments through the `$ARGUMENTS` placeholder. The basic invocation pattern is `/project:command-name` for project commands or `/user:command-name` for personal commands.

## The complete Vercel compatibility scanner command

Below is the ready-to-use Claude Code command that you should save as `.claude/commands/vercel-scan.md`:

```markdown
---
description: Comprehensive Vercel deployment compatibility scanner with auto-fix capabilities
allowed-tools: Read, Edit, Bash(find:*), Bash(grep:*), Bash(node:*), Bash(npm:*), Bash(git status:*), Bash(git diff:*)
---

# Vercel Deployment Compatibility Scanner

Perform comprehensive Vercel deployment compatibility analysis on: $ARGUMENTS

## Context Gathering
- Current git status: !`git status --short`
- Node version: !`node --version`
- Package manager: !`if [ -f "yarn.lock" ]; then echo "yarn"; elif [ -f "pnpm-lock.yaml" ]; then echo "pnpm"; else echo "npm"; fi`

## Systematic Compatibility Analysis

I will now perform a comprehensive Vercel deployment compatibility scan following this structured approach:

### Phase 1: Core Configuration Analysis

**1.1 Framework Detection and Version Compatibility**
- Identify framework (Next.js, React, Vue, etc.) and version
- Check Next.js version compatibility (15.x recommended, 14.x stable, <13.x needs migration)
- Verify Node.js version in package.json engines field (22.x default, 20.x LTS)
- Validate build command configuration

**1.2 Vercel Configuration Files**
Analyze vercel.json for:
- Invalid memory settings (max 3,009 MB)
- Excessive maxDuration values (Hobby: 60s, Pro: 300s, Enterprise: 900s)
- Deprecated routes configuration (should use rewrites/redirects)
- Invalid region specifications
- Bundle size limits (Edge: 1-4MB gzipped based on plan)

**1.3 Package.json Requirements**
Check for:
- Missing or incorrect build/start scripts
- Type field for ES modules when using Edge Runtime
- Package manager specification for ENABLE_EXPERIMENTAL_COREPACK
- Engine specifications overriding dashboard settings

### Phase 2: Runtime Compatibility Checks

**2.1 Edge Runtime Restrictions**
Scan for incompatible Node.js APIs in Edge Runtime files:
- File system operations (fs, path module usage)
- Process utilities (process.exit, __dirname)
- TCP/UDP connections
- require() statements (ES modules only)
- eval() or dynamic code execution
- Incompatible npm packages (axios, node-fetch, fs-based libraries)

**2.2 Serverless Function Analysis**
Check API routes and serverless functions for:
- Bundle size exceeding 250MB uncompressed
- Request/response payload over 4.5MB
- Memory configuration exceeding limits
- Timeout configuration exceeding plan limits
- Dynamic imports with variable paths causing bundle issues

**2.3 Middleware Constraints**
Validate middleware.js files for:
- Edge Runtime compatibility (no Node.js APIs)
- Bundle size within limits
- Proper matcher configuration
- Maximum duration compliance (25 seconds)

### Phase 3: Dependency and Module Analysis

**3.1 Module Resolution Issues**
Identify problematic patterns:
- Dynamic requires with variables: `require('./build/' + cmd)`
- Missing explicit imports for static analysis
- Circular dependencies
- Unresolved module paths

**3.2 Third-Party Package Compatibility**
Check for Edge-incompatible packages:
- axios → suggest native fetch
- fs-extra → cannot use in Edge Runtime
- bcrypt → suggest Web Crypto API
- jsonwebtoken → check for Edge-compatible alternatives

**3.3 Dependency Security and Versions**
- Scan for known vulnerabilities (CVEs)
- Check for deprecated packages
- Verify peer dependency satisfaction
- Identify packages incompatible with target Node version

### Phase 4: Environment and Build Configuration

**4.1 Environment Variables**
Validate .env and environment configuration:
- Check for required Vercel system variables
- Verify no reserved variable names (constructor, __proto__, etc.)
- Total size under 64KB limit
- Maximum 1,000 variables per environment
- Proper prefixing for client-side variables (NEXT_PUBLIC_)

**4.2 Build Output Requirements**
Verify build configuration:
- Output directory correctly specified
- Static file count reasonable (<100,000 for performance)
- Build time optimization (45-minute maximum)
- Cache usage efficiency (1GB limit)

**4.3 Asset and Static File Handling**
Check for:
- Large static files that should use CDN
- Improper asset imports in serverless functions
- Missing image optimization configuration
- Incorrect public folder usage

### Phase 5: Next.js Specific Compatibility

**5.1 App Router vs Pages Router**
- Identify router type and validate patterns
- Check for mixed router usage issues
- Validate data fetching methods (getStaticProps, getServerSideProps, etc.)
- Server Component vs Client Component boundaries

**5.2 ISR/SSR/SSG Configuration**
- Validate revalidation intervals for ISR
- Check for proper fallback configuration
- Verify getStaticPaths implementation
- Ensure no ISR with static exports

**5.3 Image Optimization**
- Validate next/image configuration
- Check for proper loader setup
- Verify image domains configuration
- Ensure proper blur placeholder setup

### Phase 6: API and Integration Compatibility

**6.1 API Route Patterns**
- Validate route handler exports (GET, POST, etc.)
- Check for proper request/response handling
- Verify streaming response setup
- Validate CORS configuration

**6.2 Database Connections**
- Check for connection pooling in serverless
- Validate connection string format
- Verify timeout configurations
- Check for proper connection cleanup

**6.3 External Service Integration**
- Validate API endpoint URLs (use environment variables)
- Check authentication patterns
- Verify webhook configurations
- Validate third-party SDK compatibility

## Issue Reporting Format

For each issue found, I will provide:

```json
{
  "severity": "CRITICAL|HIGH|MEDIUM|LOW",
  "category": "RUNTIME|CONFIG|DEPENDENCY|SECURITY|PERFORMANCE",
  "file": "path/to/file.js",
  "line": 42,
  "issue": "Detailed description of the problem",
  "impact": "How this affects Vercel deployment",
  "fix": {
    "type": "AUTO_FIX|MANUAL_FIX|SUGGESTION",
    "description": "Specific fix instructions",
    "code": "// Example corrected code",
    "risk": "LOW|MEDIUM|HIGH",
    "confidence": 0.95
  }
}
```

## Auto-Fix Decision Criteria

I will automatically apply fixes when ALL conditions are met:
- Risk level is LOW
- Backward compatibility is maintained
- Change is reversible via git
- Fix confidence > 0.9
- Category is in [CONFIG, IMPORTS, DEPRECATED_SIMPLE]

For MEDIUM or HIGH risk fixes, I will:
1. Explain the issue and proposed fix
2. Show before/after code comparison
3. Request explicit approval before applying
4. Create a git commit for easy rollback

## Progressive Remediation Strategy

**Stage 1: Critical Blockers** (Auto-fix when safe)
- Missing required configuration files
- Invalid Node.js version specifications
- Syntax errors in configuration files
- Missing required dependencies

**Stage 2: High Priority Issues** (Suggest with approval)
- Edge Runtime incompatibilities
- Bundle size violations
- Security vulnerabilities
- API breaking changes

**Stage 3: Performance Optimizations** (Recommend)
- Suboptimal caching configurations
- Unnecessary dependencies
- Large asset optimization
- Database connection pooling

**Stage 4: Best Practice Improvements** (Optional)
- Code splitting opportunities
- Image optimization enhancements
- Environment variable organization
- Documentation updates

## Execution Flow

1. **Discovery**: Scan project structure and identify key files
2. **Analysis**: Run compatibility checks in priority order
3. **Validation**: Cross-reference findings for accuracy
4. **Remediation**: Apply fixes based on risk assessment
5. **Verification**: Re-scan after fixes to ensure resolution
6. **Reporting**: Generate comprehensive compatibility report

## Final Output

After scanning, I will provide:
1. **Executive Summary**: Deployment readiness assessment
2. **Critical Issues**: Must-fix before deployment
3. **Recommendations**: Suggested improvements
4. **Applied Fixes**: List of automatic corrections made
5. **Manual Actions Required**: Steps you need to take
6. **Deployment Checklist**: Final verification items

Would you like me to proceed with the full compatibility scan, or focus on specific areas first?
```

## Usage instructions for the command

**To install and use this command:**

1. **Create the command file:**
   ```bash
   mkdir -p .claude/commands
   nano .claude/commands/vercel-scan.md
   ```
   Then paste the command content above.

2. **Invoke the command:**
   ```bash
   # Scan entire project
   /project:vercel-scan full project scan

   # Scan specific directory
   /project:vercel-scan src/ and api/ directories

   # Focus on specific issues
   /project:vercel-scan edge runtime compatibility only
   ```

3. **For global usage across all projects:**
   ```bash
   mkdir -p ~/.claude/commands
   cp .claude/commands/vercel-scan.md ~/.claude/commands/
   # Then use: /user:vercel-scan
   ```

## Key Vercel compatibility areas covered

The command comprehensively checks **six major categories** of Vercel deployment compatibility:

**Runtime Compatibility**: The command detects Edge Runtime restrictions including forbidden Node.js APIs, incompatible npm packages, and serverless function constraints. It identifies issues like filesystem access attempts, process utilities usage, and dynamic imports that break in Vercel's environment.

**Configuration Validation**: All Vercel-specific configuration files are analyzed including vercel.json settings, package.json requirements, environment variable limits, and build output specifications. The scanner catches common mistakes like excessive memory allocation or invalid region specifications.

**Dependency Analysis**: The command performs deep scanning of npm packages for Edge Runtime compatibility, security vulnerabilities, and version conflicts. It suggests compatible alternatives for problematic packages like replacing axios with native fetch for Edge functions.

**Next.js Framework Checks**: Comprehensive validation of Next.js-specific patterns including App Router vs Pages Router usage, ISR/SSR/SSG configuration, image optimization setup, and data fetching methods. It ensures proper Server Component boundaries and validates middleware implementation.

**Performance and Bundle Size**: The scanner identifies bundle size violations, suggests code splitting opportunities, validates caching configurations, and checks for unnecessary dependencies that impact deployment performance.

**Security and Best Practices**: Security vulnerability scanning, exposed credential detection, proper environment variable usage, and API endpoint configuration validation ensure production-ready deployments.

## Advanced features and best practices

**Progressive Fixing Strategy**: The command implements a risk-based approach to fixes, automatically applying only low-risk changes while requesting approval for modifications that could impact functionality. This prevents unintended breaking changes while maximizing automation efficiency.

**Multi-Environment Support**: Configure different scanning profiles for development, staging, and production environments by passing environment names as arguments. The scanner adjusts its checks based on environment-specific requirements and constraints.

**Continuous Integration**: The command can be integrated into CI/CD pipelines using Claude's headless mode:
```bash
claude -p "/project:vercel-scan full deployment check" --output-format json
```

**Custom Rule Extension**: Add project-specific checks by modifying the command file to include custom validation patterns, team-specific requirements, or organization deployment standards.

**Incremental Scanning**: For large projects, use focused scans on modified files only:
```bash
/project:vercel-scan $(git diff --name-only HEAD~1)
```

The command represents current best practices in automated deployment compatibility checking, combining static analysis, pattern matching, and intelligent remediation to ensure successful Vercel deployments while maintaining code quality and security standards.

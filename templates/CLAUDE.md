---
title: "Global Claude Code Workflow Standards"
description: "Universal standards and workflow guidelines for Claude Code development"
version: "1.0.0"
re4c_version: "1.0.0"
category: "core-standards"
last_updated: "2025-01-09"
type: "global-config"
---

# Global Claude Code Workflow

## Task Understanding Protocol
Before starting any task, I must assess my understanding level (1-5 scale):
- If understanding is less than 5/5, I will:
  1. State my current understanding level
  2. Ask 5 clarifying questions to reach full comprehension

## Repository Workflow

### For Existing Git Repositories:
1. **Feature Branch Creation**: Create a feature branch before any major changes
2. **GitHub Issue Creation**: Create a GitHub issue describing the request with:
   - Clear problem statement
   - Acceptance criteria
   - Technical approach (if known)
3. **Progress Updates**: Update the GitHub issue throughout development with:
   - Progress made
   - Technical decisions
   - Blockers encountered
4. **Test Plan**: Upon completion, update the issue with a comprehensive test plan
5. **Testing**: Create a sub-agent to test the changes using the test plan
6. **Commit**: Only commit to feature branch after tests pass

### For Non-Repository Directories:
1. **Repository Creation Check**: Ask if a git repository should be created
2. **If Yes**: Initialize repository and follow existing repository workflow
3. **If No**: Proceed with direct implementation

## Clean Code Principles

### Function Design
- **Small Functions**: Functions should be very short, ideally under 10 lines
- **Single Responsibility**: Functions should do one thing, do it well, and do it only
- **Same Level of Abstraction**: All statements in a function should be at the same level of abstraction
- **Stepdown Rule**: Code should read like a narrative, with functions calling others at the next level down

### Function Structure
- **Minimize Arguments**: Prefer 0-1 arguments, 2 is acceptable, avoid 3+
- **No Side Effects**: Functions should not have hidden behaviors that change external state
- **Command-Query Separation**: Functions should either do something OR answer something, not both
- **Extract When Unclear**: If the "what" isn't immediately obvious, extract it into a well-named function

### Naming Conventions
- **Intention-Revealing Names**: Names should clearly express intent
- **Use Verbs for Methods**: Action words for functions that do things
- **Descriptive Over Brief**: Longer, clear names are better than short, cryptic ones
- **Avoid Mental Mapping**: Don't make readers translate names to understand purpose

### Code Organization
- **Pure Functions When Possible**: Prefer functions without side effects
- **Clear Abstractions**: Don't mix high-level policy with low-level implementation details
- **Consistent Patterns**: Follow established patterns within the codebase

## TypeScript Development Strategy

### Core Philosophy
This universal scaffold prioritizes **correctness over convenience** to serve as a robust foundation for production applications. We embrace strict TypeScript checking as a quality gate.

### Strict Settings Rationale
- `exactOptionalPropertyTypes: true` - Prevents subtle undefined vs "not present" bugs
- `strictNullChecks: true` - Forces explicit null/undefined handling
- `noUncheckedIndexedAccess: true` - Prevents array/object access bugs
- `noImplicitAny: true` - Ensures type safety throughout the codebase

### Development Guidelines
1. **Fix root causes, not symptoms** - Don't add `any` or `@ts-ignore` to silence errors
2. **Design types intentionally** - Be explicit about what should be optional vs required
3. **Use type guards and assertions properly** - Handle undefined cases explicitly
4. **When stuck**: Comment the issue and continue, circle back during code review
5. **Prefer composition over inheritance** - Use interfaces and unions over complex class hierarchies

### Temporary Relaxation Protocol
- During rapid prototyping phases, specific strict rules may be temporarily disabled
- Must be documented in commit messages: "temp: disable exactOptionalPropertyTypes for [reason]"
- Must be re-enabled before production deployment
- All temporary relaxations must have GitHub issues to track re-enabling

### Performance vs Safety Trade-offs
- Compilation speed is secondary to runtime correctness
- IDE experience improvements justify stricter checking
- Build-time errors are cheaper than production bugs
- Universal scaffold nature requires modeling best practices

### Error Resolution Strategy
1. **Understand the error** - Read TypeScript error messages carefully
2. **Fix the design** - Often errors indicate flawed type design
3. **Use proper nullish coalescing** - `value ?? fallback` over loose equality
4. **Leverage type narrowing** - Use `if (value)` checks before access
5. **Create helper functions** - Extract complex type logic into utilities

## Code Quality Standards
- No Claude Code attribution in commit messages (user preference)
- Follow existing project conventions and patterns
- Run linting and type checking before commits
- Ensure all tests pass before committing
- Refactor mercilessly to maintain Clean Code principles
- Apply TypeScript Development Strategy throughout implementation

## Development Practices
- Use existing libraries and frameworks found in the codebase
- Follow established naming conventions
- Maintain security best practices
- Never commit secrets or keys
- Apply Clean Code principles during implementation and refactoring

## Testing Requirements

### Test-Driven Development (TDD) Standards
- **🧪 MANDATORY**: All code changes MUST follow Red-Green-Refactor TDD cycle
- **Tests First**: Write failing tests before any implementation code
- **No Code Without Tests**: Never write implementation code without corresponding tests
- **Test Quality**: Tests must be clean, focused, and well-named following Clean Code principles

### Framework Detection and Usage
- Identify test framework from README or codebase structure
- Run appropriate test commands (npm test, pytest, etc.)
- Ensure all tests pass before marking tasks complete
- Create comprehensive test plans for new features

### Web Application Testing Requirements
- **🎭 Playwright Mandatory**: All web UI must be tested with Playwright
- **Screenshot Validation**: Capture screenshots of key UI states and user flows
- **Responsive Testing**: Test across breakpoints and device sizes
- **User Flow Testing**: End-to-end testing of complete user journeys

## Task Management
- Use TodoWrite tool for complex multi-step tasks
- Mark tasks as in_progress before starting
- Complete tasks only when fully finished and tested
- Break down large tasks into smaller, manageable steps
- Apply Clean Code principles to task decomposition

## Validation Framework Standards

### Multi-Agent Validation Requirements
- **🔍 MANDATORY**: All slice completions MUST have multi-agent validation
- **Blocking Authority**: Validation agents have authority to block completion
- **Unanimous Approval Required**: All applicable agents must approve before completion

### Required Validation Agents
1. **Architecture Validation Agent**: Always required for structural integrity
2. **TDD Validation Agent**: Always required for code changes
3. **UI Testing Agent**: Required for all UI-related work
4. **UX Evaluation Agent**: Required for new UI features and user flows
5. **Cleanup Validation Agent**: Always required for workspace cleanliness

### Validation Override Protocol
- **User Approval Only**: Overrides require explicit user justification
- **Risk Assessment**: Clear risk assessment must be provided
- **Mitigation Plan**: Override must include mitigation strategy
- **Documentation**: All overrides must be documented in retrospectives

### Quality Gates
- **No Completion Without Validation**: Tasks cannot be marked complete without validation approval
- **Test Suite Validation**: All tests must pass before validation
- **Workspace Cleanup**: Repository must be pristine before completion
- **Production URL Usage**: Always use correct production URLs, never development URLs

## Resource Utilization Standards

### MCP Context7 Integration
- **🔧 MANDATORY**: Always use MCP Context7 for API and framework knowledge
- **Query First**: Verify API patterns and framework best practices through Context7
- **Integration Knowledge**: Use Context7 for troubleshooting integration issues
- **Documentation Reference**: Leverage Context7 for current documentation and examples

### Playwright Navigation Requirements
- **🎭 MANDATORY**: Use Playwright for all web application testing and navigation
- **Screenshot Documentation**: Capture screenshots for visual validation and documentation
- **User Flow Testing**: Test complete user interactions and workflows
- **Responsive Validation**: Verify responsive design across different viewport sizes

### Development Script Discovery
- **📁 MANDATORY**: Auto-discover `/scripts` directory at project start
- **Script Utilization**: Ask user about non-build scripts found in project
- **Existing Tool Usage**: Use existing scripts instead of recreating functionality
- **Documentation**: Document script usage in development guides

### URL Management Protocol
- **🌐 CRITICAL**: Always use correct production URLs
- **✅ Production**: Use `https://mend-delta.vercel.app` for production testing
- **❌ Development**: Never use development URLs like `mend-idk45n8bq-han-yuans-projects-6008ef83.vercel.app`
- **Verification**: Verify URL correctness before testing or validation

## Retrospective and Learning Standards

### Mandatory Retrospectives
- **📝 MANDATORY**: Every slice completion MUST have a retrospective
- **Knowledge Capture**: Document lessons learned, technical decisions, and process insights
- **Plan Updates**: Update project plans and task priorities based on learnings
- **Context Preservation**: Ensure important context survives session boundaries

### Retrospective Framework
- **Completion Analysis**: Document what was accomplished vs. planned
- **Learning Capture**: Record technical, process, and requirements insights
- **Project Plan Assessment**: Update task relevance, priorities, and scope
- **Knowledge Documentation**: Update documentation and decision records

## GitHub Integration
- Use `gh` CLI for all GitHub operations
- Create meaningful issue titles and descriptions
- Link commits to issues when appropriate
- Use proper branch naming conventions
- Follow Clean Code principles in commit messages and documentation

## Project Structure Best Practices
- **Modular Architecture**: Organize code into logical modules with clear boundaries
- **Dependency Direction**: Dependencies should point inward toward business logic
- **Interface Segregation**: Create small, focused interfaces rather than large ones
- **Configuration Management**: Keep configuration separate from business logic
- **Error Handling**: Use consistent error handling patterns throughout the codebase

## Documentation Management Standards

### Directory Structure
Projects MUST organize documentation using this structure:
- `docs/architecture/` - System design, ADRs, technical decisions
- `docs/api/` - API documentation, OpenAPI specs, endpoint guides  
- `docs/user-guides/` - End-user tutorials, workflows, FAQs
- `docs/development/` - Setup guides, contributing, coding standards
- `docs/operations/` - Deployment, monitoring, incident response

### Document Standards
All documentation files MUST include frontmatter:

```yaml
---
title: "Document Title"
description: "Brief description of content and purpose"
last_updated: "2025-01-15"
status: "current|draft|deprecated"
audience: "developer|user|ops"
---
```

### Naming Conventions
- Use kebab-case: `user-authentication-guide.md`
- Prefix by category: `api-authentication.md`, `arch-database-design.md`
- Version sensitive docs: `deployment-v2.md`

### Content Requirements
- Start with clear purpose and audience statement
- Include practical examples and code snippets
- Maintain working links and references
- Update modification date on significant changes
- Include "Related Documents" section for navigation

### Review Process
- Documents MUST be reviewed every 6 months
- Code changes MUST trigger documentation review
- Deprecated documents MUST be moved to `docs/archive/`
- Breaking changes MUST update related documentation

### Quality Gates
- No PRs without documentation updates for new features
- Quarterly documentation health reports
- Automatic link checking in CI/CD
- Documentation coverage metrics for new code
- Regular audit of document relevance and accuracy
---
description: Update global CLAUDE.md with standardized documentation management practices and structure
argument-hint: [project type or leave empty for general standards]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "documentation"
last_updated: "2025-09-08"

Update documentation standards in global CLAUDE.md for: $ARGUMENTS

Documentation standards enforcement:
1. **Directory Structure Definition**: Establish consistent docs organization
   - `/docs/architecture/` - System design, diagrams, technical decisions
   - `/docs/api/` - API documentation, endpoints, schemas
   - `/docs/user-guides/` - End-user documentation, tutorials, workflows  
   - `/docs/development/` - Developer onboarding, setup, contributing
   - `/docs/operations/` - Deployment, monitoring, troubleshooting

2. **Document Metadata Standards**: Consistent frontmatter and naming
   - Required frontmatter: title, description, last_updated, status
   - Naming convention: kebab-case with descriptive prefixes
   - Version tracking and change log requirements
   - Author attribution and review requirements

3. **Content Quality Guidelines**: Ensure documentation usefulness
   - Clear purpose statement for each document
   - Audience identification (developer, user, ops)
   - Actionable content with examples and code snippets
   - Regular review and update schedule
   - Link validation and reference accuracy

Implementation updates to CLAUDE.md:

```markdown
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
```

Documentation audit workflow:
1. **Structure Validation**: Ensure proper directory organization
   - Scan existing docs for proper categorization
   - Identify misplaced or uncategorized documents
   - Create missing directory structure
   - Generate directory README files with purpose statements

2. **Metadata Compliance**: Validate document frontmatter
   - Check for required frontmatter fields
   - Validate date formats and status values
   - Ensure audience tags are properly assigned
   - Flag documents missing critical metadata

3. **Content Quality Assessment**: Review document relevance
   - Identify documents without clear purpose
   - Flag outdated code examples and references
   - Check for broken internal and external links
   - Assess document freshness against codebase changes

4. **Cleanup Recommendations**: Generate maintenance tasks
   - List documents for archival or deletion
   - Identify documents needing updates
   - Recommend consolidation of duplicate content
   - Suggest new documentation needs

CLAUDE.md integration:
- Add documentation standards to global workflow
- Include doc review in PR requirements
- Set up automatic staleness detection
- Establish quarterly documentation audits
- Create documentation debt tracking

Quality gates:
- No PRs without documentation updates for new features
- Quarterly documentation health reports
- Automatic link checking in CI/CD
- Documentation coverage metrics for new code

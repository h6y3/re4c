---
description: Transform any project into a professional open source repository with licenses, documentation, and community guidelines
argument-hint: [leave empty to start interactive setup]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "documentation"
last_updated: "2025-09-08"

# /prepare-open-source - Professional Open Source Project Setup

**Purpose**: Transform any project into a professional, welcoming open source repository with all essential documentation, licenses, and community guidelines

**Philosophy**: Make open source projects accessible, secure, and community-friendly from day one

**Outcome**: A complete open source repository that looks professional and follows 2024 best practices

## Process Overview

This command will ask you 5 essential questions and then automatically generate all the necessary files to make your project open source-ready:

1. **Interactive Setup**: Answer 5 key questions about your project
2. **License Generation**: Create appropriate license file based on your needs
3. **Documentation Creation**: Generate professional README, CONTRIBUTING, and other docs
4. **Community Setup**: Add issue templates, security policy, and code of conduct
5. **Quality Badges**: Add relevant badges for build status, license, and standards

## The 5 Essential Questions

The command will ask you these questions to customize your open source setup:

### 1. License Selection
**Question**: "What type of license do you want for your project?"

**Options**:
- **A) MIT License** - Most popular, maximum freedom for users and businesses
- **B) Apache 2.0** - Permissive with patent protection, good for business use
- **C) GPL v3** - Copyleft, ensures derivatives remain open source
- **D) BSD 3-Clause** - Similar to MIT but with additional attribution requirements
- **E) Mozilla Public License 2.0** - Weak copyleft, good for libraries

**Guidance**: 
- Choose **MIT** if you want maximum adoption and don't care about derivatives
- Choose **Apache 2.0** if you want patent protection and business-friendly terms
- Choose **GPL v3** if you want to ensure all derivatives remain open source

### 2. Project Classification
**Question**: "What best describes your project?"

**Options**:
- **A) Library/Package** - Reusable code for other developers
- **B) Application/Tool** - End-user software or command-line tool  
- **C) Framework** - Foundation for building other applications
- **D) Educational** - Learning resource or tutorial project
- **E) Research** - Academic or experimental project

**Purpose**: Customizes README structure and contributing guidelines

### 3. Development Status
**Question**: "What's the current development status?"

**Options**:
- **A) Alpha** - Early development, expect breaking changes
- **B) Beta** - Feature-complete but may have bugs
- **C) Stable** - Production-ready with semantic versioning
- **D) Maintenance** - Stable but only accepting bug fixes
- **E) Experimental** - Proof of concept or research

**Purpose**: Sets appropriate expectations and badges

### 4. Contribution Preference
**Question**: "How do you want to handle contributions?"

**Options**:
- **A) Welcome all contributions** - Full community-driven development
- **B) Maintainer review required** - All changes need approval
- **C) Issue-first policy** - Discuss changes before coding
- **D) Limited scope** - Only accepting specific types of contributions
- **E) Maintainer-only** - Not accepting external contributions

**Purpose**: Creates appropriate CONTRIBUTING.md and issue templates

### 5. Contact and Support
**Question**: "How should users get help and contact you?"

**Options**:
- **A) GitHub Issues only** - All communication through issues
- **B) Email + Issues** - Provide email for private contact
- **C) Discord/Slack community** - Real-time community chat
- **D) Documentation site** - Comprehensive docs with examples
- **E) Multiple channels** - Issues, email, and community chat

**Purpose**: Sets up appropriate support channels and contact information

## Generated Files and Structure

Based on your answers, the command will create/update these files:

### Core Documentation
```
LICENSE                 # Appropriate license file
README.md              # Professional project overview
CONTRIBUTING.md        # Contribution guidelines  
SECURITY.md           # Security policy and vulnerability reporting
CODE_OF_CONDUCT.md    # Community standards and behavior
CHANGELOG.md          # Version history (if applicable)
```

### GitHub Community Files
```
.github/
├── ISSUE_TEMPLATE/
│   ├── bug_report.yml          # Bug report template
│   ├── feature_request.yml     # Feature request template
│   ├── question.yml            # Question template
│   └── custom.yml             # Custom issue template
├── PULL_REQUEST_TEMPLATE.md    # PR template
├── FUNDING.yml                 # Sponsorship information (optional)
└── SECURITY.md                # Security policy (symlink)
```

### Additional Quality Files
```
.gitignore             # Comprehensive gitignore (if missing)
.editorconfig          # Editor configuration
AUTHORS.md             # Contributors list
ROADMAP.md             # Project roadmap (optional)
```

## README.md Structure

The generated README will include:

### Professional Header
```markdown
# Project Name

[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Build Status](https://github.com/user/repo/workflows/CI/badge.svg)]()
[![Version](https://img.shields.io/github/v/release/user/repo)]()
[![Contributors](https://img.shields.io/github/contributors/user/repo)]()

> One-line description of what your project does

[Demo] | [Documentation] | [Contributing] | [Changelog]
```

### Core Sections
1. **Description** - What the project does and why it exists
2. **Features** - Key capabilities and benefits
3. **Installation** - Step-by-step setup instructions
4. **Quick Start** - Basic usage examples
5. **Documentation** - Links to comprehensive docs
6. **Contributing** - How to contribute and development setup
7. **License** - License information and copyright
8. **Support** - How to get help
9. **Acknowledgments** - Credits and thanks

## CONTRIBUTING.md Structure

The contributing guide will include:

### Welcome Section
- Warm welcome to contributors
- Project vision and goals
- Types of contributions welcome

### Getting Started
- Development environment setup
- Running tests locally
- Code style guidelines

### Contribution Process
- Fork and clone workflow
- Branch naming conventions
- Commit message format
- Pull request process
- Code review expectations

### Code Standards
- Coding style and formatting
- Testing requirements
- Documentation requirements
- Performance considerations

### Community Guidelines
- Communication channels
- Code of conduct reference
- Issue reporting guidelines
- Feature request process

## License Files

Pre-written license files for each option:

### MIT License Template
```
MIT License

Copyright (c) [year] [author]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

### Apache 2.0 Template
```
Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION...
```

## Security Policy Template

```markdown
# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

Please report security vulnerabilities by emailing [security-email].
Do not report security vulnerabilities through public GitHub issues.
```

## Issue Templates

### Bug Report Template (YAML format)
```yaml
name: Bug Report
description: Report a bug to help us improve
title: "[Bug]: "
labels: ["bug", "needs-triage"]
body:
  - type: textarea
    id: description
    attributes:
      label: Bug Description
      description: Clear description of the bug
    validations:
      required: true
  - type: textarea
    id: reproduction
    attributes:
      label: Steps to Reproduce
      description: Step-by-step instructions
    validations:
      required: true
```

### Feature Request Template
```yaml
name: Feature Request  
description: Suggest a new feature or improvement
title: "[Feature]: "
labels: ["enhancement", "needs-triage"]
body:
  - type: textarea
    id: problem
    attributes:
      label: Problem Description
      description: What problem does this solve?
    validations:
      required: true
```

## Code of Conduct

Based on the Contributor Covenant, adapted for your project:

```markdown
# Code of Conduct

## Our Pledge
We pledge to make participation in our community a harassment-free experience for everyone.

## Our Standards
Examples of behavior that contributes to a positive environment:
- Being respectful and inclusive
- Gracefully accepting constructive criticism
- Focusing on what is best for the community

## Enforcement
Instances of abusive behavior may be reported to [contact-email].
```

## Quality Badges

The command will suggest relevant badges based on your project type:

### Universal Badges
- License badge
- GitHub release version
- GitHub contributors count
- GitHub stars and forks

### Technology-Specific Badges
- **Node.js**: npm version, Node.js version support
- **Python**: PyPI version, Python version support  
- **Go**: Go module version, Go version support
- **Docker**: Docker image size, Docker pulls

### CI/CD Badges
- GitHub Actions build status
- Code coverage percentage
- Code quality scores
- Security audit status

## Implementation Process

The command follows this automated workflow:

1. **Project Analysis**:
   - Detect current project structure
   - Identify existing documentation
   - Check for current license
   - Analyze technology stack

2. **Interactive Questions**:
   - Present 5 key questions with clear options
   - Provide guidance for each choice
   - Validate responses and offer suggestions

3. **File Generation**:
   - Create LICENSE file with selected license
   - Generate comprehensive README.md
   - Create CONTRIBUTING.md with guidelines
   - Set up GitHub community files
   - Add security policy and code of conduct

4. **Quality Enhancement**:
   - Add appropriate badges to README
   - Create comprehensive .gitignore (if missing)
   - Set up issue and PR templates
   - Generate project documentation structure

5. **Final Review**:
   - Display summary of created files
   - Provide next steps checklist
   - Suggest additional improvements
   - Offer community building tips

## Advanced Features

### Project Type Customization
- **Libraries**: Focus on API documentation and examples
- **Applications**: Emphasize installation and usage
- **Frameworks**: Include architecture and extension guides
- **Educational**: Add learning resources and tutorials

### Compliance Features
- GDPR compliance notes (if applicable)
- Accessibility guidelines
- Security best practices
- Privacy policy template

### Community Building
- Contributor recognition system
- Development roadmap template
- Release notes automation
- Sponsorship and funding setup

## Success Metrics

After running the command, your project will have:

### Documentation Quality
- ✅ Professional README with clear value proposition
- ✅ Comprehensive contributing guidelines
- ✅ Security policy for vulnerability reporting
- ✅ Code of conduct for community standards

### Developer Experience
- ✅ Clear installation and setup instructions
- ✅ Working examples and usage documentation
- ✅ Consistent issue and PR templates
- ✅ Proper licensing and legal clarity

### Community Readiness
- ✅ Welcoming tone and inclusive language
- ✅ Multiple support channels
- ✅ Clear contribution process
- ✅ Recognition for contributors

### Professional Appearance
- ✅ Consistent formatting and structure
- ✅ Relevant badges and status indicators
- ✅ Proper GitHub integration
- ✅ Industry-standard documentation

## Post-Setup Checklist

After the command completes, consider these additional steps:

### Immediate Actions
- [ ] Review all generated files for accuracy
- [ ] Update any placeholder information
- [ ] Test installation instructions locally
- [ ] Set up GitHub Actions for CI/CD
- [ ] Enable GitHub features (Issues, Wiki, Discussions)

### Community Building
- [ ] Share your project on relevant platforms
- [ ] Create initial issues for contribution
- [ ] Set up project website or documentation
- [ ] Engage with potential contributors
- [ ] Join relevant developer communities

### Maintenance Planning
- [ ] Set up regular documentation reviews
- [ ] Plan release and versioning strategy
- [ ] Create maintainer guidelines
- [ ] Set up monitoring for issues and PRs
- [ ] Plan for scaling community management

---

**Example Usage**:
```bash
# Start interactive open source setup
/prepare-open-source

# The command will guide you through 5 questions and create all necessary files
```


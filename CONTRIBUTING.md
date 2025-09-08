# Contributing to re4c

Thank you for your interest in contributing to **re4c** (Rapid Engineering For Claude)! 🚀

We welcome contributions that help improve the AI-assisted development workflow system and make it more valuable for the Claude Code community.

## 📋 Project Vision

re4c aims to provide a comprehensive, turnkey workflow system that transforms Claude Code into a specialized engineering partner. Our goal is to maintain high-quality, production-ready commands that enforce best practices in AI-assisted software development.

## 🎯 Types of Contributions Welcome

- **🐛 Bug Fixes**: Corrections to existing functionality
- **📚 Documentation**: Improvements to README, command docs, or guides
- **🔧 Command Improvements**: Enhancements to existing commands
- **✨ New Commands**: Well-designed commands that fit the re4c philosophy
- **🧪 Testing**: Additional test coverage or testing infrastructure
- **🎨 Examples**: Usage examples and tutorials

## 🚀 Getting Started

### Development Environment Setup

1. **Fork and Clone**:
   ```bash
   git clone https://github.com/yourusername/re4c.git
   cd re4c
   ```

2. **Install Prerequisites**:
   ```bash
   # macOS
   brew install jq
   
   # Ubuntu/Debian
   sudo apt-get install jq
   ```

3. **Test Installation Locally**:
   ```bash
   ./install.sh
   # Follow prompts to install in test mode
   ```

4. **Verify Setup**:
   ```bash
   # Test a basic command
   /create-prd --help
   ```

### Running Tests Locally

```bash
# Test command syntax and structure
./scripts/validate-commands.sh

# Test installation process
./scripts/test-install.sh

# Run version validation
./scripts/version-check.sh
```

## 📝 Contribution Process

### 1. Issue-First Policy

**Before writing code, please open an issue to discuss your proposed changes.**

This helps us:
- Ensure your contribution aligns with project goals
- Avoid duplicate work
- Provide guidance on implementation approach
- Maintain architectural consistency

### 2. Fork and Branch Workflow

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/issue-description
```

### 3. Commit Message Format

We follow conventional commits for clear history:

```
type(scope): brief description

Optional longer description explaining the change.

Fixes #123
```

**Types:**
- `feat`: New feature or command
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(commands): add new slice validation agent
fix(install): resolve conflict handling for existing commands
docs(readme): update quick start guide examples
```

### 4. Pull Request Process

1. **Push your branch** to your fork
2. **Open a Pull Request** with:
   - Clear title describing the change
   - Reference to related issue(s)
   - Description of what changed and why
   - Any breaking changes noted
   - Test instructions if applicable

3. **PR Review Requirements**:
   - All changes require maintainer approval
   - CI checks must pass
   - Documentation must be updated if needed
   - Commands must follow re4c patterns and conventions

## 📏 Code Standards

### Command Structure

All commands must follow the re4c standard format:

```markdown
---
description: Brief command description
argument-hint: [expected arguments]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "category-name"
last_updated: "YYYY-MM-DD"

# /command-name - Title

**Purpose**: Clear statement of what this command does

**Philosophy**: How it fits into re4c methodology

**Previous Step**: What should be done before this
**Next Step**: What comes after this

## Process Overview
[Detailed explanation of the command workflow]
```

### Quality Requirements

- **Test-Driven Development**: Follow TDD principles where applicable
- **Validation Framework**: New commands should integrate with validation agents
- **Error Handling**: Comprehensive error handling and user feedback
- **Documentation**: Clear, comprehensive documentation with examples
- **Backward Compatibility**: Maintain compatibility with existing workflows

### File Organization

```
commands/
├── core/           # Essential workflow commands
├── validation/     # Quality and validation agents
├── development/    # Framework and tool-specific commands
├── deployment/     # Deployment and infrastructure
└── documentation/  # Documentation management
```

## 🔍 Command Design Principles

### 1. Context-First Development
- Commands should build proper context before implementation
- Follow PRD → DRD → TRD sequence where applicable
- Prevent architectural drift through systematic approaches

### 2. Shape Up Integration
- Fixed complexity budgets, variable scope
- Vertical slices that deliver user value
- Circuit breakers for complexity management

### 3. Agent-Does-All-Work Philosophy
- AI should handle complete development lifecycle
- Mandatory validation gates
- Quality over speed

### 4. Production-Ready Standards
- All output should be production-ready
- Comprehensive error handling
- Security and performance considerations

## 🧪 Testing Guidelines

### Command Testing
- Test command execution and output
- Validate file generation and modifications
- Test error conditions and edge cases
- Verify integration with other commands

### Documentation Testing
- Ensure all examples work as described
- Verify links and references
- Test installation instructions
- Validate command syntax

## 🛠️ Development Tools

### Scripts Available
- `./scripts/validate-commands.sh` - Validate command structure
- `./scripts/test-install.sh` - Test installation process
- `./scripts/version-check.sh` - Verify version consistency
- `./install.sh` - Main installation script

### Command Categories
Understanding the command categories helps with appropriate placement:

- **Core**: Essential workflow commands (PRD, slices, validation)
- **Validation**: Quality gates and validation agents
- **Development**: Framework-specific and general development tools
- **Deployment**: Production deployment and monitoring
- **Documentation**: Documentation management and organization

## 📞 Communication Guidelines

### GitHub Issues
- **Bug Reports**: Use bug report template with reproduction steps
- **Feature Requests**: Use feature request template with clear use case
- **Questions**: Use discussion or question template
- **Security Issues**: Follow security policy in SECURITY.md

### Code Review Process
- Be respectful and constructive
- Focus on code quality and architectural fit
- Consider maintainability and future extensibility
- Test changes thoroughly before approval

## 🏆 Recognition

We value all contributions! Contributors will be:
- Listed in AUTHORS.md
- Mentioned in release notes
- Recognized in project documentation
- Credited for significant contributions

## 📜 Code of Conduct

This project follows our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code and help maintain a welcoming, inclusive community.

## ❓ Questions?

- **General Questions**: Open a GitHub Discussion or Issue
- **Command Ideas**: Open a Feature Request issue
- **Bug Reports**: Use the Bug Report template
- **Documentation**: Check existing docs first, then ask

Thank you for helping make re4c better for the entire Claude Code community! 🎉
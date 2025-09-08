# re4c - Rapid Engineering For Claude

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/user/re4c)

**re4c** (Rapid Engineering For Claude) is a comprehensive, turnkey command collection and workflow system for Claude Code that implements best practices for AI-assisted software development.

## 🎯 What is re4c?

re4c provides a complete toolkit of 42 carefully crafted commands organized around a **Test-Driven Development (TDD)** workflow with **multi-agent validation** and **systematic knowledge capture**. It transforms Claude Code from a general-purpose AI assistant into a specialized engineering partner that enforces quality gates, maintains clean code practices, and captures learnings systematically.

### Key Features

- **🧪 Mandatory TDD**: All code changes follow Red-Green-Refactor cycle
- **🔍 Multi-Agent Validation**: 5 specialized validation agents with blocking authority
- **🎭 Playwright Integration**: Automatic UI testing with screenshots
- **📝 Learning Capture**: Mandatory retrospectives after every development slice
- **🔧 Resource Utilization**: MCP Context7, script discovery, proper URL management
- **🧹 Workspace Cleanup**: Repository integrity validation
- **📊 AI-Appropriate Estimation**: Complexity scoring instead of time-based estimates

## 📦 Installation

### Prerequisites

- macOS or Linux
- Claude Code CLI installed
- `jq` command-line JSON processor

```bash
# Install jq if not present
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq
```

### Quick Install

1. **Clone the repository**:
   ```bash
   git clone <repository-url> ~/re4c
   cd ~/re4c
   ```

2. **Run the installation script**:
   ```bash
   ./install.sh
   ```

3. **Follow the interactive prompts** to handle any conflicts with existing commands or configuration

### Installation Options

The installer provides several options for handling conflicts:

- **Backup and Replace**: Saves existing files with timestamps before installing new versions
- **Keep Existing**: Skips installation of conflicting files  
- **View Differences**: Shows diffs between existing and new versions before deciding
- **Interactive Prompts**: Handles each conflict individually for maximum control

## 🗂️ Command Organization

Commands are organized into logical categories:

### Core Workflow (8 commands)
Essential workflow commands for the TDD development cycle:
- `generate-tasks.md` - Generate TDD-first task lists from PRDs
- `generate-slices.md` - Create vertical slices with complexity scoring
- `process-slices.md` - Implement slices with mandatory validation  
- `process-slices-multiagent.md` - Multi-agent slice processing
- `create-prd.md`, `create-drd.md`, `create-trd.md` - Requirements documentation
- `ai-dev-help.md` - AI development assistance

### Validation Framework (6 commands)
Multi-agent validation system with blocking authority:
- `validate-slice-completion.md` - Orchestrates all validation agents
- `tdd-test-first.md` - Enforces Red-Green-Refactor TDD cycle
- `cleanup-workspace-agent.md` - Repository integrity validation
- `slice-retrospective.md` - Mandatory learning capture
- `architecture-review.md` - Deep architecture analysis
- `security-scan.md` - Security vulnerability assessment

### Development Tools (18 commands)
Framework-specific and general development utilities:
- Framework setup: `next-app.md`, `react-component.md`, `django-api.md`, `fastapi-setup.md`
- Database: `neon-setup.md`, `db-migrate.md`
- Code quality: `lint-setup.md`, `pre-commit-hooks.md`, `test-harness.md`
- Git workflow: `create-pr.md`, `fix-github-issue.md`, `smart-commit.md`
- Multi-agent: `multiagent-worktree.md`
- Standards: `universal-claude.md`, `setup-claude-standards.md`

### Deployment (5 commands)
Production deployment and monitoring:
- `vercel-deploy.md`, `railway-deploy.md` - Platform deployment
- `docker-optimize.md` - Container optimization
- `monitoring-setup.md` - Observability setup
- `vercel-scan.md` - Deployment analysis

### Documentation (5 commands)
Documentation management and organization:
- `docs-cleanup.md`, `docs-organize.md`, `docs-update.md` - Doc maintenance
- `meta-docs-standards.md` - Documentation standards
- `prepare-open-source.md` - Open source preparation

## 🚀 Quick Start Guide

### 1. Basic Development Workflow

```bash
# 1. Create requirements documents
/create-prd "user authentication system"

# 2. Generate implementation tasks  
/generate-tasks prd-user-auth.md

# 3. Create development slices
/generate-slices tasks-prd-user-auth.md

# 4. Implement with TDD validation
/process-slices
```

### 2. Multi-Agent Development

```bash
# For complex features requiring parallel development
/process-slices-multiagent
```

### 3. Mandatory Validation Gates

Every slice completion requires validation from:
- **Architecture Validation Agent**: Structural integrity
- **TDD Validation Agent**: Test coverage and quality  
- **UI Testing Agent**: Playwright testing (for UI work)
- **UX Evaluation Agent**: User experience validation (for new UI)
- **Cleanup Validation Agent**: Repository cleanliness

### 4. Learning Capture

```bash
# After every slice (mandatory)
/slice-retrospective slice-name
```

## 📋 Development Philosophy

re4c implements a systematic approach to AI-assisted development:

### Test-Driven Development (TDD)
- **Red**: Write failing tests first
- **Green**: Write minimal code to pass tests  
- **Refactor**: Improve code while keeping tests green
- **Mandatory**: No code without tests, no exceptions

### Complexity-Based Estimation  
Instead of time estimates (inappropriate for AI), re4c uses complexity scoring:
- **1-3**: Simple changes, quick implementation
- **4-6**: Moderate complexity, some research needed
- **7-9**: Complex features, multiple components
- **10**: Maximum complexity, consider breaking down

### Multi-Agent Validation
Quality gates prevent completion until all validation agents approve:
- Ensures consistent quality
- Catches issues early
- Maintains architectural integrity
- Enforces testing standards

### Systematic Learning Capture
Mandatory retrospectives after every slice:
- Document lessons learned
- Update project understanding  
- Adapt future planning
- Prevent knowledge loss

## 🔄 Updates

Keep your re4c installation up to date:

```bash
# Check for and apply updates
./update.sh

# Automatic update (no prompts)
./update.sh --auto
```

The update system:
- Compares file versions automatically
- Shows what will be updated before proceeding
- Creates backups of replaced files
- Handles new commands and obsolete files
- Updates global CLAUDE.md configuration

## 📚 Core Concepts

### Slices vs Tasks
- **Tasks**: Traditional sequential work items
- **Slices**: Vertical cuts through all application layers that deliver user value
- **Why Slices**: Better for AI development, maintain deployable state, easier validation

### Validation Agents
Specialized agents with expertise in specific domains:
- **Architecture**: System design, coupling, scalability
- **TDD**: Test quality, coverage, Red-Green-Refactor compliance  
- **UI Testing**: Playwright automation, screenshot validation
- **UX Evaluation**: User experience, accessibility, usability
- **Cleanup**: Repository integrity, workspace cleanliness

### Resource Utilization
re4c mandates proper use of available tools:
- **MCP Context7**: API documentation and framework knowledge
- **Playwright**: Web UI testing and navigation
- **Script Discovery**: Use existing project scripts
- **Correct URLs**: Always production URLs, never development

## 🛠️ Configuration

### Global Standards (CLAUDE.md)
The included `CLAUDE.md` implements:
- TDD enforcement
- Clean Code principles
- TypeScript development strategy
- Validation framework requirements
- Resource utilization standards

### Per-Project Customization
While re4c provides universal standards, you can customize:
- Project-specific complexity thresholds
- Additional validation requirements
- Custom workflow extensions
- Tool-specific configurations

## 📖 Advanced Usage

### Custom Validation Agents
Extend the validation framework:
```bash
# Create project-specific validators
/validate-slice-completion --add-validator custom-security-agent
```

### Complexity Budget Management
Track and manage development complexity:
```bash
# Set project complexity budget
/generate-slices --complexity-budget 50

# Monitor complexity usage
/process-slices --show-complexity-remaining
```

### Multi-Repository Workflows
Coordinate development across repositories:
```bash
# Set up multi-repo development environment
/multiagent-worktree --repos "frontend,backend,shared"
```

## 🔍 Troubleshooting

### Common Issues

**Installation conflicts with existing commands:**
- The installer will prompt for each conflict
- Choose "View differences" to see what's changed
- Backups are automatically created

**Missing validation agents:**
- Ensure all validation commands are installed
- Check that validation agents are executable
- Verify Claude Code has access to command directory

**TDD validation failures:**
- All tests must pass before slice completion
- Use `--debug` flag to see detailed test output
- Check test coverage meets project standards

### Getting Help

1. **Built-in documentation**: Each command includes comprehensive help
2. **Command structure**: All commands follow consistent patterns
3. **Debug mode**: Most commands support `--debug` for verbose output
4. **Issue tracking**: Report bugs and feature requests on GitHub

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🤝 Contributing

Contributions welcome! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/user/re4c/issues)
- **Discussions**: [GitHub Discussions](https://github.com/user/re4c/discussions)
- **Documentation**: See the `docs/` directory

---

**re4c**: Transform Claude Code into your specialized engineering partner with systematic TDD, multi-agent validation, and comprehensive learning capture. 🚀
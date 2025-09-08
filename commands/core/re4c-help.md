---
description: Display re4c workflow guide and available commands for structured, context-first AI-assisted development
argument-hint: [no arguments needed]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "core"
last_updated: "2025-09-08"

# /re4c-help - re4c Workflow Guide

**Purpose**: Display re4c philosophy, workflow sequence, and available commands  
**Philosophy**: Context-first development with systematic validation and quality gates

## 🎯 What is re4c?

**re4c** (Rapid Engineering For Claude) transforms Claude Code into a specialized engineering partner through:

- **Context-First Development**: PRD → DRD → TRD sequence builds comprehensive context
- **Vertical Slice Methodology**: Each slice delivers user value with deployable functionality
- **Multi-Agent Validation**: 5 specialized validation agents with blocking authority
- **Test-Driven Development**: Mandatory Red-Green-Refactor cycle for all code
- **Complexity Budgeting**: AI-appropriate scoring instead of time estimates

## 🔄 Core re4c Workflow

### Phase 1: Context Building (The Foundation)

```bash
# 1. Business Context
/create-prd "your feature description"
# AI asks clarifying questions → generates comprehensive PRD

# 2. Design Context (Optional but Recommended)
/create-drd prd-your-feature.md
# AI creates design specifications, component hierarchy, UX patterns

# 3. Technical Context (Optional but Recommended)
/create-trd prd-your-feature.md
# AI defines system architecture, data models, integration patterns
```

### Phase 2: Implementation Planning

```bash
# 4. Generate Vertical Slices
/generate-slices prd-your-feature.md [complexity-budget]
# AI creates deliverable slices with TDD requirements and validation gates
```

### Phase 3: Implementation Execution

```bash
# 5. Process Slices (Single Agent)
/process-slices
# AI implements slice-by-slice with mandatory validation

# OR for complex features:
/process-slices-multiagent
# Coordinate parallel development with git worktrees
```

### Phase 4: Quality Gates (Automatic)

Each slice completion requires validation from:
- **Architecture Agent**: Technical implementation review
- **TDD Agent**: Test-driven development compliance  
- **UI Testing Agent**: Playwright automation (for UI features)
- **UX Agent**: User experience validation (for new UI)
- **Cleanup Agent**: Repository integrity validation

### Phase 5: Learning Capture (Mandatory)

```bash
# 6. Retrospective
/slice-retrospective slice-name
# Capture lessons learned and update project understanding
```

## 📋 Key re4c Principles

### 1. Context-First Development
- **Problem**: AI needs context before implementation
- **Solution**: PRD → DRD → TRD sequence provides comprehensive context
- **Benefit**: Prevents architectural drift and ensures requirements alignment

### 2. Vertical Slice Methodology 
- **Problem**: Traditional tasks don't deliver user value
- **Solution**: Each slice cuts through all application layers
- **Benefit**: Always maintain deployable state, easier validation

### 3. Fixed Complexity, Variable Scope
- **Problem**: Time estimates are inappropriate for AI
- **Solution**: Set complexity budget, adjust scope to fit
- **Benefit**: Prevents endless feature creep, delivers working software

### 4. Agent-Does-All-Work Philosophy
- **Problem**: Context switching between human and AI is inefficient
- **Solution**: AI handles complete development lifecycle with validation gates
- **Benefit**: Consistent quality, comprehensive testing, systematic validation

## 🗂️ Command Categories

### Core Workflow Commands (8)
Essential commands for the re4c development cycle:

- **`/create-prd`** - Product Requirements Document creation
- **`/create-drd`** - Design Requirements Document creation
- **`/create-trd`** - Technical Requirements Document creation
- **`/generate-tasks`** - Legacy task generation (use `/generate-slices` instead)
- **`/generate-slices`** - Create vertical slices with complexity scoring
- **`/process-slices`** - Implement slices with validation
- **`/process-slices-multiagent`** - Multi-agent parallel development
- **`/re4c-help`** - This workflow guide

### Validation Framework (6)
Multi-agent validation system with blocking authority:

- **`/validate-slice-completion`** - Orchestrates all validation agents
- **`/tdd-test-first`** - Enforces Red-Green-Refactor TDD cycle
- **`/cleanup-workspace-agent`** - Repository integrity validation
- **`/slice-retrospective`** - Mandatory learning capture
- **`/architecture-review`** - Deep architecture analysis
- **`/security-scan`** - Security vulnerability assessment

### Development Tools (18)
Framework-specific and general development utilities for production-ready code

### Deployment (5)
Production deployment and monitoring commands

### Documentation (5)
Documentation management and organization commands

## 💡 Example Workflows

### Basic Feature Development

```bash
# Complete context-first workflow
/create-prd "user authentication with social login"
/create-drd prd-user-auth.md
/create-trd prd-user-auth.md
/generate-slices prd-user-auth.md 10
/process-slices

# Each slice will be validated before completion
# Retrospective captured automatically
```

### Rapid Prototyping (PRD Only)

```bash
# Minimal viable workflow
/create-prd "simple todo list app"
/generate-slices prd-todo-list.md 6
/process-slices

# Less context but still systematic validation
```

### Complex Multi-System Feature

```bash
# Full context + parallel development
/create-prd "real-time chat with video calls"
/create-drd prd-chat-system.md
/create-trd prd-chat-system.md  
/generate-slices prd-chat-system.md 20
/process-slices-multiagent

# Multiple agents work in parallel with coordination
```

## 🧪 Testing and Validation

### Test-Driven Development (TDD)
**Mandatory for all slices:**
- **Red**: Write failing tests first
- **Green**: Write minimal code to pass tests
- **Refactor**: Improve code while keeping tests green

### Multi-Agent Validation
**Every slice must pass all applicable validation:**
- Architecture validation (always required)
- TDD compliance validation (always required)
- UI testing with Playwright (for UI changes)
- UX evaluation (for new user interfaces)
- Workspace cleanup validation (always required)

### Learning Capture
**After each slice:**
- Document what was learned
- Update project understanding
- Adapt future planning
- Prevent knowledge loss

## 🔧 Advanced Features

### Complexity Budgeting

```bash
# Set budget to control scope
/generate-slices prd-feature.md 15

# Monitor remaining budget during implementation
/process-slices --show-complexity-remaining
```

### Multi-Repository Coordination

```bash
# Set up parallel development across repos
/multiagent-worktree --repos "frontend,backend,shared"
```

### Custom Validation

```bash
# Add project-specific validators
/validate-slice-completion --add-validator custom-security-agent
```

## 🚀 Getting Started

### New to re4c?

1. **Start with `/create-prd`** - Describe your feature
2. **Follow the AI's questions** - Build comprehensive context  
3. **Use `/generate-slices`** - Create implementation plan
4. **Run `/process-slices`** - Let AI implement with validation
5. **Review and approve** - Maintain quality control

### Best Practices

- **Always start with PRD** - Context prevents architectural drift
- **Use DRD for UI features** - Design specifications improve quality
- **Use TRD for complex systems** - Technical context prevents technical debt
- **Set appropriate complexity budgets** - Start small, expand gradually
- **Trust the validation agents** - They enforce quality and best practices
- **Capture learnings** - Retrospectives improve future development

### Common Pitfalls

- **Skipping context building** - Leads to architectural drift
- **Ignoring validation failures** - Compromises code quality
- **Setting complexity budgets too high** - Results in incomplete features
- **Bypassing TDD requirements** - Creates technical debt
- **Skipping retrospectives** - Misses learning opportunities

## 📚 Philosophy Deep Dive

### Why Context-First?
AI needs comprehensive understanding before implementation. The PRD → DRD → TRD sequence provides business, design, and technical context that prevents costly architectural mistakes.

### Why Vertical Slices?
Traditional task lists create integration challenges. Vertical slices ensure each piece of work delivers user value and maintains system deployability.

### Why Validation Gates?
Quality gates with specialized agents catch issues early, maintain consistency, and enforce best practices automatically.

### Why Complexity Scoring?
Time estimates are inappropriate for AI development. Complexity scoring allows for fixed budgets with variable scope, ensuring deliverable results.

---

## 🔗 Related Commands

- **`/create-prd`** - Start here for new features
- **`/generate-slices`** - Create implementation plan
- **`/process-slices`** - Execute implementation
- **`/validate-slice-completion`** - Run validation framework
- **`/slice-retrospective`** - Capture learnings

**Remember**: re4c is designed for systematic, high-quality AI-assisted development. Trust the process, follow the validation gates, and capture your learnings! 🚀
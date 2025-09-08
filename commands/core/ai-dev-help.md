---
description: Display AI development workflow guide and available commands for structured feature development
argument-hint: [no arguments needed]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "core"
last_updated: "2025-09-08"

# /ai-dev-help - AI Dev Tasks Workflow Guide
**Source**: ai-dev-tasks repository workflow  
**Purpose**: Display available commands and workflow sequence  

## AI Dev Tasks Workflow

This workflow provides a structured approach to feature development with AI assistance, breaking down complex features into manageable phases with built-in checkpoints.

## Available Commands

### 1. `/create-prd` - Start with PRD Creation
- **Purpose**: Create structured Product Requirements Document with clarifying questions
- **Process**: AI asks clarifying questions → generates comprehensive PRD
- **Output**: `prd-[feature-name].md` in `/tasks/` directory
- **Next Step**: Use `/generate-tasks`

### 2. `/generate-tasks` - Generate Task List from PRD  
- **Purpose**: Break down PRD into actionable implementation tasks
- **Process**: Two-phase generation (parent tasks → sub-tasks with approval)
- **Output**: `tasks-prd-[feature-name].md` in `/tasks/` directory
- **Next Step**: Use `/process-tasks`

### 3. `/process-tasks` - Process Tasks One-by-One
- **Purpose**: Methodical implementation with approval gates and git integration
- **Process**: One sub-task at a time → approval → mark complete → commit when parent complete
- **Features**: Test running, git integration, conventional commits
- **Control**: You approve each step before AI continues

## Complete Workflow Sequence

```
1. /create-prd "Your feature description"
   ↓ (AI asks clarifying questions, creates PRD)
   
2. /generate-tasks  
   ↓ (AI generates parent tasks → you say "Go" → AI adds sub-tasks)
   
3. /process-tasks "start with task 1.1"
   ↓ (AI implements task 1.1 → asks for approval → you say "yes" → repeats)
```

## File Organization

All files are saved to `/tasks/` directory:
- **PRDs**: `prd-[feature-name].md`
- **Task Lists**: `tasks-prd-[feature-name].md`

## Key Benefits

- **Structured Development**: Clear phases from idea to implementation
- **Step-by-Step Verification**: Review and approve each change
- **Manages Complexity**: Breaks large features into digestible tasks
- **Git Integration**: Automatic testing and conventional commits
- **Progress Tracking**: Visual representation of completed tasks

## Example Usage

```bash
# Start a new feature
/create-prd "Add user authentication with email verification"

# After PRD is created
/generate-tasks

# After task list is generated  
/process-tasks "start with task 1.1"

# Continue approving each task
yes
yes  
y
# ... etc
```

## Getting Started

1. Ensure your project has a `/tasks` directory
2. Start with `/create-prd` and describe your feature
3. Follow the AI's clarifying questions
4. Proceed through the workflow sequentially

**Source Repository**: Based on methodology from ai-dev-tasks repository by snarktank

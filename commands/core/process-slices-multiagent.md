---
description: Orchestrate vertical slice implementation using multiple specialized agents with git worktrees for parallel development
argument-hint: [slice-number or "all"] [agents:1-5] [strategy:sequential|pipeline|parallel]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "core"
last_updated: "2025-09-08"

# /process-slices-multiagent - Multi-Agent Vertical Slice Implementation

**Purpose**: Execute vertical slices using coordinated multi-agent teams with mandatory TDD, validation gates, and git worktree isolation  
**Philosophy**: Test-first parallel execution within slices, strict validation gates, sequential deployment between slices  
**Previous Step**: Complete `/generate-slices` first to establish slice definitions  
**Innovation**: Combines Shape Up slices with multi-agent acceleration and comprehensive quality validation

Process vertical slices using specialized agents working in parallel through git worktrees.

## Command Syntax

```bash
# Process single slice with auto-calculated agents
/process-slices-multiagent 1

# Process all slices with specified agent count
/process-slices-multiagent all agents:3

# Process slice with specific strategy
/process-slices-multiagent 2 agents:4 strategy:parallel

# Resume from failure
/process-slices-multiagent continue
```

## Pre-Execution Analysis

### 🔧 MANDATORY: Resource and Validation Setup

Before spawning agents, ensure validation framework is ready:

1. **🧪 Initialize TDD Validation**: Run `/tdd-test-first [slice-name]` for test-first requirements
2. **🔍 Setup Validation Agents**: Prepare validation agents for post-completion verification
3. **🎭 Verify Playwright**: Ensure Playwright available for UI testing across all agents
4. **📁 Discover Scripts**: Check `/scripts` directory and consult user on non-build scripts
5. **🌐 URL Protocol**: Confirm correct production URL usage (`https://mend-delta.vercel.app`)
6. **🔧 MCP Context7**: Verify context7 MCP available for API/framework knowledge

### Slice Complexity Assessment

Before spawning agents, analyze the current slice:

```markdown
SLICE ANALYSIS: Slice X - [Name]
Complexity Points: X
Sub-tasks: Y
Dependencies: [List any inter-task dependencies]
Parallelizable: Z tasks can run simultaneously
Integration Points: N places where work must merge
Recommended Agents: M
Recommended Strategy: [sequential|pipeline|parallel]
```

### Agent Allocation Strategy

**Slice Complexity → Agent Count Mapping:**
- **1 point (Static)**: 1 agent - no parallelization needed
- **2 points (Interactive)**: 1-2 agents - UI and state can be split
- **4 points (Persistent)**: 2-3 agents - backend, frontend, database
- **8 points (Integrated)**: 3-4 agents - multiple integrations
- **16+ points (Orchestrated)**: 4-5 agents - complex coordination

### Worktree Planning

For each slice, create specialized worktrees:

```bash
# Slice-specific worktree pattern
git worktree add ../project-slice-X-foundation -b slice-X/foundation
git worktree add ../project-slice-X-frontend -b slice-X/frontend  
git worktree add ../project-slice-X-backend -b slice-X/backend
git worktree add ../project-slice-X-integration -b slice-X/integration
```

## Agent Specialization for Slices

### Slice 0: Static Mockup Agents

**Single UI Agent** (1 agent total)
- **🧪 TDD Required**: Write component tests first
- Creates all static UI components
- Adds mock data  
- Handles styling
- **🎭 Playwright Testing**: Take screenshots of all UI states
- Deploys to Vercel with correct production URL
- **Success**: URL works with full UI visible, all tests pass, screenshots validated

### Slice 1: Interactive State Agents

**UI Agent** + **State Agent** (2 agents)
- **🧪 TDD Required**: Both agents follow Red-Green-Refactor
- **UI Agent**: Test-driven component creation, event handlers
- **State Agent**: Test-driven state management, validation logic
- **🎭 Playwright Testing**: Test user interactions and state changes
- **Integration Point**: State hooks into UI with integration tests
- **Success**: Interactions work in browser, all tests pass, UI flow validated

### Slice 2: Persistence Agents

**Backend Agent** + **Frontend Agent** + **Database Agent** (3 agents)
- **🧪 TDD Required**: All agents follow test-first development
- **Database Agent**: Test-driven schema, migrations, seed data
- **Backend Agent**: Test-driven API routes, business logic
- **Frontend Agent**: Test-driven API integration, loading states
- **🎭 Playwright Testing**: End-to-end data persistence flows
- **Integration Points**: API contracts with comprehensive integration tests
- **Success**: Data persists across refresh, all tests pass, E2E flows validated

### Slice 3: External Integration Agents

**Foundation Agent** + **Service Agents** + **Integration Agent** (4+ agents)
- **Foundation Agent**: Shared interfaces, error boundaries
- **Service Agent(s)**: Each external service integration
- **Integration Agent**: Orchestration, testing
- **Success**: External services work with fallbacks

## Execution Workflow

### Phase 1: Slice Initialization

```markdown
INITIALIZING SLICE X: [Name]
Complexity: Y points
Creating worktrees for Z agents...

Agent Assignments:
- Agent 1 (Foundation): Tasks [0.1, 0.2]
- Agent 2 (Frontend): Tasks [0.3, 0.4]  
- Agent 3 (Backend): Tasks [0.5, 0.6]

Coordination Strategy: [sequential|pipeline|parallel]
Estimated Time: [based on complexity]

Ready to launch agents? (yes/y)
```

### Phase 2: Agent Context Distribution

Each agent receives a specialized context package:

```markdown
## AGENT CONTEXT: [Role] for Slice X

### Slice Objective
**Goal**: [What this slice delivers to user]
**Demo Requirement**: [What must be demoable]
**Complexity Budget**: [Points allocated to this slice]

### Your Specialization: [AGENT_ROLE]
**Assigned Tasks**:
- [ ] X.1: [Specific task]
- [ ] X.2: [Specific task]

**Dependencies**:
- Must wait for: [Other agent's tasks]
- Others wait for: [Your deliverables]

### Working Directory
**Worktree**: ../project-slice-X-[role]
**Branch**: slice-X/[role]
**Port Allocation**: [If applicable]

### Coordination Protocol
**Progress File**: PROGRESS-[role].md
**Update Frequency**: Every completed sub-task
**Blocking Issues**: Flag immediately in COORDINATION.md

### Circuit Breakers for This Slice
[Specific fallbacks if this slice hits complexity limits]

### Success Criteria
- [ ] All assigned tasks complete
- [ ] Build passes: `npm run build`
- [ ] Type check passes: `npx tsc --noEmit`
- [ ] Can demo: [Specific demo requirement]

### Integration Points
**API Contracts**: [If applicable]
**Shared Types**: [Files to read first]
**State Management**: [Patterns to follow]
```

### Phase 3: Parallel Execution with Coordination

#### Sequential Strategy (Low Complexity)
```
Foundation Agent → Complete all tasks
    ↓
Backend Agent → Complete all tasks
    ↓
Frontend Agent → Complete all tasks
    ↓
Integration & Deploy
```

#### Pipeline Strategy (Medium Complexity)
```
Foundation Agent → Complete first task
    ↓ (Unblocks others)
[Backend + Frontend] → Start in parallel
    ↓ (At 50% checkpoint)
Sync Meeting Point → Resolve any conflicts
    ↓
Complete remaining tasks
    ↓
Integration Agent → Merge and deploy
```

#### Parallel Strategy (High Complexity)
```
Foundation Agent → Critical interfaces only (FAST)
    ↓
[All Agents] → Work simultaneously
    ↓
Every 30 min → Sync checkpoint
    ↓
Integration Agent → Continuous merge
    ↓
Deploy when all complete
```

### Phase 4: Sub-Task Level Coordination

Within each agent's execution:

```markdown
AGENT [Role] - Task X.Y Starting
Current: [Task description]
Dependencies Met: ✓
Estimated Completion: [time]

[... agent works ...]

AGENT [Role] - Task X.Y Complete ✓
Files Modified: [list]
Tests Status: [pass/fail]
Unblocked Tasks: [if any]
Next: Task X.Y+1

Waiting for approval to continue (yes/y)
```

### Phase 5: Integration and Merge

After all agents complete their tasks:

```bash
# Integration Agent takes over
cd ../project-slice-X-integration

# Merge all agent work
git merge slice-X/foundation
git merge slice-X/backend  
git merge slice-X/frontend

# Run integrated tests
npm run build
npm test
npm run test:integration

# If successful, prepare for deployment
git checkout main
git merge slice-X/integration
```

### Phase 6: 🚨 MANDATORY: Multi-Agent Validation Protocol

**CRITICAL**: NO SLICE IS COMPLETE without passing validation gates:

```bash
# MANDATORY: Multi-Agent Validation
/validate-slice-completion [slice-name]
```

**BLOCKING**: Must receive unanimous approval from all applicable agents:
- Architecture Validation Agent (always required)
- TDD Validation Agent (always required for code changes) 
- UI Testing Agent (required for UI work)
- UX Evaluation Agent (required for new UI features)
- Cleanup Validation Agent (always required)

### Phase 7: Slice Deployment and Verification

**ONLY AFTER ALL VALIDATION AGENTS APPROVE:**

```markdown
SLICE X INTEGRATION COMPLETE

✅ Validation: All agents approved unanimously
✅ Tests: TDD cycle completed, all tests pass
✅ Playwright: Screenshots validated, UI flows tested
✅ Workspace: Clean repository confirmed
✅ MCP Context7: API patterns validated
✅ Production URL: Correct URL verified

Merge Status: ✓ Successful
Build Status: ✓ Passing  
Tests Status: ✓ All passing
Deployment: Initiating to PRODUCTION URL...

[Deploy to Vercel/platform with correct URL]

Deployment URL: https://mend-delta.vercel.app
Demo Verification: [Instructions verified with Playwright]

### Phase 8: 📝 MANDATORY: Slice Retrospective

```bash
/slice-retrospective [slice-name]
```

**REQUIRED**: Capture multi-agent learnings:
- Document coordination effectiveness
- Update complexity estimates based on agent performance
- Record integration challenges and solutions
- Update project plans based on multi-agent insights

✅ SLICE X COMPLETE
✅ Validation: All gates passed
✅ Retrospective: Learnings captured
Complexity Used: Y points
Remaining Budget: Z points
Agents Used: N
Agent Efficiency: [coordination effectiveness score]
Time Elapsed: MM minutes

Ready to start Slice X+1? (yes/y)
```

## Coordination Management

### Real-Time Progress Tracking

**COORDINATION.md** (Central coordination file):
```markdown
# Slice X Coordination

## Agent Status
- Foundation: ████████░░ 80% [Tasks 0.1-0.4 complete]
- Frontend: ██████░░░░ 60% [Tasks 0.3-0.5 complete]
- Backend: ████████░░ 40% [Tasks 0.5-0.6 in progress]

## Dependencies
- ✓ Foundation interfaces complete (unblocked frontend/backend)
- ⏳ Waiting: Backend API for frontend integration
- ⏳ Waiting: Frontend types for backend validation

## Blocking Issues
- None currently

## Integration Readiness
- [ ] Foundation: Complete
- [ ] Frontend: In Progress
- [ ] Backend: In Progress
- [ ] Ready to merge: No
```

### Synchronization Points

**Every 30 minutes** (automatic):
```markdown
SYNC CHECKPOINT - [Timestamp]

Agent Reports:
- Foundation: [Status + any issues]
- Frontend: [Status + any issues]
- Backend: [Status + any issues]

Conflicts Detected: [None|List]
Resolution Required: [None|Specific items]
Continue? (yes/y/resolve)
```

### Conflict Resolution Protocol

When conflicts arise:

1. **Auto-Resolution** (Simple conflicts):
   - Import order differences
   - Whitespace conflicts
   - Comment conflicts
   
2. **Coordination Required** (Complex conflicts):
   ```markdown
   CONFLICT DETECTED
   
   Type: [Functional|Interface|State Management]
   Agents Involved: [List]
   Files Affected: [List]
   
   Proposed Resolution:
   Option 1: [Description]
   Option 2: [Description]
   
   Select resolution strategy (1/2/manual):
   ```

3. **Manual Intervention** (Critical conflicts):
   - Stop all agents
   - Human review required
   - Restart with adjusted strategy

## Circuit Breakers and Fallbacks

### Slice-Level Circuit Breakers

**Complexity Overflow**:
```markdown
⚠️ COMPLEXITY WARNING - Slice X

Budgeted: Y points
Current Estimate: Z points (exceeding budget)

ACTIVATING CIRCUIT BREAKER:
Original Plan: [What was intended]
Fallback Plan: [Simpler alternative]

Fallback reduces scope to:
- [Reduced feature 1]
- [Reduced feature 2]
- [Mock instead of real integration]

Accept fallback? (yes/y/abort)
```

**Time Box Exceeded**:
```markdown
⏰ TIME LIMIT WARNING - Slice X

Target: X minutes
Elapsed: Y minutes
Completion: Z%

Options:
1. Continue with reduced scope (circuit breaker)
2. Skip to next slice (defer this one)
3. Continue with current scope (accept delay)

Choose (1/2/3):
```

### Agent-Level Circuit Breakers

**Agent Failure**:
```markdown
🔴 AGENT FAILURE - [Role]

Agent Status: [Unresponsive|Invalid Output|Constraint Violation]
Tasks Completed: X/Y
Critical Path: [Yes/No]

Recovery Options:
1. Restart agent with reduced scope
2. Redistribute tasks to other agents
3. Switch to sequential execution
4. Activate slice circuit breaker

Choose (1/2/3/4):
```

## Quality Gates

### Per Sub-Task Validation
- [ ] Code compiles/builds
- [ ] No type errors
- [ ] Follows slice patterns
- [ ] Updates PROGRESS.md

### Per Agent Completion
- [ ] All assigned tasks complete
- [ ] Tests pass in worktree
- [ ] No merge conflicts
- [ ] Documentation updated

### Per Slice Integration
- [ ] All agents complete
- [ ] Integration tests pass
- [ ] Build succeeds
- [ ] Deployment works
- [ ] Demo requirements met

### Overall Quality Metrics
- [ ] Complexity budget maintained
- [ ] No circuit breakers activated (ideal)
- [ ] Test coverage adequate
- [ ] Performance acceptable
- [ ] Security validated

## Resource Management

### Token Consumption Tracking

```markdown
TOKEN USAGE - Slice X

Agent Budgets:
- Foundation: 10K tokens (Used: 7K)
- Frontend: 15K tokens (Used: 12K)
- Backend: 15K tokens (Used: 14K)
- Integration: 5K tokens (Used: 2K)

Total Budget: 45K tokens
Total Used: 35K tokens
Efficiency: 78%

⚠️ Warning at 80% consumption
🔴 Circuit breaker at 95% consumption
```

### Worktree Resource Management

```bash
# Automatic cleanup after slice completion
cleanup_slice_worktrees() {
    local SLICE_NUM=$1
    git worktree remove ../project-slice-$SLICE_NUM-foundation
    git worktree remove ../project-slice-$SLICE_NUM-frontend
    git worktree remove ../project-slice-$SLICE_NUM-backend
    git worktree remove ../project-slice-$SLICE_NUM-integration
    
    # Archive coordination files
    mv COORDINATION.md ./archive/slice-$SLICE_NUM-coordination.md
    mv PROGRESS-*.md ./archive/
}
```

## Emergency Protocols

### Cascade Failure Prevention

If multiple agents fail:
1. **Immediate**: Stop all parallel execution
2. **Assess**: Identify common cause
3. **Simplify**: Switch to single agent
4. **Restart**: With reduced complexity

### Rollback Procedure

```bash
# Complete slice rollback
rollback_slice() {
    local SLICE_NUM=$1
    
    # Stop all agents
    echo "🛑 STOPPING ALL AGENTS"
    
    # Clean up worktrees
    cleanup_slice_worktrees $SLICE_NUM
    
    # Reset to pre-slice state
    git checkout main
    git reset --hard pre-slice-$SLICE_NUM
    
    # Document failure
    echo "Slice $SLICE_NUM rolled back at $(date)" >> ROLLBACK.log
}
```

### Recovery Strategies

**From Partial Success**:
- Salvage completed agent work
- Reduce remaining scope
- Complete with single agent

**From Complete Failure**:
- Analyze failure patterns
- Redesign slice with lower complexity
- Consider skipping to next slice

## Success Metrics

### Slice-Level Metrics
- **Deployment Success**: Did it deploy?
- **Demo Readiness**: Does demo work?
- **Complexity Accuracy**: Actual vs estimated
- **Time Efficiency**: Actual vs projected
- **Agent Utilization**: Parallel efficiency

### Multi-Agent Efficiency
- **Parallelization Ratio**: Parallel vs sequential time
- **Coordination Overhead**: Time spent on sync
- **Conflict Rate**: Conflicts per integration
- **Token Efficiency**: Tokens per feature point
- **Recovery Rate**: Successful recovery from failures

## Command Implementation

```bash
#!/bin/bash
# Multi-Agent Slice Processing

SLICE_NUM="$1"
AGENT_COUNT="${2:-auto}"
STRATEGY="${3:-auto}"

# Load slice definition
TASK_FILE=$(ls -t tasks-*.md | head -1)
SLICE_COMPLEXITY=$(grep -A 1 "Slice $SLICE_NUM" $TASK_FILE | grep "Complexity:" | cut -d: -f2)

# Auto-calculate agents if needed
if [ "$AGENT_COUNT" = "auto" ]; then
    case $SLICE_COMPLEXITY in
        1) AGENT_COUNT=1 ;;
        2) AGENT_COUNT=2 ;;
        4) AGENT_COUNT=3 ;;
        8) AGENT_COUNT=4 ;;
        *) AGENT_COUNT=2 ;;
    esac
fi

# Determine strategy
if [ "$STRATEGY" = "auto" ]; then
    if [ $SLICE_COMPLEXITY -le 2 ]; then
        STRATEGY="sequential"
    elif [ $SLICE_COMPLEXITY -le 4 ]; then
        STRATEGY="pipeline"
    else
        STRATEGY="parallel"
    fi
fi

echo "🚀 Launching Multi-Agent Slice Processing"
echo "   Slice: $SLICE_NUM"
echo "   Complexity: $SLICE_COMPLEXITY points"
echo "   Agents: $AGENT_COUNT"
echo "   Strategy: $STRATEGY"
echo ""
echo "Proceed? (yes/y)"
```

## Best Practices

### ✅ DO's
- **🧪 TDD First**: All agents must follow Red-Green-Refactor cycle
- **🔍 Validation Gates**: Every slice must pass multi-agent validation
- **🎭 Playwright Testing**: Mandatory UI testing with screenshots
- **🧹 Workspace Cleanup**: Must pass cleanup validation before completion
- **📝 Retrospectives**: Capture learnings after every slice
- Start each slice with fresh worktrees
- Maintain clear task boundaries between agents
- Use circuit breakers early when complexity grows
- Document integration points explicitly
- Test continuously during parallel work
- **🌐 Correct URLs**: Always use production URL (`https://mend-delta.vercel.app`)
- **🔧 Use MCP Context7**: Leverage context7 for API/framework knowledge
- **📁 Use Existing Scripts**: Check for and utilize development scripts
- You must clean up worktrees after each slice
- Use git worktrees for isolated development work, but always merge changes back to main and deploy from the main project directory
- Slice is not complete if the code is not deployed in production from the original codebase (not a worktree)

### ❌ DON'Ts
- **🚫 NO Implementation Without Tests**: Never write code before writing tests
- **🚫 NO Validation Bypass**: Never skip validation gates or agent approval
- **🚫 NO Dirty Workspace**: Never commit with coordination docs or temporary files
- **🚫 NO Development URLs**: Never use development URLs in production
- **🚫 NO Resource Waste**: Don't ignore MCP context7, existing scripts, or Playwright
- Don't over-parallelize simple slices
- Don't skip coordination checkpoints
- Don't ignore agent failure warnings
- Don't merge without integration testing
- Don't continue if circuit breakers trigger
- Don't let token consumption run unchecked

### 🎯 Optimal Patterns
- **Slice 0**: Always single agent (simple enough)
- **Slice 1-2**: 2-3 agents with pipeline strategy
- **Slice 3+**: Full parallel with integration agent
- **Circuit Breakers**: Activate at 80% complexity budget
- **Coordination**: Every 30 min or 3 tasks (whichever first)

This merged approach ensures that you get the speed benefits of multi-agent development while maintaining the discipline of vertical slices that always produce deployable, demonstrable features.


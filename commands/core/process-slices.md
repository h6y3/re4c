---
description: Process vertical slices one sub-task at a time with approval gates, complexity tracking, and git integration
argument-hint: [slice-number or "start with task X.X" or "continue"]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "core"
last_updated: "2025-09-08"

# /process-slices - Implement Vertical Slices with Git Integration

**Purpose**: Methodically implement vertical slices with mandatory TDD, strict validation, and git workflow  
**Philosophy**: Test-first development, one sub-task at a time, commit per slice, mandatory validation gates  
**Previous Step**: Complete `/generate-slices` first  
**Usage**: Controlled implementation with TDD enforcement, multi-agent validation, and retrospectives

Process the vertical slice task list using structured implementation with approval gates.

## Execution Protocol

### Starting Options

1. **Begin from start**: `/process-slices` or `/process-slices 0`
2. **Start specific slice**: `/process-slices 2` (starts with Slice 2)
3. **Resume specific task**: `/process-slices "start with task 2.3"`
4. **Continue from last**: `/process-slices continue`

### Pre-Flight Checklist

Before starting any implementation:
1. **Locate task file**: Find most recent `tasks-*.md` in `/tasks/`
2. **Check complexity budget**: Note remaining complexity points
3. **Verify deployment**: Ensure Slice 0 deployed successfully (if past it)
4. **Review circuit breakers**: Note fallback options for current slice
5. **Git status check**: Ensure clean working directory or expected state
6. **🔧 MANDATORY: Initialize TDD Agent**: Run `/tdd-test-first [slice-name]` for test-first development
7. **🔍 Check MCP Context7**: Ensure context7 MCP available for API/framework knowledge
8. **🎭 Verify Playwright**: Confirm Playwright installed for web application testing
9. **📁 Discover Development Scripts**: Check for `/scripts` directory and consult user on non-build scripts

## Implementation Workflow

### Sub-Task Execution (One at a Time)

**CRITICAL RULE**: Do **NOT** start the next sub-task until receiving "yes" or "y" approval

1. **Read sub-task** from the task list
2. **Announce intent**: 
   ```
   "Starting Task X.X: [task description]
   Complexity impact: [if applicable]
   Circuit breaker available: [yes/no - what it is]"
   ```
3. **🧪 MANDATORY: Write Tests First (RED)**:
   - Follow TDD Red-Green-Refactor cycle
   - Write failing tests that define desired behavior
   - No implementation until tests exist and fail appropriately
   - Use Playwright for UI testing (mandatory for web apps)
   
4. **Implement the sub-task (GREEN)**:
   - Write minimal code to make tests pass
   - Follow existing code patterns where found
   - Use simplest approach that works
   - Apply circuit breaker if primary approach fails
   - Document any deviations from plan
   
5. **🔧 Refactor (REFACTOR)**:
   - Improve code quality while keeping tests green
   - Optimize performance without changing behavior
   - Ensure proper error handling and logging

6. **Update task list immediately**:
   - Mark sub-task complete: `[ ]` → `[x]`
   - Add any newly discovered tasks
   - Update "Relevant Files" section
   - Note if circuit breaker was used

7. **📸 Take Playwright Screenshots** (for UI changes):
   - Capture screenshots of key UI states
   - Verify responsive design across breakpoints
   - Test user interactions and workflows
   
8. **Report completion**:
   ```
   "✓ Task X.X complete
   Files modified: [list]
   Tests status: [ALL TESTS MUST PASS]
   Screenshots: [if UI work - list key screenshots taken]
   Ready for next task? (yes/y to continue)"
   ```

9. **STOP and WAIT** for user approval

### 🚨 MANDATORY: Slice Completion Validation Protocol

When ALL sub-tasks in a slice are marked `[x]`, **NO SLICE IS COMPLETE** until validation passes:

1. **🔍 MANDATORY: Multi-Agent Validation**:
   ```bash
   /validate-slice-completion [slice-name]
   ```
   **BLOCKING**: Must receive unanimous approval from all applicable agents:
   - Architecture Validation Agent (always required)
   - TDD Validation Agent (always required for code changes)
   - UI Testing Agent (required for UI work)
   - UX Evaluation Agent (required for new UI features)
   - Cleanup Validation Agent (always required)

2. **🧪 Test Suite Validation**:
   - All tests MUST pass (unit, integration, E2E)
   - Playwright tests MUST pass with screenshots
   - Test coverage MUST meet project standards
   - NO failing tests allowed without explicit user override

3. **🧹 Workspace Cleanup Validation**:
   ```bash
   /cleanup-workspace-agent
   ```
   **BLOCKING**: Repository must be pristine:
   - No coordination documents in codebase
   - No git worktrees active
   - No temporary or debug files committed
   - All development scripts properly organized

4. **🌐 Production URL Verification**:
   - **CORRECT**: Use `https://mend-delta.vercel.app` (production URL)
   - **INCORRECT**: Never use development URLs like `mend-idk45n8bq-...`
   - Test with actual production environment when applicable

**ONLY AFTER ALL VALIDATION AGENTS APPROVE:**

5. **Stage Changes**:
   ```bash
   git add .
   ```

6. **Commit with Slice Context**:
   ```bash
   git commit -m "feat(slice-X): [slice name] - [what it delivers]" \
              -m "Complexity: X points (Total used: Y/Z)" \
              -m "- [Key implementation detail 1]" \
              -m "- [Key implementation detail 2]" \
              -m "- Tests: [TDD cycle completed, all tests pass]" \
              -m "- Validation: [All agents approved]" \
              -m "- Screenshots: [Playwright screenshots taken]" \
              -m "Circuit breaker: [if used, what fallback]" \
              -m "Demo: [how to demo this slice]" \
              -m "Related to: [PRD reference]"
   ```

7. **Deploy Slice** (if applicable):
   ```bash
   npm run deploy  # or git push for auto-deploy
   ```
   - Verify deployment successful with CORRECT URL
   - Test the deployed slice functionality
   - Use Playwright to validate deployment

8. **📝 MANDATORY: Slice Retrospective**:
   ```bash
   /slice-retrospective [slice-name]
   ```
   **REQUIRED**: Capture lessons learned and update project plans
   - Document what was learned during implementation
   - Update task priorities based on new insights
   - Record decisions and trade-offs made
   - Update project understanding for future slices

9. **Update Slice Status**:
   - Mark parent slice complete: `[ ]` → `[x]`
   - Update complexity tracking:
     ```markdown
     ## Progress Tracking
     - [x] Slice 0 Complete (Complexity spent: 1/10) ✓ Deployed
     - [x] Slice 1 Complete (Complexity spent: 3/10) ✓ Deployed  
     - [ ] Slice 2 In Progress (Complexity spent: 3/10)
     ```

10. **Slice Handoff Report**:
   ```
   "🎯 Slice X Complete!
   
   ✅ Validation: All agents approved
   ✅ Tests: TDD cycle completed, all tests pass
   ✅ Screenshots: Playwright validation complete
   ✅ Cleanup: Workspace validated and clean
   ✅ Retrospective: Lessons captured and plans updated
   
   Delivered: [what user can now do]
   Deployment: [CORRECT production URL if applicable]
   Complexity used: X points (Y remaining)
   
   Ready to start Slice X+1? (yes/y to continue)"
   ```

## Complexity Management During Implementation

### Monitoring Complexity Budget

After each sub-task:
- Track if implementation is harder than expected
- Note if approaching complexity limit for slice
- Warn if circuit breaker might be needed

```
"⚠️ Complexity Warning:
This task is proving more complex than budgeted.
Estimated: 2 points, Actual: ~4 points
Remaining budget: X points
Recommend: [Use circuit breaker / Simplify approach / Cut scope]"
```

### Circuit Breaker Activation

When to activate circuit breaker:
1. **Time-boxed failure**: 30 minutes without progress
2. **Complexity overflow**: Task exceeds slice budget
3. **External dependency issues**: API down, service unavailable
4. **Deployment blockers**: Platform-specific constraints hit

Circuit breaker protocol:
```
"🔌 Activating Circuit Breaker for Task X.X
Reason: [specific issue]
Original approach: [what was attempted]
Fallback approach: [simpler alternative]
Impact: [what features are reduced]

Proceed with fallback? (yes/y)"
```

## Task List Maintenance

### Real-Time Updates

The task list file must be updated after:
1. **Each sub-task completion** → Mark `[x]`
2. **Each slice completion** → Update progress tracking
3. **Circuit breaker activation** → Note in task description
4. **New task discovery** → Add to appropriate slice
5. **File creation/modification** → Update "Relevant Files"

### File Tracking Format

```markdown
## Relevant Files by Slice

### Slice 0: [Name] (Complexity: 1, Total: 1) ✓ COMPLETE
- `app/page.tsx` - Main page with static mockup [CREATED]
- `public/mock-data.json` - Sample data for UI [CREATED]
- `app/page.test.tsx` - Smoke test [CREATED]

### Slice 1: [Name] (Complexity: 2, Total: 3) 🚧 IN PROGRESS
- `components/Form.tsx` - Input form component [CREATED]
- `hooks/useFormState.ts` - State management [IN PROGRESS]
- `components/Form.test.tsx` - Interaction tests [PENDING]
```

## Recovery and Continuation

### Resuming After Interruption

When returning to work:
1. **Check git status**: 
   ```bash
   git status
   git diff
   ```

2. **Review task list**: Find last completed task

3. **Verify deployment status**: Check if last slice deploys

4. **Resume with announcement**:
   ```
   "Resuming from Task X.X
   Last completed: [task description]
   Slice status: [X/Y tasks complete]
   Complexity remaining: [Z points]
   
   Continue with Task X.X+1? (yes/y)"
   ```

### Handling Failures

If a slice cannot be completed:
1. **Document the blocker** in task list
2. **Commit partial work** with `WIP:` prefix
3. **Skip to next slice** if independent
4. **Or activate circuit breaker** for simpler version

## Git Commit Templates by Slice

### Slice 0 - Static Mockup
```bash
git commit -m "feat(slice-0): static mockup with full UI" \
           -m "Complexity: 1 point (Total: 1/10)" \
           -m "- Created route structure and layout" \
           -m "- Added mock data for all UI elements" \
           -m "- Styled with Tailwind CSS" \
           -m "Demo: Visit /feature to see static version"
```

### Slice 1 - Interactive State
```bash
git commit -m "feat(slice-1): interactive client-side functionality" \
           -m "Complexity: 2 points (Total: 3/10)" \
           -m "- Added React state management" \
           -m "- Wired up form inputs and validation" \
           -m "- Created optimistic UI updates" \
           -m "Demo: Can now interact with feature (doesn't persist)"
```

### Slice 2 - Persistence
```bash
git commit -m "feat(slice-2): add data persistence layer" \
           -m "Complexity: 4 points (Total: 7/10)" \
           -m "- Set up database schema" \
           -m "- Created CRUD API routes" \
           -m "- Integrated frontend with backend" \
           -m "Demo: Actions now persist across refresh"
```

## Interaction Examples

### Starting Fresh
```
/process-slices

> "Loading tasks-prd-editor.md
> Complexity budget: 10 points
> Starting with Slice 0, Task 0.1: Create route structure
> Ready to begin? (yes/y)"

yes

> [Implements task 0.1]
> "✓ Task 0.1 complete
> Files modified: app/editor/page.tsx
> Ready for task 0.2? (yes/y)"
```

### Resuming Work
```
/process-slices continue

> "Resuming from Task 2.3
> Last completed: Set up database schema
> Slice 2 status: 2/6 tasks complete  
> Complexity remaining: 3 points
> Continue with Task 2.4: Create API routes? (yes/y)"
```

### Activating Circuit Breaker
```
> "⚠️ Task 3.2 failing: External API returning 503
> Time spent: 35 minutes
> 
> 🔌 Activating Circuit Breaker
> Fallback: Use mock responses instead
> Impact: No live data, but feature remains testable
> 
> Proceed with mock implementation? (yes/y)"
```

## Success Metrics

Track these metrics per slice:
- **Deployment success**: Does it deploy?
- **Demo readiness**: Can you show it working?
- **Test coverage**: At least one test per slice
- **Complexity accuracy**: Actual vs. estimated
- **Circuit breakers used**: Which fallbacks activated

## Resource Utilization Requirements

### 🔧 MCP Context7 Integration
**MANDATORY**: Always use MCP context7 for API and framework knowledge:
- Query context7 for API documentation and examples
- Verify framework best practices through context7
- Use context7 for troubleshooting integration issues
- **Reminder**: "Use MCP context7 to verify this API usage pattern"

### 🎭 Playwright Navigation 
**MANDATORY**: For web applications, use Playwright for testing:
- Navigate to sites under test with Playwright
- Take screenshots for visual validation
- Test user interactions and workflows
- Validate responsive design across breakpoints
- **Reminder**: "Use Playwright to navigate and validate this functionality"

### 📁 Development Scripts Discovery
**MANDATORY**: Check and utilize development scripts:
- Auto-discover `/scripts` directory at project start
- Ask user about non-build scripts found
- Use existing scripts instead of recreating functionality
- Document script usage in development guides
- **Reminder**: "Check for existing scripts before implementing tooling"

### 🌐 URL Management Protocol
**CRITICAL**: Always use correct URLs:
- ✅ **Production**: `https://mend-delta.vercel.app`
- ❌ **Never use**: Development URLs like `mend-idk45n8bq-han-yuans-projects-6008ef83.vercel.app`
- Verify URL correctness before testing
- Use production URLs for final validation

## Validation Agent Authority

### 🚨 Blocking Authority
**CRITICAL**: The following have authority to BLOCK slice completion:
- Architecture Validation Agent
- TDD Validation Agent  
- UI Testing Agent (for UI work)
- UX Evaluation Agent (for new UI features)
- Cleanup Validation Agent

### Override Requirements
**Only with explicit user approval:**
- Clear justification required for any override
- Risk assessment provided to user
- Mitigation plan documented
- Override recorded in retrospective

## Final Notes

1. **🧪 TDD is mandatory** - No code without tests first (Red-Green-Refactor)
2. **🔍 Validation gates are blocking** - No completion without agent approval
3. **🎭 Playwright is required** - All web UI must be tested with screenshots
4. **🧹 Cleanup is mandatory** - Repository must be pristine before completion
5. **📝 Retrospectives are required** - Every slice must capture learnings
6. **🔧 Use available resources** - MCP context7, Playwright, existing scripts
7. **🌐 Use correct URLs** - Always production URLs, never development
8. **Always maintain deployable state** - Never commit broken code
9. **Prefer working features over perfect code** - Ship, then refine
10. **Use circuit breakers liberally** - Simple working > complex broken
11. **Document surprises** - Add notes when reality differs from plan
12. **Celebrate slice completions** - Each slice is a victory

This workflow ensures methodical progress with mandatory TDD, strict validation gates, comprehensive testing, and systematic knowledge capture throughout the implementation.


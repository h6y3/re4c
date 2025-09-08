---
description: Generate vertical slice task list from PRD using complexity-aware Shape Up workflow
argument-hint: [prd-filename] [complexity-budget: 1-32]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "core"
last_updated: "2025-09-08"

# /generate-slices - Complexity-Aware Vertical Slice Task Generation

**Purpose**: Transform PRD, DRD, and TRD into implementable vertical slices with TDD-first complexity budgeting and validation requirements  
**Philosophy**: Test-first development, fixed complexity budget, variable scope - ship validated, tested software at each slice  
**Previous Steps**: Complete `/create-prd`, optionally `/create-drd` and `/create-trd` first  
**Next Step**: Use `/process-slices` with mandatory TDD and validation framework

Generate a complexity-aware task list driven by design and technical requirements using vertical slices that each deliver demonstrable value.

If not explicitly told which documents to use:
- List available PRDs from `/tasks` directory (files starting with `prd-`)
- Check for corresponding DRDs (`drd-*.md`) and TRDs (`trd-*.md`)
- Exclude any that already have corresponding task lists (`tasks-prd-*.md`)
- **Always** ask user to confirm document selection before proceeding
- Provide numbered options for easy selection
- **Recommend creating DRD/TRD if missing**: "I notice you don't have a DRD/TRD for this PRD. Would you like to create them first? This will result in better-informed implementation tasks."

## Process (Two-Phase Workflow)

### Phase 1: Analysis and Slice Planning

1. **Receive Document References:** User specifies PRD file and complexity budget, with optional DRD/TRD
   - Default complexity budget: 10 points if not specified
   - Validate budget is between 1-32 points
   - Load PRD, DRD (if available), and TRD (if available)

2. **Analyze Requirements:** Read and understand business, design, and technical requirements
   
   **From PRD:**
   - Identify core user flow that demonstrates primary value
   - List all mentioned features and requirements
   - Note future requirements that affect architecture decisions
   
   **From DRD (if available):**
   - Review component hierarchy and user journey maps
   - Understand visual complexity and interaction patterns  
   - Note design system requirements and responsive considerations
   - Identify design circuit breakers and fallback options
   
   **From TRD (if available):**
   - Review system architecture and data models
   - Understand technical complexity and integration requirements
   - Note performance, security, and scalability constraints
   - Identify technical circuit breakers and simplification strategies

3. **Assess Current State:** Review existing codebase against design and technical requirements
   - **Design Assessment (enhanced by DRD):**
     - Identify existing component libraries and design patterns
     - Note current responsive design and accessibility implementations
     - Document existing user experience patterns
   - **Technical Assessment (enhanced by TRD):**
     - Identify existing architecture patterns and technology stack
     - Note current database schema and API structures
     - Document existing authentication, security, and deployment setup
     - List current testing and monitoring infrastructure

4. **🧪 TDD-Aware Complexity Assessment:** Calculate complexity using enhanced model incorporating DRD/TRD insights and mandatory testing requirements
   ```
   Layer 0: Static (1 pt) - No runtime logic, pure UI + component tests + Playwright screenshots
   Layer 1: Interactive (2 pts) - Client state, no persistence + unit tests + integration tests + Playwright interactions  
   Layer 2: Persistent (4 pts) - Single data source, CRUD + API tests + database tests + E2E tests
   Layer 3: Integrated (8 pts) - Multiple services, sync coordination + contract tests + integration tests + system tests
   Layer 4: Orchestrated (16 pts) - Workflows, async state machines + comprehensive test pyramid + performance tests
   Layer 5: Distributed (32 pts) - Multi-deployment, event-driven + distributed testing + chaos testing
   ```
   
   **Enhanced Complexity Factors (from DRD/TRD + Testing Requirements):**
   - **Design Complexity:** Component hierarchy depth, interaction complexity, responsive requirements + UI testing requirements
   - **Technical Complexity:** Data model relationships, API integrations, performance requirements + API testing complexity
   - **Integration Complexity:** External service dependencies, real-time requirements, security constraints + E2E testing needs
   - **🧪 Testing Complexity:** TDD requirements, test pyramid completeness, Playwright UI testing, validation framework overhead
   
   Present integrated assessment to user:
   - **Business Requirements (PRD):** X points needed for core functionality
   - **Design Requirements (DRD):** Y points for visual and interaction requirements
   - **Technical Requirements (TRD):** Z points for architecture and integrations
   - **🧪 Testing Requirements:** A points for TDD, Playwright, and validation overhead
   - **🔍 Validation Requirements:** B points for multi-agent validation processes
   - **Total Complexity:** Combined complexity estimate (X+Y+Z+A+B)
   - **Available budget:** User-specified points
   - **Recommendation:** What can be achieved within budget, emphasizing testing and validation requirements

5. **Generate DRD/TRD-Driven Parent Slices:** Create vertical slices based on design and technical requirements
   
   **Slice Definition Strategy:**
   - Each slice must deliver user-visible value (PRD-driven)
   - Each slice must be independently deployable/demoable
   - Slice boundaries follow component hierarchy from DRD (when available)
   - Technical complexity follows data flow from TRD (when available)
   - Order slices by value delivery prioritized by business requirements
   
   **🧪 Enhanced "Test-First, Fake High, Make Low" Pattern:**
   - **Slice 0:** Static mockup using DRD component hierarchy (Layer 0) + component tests + Playwright screenshots
   - **Slice 1:** Add interactions following DRD user flows (Layer 1) + interaction tests + Playwright user flows
   - **Slice 2:** Add persistence following TRD data models (Layer 2) + API tests + database tests + E2E validation  
   - **Slice 3+:** Add integrations per TRD architecture (Layer 3+) + contract tests + system tests + validation gates
   
   **Fallback Strategy (when DRD/TRD unavailable):**
   - Generate slices based on PRD requirements only
   - Make educated guesses about component hierarchy
   - Use standard technical patterns for data and integrations
   
   **Present slices and wait for confirmation:**
   ```
   "I've generated X vertical slices within your complexity budget of Y points.
   Each slice delivers working, demoable functionality.
   Ready to break these down into implementation tasks? Respond with 'Go' to proceed."
   ```

### Phase 2: Task Breakdown

6. **Wait for Confirmation:** Pause for user "Go" response

7. **Generate Sub-Tasks per Slice:** For each parent slice, create implementation tasks
   - Group tasks by slice, not by technical layer
   - Each sub-task should be completable in one sitting
   - Include "Definition of Done" for each slice
   - Add circuit breaker/fallback for each risky task
   
   Sub-task categories per slice:
   - Setup tasks (routes, components, configs)
   - Core functionality tasks
   - Integration tasks (if applicable)
   - Testing task (at least one per slice)
   - Deployment verification task

8. **Identify Relevant Files:** List all files to be created/modified
   - Group by slice for clarity
   - Include test files alongside implementation files
   - Note any configuration files needed
   - Flag any files that might hit deployment limits

9. **Add Complexity Metadata:** Include complexity tracking
   - Running complexity total after each slice
   - Remaining budget
   - Simplification options if over budget

10. **Save Task List:** Save to `/tasks/` directory
    - Filename: `tasks-[prd-file-name].md`
    - Include complexity budget in file header
    - Add creation timestamp

## Output Format (Required Structure)

```markdown
# Task List: [Feature Name]
**Generated from:** `[prd-filename]` + `[drd-filename]` + `[trd-filename]`  
**Date:** [timestamp]  
**Complexity Budget:** [X] points  
**Estimated Complexity:** [Y] points  
**Slices:** [N] vertical slices

## Requirements Integration

### Business Requirements (from PRD)
- Core user value: [Primary value proposition]
- Key features: [Essential feature list]
- Success metrics: [How success is measured]

### Design Requirements (from DRD - if available)
- Component architecture: [Key UI components and hierarchy]
- User experience patterns: [Critical user flows and interactions]
- Visual complexity: [Design system requirements]
- Responsive requirements: [Mobile/tablet considerations]

### Technical Requirements (from TRD - if available)  
- System architecture: [Key technical decisions]
- Data requirements: [Database and API patterns]
- Integration requirements: [External services and complexity]
- Performance constraints: [Speed and scale requirements]

### 🧪 Testing Requirements (Mandatory)
- TDD approach: All slices follow Red-Green-Refactor cycle
- Test pyramid: Unit → Integration → E2E testing required
- Playwright testing: Mandatory for web UI with screenshots
- Validation framework: Multi-agent validation for each slice completion

### 🔍 Validation Requirements (Mandatory)  
- Architecture validation: Technical implementation review
- TDD validation: Test-first development compliance
- UI testing validation: Playwright test execution and screenshots
- Cleanup validation: Repository integrity and workspace cleanliness
- Retrospective requirement: Learning capture after each slice

## Integrated Complexity Assessment

### Combined Requirements Analysis
- **Business Complexity (PRD):** [X] points for core functionality
- **Design Complexity (DRD):** [Y] points for UI/UX requirements  
- **Technical Complexity (TRD):** [Z] points for architecture/integrations
- **🧪 Testing Complexity:** [A] points for TDD, Playwright, test pyramid
- **🔍 Validation Complexity:** [B] points for multi-agent validation overhead
- **Total Estimated:** [X+Y+Z+A+B] points
- **Available Budget:** [Budget] points

### Layer-by-Layer Breakdown
- Layer 0 (Static): ✓ Included - [Design mockups from DRD]
- Layer 1 (Interactive): ✓ Included - [User interactions from DRD]
- Layer 2 (Persistent): ✓ Included - [Data models from TRD]
- Layer 3 (Integrated): ⚠️ Partial - [External services from TRD]
- Layer 4 (Orchestrated): ✗ Exceeds budget - [Complex workflows excluded]

### Simplification Strategy (Circuit Breakers Applied)
- **Design Fallbacks:** [Which DRD circuit breakers were activated]
- **Technical Fallbacks:** [Which TRD circuit breakers were activated]  
- **Scope Reductions:** [What was cut to fit budget]

## Relevant Files by Slice

### Slice 0: [Name] (Complexity: 1, Total: 1)
- `app/[feature]/page.tsx` - Main page with static mockup
- `app/[feature]/page.test.tsx` - Smoke test for route
- `public/mock-data.json` - Sample data for UI

### Slice 1: [Name] (Complexity: 2, Total: 3)
- `app/[feature]/components/[Component].tsx` - Interactive component
- `app/[feature]/hooks/use[Feature].ts` - State management
- `app/[feature]/components/[Component].test.tsx` - Interaction tests

### Slice 2: [Name] (Complexity: 4, Total: 7)
[Continue pattern...]

## Vertical Slices

### ✓ Slice 0: "See It" - Static Mockup (Complexity: 1, Running Total: 1)
**Goal:** Deploy working URL with complete UI following DRD design specifications  
**Demo:** User can navigate to URL and see the feature interface matching DRD mockups  
**🧪 TDD Requirements:** Component tests written first, Playwright screenshots taken
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + Cleanup validation required
**Definition of Done:** Deployed to Vercel, all UI elements visible per DRD component hierarchy, all tests pass, validation agents approve
**Driven by:** DRD component architecture and visual design specifications

- [ ] 0.1 🧪 Write component tests first (TDD RED phase)
- [ ] 0.2 Create route structure following DRD information architecture (TDD GREEN phase)
- [ ] 0.3 Build static UI components per DRD component hierarchy (TDD GREEN phase)
- [ ] 0.4 Apply DRD visual design system (colors, typography, spacing)
- [ ] 0.5 Add mock data matching DRD content structure
- [ ] 0.6 Implement DRD responsive design patterns (static)
- [ ] 0.7 🎭 Take Playwright screenshots of all UI states and responsive breakpoints
- [ ] 0.8 Deploy to Vercel with correct production URL and verify
- [ ] 0.9 🔧 Refactor code quality while keeping tests green (TDD REFACTOR phase)
- [ ] 0.10 🔍 Run validation agents (Architecture + TDD + UI Testing + Cleanup)
  - **Circuit Breaker:** If DRD unavailable, use standard component patterns

### ✓ Slice 1: "Use It" - Interactive State (Complexity: 2, Running Total: 3)
**Goal:** Make UI functional following DRD user flow specifications  
**Demo:** User can complete DRD-defined user journeys with client-side state  
**🧪 TDD Requirements:** Interaction tests written first, Playwright user flow testing
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + UX Evaluation + Cleanup validation required
**Definition of Done:** All DRD interaction patterns work in browser (doesn't persist), all tests pass, validation agents approve
**Driven by:** DRD user flows, interaction patterns, and state management requirements

- [ ] 1.1 Implement state management following DRD state diagrams
- [ ] 1.2 Wire up form interactions per DRD form specifications
- [ ] 1.3 Add client-side validation per DRD validation patterns
- [ ] 1.4 Implement DRD micro-interactions and transitions  
- [ ] 1.5 Create error handling following DRD error state designs
- [ ] 1.6 Add loading states per DRD loading patterns
- [ ] 1.7 Write interaction tests for DRD-defined user flows
  - **Circuit Breaker:** If DRD interactions too complex, use basic form patterns

### ✓ Slice 2: "Save It" - Add Persistence (Complexity: 4, Running Total: 7)
**Goal:** Data persists following TRD data architecture specifications  
**Demo:** User actions persist per TRD data flow, can return later  
**Definition of Done:** CRUD operations work per TRD database design
**Driven by:** TRD data models, API design, and persistence patterns

- [ ] 2.1 Implement database schema per TRD data model specifications
- [ ] 2.2 Create API routes following TRD API design patterns
- [ ] 2.3 Replace mock data with TRD-specified database queries
- [ ] 2.4 Add authentication/authorization per TRD security requirements
- [ ] 2.5 Implement error handling per TRD error handling strategies
- [ ] 2.6 Add caching layers per TRD caching specifications  
- [ ] 2.7 Write integration tests for TRD API contracts
  - **Circuit Breaker:** If TRD complexity too high, fallback to simple localStorage

### ⚠️ Slice 3: "Connect It" - External Integration (Complexity: 8, Running Total: 15)
**Goal:** Integrate external services per TRD integration architecture  
**Demo:** External integrations work per TRD-defined integration patterns  
**Definition of Done:** TRD integration requirements work in production with circuit breakers
**Driven by:** TRD integration specifications, security requirements, and performance constraints

- [ ] 3.1 Implement TRD-specified API client architecture and authentication
- [ ] 3.2 Create service integration layer per TRD integration patterns
- [ ] 3.3 Add error boundaries following TRD error handling strategies
- [ ] 3.4 Implement TRD retry logic and circuit breaker patterns
- [ ] 3.5 Create fallback UI per TRD circuit breaker specifications
- [ ] 3.6 Add monitoring and logging per TRD observability requirements
- [ ] 3.7 Write tests with mocked service responses per TRD testing strategy
  - **Circuit Breaker:** If TRD integrations too complex, use TRD-specified mock responses

### ✗ Slice 4: "Automate It" - Workflows (Complexity: 16, Total: 31 - EXCEEDS BUDGET)
**Status:** NOT IMPLEMENTED - Exceeds complexity budget  
**Alternative:** Could be added in future iteration or simplified to polling

[Document what would have been included but is cut for budget]

## Implementation Notes

### Testing Strategy
- Each slice includes at least one test
- Slice 0: Smoke test (route renders)
- Slice 1: Interaction test (state changes)
- Slice 2: Integration test (API + database)
- Slice 3+: Service integration tests (with mocks)

### Deployment Checkpoints
- After each slice, deploy and verify
- Maintain working demo URL throughout
- Never break previously working functionality

### Complexity Escape Hatches
If running over budget during implementation:
1. **Slice 3 too complex?** → Mock the external service
2. **Slice 2 database issues?** → Use localStorage
3. **Slice 1 state complex?** → Simplify to essential interactions
4. **Slice 0 deployment fails?** → Run locally for demo

### For Junior Developers
- Start with Slice 0 - get something deployed first
- Each slice builds on the previous - don't skip ahead
- If stuck, implement the circuit breaker (simpler alternative)
- Tests can be simple - just verify the happy path
- Ask for help before spending >30 min on any single sub-task

## Progress Tracking
- [ ] Slice 0 Complete (Complexity spent: 1/[budget])
- [ ] Slice 1 Complete (Complexity spent: 3/[budget])
- [ ] Slice 2 Complete (Complexity spent: 7/[budget])
- [ ] Slice 3 Complete (Complexity spent: 15/[budget])

## Next Steps
Run `/process-slices 0` to begin implementation with Slice 0
```

## Interaction Model

The process maintains the two-phase approach:
1. Generate parent slices → Get user confirmation ("Go")
2. Generate detailed sub-tasks → Ready for implementation

This ensures alignment before diving into details while maintaining vertical slice discipline.

## Key Improvements Over Original

1. **Requirements-Driven Slices**: Slices now follow DRD component hierarchy and TRD technical architecture instead of ad-hoc decisions
2. **Integrated Complexity Assessment**: Combines business (PRD), design (DRD), and technical (TRD) complexity for accurate estimation
3. **Circuit Breakers at Multiple Levels**: Design fallbacks (DRD), technical fallbacks (TRD), and scope fallbacks (PRD)
4. **One-Way Door Prevention**: DRD and TRD analysis ensures future requirements don't get blocked by early decisions
5. **Concrete Implementation Guidance**: Tasks reference specific DRD components and TRD architecture instead of generic patterns
6. **Backward Compatibility**: Falls back to PRD-only approach when DRD/TRD unavailable
7. **Enhanced "Fake High, Make Low"**: Each slice follows actual design and technical patterns rather than guessed patterns

## Target Audience

Primary: **Junior developers** who need clear, achievable tasks with fallback options  
Secondary: **AI agents** that can follow structured complexity assessments

## Usage Example

```bash
/generate-slices prd-code-editor.md 10

# Output: 3 slices within 10-point budget
# Slice 0: Static editor UI (1 pt)
# Slice 1: Syntax highlighting (2 pts)  
# Slice 2: Save/load files (4 pts)
# Slice 3: Share via URL (3 pts)
# Total: 10 points allocated

# Slice 4: Real-time collaboration (8 pts) - EXCLUDED, would exceed budget
```


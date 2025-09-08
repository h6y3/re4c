---
description: Generate structured task list from existing PRD using two-phase workflow
argument-hint: [prd-filename or leave empty to see available PRDs]
---
version: "1.1.0"
re4c_version: "1.1.0"
category: "core"
last_updated: "2025-09-08"

# /generate-tasks - Enhanced AI Dev Tasks Workflow
**Source**: ai-dev-tasks repository workflow (enhanced with DRD/TRD integration + TDD validation framework)  
**Purpose**: Generate TDD-first task list from PRD, DRD, and TRD with mandatory testing and validation requirements  
**Previous Steps**: Complete `/create-prd`, optionally `/create-drd` and `/create-trd` first  
**Next Step**: Use `/process-slices` with mandatory TDD and validation framework

Please generate TDD-first tasks driven by design and technical requirements with mandatory validation and testing integrated throughout.

If not explicitly told which documents to use:
- List available PRDs from `/tasks` directory (files starting with `prd-`)
- Check for corresponding DRDs (`drd-*.md`) and TRDs (`trd-*.md`)
- Exclude any that already have corresponding task lists (`tasks-prd-*.md`)
- **Always** ask user to confirm document selection before proceeding
- Provide numbered options for easy selection
- **Recommend creating DRD/TRD if missing**: "I notice you don't have a DRD/TRD for this PRD. Would you like to create them first? This will result in more concrete implementation tasks with fewer on-the-fly decisions."

## Process (Enhanced with DRD/TRD Integration)

1. **Receive Document References:** User specifies PRD file with optional DRD/TRD files
   - Load PRD for business requirements
   - Load DRD (if available) for design specifications  
   - Load TRD (if available) for technical architecture

2. **Analyze Integrated Requirements:** Read and understand business, design, and technical requirements
   
   **From PRD:**
   - Identify functional requirements and user stories
   - Extract success criteria and business constraints
   - Note future requirements that affect implementation decisions
   
   **From DRD (if available):**
   - Review component hierarchy and design system requirements
   - Understand user experience patterns and interaction flows
   - Note visual complexity and responsive design requirements
   - Identify design circuit breakers and fallback options
   
   **From TRD (if available):**
   - Review system architecture and technical constraints
   - Understand data models, API design, and integration requirements
   - Note performance, security, and scalability constraints  
   - Identify technical circuit breakers and simplification strategies

3. **Assess Current State:** Review existing codebase against integrated requirements
   - **Design Assessment (enhanced by DRD):**
     - Identify existing component libraries and design patterns
     - Note current design system implementation and gaps
     - Document existing user experience patterns and conventions
   - **Technical Assessment (enhanced by TRD):**
     - Identify existing architecture patterns and technology stack
     - Note current database schema, API structures, and integrations
     - Document existing testing, deployment, and monitoring setup
   - **Gap Analysis:**
     - Identify what needs to be created vs. modified
     - Note where existing patterns align with DRD/TRD specifications
     - Document areas where circuit breakers might be needed

4. **Phase 1: Generate Requirements-Driven Parent Tasks:** Based on integrated requirements analysis
   - Create high-level tasks that align with DRD component boundaries (when available)
   - Ensure tasks follow TRD technical architecture (when available)  
   - Maintain PRD functional requirements as the driving business value
   - Use your judgment on task count (~5 tasks), but follow DRD/TRD structure when available
   - Present these tasks with their DRD/TRD justification
   - **Fallback Strategy:** When DRD/TRD unavailable, generate PRD-based tasks with noted assumptions
   - Inform the user: "I have generated high-level tasks based on [PRD + DRD + TRD / PRD only]. Ready to generate the sub-tasks? Respond with 'Go' to proceed."

5. **Wait for Confirmation:** Pause and wait for the user to respond with "Go".

6. **Phase 2: Generate TDD-First Implementation Sub-Tasks:** Break down each parent task with DRD/TRD guidance and mandatory testing
   - **🧪 TDD Sub-tasks:** All sub-tasks must follow Red-Green-Refactor cycle with tests written first
   - **Design-Driven Sub-tasks:** Follow DRD component specifications with component tests and Playwright validation
   - **Technical-Driven Sub-tasks:** Follow TRD data models, API design with unit tests, integration tests, and API tests
   - **Integration Sub-tasks:** Connect DRD frontend with TRD backend using contract tests and E2E validation
   - **🎭 Playwright Sub-tasks:** UI testing with screenshots for all user-facing work (mandatory for web apps)
   - **🔍 Validation Sub-tasks:** Include validation agent requirements at task completion points
   - **Circuit Breaker Sub-tasks:** Include fallback approaches from DRD/TRD when complexity is high
   - **Backward Compatibility:** Generate reasonable sub-tasks when DRD/TRD unavailable

7. **Identify Requirements-Driven Relevant Files:** List files based on integrated requirements with mandatory testing
   - **From DRD:** Component files, style files, asset files based on design hierarchy + component test files
   - **From TRD:** Data model files, API files, configuration files based on technical architecture + API test files + integration test files
   - **From PRD:** Business logic files, integration files based on functional requirements + unit test files
   - **🧪 TDD Test Files:** Corresponding test files for ALL implementation files (mandatory)
   - **🎭 Playwright Files:** E2E test files and screenshot validation for web UI (mandatory)
   - **🔍 Validation Files:** Validation and retrospective documentation files
   - **Fallback:** Standard file patterns when DRD/TRD unavailable

8. **Generate Enhanced Final Output:** Combine all elements with requirements traceability
   - Show how tasks trace back to PRD, DRD, and TRD requirements
   - Include circuit breaker options and simplification strategies
   - Document assumptions made when requirements are missing

9. **Save Enhanced Task List:** Save to `/tasks/` directory with enhanced metadata
   - Filename: `tasks-[prd-file-name].md` (maintains compatibility)
   - Include references to all source documents (PRD, DRD, TRD)
   - Add creation timestamp and requirements traceability

## Output Format (Enhanced Structure)
The generated task list _must_ follow this enhanced structure with requirements traceability:

```markdown
# Task List: [Feature Name]
**Generated from:** `[prd-filename]` + `[drd-filename]` + `[trd-filename]`  
**Date:** [timestamp]  
**Source Documents:**
- **PRD:** Business requirements and functional specifications
- **DRD:** Design requirements and component architecture (if available)
- **TRD:** Technical requirements and system architecture (if available)

## Requirements Integration Summary

### Business Requirements (from PRD)
- **Core Functionality:** [Key business requirements that drive implementation]
- **User Stories:** [Primary user journeys that must be supported]
- **Success Criteria:** [How success will be measured]
- **Future Considerations:** [PRD requirements that affect current architecture decisions]

### Design Requirements (from DRD - if available)
- **Component Architecture:** [Key UI components and their relationships]
- **User Experience Patterns:** [Critical user flows and interaction models]
- **Design System Integration:** [Visual design and responsive requirements]
- **Design Circuit Breakers:** [Fallback options when design complexity is too high]

### Technical Requirements (from TRD - if available)
- **System Architecture:** [Key technical architecture decisions]
- **Data Models:** [Database schema and API design patterns]
- **Integration Patterns:** [External services and technical integrations]
- **Technical Circuit Breakers:** [Fallback options when technical complexity is too high]

### 🧪 Testing Requirements (Mandatory)
- **TDD Approach:** All tasks follow Red-Green-Refactor cycle with tests written first
- **Test Coverage:** Unit tests, integration tests, API tests, and E2E tests required
- **Playwright Testing:** Mandatory for web UI with screenshots and user flow validation
- **Test Strategy:** Comprehensive test pyramid from unit to system level

### 🔍 Validation Requirements (Mandatory)
- **Multi-Agent Validation:** Architecture, TDD, UI Testing, UX Evaluation, Cleanup agents required
- **Completion Gates:** No task completion without validation agent approval
- **Quality Standards:** All validation agents must approve before marking tasks complete
- **Retrospective Requirement:** Learning capture and plan updates after task completion

### Assumptions Made (when DRD/TRD unavailable)
- **Design Assumptions:** [What design decisions were assumed in absence of DRD]
- **Technical Assumptions:** [What technical decisions were assumed in absence of TRD]
- **Risk Areas:** [Where lack of DRD/TRD specifications might cause rework]

## Requirements-Driven Relevant Files

### Design Layer Files (from DRD specifications)
- `components/[Component].tsx` - [Component per DRD component hierarchy] (DRD: Component Architecture)
- `components/[Component].test.tsx` - Unit tests for component (Testing requirement)
- `styles/[feature].module.css` - [Styling per DRD design system] (DRD: Visual Design System)
- `types/ui.ts` - [TypeScript interfaces for DRD component props] (DRD: Component Specifications)

### Technical Layer Files (from TRD specifications)
- `lib/api/[feature].ts` - [API client per TRD API design] (TRD: API Architecture)
- `lib/api/[feature].test.ts` - API client tests (TRD: Testing Strategy)
- `lib/models/[Entity].ts` - [Data models per TRD database design] (TRD: Data Models)
- `lib/models/[Entity].test.ts` - Model tests (TRD: Testing Strategy)
- `pages/api/[endpoint].ts` - [API routes per TRD endpoint design] (TRD: API Design)

### Business Logic Files (from PRD requirements)
- `lib/[feature]/business-logic.ts` - [Core business logic per PRD requirements] (PRD: Functional Requirements)
- `lib/[feature]/business-logic.test.ts` - Business logic tests (PRD: Success Criteria)

### Integration Files (cross-cutting concerns)
- `lib/integrations/[service].ts` - [External service integration per TRD] (TRD: Integration Architecture)
- `middleware/[feature].ts` - [Request handling per TRD middleware design] (TRD: Security Requirements)

### Configuration Files
- `config/[feature].ts` - [Feature configuration per TRD] (TRD: Configuration Management)

### Fallback Files (when DRD/TRD unavailable)
- `components/[GuessedComponent].tsx` - [Assumed component structure] ⚠️ Design assumption
- `lib/api/[assumed-api].ts` - [Assumed API pattern] ⚠️ Technical assumption

### Notes

- **Requirements Traceability:** Each file references the source requirement (PRD/DRD/TRD section)
- **Testing Strategy:** Tests follow TRD testing patterns when available, or standard patterns otherwise
- **Circuit Breakers:** ⚠️ markers indicate assumptions that may need revision
- **Component Organization:** Follows DRD component hierarchy when available
- **API Organization:** Follows TRD API design patterns when available
- Use `npx jest [optional/path/to/test/file]` to run tests. Running without a path executes all tests found by the Jest configuration.

## Requirements-Driven Tasks

### Task Structure Enhancement
Each task now includes:
- **Requirement Source:** Which document (PRD/DRD/TRD) drives this task
- **🧪 TDD Requirements:** Test-first approach with Red-Green-Refactor cycle
- **🎭 Playwright Requirements:** UI testing with screenshots (for web UI tasks)
- **🔍 Validation Requirements:** Multi-agent validation before completion
- **Implementation Guidance:** Specific patterns/components from DRD/TRD to follow
- **Circuit Breakers:** Fallback approaches when complexity is too high
- **Success Criteria:** How to verify the task meets requirements including test passes

- [ ] 1.0 **Frontend Component Development** (Driven by: DRD Component Architecture)
  - **Goal:** Implement UI components following DRD component hierarchy and design system
  - **Circuit Breaker:** If DRD components too complex, use standard component patterns
  - **🧪 TDD Requirements:** All sub-tasks follow Red-Green-Refactor with component tests written first
  - **🎭 Playwright Requirements:** UI screenshots and interaction validation for web components
  - **🔍 Validation Requirements:** Architecture, TDD, UI Testing, and UX Evaluation agents must approve
  - [ ] 1.1 **🧪 TDD:** Write failing component tests, then create [MainComponent] following DRD specification (DRD: Component Architecture)
  - [ ] 1.2 **🧪 TDD:** Write visual regression tests, then implement DRD design system integration (DRD: Visual Design)
  - [ ] 1.3 **🧪 TDD:** Write responsive tests with Playwright, then add breakpoint behavior (DRD: Responsive Design)
  - [ ] 1.4 **🧪 TDD:** Write interaction tests, then implement DRD user patterns (DRD: User Experience)
  - [ ] 1.5 **🎭 Playwright:** Take screenshots of component states and validate user workflows (DRD: Testing Requirements)

- [ ] 2.0 **Backend Data Layer** (Driven by: TRD Data Architecture)
  - **Goal:** Implement data persistence following TRD data models and API design
  - **Circuit Breaker:** If TRD architecture too complex, use simple CRUD patterns
  - **🧪 TDD Requirements:** All sub-tasks follow Red-Green-Refactor with API tests written first
  - **🔍 Validation Requirements:** Architecture and TDD agents must approve all backend changes
  - [ ] 2.1 **🧪 TDD:** Write failing schema tests, then create database schema per TRD specifications (TRD: Data Models)
  - [ ] 2.2 **🧪 TDD:** Write failing API route tests, then implement TRD API design patterns (TRD: API Design)
  - [ ] 2.3 **🧪 TDD:** Write security tests, then add authentication/authorization per TRD requirements (TRD: Security Architecture)
  - [ ] 2.4 **🧪 TDD:** Write error handling tests, then implement TRD validation strategies (TRD: Error Handling)
  - [ ] 2.5 **🧪 TDD:** Create comprehensive integration tests for all TRD API contracts (TRD: Testing Strategy)

- [ ] 3.0 **Business Logic Implementation** (Driven by: PRD Functional Requirements)
  - **Goal:** Implement core business functionality meeting PRD success criteria  
  - **Circuit Breaker:** If business logic too complex, implement simplified MVP version
  - **🧪 TDD Requirements:** All sub-tasks follow Red-Green-Refactor with business logic tests written first
  - **🔍 Validation Requirements:** Architecture and TDD agents must approve all business logic changes
  - [ ] 3.1 **🧪 TDD:** Write failing business rule tests, then implement PRD functional requirements (PRD: Functional Requirements)
  - [ ] 3.2 **🧪 TDD:** Write failing workflow tests, then create logic supporting PRD user stories (PRD: User Stories)
  - [ ] 3.3 **🧪 TDD:** Write constraint validation tests, then add PRD business rule logic (PRD: Business Rules)
  - [ ] 3.4 **🧪 TDD:** Write metrics tracking tests, then implement PRD success criteria tracking (PRD: Success Metrics)
  - [ ] 3.5 **🧪 TDD:** Create comprehensive business logic tests validating all PRD acceptance criteria (PRD: Acceptance Criteria)

- [ ] 4.0 **Frontend-Backend Integration** (Driven by: DRD + TRD Integration)
  - **Goal:** Connect DRD frontend components with TRD backend services
  - **Circuit Breaker:** If integration too complex, use direct API calls without abstraction layers
  - **🧪 TDD Requirements:** All sub-tasks follow Red-Green-Refactor with integration tests written first
  - **🎭 Playwright Requirements:** End-to-end user flow testing with screenshots
  - **🔍 Validation Requirements:** Architecture, TDD, UI Testing, and UX Evaluation agents must approve
  - [ ] 4.1 **🧪 TDD:** Write failing integration tests, then connect DRD forms to TRD APIs (DRD: Forms + TRD: API Design)
  - [ ] 4.2 **🧪 TDD:** Write loading state tests, then implement DRD states for TRD operations (DRD: Loading States + TRD: Performance)
  - [ ] 4.3 **🧪 TDD:** Write error handling tests, then add DRD error handling for TRD failures (DRD: Error States + TRD: Error Handling)
  - [ ] 4.4 **🧪 TDD:** Write real-time update tests, then implement TRD real-time features (TRD: Real-time Requirements)
  - [ ] 4.5 **🎭 Playwright:** Create comprehensive end-to-end tests covering all DRD user flows with TRD backend (Integration Testing)

- [ ] 5.0 **External Integrations & Deployment** (Driven by: TRD Integration Architecture)
  - **Goal:** Implement external service integrations and deployment per TRD specifications
  - **Circuit Breaker:** If integrations too complex, use mock responses or simplified patterns
  - **🧪 TDD Requirements:** All sub-tasks follow Red-Green-Refactor with integration and deployment tests written first
  - **🔍 Validation Requirements:** Architecture and TDD agents must approve all integrations and deployment changes
  - [ ] 5.1 **🧪 TDD:** Write failing integration tests with mocks, then implement external service integrations per TRD patterns (TRD: Integration Architecture)
  - [ ] 5.2 **🧪 TDD:** Write monitoring tests, then add logging and observability per TRD requirements (TRD: Monitoring)
  - [ ] 5.3 **🧪 TDD:** Write deployment validation tests, then configure pipeline per TRD specifications (TRD: Deployment Architecture)
  - [ ] 5.4 **🧪 TDD:** Write security and performance tests, then implement TRD requirements (TRD: Security + Performance)
  - [ ] 5.5 **🧪 TDD:** Create comprehensive integration tests with external service mocks and contract testing (TRD: Testing Strategy)

### Fallback Tasks (when DRD/TRD unavailable)
⚠️ **Note:** If DRD/TRD documents are not available, tasks will be generated based on PRD requirements with reasonable assumptions. However, this increases the risk of rework and on-the-fly decision making during implementation.

- [ ] Fallback 1.0 **Frontend Development** (⚠️ Based on PRD + assumptions)
  - **🧪 TDD Requirements:** All fallback tasks still require Red-Green-Refactor cycle with tests written first
  - **🎭 Playwright Requirements:** UI testing with screenshots still mandatory for web components
  - **🔍 Validation Requirements:** All validation agents still must approve despite assumptions
  - [ ] 1.1 **🧪 TDD:** Write component tests first, then create UI components (⚠️ Assumed: Standard React component patterns)
  - [ ] 1.2 **🧪 TDD:** Write visual tests first, then implement styling (⚠️ Assumed: Tailwind CSS with standard design)
  - [ ] 1.3 **🎭 Playwright:** Write responsive tests with screenshots, then add behavior (⚠️ Assumed: Mobile-first responsive design)

- [ ] Fallback 2.0 **Backend Development** (⚠️ Based on PRD + assumptions)
  - **🧪 TDD Requirements:** All fallback tasks still require Red-Green-Refactor cycle with API tests written first
  - **🔍 Validation Requirements:** Architecture and TDD agents still must approve despite assumptions
  - [ ] 2.1 **🧪 TDD:** Write schema tests first, then create database schema (⚠️ Assumed: Standard relational model)
  - [ ] 2.2 **🧪 TDD:** Write API route tests first, then implement endpoints (⚠️ Assumed: RESTful API patterns)
  - [ ] 2.3 **🧪 TDD:** Write authentication tests first, then add authentication (⚠️ Assumed: Simple JWT authentication)
```

## Interaction Model
The process explicitly requires a pause after generating parent tasks to get user confirmation ("Go") before proceeding to generate the detailed sub-tasks. This ensures the high-level plan aligns with user expectations before diving into details.

## Target Audience
Assume the primary reader of the task list is a **junior developer** who will implement the feature with awareness of the existing codebase context.

## Output
- **Format:** Enhanced Markdown (`.md`) with requirements traceability
- **Location:** `/tasks/`
- **Filename:** `tasks-[prd-file-name].md` (maintains compatibility)
- **Content:** Includes references to all source documents (PRD, DRD, TRD)

## Key Improvements Over Original

1. **Requirements-Driven Tasks**: Tasks now follow DRD component hierarchy and TRD technical architecture instead of guessed patterns
2. **Explicit Requirements Traceability**: Each task references specific PRD/DRD/TRD sections that drive the implementation  
3. **Circuit Breakers at All Levels**: Design fallbacks (DRD), technical fallbacks (TRD), and scope fallbacks (PRD)
4. **One-Way Door Prevention**: DRD and TRD analysis ensures future requirements don't get blocked by implementation decisions
5. **Concrete Implementation Guidance**: Sub-tasks reference specific DRD components and TRD patterns instead of generic approaches
6. **Reduced On-the-Fly Decision Making**: Developers follow predetermined design and technical patterns rather than making up solutions
7. **Backward Compatibility**: Falls back to PRD-only approach when DRD/TRD unavailable, with clear assumption markers
8. **Enhanced Risk Management**: Clear identification of assumptions and areas where rework might be needed

## Integration Notes
- **Enhanced Compatibility**: Works with Claude Code's existing git workflow while adding requirements traceability
- **Improved File Organization**: Leverages Claude Code's file editing capabilities with DRD/TRD-driven file structure
- **Advanced Task Tracking**: Uses TodoWrite tool for internal task tracking with requirements context
- **Standards Compliance**: Follows conventional commit standards with requirements references in commit messages

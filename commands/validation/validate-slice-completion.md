---
description: Multi-agent validation system that blocks slice completion until all quality gates pass with user approval override only
argument-hint: [slice-name or leave empty for current slice]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "validation"
last_updated: "2025-09-08"

# /validate-slice-completion - Strict Multi-Agent Validation System

**Purpose**: Prevent premature slice completion through comprehensive multi-agent validation with mandatory quality gates

**Philosophy**: Bias towards blocking completion unless explicit justification and user approval provided

**Authority**: BLOCKING - Work is incomplete until all applicable validation agents unanimously approve

## Validation Framework

### Core Principle
**A slice is ONLY complete when:**
1. All applicable validation agents approve
2. All quality gates pass
3. Workspace cleanup validation confirms integrity
4. User explicitly approves any override with clear justification

### Validation Agents

#### 1. **Architecture Validation Agent** (Always Required)
**Scope**: Verify technical implementation meets requirements
**Authority**: BLOCKING until approved

**Validation Checklist**:
- [ ] All project requirements satisfied
- [ ] Code maintainability standards met
- [ ] All quality assurance scripts executed successfully
- [ ] No architectural debt introduced
- [ ] Performance requirements met
- [ ] Security standards followed
- [ ] Error handling implemented properly
- [ ] Logging and observability added
- [ ] Documentation updated appropriately

**Agent Context**: Limited to requirements, technical specs, and quality standards to prevent confusion

**Blocking Conditions**:
- Any failing tests
- Unmet performance requirements  
- Security vulnerabilities introduced
- Code quality below project standards
- Missing error handling or logging
- Incomplete documentation updates

#### 2. **TDD Validation Agent** (Always Required for Code Changes)
**Scope**: Ensure test-driven development practices followed
**Authority**: BLOCKING until approved

**Validation Checklist**:
- [ ] Tests written before implementation (Red-Green-Refactor)
- [ ] All tests passing
- [ ] Test coverage meets project standards
- [ ] Tests cover edge cases and error conditions
- [ ] Integration tests included for API changes
- [ ] Unit tests for business logic
- [ ] Tests are maintainable and clear

**Blocking Conditions**:
- Any failing tests
- Tests written after implementation
- Insufficient test coverage
- Missing tests for edge cases
- Tests that are unclear or unmaintainable

#### 3. **UI Testing Agent** (Required for UI-Related Work)
**Scope**: Perform "black box" testing of user flows without implementation knowledge
**Authority**: BLOCKING until approved

**Validation Checklist**:
- [ ] Playwright tests executed for all user flows
- [ ] Screenshots taken of key UI states
- [ ] Visual distortions and rendering issues identified
- [ ] Cross-browser compatibility verified
- [ ] Responsive design tested
- [ ] Accessibility standards met
- [ ] Loading states and error states tested
- [ ] User interactions work as expected

**Agent Context**: Provided with user requirements and acceptance criteria only, NOT implementation details

**Blocking Conditions**:
- Visual distortions or broken layouts
- Non-functional user interactions
- Accessibility violations
- Missing or broken responsive design
- Failing Playwright tests
- Performance issues affecting user experience

#### 4. **UX Evaluation Agent** (Required for New UI Features)
**Scope**: Assess user experience quality and design patterns
**Authority**: BLOCKING until approved

**Validation Checklist**:
- [ ] User experience meets design standards
- [ ] Navigation is intuitive and consistent
- [ ] Information architecture is clear
- [ ] Interactive elements are accessible
- [ ] Error messages are helpful and clear
- [ ] Loading and empty states are appropriate
- [ ] Design patterns are consistent with app
- [ ] User flow is efficient and logical

**Blocking Conditions**:
- Confusing or inconsistent user experience
- Inaccessible interactive elements
- Poor information architecture
- Inconsistent design patterns
- Inefficient user flows

#### 5. **Cleanup Validation Agent** (Always Required)
**Scope**: Verify workspace cleanliness and code repository integrity
**Authority**: BLOCKING until approved

**Validation Checklist**:
- [ ] No coordination documents in codebase
- [ ] Git worktrees properly cleaned up
- [ ] No improperly merged code fragments
- [ ] No temporary or debug files committed
- [ ] All development scripts in proper location
- [ ] No unused imports or dead code
- [ ] Proper git history (no WIP commits in main)
- [ ] All environment variables documented

**Blocking Conditions**:
- Coordination documents in repository
- Active git worktrees not cleaned up
- Temporary files or debugging code committed
- Improper git history
- Undocumented configuration changes

## Validation Protocol

### Phase 1: Pre-Validation Setup
1. **Identify Applicable Agents**: Determine which validation agents are required based on work type
2. **Context Preparation**: Prepare focused context for each agent (limited to prevent confusion)
3. **Agent Briefing**: Provide each agent with their specific validation checklist and authority

### Phase 2: Agent Validation
1. **Architecture Validation**: Always required first
2. **TDD Validation**: Required for any code changes
3. **UI Testing**: Required for UI-related work with Playwright
4. **UX Evaluation**: Required for new UI features
5. **Cleanup Validation**: Always required last

### Phase 3: Approval Gate
1. **Unanimous Approval Required**: ALL applicable agents must approve
2. **Blocking Authority**: Any agent can block completion
3. **Clear Feedback**: Agents must provide specific reasons for blocking
4. **Remediation Path**: Clear instructions for addressing blocking issues

## Override Protocol (User Approval Required)

### When Override May Be Considered
- Technical constraints prevent full implementation
- External dependencies block completion
- Time-critical deployment requirements
- Scope changes affect validation criteria

### Override Requirements
1. **Explicit Justification**: Clear explanation of why override is needed
2. **Risk Assessment**: Document specific risks being accepted
3. **User Approval**: Explicit user approval of override decision
4. **Mitigation Plan**: Plan for addressing issues post-deployment
5. **Documentation**: Record override decision and reasoning

### Override Process
```
1. Agent explains blocking condition
2. Main agent explains why override may be necessary
3. Risk assessment provided to user
4. User explicitly approves or rejects override
5. If approved, override documented in slice notes
6. If rejected, remediation must occur before completion
```

## Execution Workflow

### Step 1: Validation Agent Deployment
```
For each applicable validation agent:
1. Create focused agent with limited context
2. Provide specific validation checklist
3. Grant blocking authority
4. Execute validation process
5. Collect approval or blocking feedback
```

### Step 2: Results Aggregation
```
1. Collect all agent feedback
2. Identify any blocking conditions
3. Document specific issues requiring remediation
4. Provide clear remediation path
5. Report validation status to main agent
```

### Step 3: Completion Gate
```
IF all agents approve:
  → Proceed to completion
ELSE:
  → Remediate blocking issues OR
  → Follow override protocol with user approval
```

## Quality Gates Checklist

### Technical Quality Gates
- [ ] All tests passing (unit, integration, E2E)
- [ ] Code quality metrics met
- [ ] Security scan passed
- [ ] Performance benchmarks met
- [ ] Documentation updated
- [ ] Error handling comprehensive
- [ ] Logging and monitoring configured

### User Experience Quality Gates
- [ ] Playwright tests passed with screenshots
- [ ] User flows tested and verified
- [ ] Accessibility standards met
- [ ] Responsive design verified
- [ ] Error states and loading states implemented
- [ ] Cross-browser compatibility confirmed

### Process Quality Gates
- [ ] TDD process followed (Red-Green-Refactor)
- [ ] Test coverage requirements met
- [ ] Code review completed
- [ ] Workspace cleaned up
- [ ] Git history clean
- [ ] Configuration documented

## Integration with Slice Commands

### Process Slices Integration
- All slice commands must call validation before declaring completion
- Validation results determine slice completion status
- Override decisions documented in slice retrospective
- Failed validations trigger remediation workflow

### Multi-Agent Coordination
- Main agent coordinates validation agents
- Each validation agent operates independently
- No communication between validation agents
- Main agent aggregates results and manages overrides

## Success Metrics

### Validation Effectiveness
- Percentage of slices passing validation on first attempt
- Number of critical issues caught before deployment
- Reduction in post-deployment defects
- Time saved on manual testing and review

### Quality Improvements
- Consistent test coverage across all code changes
- Improved user experience consistency
- Reduced workspace contamination incidents
- Better adherence to architectural standards

## Example Validation Flow

### Scenario: UI Feature Implementation
```
1. Architecture Agent validates:
   - API endpoints properly implemented
   - Error handling comprehensive
   - Performance requirements met
   ✅ APPROVED

2. TDD Agent validates:
   - Tests written before implementation
   - All tests passing
   - Coverage above threshold
   ✅ APPROVED

3. UI Testing Agent validates:
   - Playwright tests executed
   - Screenshots show proper rendering
   - User interactions functional
   ❌ BLOCKED: Button click not responsive on mobile

4. Remediation Required:
   - Fix mobile button interaction
   - Re-run UI validation
   - Only proceed when all agents approve
```

## Command Usage

```bash
# Validate current slice completion
/validate-slice-completion

# Validate specific slice
/validate-slice-completion user-authentication

# Emergency override validation (requires user approval)
/validate-slice-completion --override-request "deployment deadline critical"
```

## Integration Requirements

This command must be integrated into:
- `/process-slices` - Called before completion declaration
- `/process-slices-multiagent` - Built into multi-agent workflow
- All slice execution commands
- Project completion workflows


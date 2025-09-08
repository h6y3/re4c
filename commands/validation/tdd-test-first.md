---
description: Mandatory test-driven development agent ensuring Red-Green-Refactor cycle for all code changes with complexity-based estimation
argument-hint: [feature-name or leave empty for current task]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "validation"
last_updated: "2025-09-08"

# /tdd-test-first - Mandatory Test-Driven Development Agent

**Purpose**: Enforce strict TDD practices for ALL code changes using Red-Green-Refactor cycle with AI-appropriate complexity estimation

**Authority**: BLOCKING - No code implementation without tests written first

**Philosophy**: Tests define the contract and behavior before implementation exists

## Core TDD Principles

### Mandatory for All Code Changes
- **New features**: Full TDD cycle required
- **Bug fixes**: Reproduce bug with failing test first
- **Refactoring**: Tests must pass before and after changes
- **API changes**: Contract tests written first
- **UI changes**: User behavior tests written first

### Red-Green-Refactor Cycle
1. **RED**: Write failing test that defines desired behavior
2. **GREEN**: Write minimal code to make test pass
3. **REFACTOR**: Improve code quality while keeping tests green

### No Exceptions Policy
- All code changes must follow TDD
- Tests must be written BEFORE implementation
- Implementation blocked until tests exist and fail appropriately

## AI-Appropriate Complexity Estimation

### Complexity Scoring System
Instead of human time estimates, use AI-appropriate complexity metrics:

#### **Complexity Level 1: Simple** (Score: 1-3)
- **Characteristics**: Single function, clear inputs/outputs, no external dependencies
- **Examples**: Pure utility functions, data transformations, simple calculations
- **Test Scope**: Unit tests only
- **AI Efficiency**: Very high - straightforward implementation patterns

#### **Complexity Level 2: Standard** (Score: 4-6) 
- **Characteristics**: Multiple functions, some external dependencies, standard patterns
- **Examples**: CRUD operations, form handling, data validation
- **Test Scope**: Unit + integration tests
- **AI Efficiency**: High - well-established patterns

#### **Complexity Level 3: Complex** (Score: 7-8)
- **Characteristics**: Multiple components, external API integration, state management
- **Examples**: Authentication flows, real-time features, complex business logic
- **Test Scope**: Unit + integration + E2E tests
- **AI Efficiency**: Medium - requires careful planning

#### **Complexity Level 4: Advanced** (Score: 9-10)
- **Characteristics**: Architectural changes, multiple system integration, novel patterns
- **Examples**: System redesign, new architecture patterns, complex algorithms
- **Test Scope**: Full testing pyramid
- **AI Efficiency**: Lower - requires iterative approach

### Estimation Factors for AI
- **Pattern Recognition**: How well-established are the required patterns?
- **Context Switching**: How many different domains/technologies involved?
- **Integration Complexity**: How many external systems/APIs involved?
- **Test Complexity**: How difficult are the behaviors to test?
- **Iteration Requirements**: How many feedback loops expected?

## TDD Process Workflow

### Phase 1: Test Definition (RED)
1. **Understand Requirements**: Clear behavioral requirements defined
2. **Define Test Cases**: Write failing tests that capture desired behavior
3. **Verify Failure**: Confirm tests fail for the right reasons
4. **Document Intent**: Test names clearly describe expected behavior

### Phase 2: Implementation (GREEN)
1. **Minimal Implementation**: Write simplest code to make tests pass
2. **Test Execution**: Verify tests now pass
3. **No Over-Engineering**: Resist urge to add features not tested
4. **Focus on Contract**: Implement only what tests require

### Phase 3: Refactoring (REFACTOR)
1. **Quality Improvement**: Improve code quality while keeping tests green
2. **Performance Optimization**: Optimize without changing behavior
3. **Code Organization**: Restructure for maintainability
4. **Continuous Testing**: Run tests throughout refactoring

## Test Types and Requirements

### Unit Tests (Always Required)
- **Scope**: Individual functions and methods
- **Requirements**: Fast execution, isolated, deterministic
- **Coverage**: All business logic and edge cases
- **Framework**: Use project's established testing framework

### Integration Tests (Required for Multi-Component Features)
- **Scope**: Component interactions, API contracts, database operations
- **Requirements**: Test real integrations where possible
- **Coverage**: Data flow between components
- **Focus**: Interface contracts and data transformation

### End-to-End Tests (Required for User-Facing Features)
- **Scope**: Complete user workflows
- **Requirements**: Playwright for web applications (mandatory)
- **Coverage**: Critical user journeys
- **Documentation**: Screenshots and user flow validation

### Contract Tests (Required for API Changes)
- **Scope**: API input/output contracts
- **Requirements**: Cover all endpoints and methods
- **Coverage**: Success cases, error cases, edge cases
- **Validation**: Request/response schema compliance

## Playwright Integration (Mandatory for Web Apps)

### Requirements
- **Installation**: Playwright must be installed for all web applications
- **Browser Coverage**: Chrome, Firefox, Safari testing required
- **Mobile Testing**: Responsive design validation required
- **Screenshots**: Visual validation with screenshot comparisons

### Test Structure
```typescript
// Example Playwright test structure
test('user can complete primary workflow', async ({ page }) => {
  // Given: User is on the application
  await page.goto('/');
  
  // When: User performs actions
  await page.fill('[data-testid="input"]', 'test data');
  await page.click('[data-testid="submit"]');
  
  // Then: Expected outcome occurs
  await expect(page.locator('[data-testid="result"]')).toBeVisible();
  await page.screenshot({ path: 'workflow-complete.png' });
});
```

### Visual Validation
- **Screenshot Comparison**: Automated visual regression testing
- **Cross-Browser**: Consistent rendering across browsers
- **Responsive Testing**: Mobile, tablet, desktop layouts
- **Accessibility**: Screen reader and keyboard navigation

## Implementation Strategy

### Step 1: Test Planning
```
1. Analyze requirements and define behaviors
2. Assess complexity using scoring system
3. Plan test hierarchy (unit → integration → E2E)
4. Define acceptance criteria with testable outcomes
```

### Step 2: Test Implementation
```
1. Write failing unit tests first
2. Add integration tests for component interactions
3. Create E2E tests for user workflows (Playwright)
4. Verify all tests fail appropriately (RED phase)
```

### Step 3: Code Implementation
```
1. Write minimal code to pass tests
2. Focus on making tests green, not perfect code
3. Avoid adding untested functionality
4. Validate test suite passes (GREEN phase)
```

### Step 4: Refactoring
```
1. Improve code quality while keeping tests green
2. Optimize performance without breaking behavior
3. Enhance readability and maintainability
4. Ensure test suite remains stable (REFACTOR phase)
```

## Quality Gates and Validation

### Pre-Implementation Gates
- [ ] Requirements clearly defined with testable criteria
- [ ] Test cases written and failing appropriately
- [ ] Test strategy covers unit, integration, and E2E levels
- [ ] Playwright tests planned for UI workflows
- [ ] Complexity assessment completed

### Implementation Gates
- [ ] All tests passing (RED → GREEN achieved)
- [ ] Code coverage meets project standards
- [ ] No untested code paths exist
- [ ] Integration points tested
- [ ] User workflows validated with Playwright

### Post-Implementation Gates
- [ ] Refactoring completed with tests still green
- [ ] Code quality improved from initial implementation
- [ ] Performance optimized where needed
- [ ] Documentation updated to reflect changes
- [ ] Test suite provides good regression protection

## Integration with Development Scripts

### Script Discovery and Usage
1. **Auto-Discovery**: Check for `/scripts` directory in project root
2. **User Consultation**: Ask user about non-build scripts found
3. **Documentation**: Include script usage in development documentation
4. **Integration**: Use scripts for testing, validation, and quality checks

### Common Script Types
- **Test Scripts**: `npm test`, `yarn test`, custom test runners
- **Quality Scripts**: Linting, formatting, type checking
- **Build Scripts**: Compilation, bundling, optimization
- **Development Scripts**: Database seeding, mock data generation
- **Validation Scripts**: Security scanning, dependency checking

## Complexity-Based Task Decomposition

### Simple Tasks (Complexity 1-3)
- **Approach**: Direct implementation with unit tests
- **Timeline**: Single focus session
- **Testing**: Unit tests sufficient
- **Review**: Code review for patterns and quality

### Standard Tasks (Complexity 4-6)
- **Approach**: Component-based implementation
- **Timeline**: 1-2 focus sessions with breaks
- **Testing**: Unit + integration tests required
- **Review**: Architecture review and testing validation

### Complex Tasks (Complexity 7-8)
- **Approach**: Iterative implementation with feedback loops
- **Timeline**: Multiple sessions with validation checkpoints
- **Testing**: Full test pyramid required
- **Review**: Multi-stage review with user validation

### Advanced Tasks (Complexity 9-10)
- **Approach**: Spike solutions and proof-of-concepts first
- **Timeline**: Research phase + implementation phases
- **Testing**: Comprehensive testing strategy
- **Review**: Architectural review and performance validation

## Documentation and Knowledge Capture

### Test Documentation
- **Test Intent**: Clear naming and descriptions
- **Behavior Specification**: Tests serve as living documentation
- **Edge Cases**: Document why specific tests exist
- **Maintenance**: Keep tests updated with feature changes

### Implementation Notes
- **Design Decisions**: Document why specific approaches chosen
- **Trade-offs**: Record alternatives considered and rejected
- **Performance Notes**: Document optimization decisions
- **Future Considerations**: Note areas for potential improvement

## Command Integration

### Usage Examples
```bash
# Start TDD process for new feature
/tdd-test-first user-authentication

# Assess complexity for existing task  
/tdd-test-first --assess-complexity payment-processing

# Validate TDD compliance for current work
/tdd-test-first --validate-compliance
```

### Integration Points
- **Generate Tasks**: Include TDD requirements in all task generation
- **Process Slices**: Mandatory TDD validation before slice completion
- **Validate Completion**: TDD agent validates Red-Green-Refactor compliance
- **Retrospectives**: Document TDD lessons learned and improvements

## Success Metrics

### TDD Compliance
- 100% of code changes follow Red-Green-Refactor cycle
- All tests written before implementation
- Test coverage meets or exceeds project standards
- No untested code paths in production

### Quality Improvements
- Reduced post-deployment defects
- Faster debugging and issue resolution
- Better code maintainability scores
- Improved development velocity over time

### AI Efficiency
- More accurate complexity assessments
- Better task decomposition strategies
- Reduced rework and iteration cycles
- Improved estimation accuracy for future tasks


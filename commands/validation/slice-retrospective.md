---
description: Mandatory post-slice learning capture, project plan updates, and knowledge transfer for continuous improvement
argument-hint: [slice-name or leave empty for current slice]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "validation"
last_updated: "2025-09-08"

# /slice-retrospective - Mandatory Post-Slice Learning and Planning Update

**Purpose**: Capture lessons learned, update project plans, and transfer knowledge after every slice completion

**Authority**: MANDATORY - Required after every slice, regardless of size or complexity

**Philosophy**: Continuous improvement through systematic learning capture and adaptive planning

## Core Requirements

### Mandatory After Every Slice
- **No exceptions**: Every slice must have a retrospective
- **Immediate execution**: Run immediately after slice completion validation
- **Documentation**: All insights must be documented in `/docs/retrospectives/`
- **Plan updates**: Project plans must be updated based on learnings

### Knowledge Transfer Goals
1. **Capture lessons learned**: Document what worked, what didn't, and why
2. **Update project understanding**: Revise assumptions and requirements
3. **Adapt future planning**: Reorder priorities based on new information
4. **Prevent knowledge loss**: Ensure insights survive session boundaries

## Retrospective Framework

### Phase 1: Completion Analysis
**Question Set**: What was actually accomplished?

1. **Tasks Completed**: List all tasks marked as done
2. **Scope Changes**: Identify any scope modifications during implementation
3. **Unexpected Work**: Document work not originally planned
4. **Technical Decisions**: Record significant technical choices made
5. **Blockers Resolved**: Note how obstacles were overcome

**Output**: Comprehensive completion summary with deviations from plan

### Phase 2: Learning Capture
**Question Set**: What did we learn during this slice?

#### Technical Learnings
- **New patterns discovered**: Code patterns, architecture insights, tool usage
- **Performance insights**: What worked well, what was slow
- **Integration challenges**: Unexpected API behaviors, compatibility issues
- **Testing revelations**: Test patterns that worked, testing challenges
- **Tool discoveries**: New tools found, better ways to use existing tools

#### Process Learnings  
- **Estimation accuracy**: How accurate were complexity estimates?
- **Workflow effectiveness**: Which processes helped/hindered progress
- **Communication insights**: What information was missing or helpful
- **Resource utilization**: How well were available tools/resources used
- **Validation effectiveness**: How well did quality gates work?

#### Context and Requirements Learnings
- **Requirement clarifications**: What requirements were misunderstood initially?
- **User needs insights**: Better understanding of user problems
- **Business context evolution**: Changes in business priorities or constraints
- **Technical constraint discoveries**: New limitations or capabilities found
- **Integration requirement changes**: Updates to external system requirements

**Output**: Structured learning documentation with actionable insights

### Phase 3: Project Plan Assessment
**Question Set**: How should this learning change our plans?

#### Task Relevance Review
1. **Still Relevant**: Which remaining tasks are still necessary?
2. **No Longer Relevant**: Which tasks can be removed or significantly modified?
3. **New Tasks Discovered**: What new tasks emerged from implementation learning?
4. **Priority Changes**: Which tasks should move up/down in priority?
5. **Dependency Updates**: How do new learnings affect task dependencies?

#### Scope and Timeline Impact
1. **Scope Adjustments**: Should project scope be expanded or reduced?
2. **Complexity Reassessment**: Were original complexity estimates accurate?
3. **Resource Requirements**: Do we need different tools or capabilities?
4. **Risk Updates**: What new risks were discovered or mitigated?
5. **Success Criteria Evolution**: Should success metrics be updated?

#### Next Slice Planning
1. **Next Logical Step**: Is the next planned slice still the right priority?
2. **Preparation Requirements**: What preparation is needed for the next slice?
3. **Context Handoff**: What context must be preserved for future work?
4. **Tool Setup**: What tools or configurations are needed for upcoming work?

**Output**: Updated project plan with revised priorities and scope

### Phase 4: Knowledge Documentation
**Question Set**: How do we preserve and share these insights?

#### Documentation Updates
- **README updates**: User-facing documentation changes needed
- **Technical documentation**: Architecture, API, or implementation docs to update
- **Development guides**: Process or setup documentation improvements
- **Troubleshooting guides**: New solutions to capture for common issues

#### Decision Records
- **Architecture decisions**: Significant technical choices made
- **Tool selections**: Why specific tools or approaches were chosen
- **Trade-off decisions**: Performance vs. complexity vs. maintainability choices
- **Process decisions**: Workflow or methodology choices

#### Future Considerations
- **Technical debt created**: Shortcuts taken that need future attention
- **Optimization opportunities**: Performance or quality improvements identified
- **Refactoring candidates**: Code that should be improved later
- **Feature enhancements**: User experience improvements discovered

**Output**: Updated documentation and decision records

## Retrospective Documentation Structure

### File Organization
```
docs/
├── retrospectives/
│   ├── 2024/
│   │   ├── Q4/
│   │   │   ├── slice-001-user-auth-2024-12-15.md
│   │   │   ├── slice-002-dashboard-ui-2024-12-18.md
│   │   │   └── slice-003-payment-flow-2024-12-22.md
│   │   └── retrospective-summary-2024-Q4.md
│   └── templates/
│       ├── slice-retrospective-template.md
│       └── quarterly-summary-template.md
```

### Retrospective Document Template
```markdown
# Slice Retrospective: [Slice Name] - [Date]

## Slice Overview
- **Duration**: [Start] to [Completion]
- **Original Scope**: [What was planned]
- **Actual Scope**: [What was delivered]
- **Complexity Score**: [Original estimate] → [Actual experience]

## Completion Analysis

### Tasks Completed ✅
- [List of completed tasks]

### Scope Changes 🔄
- [Changes made during implementation]

### Unexpected Work 🆕
- [Work not originally planned]

### Technical Decisions 🏗️
- [Significant technical choices made]

## Key Learnings

### Technical Insights 🔧
- **What Worked Well**: [Successful patterns and approaches]
- **What Was Challenging**: [Difficult areas and why]
- **New Discoveries**: [Tools, patterns, or techniques learned]
- **Performance Notes**: [Speed, efficiency, or quality observations]

### Process Insights 📋
- **Estimation Accuracy**: [How accurate were original estimates]
- **Workflow Effectiveness**: [What processes helped/hindered]
- **Resource Utilization**: [How well tools and resources were used]
- **Validation Effectiveness**: [How well quality gates worked]

### Context Evolution 🧠
- **Requirement Clarifications**: [Better understanding of requirements]
- **User Need Insights**: [Better understanding of user problems]
- **Business Context Changes**: [Changes in priorities or constraints]
- **Integration Discoveries**: [New understanding of external systems]

## Project Plan Updates

### Task Relevance Changes
- **Tasks to Remove**: [Tasks no longer relevant]
- **Tasks to Add**: [New tasks discovered]
- **Priority Changes**: [Tasks that should move up/down]
- **Dependency Updates**: [Changed task relationships]

### Scope and Timeline Impact
- **Scope Adjustments**: [Project scope changes]
- **Complexity Reassessments**: [Updated complexity understanding]
- **Resource Requirement Changes**: [New tool or capability needs]
- **Risk Updates**: [New risks discovered or mitigated]

### Next Slice Recommendations
- **Next Priority**: [What should be tackled next and why]
- **Preparation Needed**: [Setup or research required for next slice]
- **Context to Preserve**: [Important information for future work]

## Knowledge Preservation

### Documentation Updates Needed
- [ ] README updates
- [ ] Technical documentation updates  
- [ ] Development guide updates
- [ ] Troubleshooting guide updates

### Decision Records Created
- **Architecture Decisions**: [Links to ADRs created]
- **Tool Selection Decisions**: [Tool choice rationale]
- **Process Decisions**: [Workflow or methodology choices]

### Future Considerations
- **Technical Debt**: [Shortcuts taken needing future attention]
- **Optimization Opportunities**: [Performance improvements identified]
- **Refactoring Candidates**: [Code that should be improved]
- **Enhancement Ideas**: [User experience improvements discovered]

## Validation and Quality Assessment

### Validation Process Review
- **Architecture Validation**: [How well it worked]
- **TDD Process**: [Red-Green-Refactor effectiveness]  
- **UI Testing**: [Playwright testing effectiveness]
- **Cleanup Process**: [Workspace cleanup effectiveness]

### Quality Metrics
- **Test Coverage**: [Achieved vs. target]
- **Code Quality**: [Linting, formatting, review feedback]
- **Performance**: [Speed, efficiency metrics]
- **User Experience**: [Usability and interface quality]

## Recommendations for Future Slices

### Process Improvements
- [Specific process changes to try]

### Tool Usage Enhancements  
- [Better ways to use existing tools]
- [New tools to consider]

### Planning Improvements
- [Better estimation approaches]
- [Improved task decomposition strategies]

### Knowledge Management
- [Better documentation practices]
- [Improved knowledge transfer methods]

## Action Items
- [ ] [Specific actions with owners and dates]
- [ ] [Documentation updates needed]
- [ ] [Process changes to implement]
- [ ] [Tools to install or configure]

## Next Slice Context
**What the next implementer needs to know**:
- [Critical context for next slice]
- [Important decisions made that affect future work]  
- [Tools and configurations in place]
- [Known issues or limitations to be aware of]
```

## Integration with Project Management

### Task Management Updates
- Update task priorities in project management systems
- Mark completed tasks as done
- Add new tasks discovered during implementation
- Update task estimates based on actual complexity experienced

### Requirement Refinement
- Update user stories based on implementation learning
- Refine acceptance criteria based on edge cases discovered
- Update business requirements based on user feedback
- Revise technical requirements based on constraint discoveries

### Risk and Issue Management
- Update risk assessments based on new information
- Document new risks discovered during implementation  
- Record solutions to issues for future reference
- Update mitigation strategies based on what worked

## Quarterly Summary Process

### Retrospective Aggregation
Every quarter, create a summary retrospective that:
- **Aggregates learnings**: Common patterns across slices
- **Identifies trends**: Recurring challenges or successes
- **Recommends process changes**: System-wide improvements
- **Updates standards**: Evolution of best practices

### Knowledge Base Updates
- Update development documentation based on learnings
- Refine estimation guidelines based on accuracy data
- Update tool recommendations based on effectiveness
- Revise workflow standards based on retrospective feedback

## Command Usage

```bash
# Run retrospective for current slice
/slice-retrospective

# Run retrospective for specific slice
/slice-retrospective user-authentication-slice

# Generate quarterly summary
/slice-retrospective --quarterly-summary 2024-Q4

# Template creation for new project
/slice-retrospective --create-templates
```

## Success Metrics

### Learning Effectiveness
- **Knowledge retention**: Lessons learned applied in subsequent slices
- **Estimation improvement**: Better accuracy over time
- **Process evolution**: Measurable workflow improvements
- **Quality trends**: Consistent improvement in validation metrics

### Project Adaptation
- **Plan accuracy**: Better alignment between plans and execution
- **Scope management**: Fewer unexpected scope changes
- **Priority alignment**: Better task prioritization over time
- **Risk mitigation**: Improved risk identification and management

### Team Performance
- **Velocity consistency**: More predictable development pace
- **Quality consistency**: Stable quality metrics across slices
- **Context preservation**: Better knowledge transfer between sessions
- **Process satisfaction**: Higher team satisfaction with workflows


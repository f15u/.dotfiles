---
name: openspec
description: >
  Recognize when to suggest OpenSpec workflow for complex features and brownfield changes.
  Trigger on: multi-file features, unclear scope, team collaboration needs.
  Skip on: one-liners, trivial fixes, prototypes.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash(/opsx:*)
  - Edit
  - Write
---

# OpenSpec Usage Detection

Recognize when tasks benefit from spec-driven workflow and suggest `/opsx:new` to create change directories.

## Suggest OpenSpec When

**Task characteristics**:
- Multi-file changes spanning components
- Unclear scope requiring exploration
- Complex features needing alignment before code
- Team collaboration requiring shared context
- Brownfield codebases where understanding is critical

**User signals**:
- "I need to add [complex feature]"
- "Help me implement [multi-step change]"
- "We should refactor [component]"
- Vague requirements needing clarification

**Action**: Suggest `/opsx:new <change-name>` before diving into implementation.

## Never Suggest OpenSpec When

**Task characteristics**:
- One-line fixes or variable changes
- Trivial bugs with obvious solutions
- Prototype or exploratory code
- Time-sensitive hotfixes
- Single-file edits with clear approach

**User signals**:
- "Quick fix for..."
- "Just change X to Y"
- "Debug why..."
- "Add console.log..."

**Action**: Implement directly without spec overhead.

## Workflow Pattern

When OpenSpec is appropriate:

1. Suggest `/opsx:new <change-name>` to create change directory
2. User runs command (or you suggest they do)
3. Guide them to `/opsx:ff` to generate artifacts
4. Review generated proposal/specs/design/tasks
5. Iterate on specs if needed (fluid, not locked)
6. Implement with `/opsx:apply` when aligned

## Decision Logic

```
Is task complex? → Yes → Suggest OpenSpec
  ↓ No
Is scope unclear? → Yes → Suggest OpenSpec
  ↓ No
Multi-file changes? → Yes → Suggest OpenSpec
  ↓ No
Team collaboration? → Yes → Suggest OpenSpec
  ↓ No
Implement directly
```

## Example Triggers

**Suggest**:
- "Add authentication to the app"
- "Refactor the API layer"
- "Implement dark mode"
- "We need to support multi-tenancy"

**Don't suggest**:
- "Fix typo in README"
- "Change timeout from 30s to 60s"
- "Add debug logging here"
- "Run the tests"

## Key Principle

OpenSpec is for alignment before implementation. If you'd normally ask clarifying questions or explore the codebase first, suggest OpenSpec instead.

---
name: skill-builder
description: >
  Create and update Claude Code skills with proper YAML frontmatter, structure, and organization.
  Use when building new skills, updating existing skills, refactoring skill structure, validating skill format, or learning skill architecture.
  Extract patterns for SKILL.md creation, tool restrictions, hooks, context isolation, progressive disclosure, and security best practices.
  Update existing skills with enforced validation and compliance checks.
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Bash(mkdir:*, chmod:*)
hooks:
  PostToolUse:
    - matcher: "Write|Edit"
      hooks:
        - type: command
          command: "./scripts/validate-on-skill-edit.sh"
          timeout: 5
    - matcher: "**/SKILL.md"
      hooks:
        - type: command
          command: "./scripts/validate-skill.sh $(dirname $TOOL_INPUT.filePath)"
          timeout: 10
---

# Skill Builder

Create and update properly structured Claude Code skills with correct YAML frontmatter and file organization.

**Use for**:
- Creating new skills from scratch
- Updating existing skills to follow current standards
- Refactoring skill structure and organization
- Validating skill format and best practices

## Core Principles

### Concise is Key
The context window is a public good. Only add context Claude doesn't already have. Challenge each piece of information. Prefer concise examples over verbose explanations.

### Set Appropriate Degrees of Freedom
- **High freedom** (text-based): Multiple approaches, context-dependent decisions
- **Medium freedom** (structured + examples): Standard procedures with variations
- **Low freedom** (templates + validation): Critical operations requiring precision

## Skill Structure

### Required Files
- **SKILL.md**: Metadata + instructions (frontmatter + markdown)

### Optional Supporting Files
- **reference.md**: Detailed API documentation
- **examples.md**: Usage examples and templates
- **scripts/**: Utility scripts (must be executable)

### Directory Layout
```
.claude/skills/skill-name/       # Project skill
├── SKILL.md                     # Required
├── reference.md                 # Optional: detailed docs
├── examples.md                  # Optional: usage examples
└── scripts/                     # Optional: utility scripts
    └── helper.sh                # Must be executable
```

## Creating a Skill

### The Five-Step Process

1. **Understand**: Find concrete examples of the skill's target behavior
2. **Plan**: Identify reusable knowledge, tools, and patterns
3. **Initialize**: Create directory structure with `init_skill.sh`
4. **Edit**: Write SKILL.md with proper frontmatter and instructions
5. **Iterate**: Test and refine based on validation

### Frontmatter Requirements

**Required fields**:
- `name`: lowercase, hyphens only, max 64 chars
- `description`: Include trigger keywords, max 1024 chars

**Optional fields**:
- `allowed-tools`: Restrict tool access for security
- `context: fork`: Isolate complex workflows
- `hooks`: Add validation, security checks, or cleanup

## Updating Existing Skills

### Update Process

1. **Read existing skill**: Understand current functionality
2. **Run validation**: `./scripts/validate-skill.sh <skill-dir>`
3. **Update frontmatter**: 
   - Enhance description with trigger keywords
   - Add `allowed-tools` for security
   - Consider `context: fork` for complex workflows
4. **Refactor content**:
   - Keep SKILL.md under 500 lines
   - Move detailed docs to reference.md
   - Move examples to examples.md
5. **Validate again**: Ensure compliance with standards

### Common Updates

#### Add Missing Frontmatter Fields
```yaml
# Before
---
name: my-skill
description: Does stuff
---

# After
---
name: my-skill
description: >
  Specific description with trigger keywords.
  Lists exact capabilities: analyze, generate, process.
allowed-tools:
  - Read
  - Grep
  - Glob
---
```

#### Add Tool Restrictions
```yaml
# Read-only skill
allowed-tools:
  - Read
  - Grep
  - Glob

# Python-only skill
allowed-tools:
  - Bash(python:*)
```

#### Reorganize Large Skills
- SKILL.md: 300 lines (essential instructions)
- reference.md: 400 lines (detailed documentation)
- examples.md: 200 lines (usage examples)

## Validation Checklist

**Apply to both NEW and UPDATED skills before completing**:

- [ ] SKILL.md exists with proper frontmatter
- [ ] Name is lowercase with hyphens only
- [ ] Description includes trigger keywords
- [ ] Description under 1024 characters
- [ ] Description mentions "update" or "refactor" if skill handles updates
- [ ] Instructions are clear and actionable
- [ ] Tool restrictions appropriate for security (add if missing)
- [ ] Supporting files linked (if used)
- [ ] Scripts have execute permissions
- [ ] Dependencies listed in description
- [ ] Context isolation considered for complex workflows
- [ ] Hooks added if validation/security needed
- [ ] SKILL.md under 500 lines (refactor if needed)
- [ ] Backward compatibility maintained (for updates)
- [ ] Validation script passes

## Quick Reference

### Best Practices
- Description: Include specific trigger keywords and capabilities
- Tool restrictions: Start with Read-only, expand as needed
- Context isolation: Use `context: fork` for complex workflows
- Hooks: Add security/validation for sensitive operations
- File organization: Keep SKILL.md concise, use supporting files

### Common Patterns
- **Capability-specific**: Focus on single task type
- **Tool-restricted**: Limit to Read/Grep/Glob for safety
- **Forked context**: Complex workflows needing isolation
- **Hook-based**: Security checks, validation, cleanup

### File References
- Detailed specifications: See [REFERENCE.md](REFERENCE.md)
- Templates and examples: See [EXAMPLES.md](EXAMPLES.md)
- Validation script: `./scripts/validate-skill.sh <skill-dir>`

## Migration Guide

### Converting Legacy Skills
1. Add missing frontmatter fields (name, description)
2. Enhance description with trigger keywords
3. Add `allowed-tools` for security
4. Consider `context: fork` if complex
5. Reorganize if over 500 lines
6. Add validation hooks if needed
7. Run validation script

### Backward Compatibility
When updating skills:
- Preserve existing functionality
- Keep same skill name
- Don't break workflows
- Test before/after behavior
- Document breaking changes

## Scripts Directory

### Creating Scripts
- Use `bash` shebang: `#!/usr/bin/env bash`
- Make executable: `chmod +x scripts/script.sh`
- Reference from SKILL.md: `./scripts/script.sh`
- Access environment variables: `$CLAUDE_PROJECT_DIR`

### Common Script Patterns
- Validation: Check inputs/outputs
- Security: Block dangerous operations
- Cleanup: Remove temporary files
- Testing: Run integration tests
# Skill Builder Reference

Detailed specifications and advanced patterns for Claude Code skills.

## YAML Frontmatter Complete Schema

```yaml
---
# Required Fields
name: skill-name                          # Required: lowercase, hyphens, max 64 chars
description: >                            # Required: max 1024 chars, trigger keywords
  What skill does. When to use it.
  Specific capabilities: "Extract, merge, analyze"

# Optional Fields
allowed-tools: [Read, Grep, Glob]         # Tool restrictions
model: claude-opus-4-5-20251101           # Override model
context: fork                             # Isolate in sub-agent
agent: general-purpose                    # Sub-agent type
user-invocable: true                      # Show in slash menu (default)
disable-model-invocation: false           # Block Skill tool access

# Hooks - Lifecycle Management
hooks:                                    # Optional: Pre/Post/Stop hooks
  PreToolUse: [...]
  PostToolUse: [...]
  Stop: [...]
---
```

### Field Specifications

#### name
- **Type**: string
- **Required**: Yes
- **Max Length**: 64 characters
- **Format**: Lowercase letters, numbers, hyphens only
- **Example**: `my-skill`, `pdf-processor`, `code-review-helper`
- **Notes**: Must be unique within scope (personal/project/plugin)

#### description
- **Type**: string (multi-line supported with `>`)
- **Required**: Yes
- **Max Length**: 1024 characters
- **Purpose**: Discovery trigger + capability summary
- **Best Practices**:
  - Include keywords users would naturally say
  - List specific capabilities: "Extract, fill, merge, analyze"
  - Answer: What does it do? When to use it?
  - Be specific, not vague
- **Example**:
```yaml
description: >
  Extract text from PDFs, fill forms, merge documents, split pages.
  Use when working with PDF files, form processing, or document extraction.
  Requires pypdf and pdfplumber packages.
```

### Optional Configuration Fields

#### allowed-tools
- **Type**: string (comma-separated) or list
- **Default**: All tools unrestricted
- **Purpose**: Restrict tool access for security/focus
- **Formats**:
```yaml
# Comma-separated string
allowed-tools: Read, Grep, Glob

# YAML list
allowed-tools:
  - Read
  - Grep
  - Bash(python:*)
```
- **Tool Names**: Read, Write, Edit, Glob, Grep, Bash, Task, TodoWrite, WebFetch, WebSearch, etc.
- **Patterns**:
  - `Bash(python:*)` - Bash with python commands only
  - `Bash(git:*)` - Bash with git commands only
  - Exact tool name for full access to that tool

#### model
- **Type**: string
- **Default**: Inherits from conversation
- **Purpose**: Override LLM model for skill execution
- **Valid Values**:
  - `claude-opus-4-5-20251101` - Most capable
  - `claude-sonnet-4-5-20250929` - Balanced
  - `claude-haiku-4-5-20250101` - Fast, cost-effective
- **Example**:
```yaml
model: claude-opus-4-5-20251101
```

#### context
- **Type**: enum
- **Default**: `main` (runs in current conversation)
- **Valid Values**: `main`, `fork`
- **Purpose**: Control execution context
- **fork**: Runs in isolated sub-agent with separate conversation history
- **Use Cases for fork**:
  - Complex multi-step operations
  - Prevents clutter in main conversation
  - Independent workflows
- **Example**:
```yaml
context: fork
agent: general-purpose
```

#### agent
- **Type**: string
- **Default**: `general-purpose`
- **Valid When**: `context: fork` is set
- **Valid Values**:
  - `general-purpose` - Multi-purpose tasks
  - `Explore` - Codebase exploration
  - `Plan` - Implementation planning
  - Custom agent types
- **Example**:
```yaml
context: fork
agent: Explore
```

#### user-invocable
- **Type**: boolean
- **Default**: true
- **Purpose**: Control visibility in slash command menu
- **Values**:
  - `true`: Shows in `/` menu, Claude can invoke, Skill tool works
  - `false`: Hidden from menu, Claude can invoke, Skill tool works
- **Example**:
```yaml
user-invocable: false  # Hidden helper skill
```

#### disable-model-invocation
- **Type**: boolean
- **Default**: false
- **Purpose**: Block programmatic invocation via Skill tool
- **Values**:
  - `false`: Claude can invoke via Skill tool
  - `true`: Only user can invoke (slash command/at-mention)
- **Example**:
```yaml
disable-model-invocation: true  # User-only skill
```

### Invocation Control Matrix

| user-invocable | disable-model-invocation | Slash Menu | Claude Auto | Skill Tool |
|----------------|--------------------------|------------|-------------|------------|
| true           | false                    | ✓          | ✓           | ✓          |
| false          | false                    | ✗          | ✓           | ✓          |
| true           | true                     | ✓          | ✗           | ✗          |
| false          | true                     | ✗          | ✗           | ✗          |

## Hooks Configuration

### Hook Events

#### PreToolUse
Executes before Claude uses a tool.

**Structure**:
```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"              # Tool name to intercept
      hooks:
        - type: command
          command: "./scripts/security-check.sh $TOOL_INPUT"
          once: true               # Run only on first match
```

**Use Cases**:
- Security validation before execution
- Input sanitization
- Permission checks
- Rate limiting setup

#### PostToolUse
Executes after tool completes.

**Structure**:
```yaml
hooks:
  PostToolUse:
    - matcher: "Write"
      hooks:
        - type: command
          command: "./scripts/validate.sh $TOOL_OUTPUT"
```

**Use Cases**:
- Output validation
- Result processing
- Logging
- Metrics collection

#### Stop
Executes when skill execution completes.

**Structure**:
```yaml
hooks:
  Stop:
    - type: command
      command: "./scripts/cleanup.sh"
```

**Use Cases**:
- Cleanup operations
- Resource release
- Final reporting
- State persistence

### Hook Parameters

| Parameter | Type    | Required | Description                          |
|-----------|---------|----------|--------------------------------------|
| matcher   | string  | Yes      | Tool name to intercept               |
| type      | string  | Yes      | Always "command"                     |
| command   | string  | Yes      | Shell command to execute             |
| once      | boolean | No       | Run only on first match (default: false) |

### Hook Environment Variables

Available in hook commands:
- `$TOOL_INPUT` - Tool input parameters
- `$TOOL_OUTPUT` - Tool output (PostToolUse only)
- Standard environment variables

### Multi-Hook Configuration

```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/security-check.sh"
          once: true
    - matcher: "Write"
      hooks:
        - type: command
          command: "./scripts/validate-write.sh"
  PostToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/log-execution.sh"
  Stop:
    - type: command
      command: "./scripts/cleanup.sh"
```

## File Organization Patterns

### Minimal Skill (Single File)
```
.claude/skills/simple-skill/
└── SKILL.md
```

### Standard Skill
```
.claude/skills/standard-skill/
├── SKILL.md          # Main instructions
├── reference.md      # Detailed docs
└── examples.md       # Usage examples
```

### Advanced Skill with Scripts
```
.claude/skills/advanced-skill/
├── SKILL.md
├── reference.md
├── examples.md
└── scripts/
    ├── validate.sh
    ├── security-check.py
    └── cleanup.sh
```

### Script Requirements
- Must have execute permissions: `chmod +x scripts/*.sh`
- Not loaded into context automatically
- Executed when called explicitly or via hooks
- Use forward slashes in paths: `scripts/helper.py`

## Tool Restriction Patterns

### Read-Only Skills
```yaml
allowed-tools:
  - Read
  - Grep
  - Glob
```
**Use**: Code analysis, documentation search, information gathering

### Write-Enabled Skills
```yaml
allowed-tools:
  - Read
  - Write
  - Edit
```
**Use**: File modification, content generation, refactoring

### Bash-Restricted Skills
```yaml
allowed-tools:
  - Read
  - Bash(git:*)
```
**Use**: Git operations without arbitrary command execution

### Python-Only Skills
```yaml
allowed-tools:
  - Read
  - Write
  - Bash(python:*)
```
**Use**: Python scripting, data processing, analysis

### Full Access Skills
```yaml
# No allowed-tools field
```
**Use**: Complex workflows requiring multiple tool types

## Context Isolation Patterns

### Main Context (Default)
```yaml
# No context field needed
```
- Runs in current conversation
- Shares history with main conversation
- Immediate access to context
- Best for: Quick operations, simple tasks

### Forked Context
```yaml
context: fork
agent: general-purpose
```
- Isolated sub-agent
- Separate conversation history
- Clean slate for complex operations
- Best for: Multi-step workflows, complex analysis

### Forked with Exploration
```yaml
context: fork
agent: Explore
```
- Optimized for codebase exploration
- Fast file discovery
- Pattern matching focus
- Best for: Finding files, searching code, understanding structure

### Forked with Planning
```yaml
context: fork
agent: Plan
```
- Software architecture focus
- Implementation strategy
- Design decisions
- Best for: Planning features, architectural changes

## Advanced Patterns

### Security-Focused Skill
```yaml
---
name: secure-executor
description: Execute commands with security validation and audit logging
allowed-tools:
  - Bash(git:*, npm:test, npm:build)
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/security-check.sh $TOOL_INPUT"
          once: false
  PostToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/audit-log.sh $TOOL_OUTPUT"
  Stop:
    - type: command
      command: "./scripts/generate-report.sh"
---
```

### Multi-Language Development Skill
```yaml
---
name: polyglot-dev
description: Development tasks across Python, JavaScript, and Rust projects
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(python:*, npm:*, cargo:*)
context: fork
---
```

### Documentation Generator
```yaml
---
name: doc-generator
description: Generate API documentation, README files, and code comments
allowed-tools:
  - Read
  - Write
  - Grep
  - Glob
model: claude-opus-4-5-20251101
---
```

### Interactive Workflow Skill
```yaml
---
name: interactive-setup
description: Interactive project setup with user prompts and configuration
user-invocable: true
disable-model-invocation: true
---
```

## Skill Distribution

### Personal Skills
**Location**: `~/.claude/skills/skill-name/`
**Scope**: All your projects
**Version Control**: Not shared via git
**Use**: Personal workflows, preferences, utilities

### Project Skills
**Location**: `.claude/skills/skill-name/`
**Scope**: Repository only
**Version Control**: Committed to git, team-shared
**Use**: Team workflows, project-specific tasks

### Plugin Skills
**Location**: `skills/skill-name/` in plugin root
**Scope**: Plugin subscribers
**Distribution**: Via plugin system
**Use**: Reusable components, framework integrations

### Enterprise Skills
**Location**: Admin-configured
**Scope**: Organization-wide
**Management**: Centrally deployed
**Use**: Company standards, compliance workflows

### Precedence
1. Enterprise (highest)
2. Personal
3. Project
4. Plugin (lowest)

Same name? Higher precedence wins.

## Validation Rules

### Name Validation
- Lowercase only
- Hyphens allowed, underscores not recommended
- No spaces
- Max 64 characters
- Pattern: `^[a-z0-9-]+$`

### Description Validation
- Max 1024 characters
- Must include trigger keywords
- Should be specific, not vague
- Multi-line supported with `>`

### File Validation
- SKILL.md must exist
- Case-sensitive filename
- Valid YAML frontmatter
- Frontmatter must start with `---` and end with `---`

### Tool Names Validation
- Must match existing tool names
- Case-sensitive
- Pattern syntax: `ToolName(pattern:*)`

### Hook Validation
- Scripts must have execute permissions
- Commands must be valid shell commands
- Paths must use forward slashes

## Performance Considerations

### Context Size
- Keep SKILL.md under 500 lines
- Use reference.md for detailed docs
- Link to examples.md for usage patterns
- Scripts aren't loaded into context

### Model Selection
- Haiku: Fast, cost-effective for simple tasks
- Sonnet: Balanced for most workflows
- Opus: Complex reasoning, architectural decisions

### Tool Restrictions
- Reduces available actions
- Improves focus
- Enhances security
- Faster skill selection

## Debugging Skills

### Common Issues

**Skill not triggering**:
- Description too vague
- Missing trigger keywords
- Conflicting skill names

**Tool access denied**:
- Check allowed-tools configuration
- Verify tool name spelling
- Ensure pattern syntax correct

**Hook not executing**:
- Check script permissions: `chmod +x`
- Verify command path
- Test script independently

**Context issues**:
- Forked context isolated from main
- Agent type mismatch
- Model override conflicts

### Testing Skills

1. Create skill in `.claude/skills/test-skill/`
2. Write minimal SKILL.md
3. Test with `/test-skill` command
4. Iterate on description for triggering
5. Add tool restrictions gradually
6. Validate hooks independently

## Updating Existing Skills

### Update Philosophy

**All skills must follow current standards**, whether new or existing:
- Same validation rules apply
- Same structure requirements
- Same security patterns (tool restrictions)
- Same organization principles (progressive disclosure)

### Identifying Skills for Update

Find existing skills:
```bash
# Project skills
find .claude/skills -name "SKILL.md" -exec echo "Project: {}" \;

# Personal skills
find ~/.claude/skills -name "SKILL.md" -exec echo "Personal: {}" \;
```

### Update Priority

**High Priority** (security/functionality issues):
- Missing tool restrictions
- Vague descriptions (poor triggering)
- Security vulnerabilities
- Broken functionality

**Medium Priority** (quality/maintainability):
- Over 500 lines in SKILL.md
- Missing supporting files structure
- Unclear instructions
- No validation hooks

**Low Priority** (optimization):
- Description could be more specific
- Could benefit from context isolation
- Minor organization improvements

### Update Process

1. **Analyze Current State**
   ```bash
   # Validate existing skill
   ./scripts/validate-skill.sh .claude/skills/existing-skill

   # Check line count
   wc -l .claude/skills/existing-skill/SKILL.md

   # Review frontmatter
   head -n 20 .claude/skills/existing-skill/SKILL.md
   ```

2. **Plan Updates**
   - List required changes
   - Identify breaking changes
   - Plan backward compatibility

3. **Apply Updates**
   - Update frontmatter fields
   - Add tool restrictions
   - Refactor content if needed
   - Add supporting files

4. **Validate**
   ```bash
   # Run validation
   ./scripts/validate-skill.sh .claude/skills/updated-skill

   # Test invocation
   # (test the skill works as expected)
   ```

5. **Document Changes**
   - Note what changed
   - Document breaking changes
   - Update examples if needed

### Common Update Patterns

#### Pattern 1: Add Security Restrictions

**Before** (insecure):
```yaml
---
name: file-processor
description: Process files with custom scripts
---
```

**After** (secure):
```yaml
---
name: file-processor
description: >
  Process files with Python scripts, analyze data, generate reports.
  Use when processing data files, cleaning datasets, or batch operations.
allowed-tools:
  - Read
  - Write
  - Bash(python:*)
---
```

**Rationale**: Limits bash to Python commands only, preventing arbitrary command execution.

#### Pattern 2: Improve Description

**Before** (won't trigger):
```yaml
description: Helps with git
```

**After** (triggers reliably):
```yaml
description: >
  Generate conventional commit messages from git diffs, analyze changes, suggest commit types.
  Use when creating commits, reviewing staged changes, or writing commit messages.
  Follows conventional commit format: feat, fix, docs, refactor, test, chore.
```

**Rationale**: Specific keywords ("commit", "git diff", "staged") trigger skill when relevant.

#### Pattern 3: Refactor Large Skill

**Before** (monolithic):
```
.claude/skills/api-helper/
└── SKILL.md  (1200 lines - everything)
```

**After** (organized):
```
.claude/skills/api-helper/
├── SKILL.md        (400 lines - core instructions)
├── reference.md    (500 lines - API documentation)
├── examples.md     (300 lines - examples)
└── scripts/
    └── validate.sh (API validation)
```

**Rationale**: Progressive disclosure - load core instructions first, supporting docs as needed.

#### Pattern 4: Add Context Isolation

**Before** (clutters main):
```yaml
---
name: data-analysis
description: Analyze datasets and generate reports
---
```

**After** (isolated):
```yaml
---
name: data-analysis
description: >
  Analyze datasets, generate statistics, create visualizations, produce reports.
  Use when processing CSV/JSON data, generating insights, or data exploration.
context: fork
agent: general-purpose
allowed-tools:
  - Read
  - Write
  - Bash(python:*)
---
```

**Rationale**: Complex multi-step analysis doesn't clutter main conversation.

#### Pattern 5: Add Validation Hooks

**Before** (no validation):
```yaml
---
name: deployment
description: Deploy application to production
allowed-tools:
  - Bash
---
```

**After** (validated):
```yaml
---
name: deployment
description: >
  Deploy application to production with security checks and validation.
  Use when deploying code, releasing versions, or production updates.
allowed-tools:
  - Read
  - Bash(git:*, npm:*, docker:*)
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/pre-deploy-check.sh $TOOL_INPUT"
          once: false
  PostToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/verify-deployment.sh"
  Stop:
    - type: command
      command: "./scripts/cleanup.sh"
---
```

**Rationale**: Validation prevents dangerous operations, verifies success, cleans up.

### Backward Compatibility

**Preserve Functionality**:
- Same skill name (unless renaming is goal)
- Same core capabilities
- Same expected behavior
- Test before/after

**Breaking Changes**:
- Document clearly
- Provide migration path
- Consider versioning (skill-name-v2)

**Safe Updates**:
- Adding tool restrictions (more secure)
- Improving description (better triggering)
- Reorganizing files (same functionality)
- Adding hooks (validation layer)

**Risky Updates**:
- Changing skill name (breaks invocation)
- Removing capabilities (breaks workflows)
- Changing behavior significantly
- Removing tools (breaks functionality)

### Update Validation Checklist

Before considering update complete:
- [ ] Validation script passes
- [ ] Name format correct (lowercase-hyphen)
- [ ] Description specific with triggers
- [ ] Tool restrictions added/verified
- [ ] Context isolation considered
- [ ] Hooks added if needed
- [ ] Supporting files organized
- [ ] Scripts executable
- [ ] Backward compatibility maintained
- [ ] Functionality tested
- [ ] No regressions introduced
- [ ] Documentation updated

### Batch Update Process

Updating multiple skills:

```bash
# Find all skills
find .claude/skills -name "SKILL.md" > skills-list.txt

# Validate each
while read skill; do
    dir=$(dirname "$skill")
    echo "Validating: $dir"
    ./scripts/validate-skill.sh "$dir"
done < skills-list.txt

# Prioritize updates by validation results
# Update high-priority first (security issues)
# Then medium-priority (quality issues)
# Then low-priority (optimizations)
```

## Migration Guide

### From Legacy Format
Legacy skills may use different structures. Convert to current format:

**Old**:
```yaml
trigger: "commit message"
tools: ["Read", "Bash"]
```

**New**:
```yaml
name: commit-helper
description: >
  Generate commit messages from git diffs, analyze changes, suggest formats.
  Use when creating commits, reviewing changes, or writing commit messages.
allowed-tools:
  - Read
  - Bash(git:*)
```

### From Unrestricted to Restricted

**Old** (no restrictions):
```yaml
---
name: helper
description: General helper
---
```

**New** (restricted):
```yaml
---
name: helper
description: >
  Specific description with exact capabilities and trigger keywords.
  Use when [specific scenarios].
allowed-tools:
  - Read
  - Grep
  - Glob
---
```

## Best Practices Summary

1. **Descriptions**: Specific, keyword-rich, under 1024 chars
2. **Instructions**: Essential info in SKILL.md, details in reference.md
3. **Tools**: Restrict to minimum needed for security
4. **Context**: Fork for complex workflows, main for simple tasks
5. **Hooks**: Use for validation, security, cleanup
6. **Scripts**: Executable, path with forward slashes
7. **Dependencies**: Document in description
8. **Organization**: One-level references, clear structure
9. **Testing**: Iterate on description for triggering
10. **Distribution**: Choose scope based on audience

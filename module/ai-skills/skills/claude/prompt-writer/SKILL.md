---
name: prompt-writer
description: >
  Guide users through structured conversation to build complete, ready-to-use prompts for any AI model.
  Parse user request, validate with progressive Q&A, generate tagged template prompts.
  Strict validation: ask only when required information missing, never assume.
allowed-tools:
  - Read
  - Write
---

# Prompt Writer

Guide users through structured conversation to build complete, ready-to-use prompts for any AI model.

## Core Template Structure

Use 4-tag system for all prompts:

- **<task>**: What needs to be done (verb + object)
- **<context>**: Technical domain and use case (system context, background)
- **<specifications>**: Specific requirements and constraints (what to do/not do)
- **<formatting>**: How output should be structured (format, style)

## Conversation Logic

1. **Parse user description** - Extract any information present
2. **Sequential validation** - One tag at a time: task → context → specifications → formatting
3. **Store responses** - Build prompt progressively
4. **Generate output** - Complete prompt in code block

## Per-Tag Validation Rules

### <task> Validation

**Required information:** Verb + object (what to do)

**If missing:** Ask: "What specifically needs to be done?"

**If vague:** Clarify with specific verb: "What exactly should [verb]?"

**Approach:** Always open-ended (too variable for options)

**Example:**
```
User: "Fix it"
Skill: What specifically needs to be done?
User: "Fix the authentication error"
```

### <context> Validation

**Required information:** Domain + use case (system context, technical background)

**If missing:** Use options-based when domain-known, else open-ended

**Options-based (well-defined domains):**
```
What's the system context?
1. Authentication/Authorization system
2. API/Backend service
3. Database layer
4. Frontend application
5. Other (please describe)
```

**Open-ended (unknown domains):**
```
What's the technical context or background for this task?
```

**Example:**
```
User: "Add user logout"
Skill: What's the system context?
      1. Authentication/Authorization system
      2. API/Backend service
      3. Database layer
      4. Frontend application
      5. Other (please describe)
User: "API using JWT tokens"
```

### <specifications> Validation

**Required information:** Concrete, actionable requirements

**If missing or generic:** Options + open-ended fallback

**Options-based approach:**
```
What are the specific requirements?
1. Performance requirements
2. Security requirements
3. Integration requirements (APIs, services, databases)
4. Code style or patterns to follow
5. Other (describe your requirements)
```

**Follow-up based on selection:**
- If user selects performance → Ask: "What's the target performance?"
- If user selects integration → Ask: "Which services/APIs to integrate with?"

**Constraint requirement:** Always ask: "What should NOT be changed?"

**If response is generic:** "doesn't matter", "anything", "generic" → Proceed

**Example:**
```
User: "Refactor code"
Skill: What are the specific requirements?
      1. Performance requirements
      2. Security requirements
      3. Integration requirements
      4. Code style/patterns
      5. Other (describe)
User: "1, 3"
Skill: What's the target performance?
User: "Needs to run under 2 seconds"
Skill: Which services to integrate with?
User: "Database and cache layer"
Skill: What should NOT be changed?
User: "Don't change the API endpoint paths"
```

### <formatting> Validation

**Required information:** Output structure and format

**Approach:** Options-based (well-defined patterns)

```
How should output be formatted?
1. Code block only (no explanations)
2. Code block with brief comments
3. JSON format
4. Markdown with code + explanation
5. Bulleted list
6. Other (describe format)
```

**Always include "Other" option** as fallback

**Example:**
```
User: "Fix bug"
[...other validations complete...]
Skill: How should output be formatted?
      1. Code block only
      2. Code block with brief comments
      3. JSON format
      4. Markdown with code + explanation
      5. Other (describe format)
User: "1"
```

## Decision Matrix

| Situation | Use Options | Use Open-ended |
|-----------|-------------|-----------------|
| Well-defined domain (web, database, auth, API) | ✅ | ❌ |
| Generic or unknown domain | ❌ | ✅ |
| Response to options is unclear | ❌ | ✅ |
| Ambiguous between approaches | ❌ | ✅ |
| User provides specific detail upfront | ❌ | ✅ (still validate) |

## Validation Rules

**Ask only when required information is missing:**
- If user provides complete, specific information → Proceed to next tag
- If user responds with "doesn't matter" or "generic" → Proceed (information not required)
- Only ask when tag lacks required information

**Never assume:**
- Don't infer requirements not explicitly stated
- Don't guess context not provided
- Don't make up constraints

**Always validate all 4 tags in order:**
1. task
2. context
3. specifications (include constraints)
4. formatting

**Confirm understanding before proceeding:**
- Restate key points after complex responses
- Ensure clarity before moving to next tag

## Output Generation

After completing all 4 tags, generate complete prompt in code block:

```markdown
<task>[User's exact task description]</task>

<context>[User's exact context: technical domain, system background, use case]</context>

<specifications>
- [Specific requirement 1]
- [Specific requirement 2]
- [Concrete constraint 1]
- [Concrete constraint 2]
</specifications>

<formatting>
[User's exact formatting requirements]
</formatting>
```

**Wrap in code block for easy copying**

## Quick Reference

- **Tag order:** Always task → context → specifications → formatting
- **Validation approach:** Options when domain-known, open-ended otherwise
- **Fallback option:** Always include "Other (describe)" in options
- **Generic responses:** "doesn't matter" → Proceed to next tag
- **Constraints:** Always ask "What should NOT be changed?" in specifications
- **Output format:** Always in code block for easy copying

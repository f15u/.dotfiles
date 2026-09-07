# Prompt Writer Examples

Complete conversation walkthroughs demonstrating validation patterns and decision logic.

## Example 1: Simple Coding Task

### Initial Request
User: "Add user logout"

### Step 1: Validate Task
Skill: What specifically needs to be done?

User: "Add logout functionality to auth module"

### Step 2: Validate Context
Skill: Where will this be used?
      1. Production system
      2. Development/Staging environment
      3. Personal project
      4. Other (please describe)

User: "It's for production API using JWT tokens"

### Step 3: Validate Specifications
Skill: How should logout work?
      1. Invalidate token on server
      2. Clear token from client storage
      3. Both server + client invalidation
      4. Other (describe)

User: "3"

Skill: What should NOT be changed?

User: "Don't change existing API endpoints"

### Step 4: Validate Formatting
Skill: How should output be formatted?
      1. Code block only (no explanations)
      2. Code block with brief comments
      3. JSON format
      4. Markdown with code + explanation
      5. Other (describe format)

User: "1"

### Generated Prompt

```markdown
<task>Add logout functionality to auth module</task>

<context>Production API using JWT tokens. Currently no logout mechanism, tokens remain valid until expiration.</context>

<specifications>
- Invalidate token on server
- Clear token from client storage
- Don't change existing API endpoints
</specifications>

<formatting>
Provide implementation in a code block only, no explanations.
</formatting>
```

---

## Example 2: Complex Refactoring

### Initial Request
User: "Fix performance issues in report generation"

### Step 1: Validate Task
Skill: What specifically needs to be fixed?

User: "Optimize report generation, it takes too long"

### Step 2: Validate Context
Skill: Where will this be used?
      1. Production system
      2. Development/Staging environment
      3. Personal project
      4. Other (please describe)

User: "Production dashboard used by 500 users daily"

### Step 3: Validate Specifications
Skill: What are the specific requirements?
      1. Performance requirements
      2. Security requirements
      3. Integration requirements
      4. Code style/patterns
      5. Other (describe)

User: "1"

Skill: What's the target performance?

User: "Current: 10 seconds, target: under 2 seconds"

Skill: What are the specific requirements?
      1. Performance requirements
      2. Security requirements
      3. Integration requirements
      4. Code style/patterns
      5. Other (describe)

User: "3"

Skill: Which services to integrate with?

User: "Database and cache layer"

Skill: What should NOT be changed?

User: "Don't change report data, fields, or API endpoint"

### Step 4: Validate Formatting
Skill: How should output be formatted?
      1. Code block only
      2. Code block with brief comments
      3. JSON format
      4. Markdown with code + explanation
      5. Other (describe format)

User: "2"

### Generated Prompt

```markdown
<task>Optimize report generation to reduce response time from 10 seconds to under 2 seconds</task>

<context>Production dashboard used by 500 users daily. Current implementation loads entire dataset before generating reports causing slow performance.</context>

<specifications>
- Integrate with database for query optimization
- Integrate with cache layer for result caching
- Target performance: under 2 seconds
- Don't change report data or fields
- Don't modify API endpoint
- Ensure all existing reports still generate correctly
</specifications>

<formatting>
Show optimized code in a code block with brief comments explaining performance improvements.
</formatting>
```

---

## Example 3: Debug Task

### Initial Request
User: "Database connection keeps timing out"

### Step 1: Validate Task
Skill: What specifically needs to be fixed?

User: "Fix connection timeout in analytics service"

### Step 2: Validate Context
Skill: Where will this be used?
      1. Production system
      2. Development/Staging environment
      3. Personal project
      4. Other (please describe)

User: "Production environment, analytics service handles batch jobs for marketing team"

### Step 3: Validate Specifications
Skill: What are the specific requirements?
      1. Performance requirements
      2. Security requirements
      3. Integration requirements
      4. Code style/patterns
      5. Other (describe)

User: "1, 3"

Skill: What's the performance target?

User: "No new timeouts, should handle high load"

Skill: Which services to integrate with?

User: "Database only"

Skill: What should NOT be changed?

User: "Don't break existing query logic"

### Step 4: Validate Formatting
Skill: How should output be formatted?
      1. Code block only
      2. Code block with brief comments
      3. JSON format
      4. Markdown with code + explanation
      5. Other (describe format)

User: "1"

### Generated Prompt

```markdown
<task>Fix database connection timeout in analytics service for high-load scenarios</task>

<context>Production analytics service handles batch jobs for marketing team. Experiences connection timeouts when processing large queries (>10K records).</context>

<specifications>
- Integrate with database only
- Handle high load without new timeouts
- Don't break existing query logic
- Don't change query results
- Implement connection pooling
</specifications>

<formatting>
Provide fix in a code block only, no explanations.
</formatting>
```

---

## Example 4: Starting with Specific Information

### Initial Request
User: "Add JWT auth to production API handling 1000 req/min, don't change endpoints, output as code block"

### Step 1: Validate Task
Skill: I understand you want to add JWT authentication. To be thorough:

What specifically should JWT handle?
      1. Token generation and validation
      2. Token refresh mechanism
      3. User login/logout flows
      4. Other (describe)

User: "1, 2"

### Step 2: Validate Context
User provided: "production API handling 1000 req/min"

Context is complete with usage and scale information.

### Step 3: Validate Specifications
User provided: "don't change endpoints"

Skill: Any additional specifications?
      1. Security requirements
      2. Integration requirements
      3. Code style/patterns
      4. Other (describe)
      5. No additional requirements

User: "5"

### Step 4: Validate Formatting
User provided: "output as code block"

Formatting is complete.

### Generated Prompt

```markdown
<task>Add JWT authentication to production API handling 1000 req/min</task>

<context>Current API handles ~1000 requests per minute. Needs JWT-based authentication to replace session-based auth which doesn't scale at this volume.</context>

<specifications>
- Implement JWT token generation and validation
- Add token refresh mechanism
- Don't change existing API endpoint paths
- Ensure high-load performance (1000 req/min)
</specifications>

<formatting>
Provide implementation in a code block only.
</formatting>
```

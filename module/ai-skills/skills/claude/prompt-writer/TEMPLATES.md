# Prompt Templates

Ready-to-use prompts generated from skill's Q&A process. Copy and paste to use.

## Template 1: Add Feature

```markdown
<task>Add user authentication to production API</task>

<context>API handles ~1000 req/min, currently uses session-based auth which doesn't scale. Users experience login issues under high load. Deployment to production scheduled in 2 weeks.</context>

<specifications>
- Implement JWT-based authentication
- Add token refresh mechanism with 1-hour expiration
- Secure all endpoints except /login and /register
- Use bcrypt for password hashing
- Handle token invalidation on logout
- Don't change existing API endpoint paths
- Don't modify existing user database schema
- Support concurrent login from multiple devices
</specifications>

<formatting>
Provide complete implementation in a code block. Include file paths and brief comments explaining key sections: token generation, validation, refresh logic.
</formatting>
```

---

## Template 2: Refactor Performance

```markdown
<task>Optimize report generation for production dashboard</task>

<context>Dashboard serves 500 users daily. Current implementation loads entire dataset before generating reports, causing 10-second response times. Target: under 2 seconds to improve user experience.</context>

<specifications>
- Add database query pagination
- Implement result caching with 5-minute TTL
- Optimize expensive joins
- Don't change report data structure or fields
- Don't modify API endpoint
- Ensure all existing reports still generate correctly
- Maintain backward compatibility with existing dashboards
</specifications>

<formatting>
Show optimized code in a code block with brief comments explaining performance improvements.
</formatting>
```

---

## Template 3: Debug Issue

```markdown
<task>Fix database connection timeout in analytics service</task>

<context>Production analytics service experiences 30-second timeouts when processing large queries (>10K records). Service handles batch analytics jobs for marketing team. Team currently manually re-running failed jobs.</context>

<specifications>
- Implement connection pooling for high-load scenarios
- Add retry logic for transient failures
- Ensure connection doesn't block on large queries
- Don't break existing query logic
- Don't change query results or data
- Log connection errors for monitoring
- Set reasonable timeout thresholds
</specifications>

<formatting>
Provide fix in a code block only, no explanations.
</formatting>
```

---

## Template 4: Review Code

```markdown
<task>Review authentication module for security vulnerabilities</task>

<context>Module handles user login, password reset, and session management. Recently added OAuth integration. Deployment to production scheduled in 2 weeks. Compliance requires security audit before release.</context>

<specifications>
- Check OWASP Top 10 vulnerabilities
- Verify OAuth implementation is secure
- Identify any hardcoded secrets or keys
- Check for SQL injection risks
- Verify password reset flow isn't exploitable
- Note any missing security headers
- Review session management for session fixation risks
- Don't refactor code, only identify issues
</specifications>

<formatting>
Provide findings in a structured list with severity (Critical/High/Medium/Low) and remediation suggestions for each vulnerability found.
</formatting>
```

---

## Template 5: Write Tests

```markdown
<task>Write unit tests for user service</task>

<context>User service handles CRUD operations, validation, and business logic. Currently 0% test coverage. Team uses Jest testing framework. Production deployment requires minimum 80% coverage.</context>

<specifications>
- Test all public methods
- Include edge cases (null inputs, invalid data, boundary conditions)
- Mock database calls
- Verify error handling
- Test business logic validation
- Don't refactor existing code
- Use existing Jest configuration and test patterns
- Achieve minimum 80% code coverage
</specifications>

<formatting>
Provide complete test file with describe blocks and it statements. Include brief comments explaining what each test covers.
</formatting>
```

---

## Template 6: Document Code

```markdown
<task>Add API documentation to payment service</task>

<context>Payment service processes transactions, refunds, and disputes. External partners need to integrate with this API. Currently undocumented. Integration timeline: 3 weeks.</context>

<specifications>
- Document all endpoints with HTTP methods and paths
- Include request/response schemas
- Provide example requests and responses
- Note authentication requirements
- List error codes and meanings
- Document rate limiting if applicable
- Don't change any API implementation
- Use OpenAPI/Swagger format
</specifications>

<formatting>
Provide documentation in OpenAPI/Swagger format as a code block.
</formatting>
```

---

## Template 7: Migrate System

```markdown
<task>Migrate from session-based to JWT authentication</task>

<context>Current implementation uses server-side sessions stored in Redis. Scaling issues with multiple servers - users lose session when requests hit different server. Need stateless authentication for horizontal scaling. Production deployment in 3 months.</context>

<specifications>
- Implement JWT token generation and validation
- Add token refresh mechanism
- Migrate existing user sessions to tokens
- Keep all existing API endpoints functional during migration
- Maintain backward compatibility
- Support concurrent login from multiple devices
- Implement graceful transition period (dual auth support)
- Don't break existing user data or sessions
- Clear Redis of expired sessions post-migration
</specifications>

<formatting>
Provide migration steps in code block with brief comments. Include file paths and what each file handles.
</formatting>
```

---

## Template 8: Optimize Database Queries

```markdown
<task>Optimize slow database queries in reporting module</task>

<context>Reporting module generates dashboards for 5000+ users. Current implementation runs 15+ complex queries per request. Average response time: 8 seconds. Target: under 2 seconds. Users abandoning dashboard due to slowness.</context>

<specifications>
- Add database indexes for frequently filtered columns
- Implement query result caching with 10-minute TTL
- Optimize joins and subqueries
- Batch similar queries where possible
- Consider denormalization for expensive calculations
- Don't change report data or calculations
- Ensure all existing reports still generate correctly
- Maintain data accuracy
- Add performance monitoring for slow queries
</specifications>

<formatting>
Show optimized queries in code block with brief comments explaining performance improvements.
</formatting>
```

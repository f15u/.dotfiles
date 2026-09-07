# Skill Builder Examples

Real-world skill implementations demonstrating various patterns and use cases.

## Basic Skills

### 1. Commit Message Generator

**Use Case**: Generate clear git commit messages from staged changes

```yaml
---
name: commit-helper
description: >
  Generate clear, conventional commit messages from git diffs.
  Use when writing commit messages, reviewing staged changes, or preparing commits.
allowed-tools:
  - Read
  - Bash(git:*)
---

# Commit Message Helper

Generate commit messages following conventional commit format.

## Process

1. Run `git diff --staged` to see changes
2. Analyze modifications:
   - Files changed
   - Functions/classes added/modified
   - Bug fixes vs features vs refactoring
3. Generate commit message:
   - Type: feat, fix, docs, style, refactor, test, chore
   - Scope: component/module affected
   - Description: imperative mood, under 50 chars
   - Body: detailed explanation if needed

## Format

```
type(scope): short description

Detailed explanation of what and why, not how.
Reference issue numbers if applicable.
```

## Examples

**Feature**:
```
feat(auth): add JWT token refresh mechanism

Implement automatic token refresh before expiration
to improve user experience and reduce login frequency.
```

**Bug Fix**:
```
fix(api): prevent race condition in user creation

Add transaction isolation to ensure user record
consistency during concurrent signup requests.
```

## Best Practices

- Present tense: "Add feature" not "Added feature"
- Imperative mood: "Fix bug" not "Fixes bug"
- Explain what and why, not implementation details
- Reference issues: "Closes #123"
- Keep summary under 50 characters
```

---

### 2. README Generator

**Use Case**: Generate project README files from codebase analysis

```yaml
---
name: readme-generator
description: >
  Generate comprehensive README.md files with installation, usage, and API documentation.
  Use when starting projects, documenting features, or updating project documentation.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
model: claude-opus-4-5-20251101
---

# README Generator

Generate comprehensive README.md files by analyzing project structure.

## Analysis Steps

1. Identify project type (language, framework)
2. Find entry points (main files, package.json, setup.py)
3. Extract dependencies from package files
4. Analyze code structure for features
5. Check for existing docs

## README Sections

### Essential
- Project title and description
- Installation instructions
- Quick start example
- Basic usage

### Standard
- Features list
- Configuration options
- API documentation
- Contributing guidelines
- License

### Optional
- Screenshots/demos
- Architecture overview
- Testing instructions
- Deployment guide
- FAQ

## Template

```markdown
# Project Name

Brief description of what this project does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

\`\`\`bash
npm install project-name
\`\`\`

## Quick Start

\`\`\`javascript
const project = require('project-name');
project.doSomething();
\`\`\`

## Usage

Detailed usage instructions with examples.

## API

Function and class documentation.

## Contributing

Contribution guidelines.

## License

MIT
```

## Best Practices

- Start with clear, concise description
- Include working code examples
- Document all configuration options
- Keep installation steps minimal
- Add badges for build status, coverage
- Include troubleshooting section if needed
```

---

## Security-Focused Skills

### 3. Secure Code Reviewer

**Use Case**: Review code for security vulnerabilities and best practices

```yaml
---
name: security-review
description: >
  Review code for security vulnerabilities: XSS, SQL injection, CSRF, authentication issues.
  Use when reviewing pull requests, auditing code, or checking security best practices.
  Checks OWASP Top 10 vulnerabilities.
allowed-tools:
  - Read
  - Grep
  - Glob
context: fork
agent: Explore
---

# Security Code Reviewer

Analyze code for security vulnerabilities and anti-patterns.

## Security Checks

### 1. Injection Vulnerabilities
- SQL injection (unsanitized queries)
- Command injection (shell execution with user input)
- LDAP injection
- XML injection

### 2. Authentication & Authorization
- Weak password policies
- Missing authentication checks
- Insufficient authorization
- Session management issues

### 3. Cross-Site Scripting (XSS)
- Unescaped output
- Unsafe DOM manipulation
- User input in HTML context

### 4. Sensitive Data Exposure
- Hardcoded credentials
- Unencrypted sensitive data
- Logging sensitive information
- Exposed API keys

### 5. Security Misconfiguration
- Debug mode in production
- Default credentials
- Unnecessary features enabled
- Missing security headers

### 6. Insecure Dependencies
- Outdated packages with known vulnerabilities
- Dependencies from untrusted sources

## Analysis Process

1. **Input Validation**
   - Check all user input handling
   - Verify sanitization and validation
   - Look for trust boundary violations

2. **Authentication/Authorization**
   - Review auth logic
   - Check permission enforcement
   - Validate session handling

3. **Data Protection**
   - Find hardcoded secrets
   - Check encryption usage
   - Review data storage

4. **Code Patterns**
   - Unsafe function usage
   - Dangerous APIs
   - Deprecated security practices

## Report Format

```
# Security Review Report

## Critical Issues (Immediate Action Required)
1. [Issue description] - Location: file.js:line

## High Priority
2. [Issue description] - Location: file.js:line

## Medium Priority
3. [Issue description] - Location: file.js:line

## Recommendations
- [Best practice suggestions]
```

## Common Patterns to Flag

### SQL Injection
```javascript
// BAD
const query = `SELECT * FROM users WHERE id = ${userId}`;

// GOOD
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

### XSS
```javascript
// BAD
element.innerHTML = userInput;

// GOOD
element.textContent = userInput;
```

### Command Injection
```javascript
// BAD
exec(`git log ${userInput}`);

// GOOD
execFile('git', ['log', userInput]);
```
```

---

## Workflow Automation Skills

### 4. Test Runner & Fixer

**Use Case**: Run tests, identify failures, fix issues automatically

```yaml
---
name: test-runner
description: >
  Run tests, analyze failures, suggest fixes, and implement solutions.
  Use when running test suites, debugging test failures, or ensuring code quality.
  Handles unit tests, integration tests, and e2e tests.
allowed-tools:
  - Read
  - Edit
  - Bash(npm:test, npm:run, pytest:*, cargo:test)
context: fork
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "echo 'Running tests...' >> test-log.txt"
  PostToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/parse-test-results.sh"
---

# Test Runner & Fixer

Run tests, analyze failures, and implement fixes automatically.

## Workflow

1. **Detect Test Framework**
   - Jest/Vitest (JavaScript)
   - pytest (Python)
   - cargo test (Rust)
   - go test (Go)

2. **Run Tests**
   - Execute full test suite
   - Capture output and errors
   - Parse failure messages

3. **Analyze Failures**
   - Identify failing tests
   - Extract error messages
   - Locate source of failure
   - Categorize by type

4. **Fix Issues**
   - Logic errors: Update implementation
   - Assertion failures: Fix expectations or code
   - Setup/teardown: Repair test infrastructure
   - Flaky tests: Add stability improvements

5. **Verify Fixes**
   - Run tests again
   - Ensure no regressions
   - Report results

## Test Failure Categories

### Logic Errors
Test expects different behavior than implementation provides.
**Fix**: Update implementation logic

### Broken Tests
Test assumptions invalid after code changes.
**Fix**: Update test expectations

### Environment Issues
Tests fail due to setup/configuration problems.
**Fix**: Update test setup/teardown

### Flaky Tests
Tests pass/fail non-deterministically.
**Fix**: Add waits, fix race conditions, mock time

## Example Fixes

### Assertion Failure
```javascript
// Test failure
expect(sum(2, 2)).toBe(5); // Expected 5, got 4

// Fix implementation
function sum(a, b) {
  return a + b; // Works correctly

// OR fix test expectation
expect(sum(2, 2)).toBe(4); // Correct expectation
```

### Async Issue
```javascript
// Flaky test
test('fetch data', () => {
  const data = fetchData();
  expect(data).toBeDefined(); // Sometimes fails

// Fix
test('fetch data', async () => {
  const data = await fetchData();
  expect(data).toBeDefined(); // Reliable
```

## Report Format

```
# Test Run Report

## Summary
- Total: 150 tests
- Passed: 147
- Failed: 3
- Duration: 12.5s

## Failures

### 1. UserService.createUser
**Location**: src/services/user.test.js:45
**Error**: Expected status 201, got 400
**Cause**: Validation missing for email format
**Fix**: Added email validation in UserService

### 2. API.fetchPosts (flaky)
**Location**: tests/api.test.js:78
**Error**: Timeout waiting for response
**Cause**: No timeout handling
**Fix**: Added 5s timeout to fetch call

## All Tests Passing ✓
```
```

---

### 5. PR Review Assistant

**Use Case**: Comprehensive pull request review with feedback

```yaml
---
name: pr-reviewer
description: >
  Review pull requests for code quality, style, logic, security, and best practices.
  Use when reviewing PRs, providing feedback, or ensuring code standards.
  Checks style, tests, documentation, and breaking changes.
allowed-tools:
  - Read
  - Grep
  - Bash(git:*, gh:*)
context: fork
model: claude-opus-4-5-20251101
---

# PR Review Assistant

Comprehensive pull request review with actionable feedback.

## Review Checklist

### Code Quality
- [ ] Clear, readable code
- [ ] Appropriate abstractions
- [ ] No code duplication
- [ ] Proper error handling
- [ ] Edge cases covered

### Testing
- [ ] Tests for new features
- [ ] Tests for bug fixes
- [ ] Existing tests still pass
- [ ] Test coverage maintained/improved

### Documentation
- [ ] Comments for complex logic
- [ ] README updated if needed
- [ ] API docs updated
- [ ] Changelog entry

### Security
- [ ] No security vulnerabilities
- [ ] Input validation present
- [ ] Sensitive data protected
- [ ] Dependencies secure

### Performance
- [ ] No obvious bottlenecks
- [ ] Efficient algorithms
- [ ] Resource usage reasonable

### Style
- [ ] Consistent with codebase
- [ ] Follows style guide
- [ ] Linting passes
- [ ] Naming conventions followed

## Review Process

1. **Understand Changes**
   - Read PR description
   - Check linked issues
   - Review diff overview
   - Identify affected components

2. **Analyze Code**
   - Review each file
   - Check logic correctness
   - Identify potential issues
   - Note improvements

3. **Check Tests**
   - Verify test coverage
   - Review test quality
   - Check edge cases

4. **Security Scan**
   - Look for vulnerabilities
   - Check input handling
   - Review auth/authz

5. **Provide Feedback**
   - Categorize by severity
   - Suggest specific improvements
   - Include code examples
   - Note positive aspects

## Feedback Format

```markdown
# PR Review: [PR Title]

## Summary
Brief overview of changes and overall assessment.

## Strengths
- Clear implementation
- Good test coverage
- Well-documented

## Issues

### Critical (Must Fix)
**File**: src/auth.js:45
**Issue**: SQL injection vulnerability
**Suggestion**:
\`\`\`javascript
// Current
db.query(\`SELECT * FROM users WHERE id = ${id}\`);

// Suggested
db.query('SELECT * FROM users WHERE id = ?', [id]);
\`\`\`

### Important (Should Fix)
**File**: src/api.js:120
**Issue**: Missing error handling
**Suggestion**: Add try-catch around async operation

### Minor (Nice to Have)
**File**: src/utils.js:78
**Issue**: Variable naming could be clearer
**Suggestion**: Rename `x` to `userId` for clarity

## Recommendations
- Add integration tests for auth flow
- Document new API endpoints
- Consider edge case: empty user list

## Approval Status
- [ ] Approved
- [ ] Approved with minor comments
- [x] Changes requested
```

## Severity Levels

### Critical
- Security vulnerabilities
- Breaking changes without migration
- Data loss risks
- Major logic errors

### Important
- Missing error handling
- Incomplete functionality
- Missing tests
- Performance issues

### Minor
- Style inconsistencies
- Naming improvements
- Optimization opportunities
- Documentation clarity
```

---

## Data Processing Skills

### 6. CSV Data Analyzer

**Use Case**: Analyze CSV files, generate statistics, clean data

```yaml
---
name: csv-analyzer
description: >
  Analyze CSV files, generate statistics, clean data, detect patterns, and create visualizations.
  Use when processing datasets, cleaning data, or generating reports from CSV files.
  Requires pandas and matplotlib.
allowed-tools:
  - Read
  - Write
  - Bash(python:*)
---

# CSV Data Analyzer

Analyze and process CSV files with Python pandas.

## Capabilities

- Load and parse CSV files
- Generate statistical summaries
- Detect missing/invalid data
- Clean and normalize data
- Find correlations and patterns
- Create visualizations
- Export processed data

## Analysis Workflow

1. **Load Data**
```python
import pandas as pd
df = pd.read_csv('data.csv')
```

2. **Inspect Structure**
```python
print(df.info())
print(df.describe())
print(df.head())
```

3. **Check Quality**
```python
# Missing values
print(df.isnull().sum())

# Duplicates
print(df.duplicated().sum())

# Data types
print(df.dtypes)
```

4. **Clean Data**
```python
# Drop missing
df = df.dropna()

# Fill missing
df = df.fillna(df.mean())

# Remove duplicates
df = df.drop_duplicates()

# Convert types
df['date'] = pd.to_datetime(df['date'])
```

5. **Analyze**
```python
# Statistics
print(df['column'].mean())
print(df['column'].median())
print(df.groupby('category').sum())

# Correlations
print(df.corr())
```

6. **Visualize**
```python
import matplotlib.pyplot as plt

df['column'].hist()
plt.savefig('histogram.png')

df.plot(x='date', y='value')
plt.savefig('line-plot.png')
```

7. **Export**
```python
df.to_csv('cleaned-data.csv', index=False)
```

## Common Operations

### Filter Rows
```python
filtered = df[df['age'] > 18]
filtered = df[df['status'].isin(['active', 'pending'])]
```

### Aggregate Data
```python
summary = df.groupby('category').agg({
    'sales': 'sum',
    'quantity': 'mean'
})
```

### Transform Columns
```python
df['total'] = df['price'] * df['quantity']
df['normalized'] = (df['value'] - df['value'].mean()) / df['value'].std()
```

### Merge Datasets
```python
merged = pd.merge(df1, df2, on='id', how='inner')
```

## Report Template

```
# CSV Analysis Report

## Dataset Overview
- Rows: 1,234
- Columns: 15
- File size: 2.5 MB

## Data Quality
- Missing values: 45 (3.6%)
- Duplicates: 12 (0.9%)
- Invalid entries: 3

## Key Statistics
- Average value: 45.67
- Median: 42.00
- Std deviation: 12.34
- Min: 10.00
- Max: 98.50

## Insights
1. Strong correlation (0.85) between X and Y
2. 80% of records in 'active' status
3. Seasonal pattern in sales data

## Recommendations
- Clean 45 missing values
- Remove duplicate entries
- Fix date format in 'purchase_date' column
```

## Requirements

```bash
pip install pandas matplotlib numpy
```
```

---

## Advanced Pattern: Multi-Stage Workflow

### 7. Feature Implementer

**Use Case**: Complete feature implementation from planning to deployment

```yaml
---
name: feature-implementer
description: >
  Implement complete features from planning through testing and documentation.
  Use when adding new features, building components, or implementing requirements.
  Handles planning, coding, testing, and documentation.
context: fork
model: claude-opus-4-5-20251101
hooks:
  Stop:
    - type: command
      command: "./scripts/feature-checklist.sh"
---

# Feature Implementer

Complete feature implementation workflow from design to deployment.

## Implementation Stages

### 1. Planning
- [ ] Understand requirements
- [ ] Review existing code
- [ ] Design approach
- [ ] Identify files to modify
- [ ] Consider edge cases

### 2. Implementation
- [ ] Write core functionality
- [ ] Handle errors gracefully
- [ ] Follow code standards
- [ ] Add input validation
- [ ] Consider performance

### 3. Testing
- [ ] Write unit tests
- [ ] Add integration tests
- [ ] Test edge cases
- [ ] Verify error handling
- [ ] Check performance

### 4. Documentation
- [ ] Add code comments
- [ ] Update API docs
- [ ] Update README if needed
- [ ] Add usage examples

### 5. Review
- [ ] Self-review changes
- [ ] Run linter
- [ ] Check test coverage
- [ ] Verify no regressions

## Example: Add User Search Feature

### Planning
```
Requirement: Add search functionality to user list

Files to modify:
- src/components/UserList.tsx (add search UI)
- src/services/UserService.ts (add search API)
- src/api/users.ts (add endpoint)
- tests/UserList.test.tsx (add tests)

Approach:
- Client-side filtering for <100 users
- Server-side search for larger datasets
- Debounce input for performance
```

### Implementation
```typescript
// src/services/UserService.ts
export class UserService {
  async searchUsers(query: string): Promise<User[]> {
    if (query.length < 2) return [];

    try {
      const response = await api.get('/users/search', {
        params: { q: query }
      });
      return response.data;
    } catch (error) {
      console.error('Search failed:', error);
      throw new Error('Failed to search users');
    }
  }
}
```

### Testing
```typescript
// tests/UserService.test.ts
describe('UserService.searchUsers', () => {
  it('returns empty array for short queries', async () => {
    const results = await service.searchUsers('a');
    expect(results).toEqual([]);
  });

  it('searches users by name', async () => {
    const results = await service.searchUsers('john');
    expect(results).toContainEqual(
      expect.objectContaining({ name: 'John' })
    );
  });

  it('handles API errors gracefully', async () => {
    mockApi.get.mockRejectedValue(new Error('Network error'));
    await expect(service.searchUsers('test')).rejects.toThrow();
  });
});
```

### Documentation
```markdown
## User Search

Search users by name or email.

### Usage

\`\`\`typescript
const users = await userService.searchUsers('john');
\`\`\`

### Parameters
- `query` (string): Search term (minimum 2 characters)

### Returns
- `Promise<User[]>`: Matching users

### Errors
- Throws `Error` if search fails
```

## Completion Checklist

Before marking feature complete:
- [ ] All code written and reviewed
- [ ] Tests passing (unit + integration)
- [ ] Documentation updated
- [ ] No linting errors
- [ ] No security issues
- [ ] Performance acceptable
- [ ] Edge cases handled
- [ ] Error handling present
- [ ] Code follows style guide
- [ ] Ready for PR review
```

---

## Quick Reference

### Minimal Skill Template
```yaml
---
name: my-skill
description: What it does and when to use it
---

# Skill Name

Instructions here.
```

### Read-Only Skill Template
```yaml
---
name: analyzer
description: Analyze code without modifications
allowed-tools: [Read, Grep, Glob]
---
```

### Isolated Workflow Template
```yaml
---
name: complex-task
description: Multi-step workflow in isolated context
context: fork
agent: general-purpose
---
```

### Secure Skill Template
```yaml
---
name: secure-task
description: Task with security validation
allowed-tools: [Read, Bash(git:*)]
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
---
```

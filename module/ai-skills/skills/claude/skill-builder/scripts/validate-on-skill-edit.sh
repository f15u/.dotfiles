#!/usr/bin/env bash
# Validate skill edits immediately after Write/Edit operations
# Intercepts tool input and validates if SKILL.md was modified

set -e

# Read tool input from stdin
TOOL_INPUT=$(cat)

# Extract file path if available
FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.filePath // empty')

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if this is a SKILL.md edit
if [[ -n "$FILE_PATH" && "$FILE_PATH" == *"SKILL.md" ]]; then
    echo -e "${GREEN}[Skill Validation]${NC} Validating SKILL.md modification: $FILE_PATH"
    
    # Get the directory containing the skill
    SKILL_DIR=$(dirname "$FILE_PATH")
    
    # Run validation
    if "$0/../validate-skill.sh" "$SKILL_DIR" 2>/dev/null; then
        echo -e "${GREEN}[Skill Validation]${NC} ✓ Skill validation passed"
        exit 0
    else
        # Check exit code to determine severity
        EXIT_CODE=$?
        if [ $EXIT_CODE -eq 1 ]; then
            echo -e "${YELLOW}[Skill Validation]${NC} ⚠ Skill validation passed with warnings"
            exit 1  # Warn but allow
        else
            echo -e "${RED}[Skill Validation]${NC} ✗ Skill validation failed - blocking edit"
            echo "Use 'validate-skill.sh $SKILL_DIR' to see details"
            exit 2  # Block the edit
        fi
    fi
else
    # Not a SKILL.md edit, allow without validation
    exit 0
fi
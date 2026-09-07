#!/bin/bash
# Initialize a new Claude Code skill with proper structure and templates.
#
# Usage:
#     scripts/init_skill.sh <skill-name> --path <output-directory>

set -e

# Check arguments
if [ $# -lt 3 ] || [ "$2" != "--path" ]; then
    echo "Usage: $0 <skill-name> --path <output-directory>"
    echo ""
    echo "Examples:"
    echo "  $0 my-new-skill --path .claude/skills"
    echo "  $0 my-api-helper --path ~/.claude/skills"
    exit 1
fi

SKILL_NAME="$1"
BASE_PATH="$3"

# Validate skill name (lowercase, hyphens only)
if ! [[ "$SKILL_NAME" =~ ^[a-z0-9-]+$ ]]; then
    echo "Error: Skill name must contain only lowercase letters, numbers, and hyphens" >&2
    exit 1
fi

# Convert skill-name to "Skill Name" for title
SKILL_TITLE=$(echo "$SKILL_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1')

SKILL_DIR="$BASE_PATH/$SKILL_NAME"

# Check if directory already exists
if [ -d "$SKILL_DIR" ]; then
    echo "Error: Skill directory already exists: $SKILL_DIR" >&2
    exit 1
fi

# Create directories
mkdir -p "$SKILL_DIR"/{scripts,references,assets}

# Create SKILL.md
cat > "$SKILL_DIR/SKILL.md" <<EOF
---
name: $SKILL_NAME
description: >
  TODO: Add description. Include what the skill does and when to use it.
  List specific capabilities and trigger keywords.
---

# $SKILL_TITLE

TODO: Add skill instructions here.

## Usage

TODO: Add usage instructions and examples.

## Resources

This skill includes example resource directories:

### scripts/
Executable code that can be run directly. Delete if not needed.

### references/
Documentation loaded into context as needed. Delete if not needed.

### assets/
Files used in output (templates, images). Delete if not needed.
EOF

# Create example script
cat > "$SKILL_DIR/scripts/example.sh" <<'EOF'
#!/bin/bash
# Example shell script for the skill.
# Delete this if not needed.

echo "Example script - replace with actual implementation"
EOF
chmod +x "$SKILL_DIR/scripts/example.sh"

# Create reference.md
cat > "$SKILL_DIR/reference.md" <<EOF
# Reference Documentation

TODO: Add detailed API documentation, schemas, or reference material here.
This file is loaded into context only when Claude needs it.

Delete this file if not needed.
EOF

# Create examples.md
cat > "$SKILL_DIR/examples.md" <<EOF
# Examples

TODO: Add usage examples here.

## Example 1: Basic Usage

[Description]

\`\`\`
[Code example]
\`\`\`

Delete this file if not needed.
EOF

# Create README in references directory
cat > "$SKILL_DIR/references/README.md" <<EOF
# References

Add additional reference documentation files here.
Delete this README if not needed.
EOF

# Create README in assets directory
cat > "$SKILL_DIR/assets/README.md" <<EOF
# Assets

Add templates, images, and other output files here.
Delete this README if not needed.
EOF

echo "✓ Created skill directory: $SKILL_DIR"
echo "✓ Created SKILL.md with template"
echo "✓ Created example scripts in scripts/"
echo "✓ Created example reference files"
echo ""
echo "Next steps:"
echo "1. Edit $SKILL_DIR/SKILL.md and fill in the TODOs"
echo "2. Add or remove files in scripts/, references/, and assets/ as needed"
echo "3. Test the skill"

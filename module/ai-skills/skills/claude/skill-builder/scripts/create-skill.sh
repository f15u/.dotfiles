#!/usr/bin/env bash
# Create a new Claude Code skill from template

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Get skill name
if [ -z "$1" ]; then
    echo "Usage: $0 <skill-name> [scope]"
    echo ""
    echo "scope:"
    echo "  project  - .claude/skills/ (default)"
    echo "  personal - ~/.claude/skills/"
    exit 1
fi

SKILL_NAME="$1"
SCOPE="${2:-project}"

# Validate skill name
if [[ ! "$SKILL_NAME" =~ ^[a-z0-9-]+$ ]]; then
    echo -e "${YELLOW}Error: Skill name must be lowercase with hyphens only${NC}"
    exit 1
fi

# Determine directory
if [ "$SCOPE" = "personal" ]; then
    SKILL_DIR="$HOME/.claude/skills/$SKILL_NAME"
else
    SKILL_DIR=".claude/skills/$SKILL_NAME"
fi

# Check if exists
if [ -d "$SKILL_DIR" ]; then
    echo -e "${YELLOW}Error: Skill already exists at $SKILL_DIR${NC}"
    exit 1
fi

# Create directory
echo -e "${BLUE}Creating skill: $SKILL_NAME${NC}"
mkdir -p "$SKILL_DIR"

# Create SKILL.md template
cat > "$SKILL_DIR/SKILL.md" << 'EOF'
---
name: SKILL_NAME
description: >
  Brief description of what this skill does.
  Include trigger keywords users would say.
  List specific capabilities.
---

# SKILL_NAME

Short introduction to the skill's purpose.

## Instructions

1. Step one
2. Step two
3. Step three

## Usage

Provide usage examples and guidance.

## Example

```bash
# Example command or code
```

## Best Practices

- Practice one
- Practice two
- Practice three
EOF

# Replace SKILL_NAME placeholder
sed -i "s/SKILL_NAME/$SKILL_NAME/g" "$SKILL_DIR/SKILL.md"

echo -e "${GREEN}✓ Created $SKILL_DIR/SKILL.md${NC}"

# Ask about optional files
echo ""
echo "Create optional files? (y/n)"
echo "  - reference.md (detailed documentation)"
echo "  - examples.md (usage examples)"
echo "  - scripts/ (utility scripts)"
read -p "Create optional files? [y/N]: " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Create reference.md
    cat > "$SKILL_DIR/reference.md" << 'EOF'
# SKILL_NAME Reference

Detailed API documentation and reference material.

## Configuration

Document configuration options here.

## API

Document functions, classes, and interfaces.

## Advanced Usage

Document advanced patterns and techniques.
EOF
    sed -i "s/SKILL_NAME/$SKILL_NAME/g" "$SKILL_DIR/reference.md"
    echo -e "${GREEN}✓ Created reference.md${NC}"

    # Create examples.md
    cat > "$SKILL_DIR/examples.md" << 'EOF'
# SKILL_NAME Examples

Real-world usage examples and patterns.

## Example 1: Basic Usage

Description of what this example demonstrates.

```bash
# Example code
```

## Example 2: Advanced Usage

Description of advanced pattern.

```bash
# Example code
```

## Common Patterns

Document common usage patterns.
EOF
    sed -i "s/SKILL_NAME/$SKILL_NAME/g" "$SKILL_DIR/examples.md"
    echo -e "${GREEN}✓ Created examples.md${NC}"

    # Create scripts directory
    mkdir -p "$SKILL_DIR/scripts"
    echo -e "${GREEN}✓ Created scripts/${NC}"
fi

echo ""
echo -e "${GREEN}✓ Skill created successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit $SKILL_DIR/SKILL.md"
echo "  2. Update name and description in frontmatter"
echo "  3. Add instructions and examples"
echo "  4. Test with: /skill-builder validate $SKILL_DIR"
echo ""
echo "Location: $SKILL_DIR"

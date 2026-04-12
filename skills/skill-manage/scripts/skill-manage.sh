#!/bin/bash
# skill-manage.sh — CRUD operations on workspace skills
# Usage: skill-manage.sh <action> <skill-name> [options]

SKILLS_DIR="${SKILLS_DIR:-$HOME/.openclaw/workspace-hermes/skills}"
ACTION="$1"
SKILL_NAME="$2"
CONTENT="$3"

validate_name() {
    local name="$1"
    if [[ ! "$name" =~ ^[a-z0-9][a-z0-9-]{0,63}$ ]]; then
        echo "Error: Invalid skill name '$name'. Use lowercase letters, digits, hyphens. Max 64 chars."
        return 1
    fi
}

create_skill() {
    local name="$1"
    local desc="$2"
    validate_name "$name" || return 1

    local skill_dir="$SKILLS_DIR/$name"
    if [ -d "$skill_dir" ]; then
        echo "Error: Skill '$name' already exists at $skill_dir"
        return 1
    fi

    mkdir -p "$skill_dir/scripts" "$skill_dir/references" "$skill_dir/templates"

    cat > "$skill_dir/SKILL.md" << EOF
---
name: $name
description: ${desc:-"TODO: Add description"}
---

# ${name}

## When to use
TODO

## Steps
1. TODO

## Pitfalls
- None known

## Verification
- TODO
EOF

    echo "Created skill: $skill_dir"
}

delete_skill() {
    local name="$1"
    validate_name "$name" || return 1

    local skill_dir="$SKILLS_DIR/$name"
    if [ ! -d "$skill_dir" ]; then
        echo "Error: Skill '$name' not found at $skill_dir"
        return 1
    fi

    rm -rf "$skill_dir"
    echo "Deleted skill: $skill_dir"
}

list_skills() {
    if [ ! -d "$SKILLS_DIR" ]; then
        echo "No skills directory found at $SKILLS_DIR"
        return 1
    fi

    echo "Skills in $SKILLS_DIR:"
    for dir in "$SKILLS_DIR"/*/; do
        [ -d "$dir" ] || continue
        local name=$(basename "$dir")
        local desc=""
        if [ -f "$dir/SKILL.md" ]; then
            desc=$(grep -m1 "^description:" "$dir/SKILL.md" 2>/dev/null | sed 's/^description: *//')
        fi
        echo "  - $name: ${desc:-'(no description)'}"
    done
}

show_skill() {
    local name="$1"
    validate_name "$name" || return 1

    local skill_dir="$SKILLS_DIR/$name"
    if [ ! -d "$skill_dir" ]; then
        echo "Error: Skill '$name' not found"
        return 1
    fi

    echo "=== $name ==="
    find "$skill_dir" -type f | while read f; do
        echo "  ${f#$skill_dir/}"
    done
}

case "$ACTION" in
    create)
        create_skill "$SKILL_NAME" "$CONTENT"
        ;;
    delete)
        delete_skill "$SKILL_NAME"
        ;;
    list)
        list_skills
        ;;
    show)
        show_skill "$SKILL_NAME"
        ;;
    *)
        echo "Usage: skill-manage.sh <action> <skill-name> [description]"
        echo "Actions: create, delete, list, show"
        exit 1
        ;;
esac

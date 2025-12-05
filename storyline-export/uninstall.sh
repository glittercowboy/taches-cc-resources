#!/bin/bash
# Storyline uninstaller

set -e

echo "📖 Uninstalling Storyline..."
echo ""

# Remove skills
echo "Removing Storyline skills..."
rm -rf ~/.claude/skills/epic-creator
rm -rf ~/.claude/skills/story-creator
rm -rf ~/.claude/skills/spec-story
rm -rf ~/.claude/skills/dev-story

# Remove commands
echo "Removing Storyline commands..."
rm -f ~/.claude/commands/epic-creator.md
rm -f ~/.claude/commands/story-creator.md
rm -f ~/.claude/commands/spec-story.md
rm -f ~/.claude/commands/dev-story.md

echo ""
echo "✅ Storyline uninstalled successfully!"
echo ""
echo "Note: taches-cc-resources (dependency) was NOT removed."
echo "To remove it, manually delete:"
echo "  ~/.claude/skills/create-plans"
echo "  ~/.claude/skills/create-agent-skills"
echo "  (and other taches skills/commands as needed)"

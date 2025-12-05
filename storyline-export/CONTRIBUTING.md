# Contributing to Storyline

Thank you for your interest in contributing! Storyline is an open-source project that benefits from community contributions.

## Ways to Contribute

### 1. Report Bugs
Found a bug? Open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your environment (OS, Claude Code version)

### 2. Suggest Enhancements
Have an idea? Open an issue with:
- Use case description
- Proposed solution
- How it fits the story-driven workflow

### 3. Improve Documentation
- Fix typos
- Clarify confusing sections
- Add examples
- Improve README

### 4. Contribute Code

#### Before You Start
1. Check existing issues to avoid duplicate work
2. For large changes, open an issue first to discuss
3. Read the skill development patterns in taches-cc-resources

#### Development Setup
```bash
# Fork the repo on GitHub

# Clone your fork
git clone https://github.com/YOUR_USERNAME/storyline.git
cd storyline

# Install locally to test
./install.sh

# Make changes to skills/ or commands/

# Test your changes in Claude Code
# (start new session to reload skills)
```

#### Pull Request Process
1. Create a feature branch: `git checkout -b feature/my-feature`
2. Make your changes
3. Test thoroughly with Claude Code
4. Commit with clear messages
5. Push to your fork
6. Open a pull request

**PR Guidelines:**
- Clear title describing the change
- Description explaining why and what
- Reference related issues
- Include before/after examples if applicable

### 5. Improve Skills

#### Skill Development Standards

Follow patterns from taches-cc-resources:
- **Router pattern** for complex skills
- **Pure XML structure** (no markdown headings in skill body)
- **Progressive disclosure** (load only what's needed)
- **Clear workflows** in workflows/ directory
- **Reusable references** in references/ directory
- **Consistent templates** in templates/ directory

#### Testing Skills
```bash
# After modifying a skill
./install.sh  # Reinstall

# Start new Claude Code session

# Test the skill with example workflow
/epic-creator examples/sample-workflow/PRD.md

# Verify output quality
# Check for errors
# Ensure traceability maintained
```

## Code Style

### Markdown Files
- Use clear, descriptive headings
- Include examples where helpful
- Keep line length reasonable (<100 chars)
- Use code blocks with language tags

### YAML Frontmatter
```yaml
---
name: skill-name           # lowercase-with-hyphens
description: ...           # Clear, concise, when to use
---
```

### XML Structure
```xml
<objective>Clear goal</objective>
<process>Step-by-step</process>
<success_criteria>Measurable outcomes</success_criteria>
```

## Attribution

This project builds on taches-cc-resources. When contributing:
- Respect the original framework's patterns
- Maintain compatibility with create-plans
- Credit patterns adapted from taches

## Questions?

Open an issue or start a discussion. We're here to help!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for helping make Storyline better!** 🙏

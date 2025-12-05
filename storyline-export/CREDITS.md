# Credits

## Attribution

Storyline is built on the foundation of **[taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources)** by **[glittercowboy](https://github.com/glittercowboy)**.

## Core Dependencies

The following skills and patterns from taches-cc-resources power Storyline:

### `create-plans` Skill
- **Author**: glittercowboy
- **Purpose**: Hierarchical project planning for solo developer + Claude workflows
- **How we use it**: Powers the `/dev-story` command, executing technical specs with atomic task breakdown, quality controls, and git integration
- **License**: As specified in [taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources)

### `create-agent-skills` Skill
- **Author**: glittercowboy
- **Purpose**: Framework for building Claude Code skills
- **How we use it**: All Storyline skills follow the patterns and principles established in this skill (router pattern, progressive disclosure, XML structure)
- **License**: As specified in [taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources)

### `create-meta-prompts` Skill
- **Author**: glittercowboy
- **Purpose**: Staged workflow generation with dependency detection
- **How we use it**: Influences the pipeline architecture (epic → story → spec → implementation)
- **License**: As specified in [taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources)

## Architecture Patterns

The following architectural patterns from taches-cc-resources are used throughout Storyline:

1. **Router Pattern**: Skills use `SKILL.md` as a router to appropriate workflows
2. **Progressive Disclosure**: Load only necessary reference files per workflow
3. **Pure XML Structure**: No markdown headings in skill bodies, semantic XML tags
4. **Autonomous Execution**: Subagents execute with fresh context to prevent degradation
5. **Quality Gates**: Validation and verification at each stage

## Philosophy

The core philosophy of Storyline inherits from taches-cc-resources:

> "When you use a tool like Claude Code, it's your responsibility to assume everything is possible. Dream big. Happy building."
>
> — glittercowboy ([taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources))

Storyline extends this philosophy to story-driven development, making it possible to go from product requirements to working code through a structured, traceable workflow.

## Direct Inspiration

Specific concepts adapted from taches-cc-resources:

- **Deviation Rules**: The 5 embedded rules for handling deviations during execution (auto-fix bugs, auto-add critical, auto-fix blockers, ask architectural, log enhancements)
- **Scope Control**: Aggressive atomicity (2-3 tasks per plan) to maintain quality
- **Context Management**: Monitoring token usage and auto-handoffs
- **Solo Developer + Claude**: Planning for ONE person (user as visionary) and ONE implementer (Claude as builder)
- **Plans Are Prompts**: PLAN.md IS the prompt, not documentation

## License Compatibility

Storyline is released under the MIT License. We have ensured that our usage of taches-cc-resources patterns and dependencies is compatible with the original project's licensing.

## Acknowledgments

Special thanks to **glittercowboy** for:
- Creating the taches-cc-resources framework that makes Storyline possible
- Establishing best practices for Claude Code skill development
- Pioneering the concept of autonomous, self-healing Claude workflows
- Building a foundation that enables the broader Claude Code community to create powerful tools

## Contributing Back

If you discover improvements to the core patterns while using Storyline, we encourage you to contribute them back to [taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources).

---

**Storyline** builds on giants. We stand grateful. 🙏

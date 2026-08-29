# Final Review

[English](./README.md) | [简体中文](./README.zh-CN.md)

Final Review is a pre-delivery agent skill for responses and artifacts produced by current language models. Its main purpose is to reduce wording that can feel uncomfortable, mechanical, overly polished, or strongly AI-generated while preserving facts, intended meaning, and useful constraints.

Writing preferences differ from person to person. The bundled rules are a starting point, and users can add, remove, or rewrite them to match their own preferences.

This repository is configured for Codex. Its core `SKILL.md` follows the open Agent Skills format and can be adapted for other compatible agents.

## Main behavior

- Check that factual claims, actions, dates, links, citations, and completion status match the available evidence.
- Keep the response within the user's request and preserve relevant uncertainty or limitations.
- Follow the user's requested language or the main language of the current conversation.
- Apply user-maintained expression preferences from `references/custom-language-rules.md`.
- Use the bundled Humanizer reference for English output.
- Review the draft silently and return only the revised result.

Final Review can reduce recurring expression patterns, but it cannot guarantee that every reader will find the result natural or comfortable.

## Personalize expression rules

Edit the installed file:

```text
~/.agents/skills/final-review/references/custom-language-rules.md
```

Rules are grouped by language. You can change the included rules or add a section for another language. Keep each rule specific enough to preserve the source meaning, real distinctions, quotations, and genre requirements.

The current user request always takes priority over persistent preferences.

## Experimental code review

The code-specific section is an experimental feature and is disabled by default. Experienced developers may find some of its judgments inaccurate, unnecessary, or unsuitable for their workflow. It should not be treated as a replacement for professional code review, project-specific tests, security review, or runtime verification.

Control it in the installed `references/settings.yaml` file:

```yaml
code_review:
  enabled: false
```

- `false`: skip `references/code-review.md` while keeping the shared factual, scope, language, and delivery review.
- `true`: load the code-specific reference for code, configuration, tests, builds, and implementation reports.

This is a setting interpreted by the skill, not a native Codex UI option. A missing or malformed setting is treated as `false`.

You can also delete `references/code-review.md`. Setting the option to `false` first makes that choice explicit. The update script preserves an already-missing code reference. To restore it later, copy the file from this repository and set `enabled` to `true`.

## Install on Codex

Clone the repository to any local working directory, then run:

```bash
git clone https://github.com/MrD-Lt/codex-final-review.git
cd codex-final-review
zsh install.sh
```

The installer copies the skill to the official user-level location at `~/.agents/skills/final-review` and adds the instruction in `AGENTS-snippet.md` to `~/.codex/AGENTS.md`. When `CODEX_HOME` is set, the global `AGENTS.md` path follows that directory while the skill remains in `~/.agents/skills`. The instruction asks Codex to apply `$final-review` before each user-visible delivery.

To update an existing installation:

```bash
git pull --ff-only
zsh update-installed-skill.sh
```

The update script preserves the installed `references/custom-language-rules.md` and `references/settings.yaml`. It updates `references/code-review.md` only when that optional file is still present in the installed skill. An existing installation under the former `$CODEX_HOME/skills/final-review` location is moved to `~/.agents/skills/final-review` before updating. If both locations already exist, the script stops so you can resolve the duplicate safely.

## Manual installation

Copy these items into `~/.agents/skills/final-review`:

```text
SKILL.md
agents/
references/
```

Then add the contents of `AGENTS-snippet.md` to `~/.codex/AGENTS.md`, or to `$CODEX_HOME/AGENTS.md` when you use a custom Codex home. Restart Codex if the updated skill does not appear.

## Usage

The global `AGENTS.md` instruction enables the pre-delivery review across Codex tasks. You can also invoke the skill explicitly:

```text
$final-review
```

## Repository layout

```text
.
├── SKILL.md
├── agents/
│   └── openai.yaml
├── references/
│   ├── code-review.md
│   ├── custom-language-rules.md
│   ├── humanizer.md
│   ├── humanizer-license.txt
│   └── settings.yaml
├── AGENTS-snippet.md
├── install.sh
└── update-installed-skill.sh
```

## Humanizer attribution

This repository includes an unmodified copy of [Humanizer](https://github.com/blader/humanizer) version 2.11.2 by Siqi Chen. Humanizer is licensed under the MIT License.

The vendored instructions are in `references/humanizer.md`. The original license is preserved in `references/humanizer-license.txt`. See [THIRD_PARTY_NOTICES.md](./THIRD_PARTY_NOTICES.md) for the pinned source commit and coverage details.

Final Review is an independent project. The Humanizer project does not endorse or maintain it.

## License

Final Review is released under the [MIT License](./LICENSE). The bundled Humanizer reference remains covered by its original MIT notice in `references/humanizer-license.txt`.

#!/bin/zsh
set -eu

repo_root=${0:A:h}
skill_source="$repo_root"
codex_root=${CODEX_HOME:-"$HOME/.codex"}
skill_root="$HOME/.agents/skills"
skill_target="$skill_root/final-review"
legacy_skill_target="$codex_root/skills/final-review"
core_files=(
  "SKILL.md"
  "agents/openai.yaml"
  "references/humanizer.md"
  "references/humanizer-license.txt"
)
user_files=(
  "references/custom-language-rules.md"
  "references/settings.yaml"
)

for relative_file in "${core_files[@]}" "references/code-review.md" "${user_files[@]}"; do
  if [[ ! -f "$skill_source/$relative_file" ]]; then
    print -u2 "Updated final-review source is missing: $skill_source/$relative_file"
    exit 2
  fi
done

is_final_review_skill() {
  [[ -f "$1" ]] || return 1
  awk '
    NR == 1 && $0 == "---" {
      in_frontmatter = 1
      next
    }
    in_frontmatter && $0 == "---" {
      closed = 1
      exit(found ? 0 : 1)
    }
    in_frontmatter && $0 ~ /^name:[[:space:]]*/ {
      value = $0
      sub(/^name:[[:space:]]*/, "", value)
      sub(/[[:space:]]*$/, "", value)
      if (value == "final-review" || value == "\"final-review\"" || value == "\047final-review\047") {
        found = 1
      }
    }
    END { if (!closed) exit 1 }
  ' "$1"
}

if [[ -e "$skill_target" && ! -f "$skill_target/SKILL.md" ]]; then
  print -u2 "The official final-review path exists but is not a complete installation:"
  print -u2 "  $skill_target"
  print -u2 "Move or archive that path before updating."
  exit 4
elif [[ -f "$skill_target/SKILL.md" ]]; then
  if ! is_final_review_skill "$skill_target/SKILL.md"; then
    print -u2 "The official final-review path contains an unrecognized SKILL.md:"
    print -u2 "  $skill_target/SKILL.md"
    print -u2 "Move or archive that path before updating."
    exit 4
  fi
  if [[ "$legacy_skill_target" != "$skill_target" && -e "$legacy_skill_target" ]]; then
    print -u2 "Both current and legacy final-review installations exist:"
    print -u2 "  $skill_target"
    print -u2 "  $legacy_skill_target"
    print -u2 "Remove or archive the unwanted copy before updating."
    exit 4
  fi
elif [[ -f "$legacy_skill_target/SKILL.md" ]]; then
  if ! is_final_review_skill "$legacy_skill_target/SKILL.md"; then
    print -u2 "The legacy final-review path contains an unrecognized SKILL.md:"
    print -u2 "  $legacy_skill_target/SKILL.md"
    print -u2 "Move or archive that path before updating."
    exit 4
  fi
  mkdir -p "$skill_root"
  mv "$legacy_skill_target" "$skill_target"
  print "Migrated final-review from $legacy_skill_target to $skill_target"
else
  print -u2 "Installed final-review skill was not found at either supported location:"
  print -u2 "  $skill_target/SKILL.md"
  print -u2 "  $legacy_skill_target/SKILL.md"
  exit 3
fi

for relative_file in "${core_files[@]}"; do
  target_file="$skill_target/$relative_file"
  mkdir -p "${target_file:h}"
  cp "$skill_source/$relative_file" "$target_file"
done

for relative_file in "${user_files[@]}"; do
  target_file="$skill_target/$relative_file"
  if [[ -f "$target_file" ]]; then
    print "Preserved user file at $target_file"
  else
    mkdir -p "${target_file:h}"
    cp "$skill_source/$relative_file" "$target_file"
    print "Installed default user file at $target_file"
  fi
done

code_review_target="$skill_target/references/code-review.md"
if [[ -f "$code_review_target" ]]; then
  cp "$skill_source/references/code-review.md" "$code_review_target"
  print "Updated code review reference at $code_review_target"
else
  print "Preserved the absence of the optional code review reference at $code_review_target"
fi

print "Updated final-review at $skill_target"

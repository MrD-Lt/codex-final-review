#!/bin/zsh
set -eu

repo_root=${0:A:h}
skill_source="$repo_root"
codex_root=${CODEX_HOME:-"$HOME/.codex"}
skill_root="$HOME/.agents/skills"
skill_target="$skill_root/final-review"
legacy_skill_target="$codex_root/skills/final-review"
agents_file="$codex_root/AGENTS.md"
snippet_file="$repo_root/AGENTS-snippet.md"
start_marker='<!-- final-review:start -->'
end_marker='<!-- final-review:end -->'
invocation='Before sending any final response or user-visible artifact, invoke and apply `$final-review`. Run the review silently and return the revised final content.'

required_files=(
  "$skill_source/SKILL.md"
  "$skill_source/agents/openai.yaml"
  "$skill_source/references/code-review.md"
  "$skill_source/references/custom-language-rules.md"
  "$skill_source/references/settings.yaml"
  "$skill_source/references/humanizer.md"
  "$skill_source/references/humanizer-license.txt"
  "$snippet_file"
)

for required_file in "${required_files[@]}"; do
  if [[ ! -f "$required_file" ]]; then
    print -u2 "The final-review package is incomplete: $required_file"
    exit 2
  fi
done

if [[ -e "$agents_file" && ! -f "$agents_file" ]]; then
  print -u2 "Global guidance path is not a regular file: $agents_file"
  exit 4
fi

has_line() {
  grep -Fqx -- "$1" "$agents_file"
}

has_complete_guidance() {
  awk -v start="$start_marker" -v instruction="$invocation" -v end="$end_marker" '
    $0 == start {
      if (getline && $0 == instruction && getline && $0 == end) {
        found = 1
        exit
      }
    }
    END { exit(found ? 0 : 1) }
  ' "$agents_file"
}

if [[ ! -e "$agents_file" ]]; then
  guidance_status='created'
else
  start_found=0
  end_found=0
  invocation_found=0
  has_line "$start_marker" && start_found=1
  has_line "$end_marker" && end_found=1
  has_line "$invocation" && invocation_found=1

  if has_complete_guidance; then
    guidance_status='already present'
  elif (( start_found + end_found + invocation_found > 0 )); then
    print -u2 "Existing global guidance is a partial final-review block in $agents_file. Expected the start marker, canonical invocation instruction, and end marker together."
    exit 4
  else
    guidance_status='appended'
  fi
fi

if [[ -e "$skill_target" ]]; then
  print -u2 "A final-review skill already exists at $skill_target"
  exit 3
fi

if [[ "$legacy_skill_target" != "$skill_target" && -e "$legacy_skill_target" ]]; then
  print -u2 "A legacy final-review installation exists at $legacy_skill_target"
  print -u2 "Run update-installed-skill.sh to migrate it to $skill_target"
  exit 5
fi

mkdir -p "$skill_root" "$codex_root"
mkdir -p "$skill_target/agents" "$skill_target/references"
cp "$skill_source/SKILL.md" "$skill_target/SKILL.md"
cp "$skill_source/agents/openai.yaml" "$skill_target/agents/openai.yaml"
cp "$skill_source/references/code-review.md" "$skill_target/references/code-review.md"
cp "$skill_source/references/custom-language-rules.md" "$skill_target/references/custom-language-rules.md"
cp "$skill_source/references/settings.yaml" "$skill_target/references/settings.yaml"
cp "$skill_source/references/humanizer.md" "$skill_target/references/humanizer.md"
cp "$skill_source/references/humanizer-license.txt" "$skill_target/references/humanizer-license.txt"

if [[ "$guidance_status" == 'created' ]]; then
  cp "$snippet_file" "$agents_file"
elif [[ "$guidance_status" == 'appended' ]]; then
  printf '\n' >> "$agents_file"
  sed -n 'p' "$snippet_file" >> "$agents_file"
fi

print "Installed final-review at $skill_target"
print "Global guidance $guidance_status at $agents_file"

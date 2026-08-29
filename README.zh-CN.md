# Final Review

[English](./README.md) | [简体中文](./README.zh-CN.md)

Final Review 是面向当前语言模型输出的交付前审校 Skill。它的主要目的，是尽量减少回复或产物中容易让人感到不适、机械、生硬或 AI 感明显的表达，同时保留事实、原意和真正有用的限制条件。

每个人对表达方式都有自己的偏好。仓库内的规则可以作为起点，用户可以根据自己的习惯添加、删除或改写。

本仓库面向 Codex 配置。核心 `SKILL.md` 遵循开放的 Agent Skills 格式，也可以适配其他兼容 Agent。

## 主要作用

- 检查事实、已执行操作、日期、链接、引用和完成状态是否与现有依据一致。
- 让回复保持在用户请求范围内，并保留相关的不确定性和限制。
- 使用用户明确要求的语言；没有明确要求时，沿用当前对话的主要语言。
- 应用 `references/custom-language-rules.md` 中由用户维护的表达偏好。
- 英文输出会使用仓库内置的 Humanizer 参考。
- 静默审校草稿，最终仅返回修改后的内容。

Final Review 可以减少反复出现的表达问题，但无法保证每位读者都会觉得结果自然或舒适。

## 自定义表达规则

编辑安装目录中的文件：

```text
~/.agents/skills/final-review/references/custom-language-rules.md
```

规则按语言分组。你可以修改现有规则，也可以为其他语言增加新的分组。每条规则需要足够具体，并保留原文含义、真实差异、引文和体裁要求。

用户在当前任务中的明确要求始终优先于长期偏好。

## 实验性的代码审校

代码部分目前属于测试功能，默认关闭。专业开发者可能认为其中一些判断不准确、没有必要，或者不适合自己的工作流程。它不能替代专业代码审查、项目测试、安全检查和运行时验证。

通过安装目录中的 `references/settings.yaml` 控制这个功能：

```yaml
code_review:
  enabled: false
```

- `false`：跳过 `references/code-review.md`，事实、范围、语言和交付状态等通用审校仍会运行。
- `true`：代码、配置、测试、构建和实现报告会加载代码专项参考。

这个字段由 Skill 自己读取，目前不是 Codex 界面中的原生选项。设置文件缺失或格式无法识别时，会按 `false` 处理。

你也可以手动删除 `references/code-review.md`。建议先把设置改为 `false`，这样更容易看出你的选择。更新脚本会保留代码参考文件已经被删除的状态。以后需要恢复时，从仓库重新复制该文件，再把 `enabled` 改为 `true`。

## 在 Codex 中安装

将仓库克隆到任意本地工作目录，然后运行：

```bash
git clone https://github.com/MrD-Lt/codex-final-review.git
cd codex-final-review
zsh install.sh
```

安装脚本会把 Skill 复制到官方推荐的用户级目录 `~/.agents/skills/final-review`，并将 `AGENTS-snippet.md` 中的指令加入 `~/.codex/AGENTS.md`。设置了 `CODEX_HOME` 时，全局 `AGENTS.md` 会跟随该目录，Skill 仍安装在 `~/.agents/skills`。这条指令要求 Codex 在每次用户可见内容交付前应用 `$final-review`。

更新已经安装的版本：

```bash
git pull --ff-only
zsh update-installed-skill.sh
```

更新脚本会保留安装目录中的 `references/custom-language-rules.md` 和 `references/settings.yaml`。只有安装目录仍然保留 `references/code-review.md` 时，才会更新这份可选参考。旧版 `$CODEX_HOME/skills/final-review` 安装会先迁移到 `~/.agents/skills/final-review`，随后再更新。新旧目录同时存在时，脚本会停止，让你先安全处理重复安装。

## 手动安装

将以下内容复制到 `~/.agents/skills/final-review`：

```text
SKILL.md
agents/
references/
```

随后把 `AGENTS-snippet.md` 的内容加入 `~/.codex/AGENTS.md`；使用自定义 Codex 主目录时，请写入 `$CODEX_HOME/AGENTS.md`。如果 Codex 没有显示更新后的 Skill，请重启 Codex。

## 使用方法

全局 `AGENTS.md` 指令会在 Codex 任务交付前启用审校。也可以显式调用：

```text
$final-review
```

## 仓库结构

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

## Humanizer 署名

本仓库包含 [Humanizer](https://github.com/blader/humanizer) 2.11.2 的完整未修改副本，原作者为 Siqi Chen。Humanizer 使用 MIT License。

内嵌说明位于 `references/humanizer.md`，原始许可证保存在 `references/humanizer-license.txt`。固定来源提交和适用范围记录在 [THIRD_PARTY_NOTICES.md](./THIRD_PARTY_NOTICES.md) 中。

Final Review 是独立项目，Humanizer 项目没有参与维护或提供背书。

## 许可证

Final Review 使用 [MIT License](./LICENSE)。内嵌的 Humanizer 参考继续遵循 `references/humanizer-license.txt` 中的原始 MIT 声明。

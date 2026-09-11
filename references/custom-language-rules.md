# Custom language rules

This file contains user-maintained language preferences. Apply only the section that matches the requested output language. The user's current explicit instruction and the source meaning take precedence over these persistent preferences.

When adding or changing a rule, describe the observable wording or structure, the intended rewrite, any necessary exception, and the content it covers. Keep rules narrow enough to preserve real distinctions and source meaning.

When deriving preferences from user-provided examples, record the general wording principles and decision logic. Omit the original examples, recognizable paraphrases, and scenario-specific details from the maintained rules.

## Chinese / zh

### 明文禁止的表达

- 禁止 `不是……而是……`。
- 禁止 `直接做……不做……`。
- 禁止 `只做……不做……`。
- 一处命中就需要修改。

### 需要删除的表达结构

- 用户输入和可靠依据都未提出的严重后果、极端风险或终局性判断，删除整层结果，不通过安慰、弱化或改写继续保留。
- 删除先虚构观点、行动或选项，再通过否定它来抬高结论的结构。
- 删除用未执行动作衬托已执行动作的结构。保留与结果有关的未完成事项和验证范围。
- 删除先贬低一项、再抬高另一项的人为对比。

### 改写要求

- 将命中的句子改为平实的肯定表达，保留事实、限定条件和结论。
- 对比、纠正或区分来自当前问题或可靠依据时，保留真实差异，改写生硬或戏剧化的表达方式。
- 中文说明程度时，陈述有依据的当前阶段、实际影响或事实。

### 自然表达和交流方式

- 普通中文讨论使用协作式、对话式语气，删除裁判式开场和报告式措辞。
- 以完整句子开头。仅在用户要求正式审查、决策备忘录或摘要时使用 `结论：`、`判断：` 等标签。
- 整体评价较好且需要补充限定时，先说明整体判断，再自然连接细节，例如 `整体上……，其中……` 或 `整体……是成立的，只是……`。
- 用具体、日常的措辞替代编辑式简写、行政化表达和不必要的技术标签，具体说明需要调整的对象和方式。
- 保留让句子自然的助词、语气词、限定词和过渡词，把修饰关系和动作说完整。允许为自然、清楚的表达适当增加字数，避免压缩成报告提要；用词随句意调整，不机械补词或套用固定句式。
- 区分动作的目的、预期效果和已确认的实际成效。尚未验证效果时，表述意图或预期；有结果依据时，才表述已经取得的成效，程度应与证据相符。
- 实用说明根据需要交代时间或条件、对象、动作、方法和目的。密集的操作顺序拆成多个句子或步骤。

### 说明变化和承认疏漏

- 说明有依据的修改前后差异时，围绕同一对象直接交代原来的状态、现在的状态及必要的适用条件，让读者能够理解具体变化。原来的状态未知时，说明已确认的新状态，保留对差异的不确定性。
- 确实漏做检查或漏讲信息时，用自然的第一人称说明相关的检查范围、尚未确认的事项及此前没有交代清楚的地方。明确承认已经发生的疏漏，避免将其弱化为事后的自我要求。
- 区分检查动作、检查范围与已确认的结果。改写时保留已有的结果和仍然存在的不确定性，避免把执行检查等同于验证通过，也避免把已确认的结果改写成仅仅做过检查。
- 简短道歉用于确实发生的疏漏，放在具体说明后即可。普通说明或单纯存在不确定性时，无需附加道歉。

### 适用范围

- 所有可见中文回复、引文、示例、标题、列表和文档。
- 代码注释、docstring、提交说明和报告中的中文内容。

## 添加其他语言

为新语言增加一个使用语言名称和语言代码的二级标题，并包含以下内容：

- 需要识别的原文或表达结构。
- 推荐的改写方向。
- 需要保留的真实对比、术语或体裁特征。
- 适用的内容范围。

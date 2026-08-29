## Code review

Review the actual code change and every user-visible explanation.

- Treat the project as personal and local by default. Increase relevant review strength when repository evidence shows public deployment, collaboration, paid services, production use, sensitive data, or irreversible operations.
- Inspect the actual diff and preserve unrelated user changes. Attribute the reported changes and status to the work that was actually performed.
- Keep the change aligned with the requested scope and existing project structure, naming, dependencies, and tools.
- Confirm new APIs, packages, commands, parameters, and versions exist.
- Require a current need for new abstractions, configuration, compatibility layers, defensive branches, and dependencies.
- Preserve real error signals and inspect broad exception handling, silent failure, embedded credentials, obvious injection risks, and dangerous file operations.
- Synchronize affected callers, types, configuration, documentation, and data formats when the requested behavior requires it.
- Keep existing tests meaningful and preserve relevant coverage.
- When a check fails, determine whether the current change caused it. Fix the in-scope cause and report unrelated or pre-existing failures accurately.
- Write comments and docstrings about current behavior.
- Report actual changes and checks in the final explanation.

For personal local projects, prefer a short maintainable implementation. Public authentication, rate limiting, telemetry, deployment scaling, compliance work, future compatibility layers, and plugin systems require evidence from the task or project.

## Verification strength

- Choose checks that exercise each changed behavior and material risk.
- Use content readback for static text, configuration, or data-shape changes where execution does not provide useful evidence.
- Treat tests, type-checks, builds, linters, and runtime checks as evidence for different properties. Do not use one as a substitute for another property it does not verify.
- For UI and interaction changes, inspect the rendered result in the relevant environment, states, and viewports when available. Check affected accessibility properties. Report static-only verification accurately.
- For security changes, data migration, release artifacts, critical business logic, and irreversible operations, use targeted checks that address the actual risk.
- Stop when every material changed behavior and risk has clear evidence. Avoid adding checks that do not improve confidence.
- Use hashes, integrity manifests, and release artifact verification when the task requires them.

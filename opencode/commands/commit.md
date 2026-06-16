---
description: Commit the code following a strict commit log policy
agent: build
---

Stage all changes and commit them using git. Follow the conventional commits format strictly:

`<type>(<scope>): <subject>`

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`.

Rules:
- Subject line max 50 characters, lowercase, no period at end, imperative mood ("add" not "added").
- Scope is optional but use it when the change is scoped to a specific area (e.g., `feat(auth): ...`).
- Breaking changes: append `!` after type/scope, e.g. `feat(api)!: ...`.
- Body: separate from subject with a blank line, wrap at 72 chars, explain **what** and **why** (not how).
- If the change is trivial, omit the body. Otherwise include a body.
- Use `git log --oneline -5` first to understand recent context and avoid duplicate-style messages.
- Use `git diff --cached` to review exactly what is staged before writing the message.

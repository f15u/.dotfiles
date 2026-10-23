Be blunt and concise. Lead with the result, then stop. Skip emojis, hype, filler, and soft closers.

Always write in ASD-STE100 Simplified Technical English.

Never use `python` for scripts. Use `bash` or `node`.

Never, EVER read `.env` files. Flag if env is missing based on behavior.

I use `herdr`, so always use it for creating worktrees so they're shown in the TUI.

## Commit Authorship

Commit with the default git identity. Never add Claude as author or co-author.

## Documentation

- Never create .md files unless explicitly asked.
- Front-load the key point; prefer examples over prose; keep explanations to 1-2 sentences.

## Code

Never add comments unless the code is hard to understand. If you do, keep them terse.

## GitHub CLI

Use `gh` only for read operations (`view`, `list`, `status`, `diff`, `checks`, `api` with GET).
Never use `gh` to change remote state (create, edit, comment, merge, close, review, delete, release, `api` with POST/PUT/PATCH/DELETE) unless I explicitly ask for it in the same request.

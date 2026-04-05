# skills

A GitHub Copilot-powered automated code review system that runs as a pre-push git hook.

[日本語版はこちら](README.ja.md)

## Overview

On every `git push`, this system automatically:

1. Extracts the diff between the current branch and its remote tracking branch
2. Sends the diff to the GitHub Copilot API for code review
3. Saves the review result to `copilot-review/review.md`
4. Blocks the push if 2 or more `must`-priority issues are found

## Requirements

- [lefthook](https://github.com/evilmartians/lefthook)
- [GitHub CLI (`gh`)](https://cli.github.com/) — must be authenticated with `gh auth login`
- `jq`
- A valid GitHub Copilot subscription

## Getting Started

### Using Dev Container (recommended)

Open this repository in VS Code with the Dev Containers extension. The container is based on Alpine Linux and includes all required dependencies.

### Manual Setup

Install lefthook and set up the git hooks:

```sh
lefthook install
```

### Using in Another Project

The `template` branch contains only the files needed to run the review system. Run the following one-liner in your project root to extract the files, install dependencies, and register git hooks:

```sh
curl -sL https://raw.githubusercontent.com/taka1156/skills/master/scripts/bootstrap.sh | bash
```

> **Security Notice:** Always review the script contents before executing it. Running scripts piped directly from the internet (especially with `sudo`) carries a risk of MITM attacks. You can inspect the script first by running:
> ```sh
> curl -sL https://raw.githubusercontent.com/taka1156/skills/master/scripts/bootstrap.sh
> ```
>
> When reviewing, check for the following:
> - Destructive commands such as `sudo`, `rm -rf`, or privilege escalation
> - Unexpected outbound connections to external servers
> - Packages being installed or files being modified outside the expected scope

## Usage

### Automatic (on push)

The review runs automatically when you `git push`. If 2 or more `must`-priority issues are detected, the push is blocked.

### Dry Run

To run the review without pushing:

```sh
lefthook run pre-push
```

### Language Option

The review is generated in Japanese by default. To switch to English:

```sh
bash scripts/run-copilot-review.sh --lang=en
```

## Review Output

Results are saved to `copilot-review/review.md` (excluded from version control via `.gitignore` — this file is a local review artifact and not intended to be committed).

### Priority Labels

The priority labels are based on the review comment prefix convention described in the following article:

> [よく使うレビューコメントのプレフィックスまとめ — Classmethod Developers IO](https://dev.classmethod.jp/articles/prefixes-for-frequently-used-review-comments/)

| Label | Meaning |
|-------|---------|
| 🔴 `must` | Must be fixed |
| 🟠 `want` | Should be fixed |
| 🟡 `imo` | Opinion: probably worth fixing |
| 🟡 `imho` | Opinion: might be worth fixing |
| 🔵 `nits` | Minor nitpick |
| 💬 `info` | Advisory / FYI |
| ❓ `ask` | Question — no fix requested |

## Skills

This repository contains two Copilot skill definitions under `.github/skills/`:

| Skill | Description |
|-------|-------------|
| `git-hook-code-review` | Outputs structured JSON for use in git hooks |
| `chat-code-review` | Outputs emoji-annotated Markdown for use in chat |

## Files

```
.github/skills/          # Copilot skill definitions
scripts/
  bootstrap.sh           # One-liner setup for other projects (fetched via curl)
  install.sh             # Installs jq, lefthook, and github-cli
  setup.sh               # Registers git hooks and checks gh authentication
  run-copilot-review.sh  # Calls Copilot API and generates review.md
  review-check.sh        # Checks review result and blocks push on must issues
lefthook.yml             # Git hook configuration
copilot-review/          # Review output directory (gitignored)
```

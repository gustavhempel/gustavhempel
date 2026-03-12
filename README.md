# Professional Git Setup

Opinionated, practical Git defaults for daily development.

## What This Repository Provides

- A shared Git config with safe defaults and useful aliases
- A global `.gitignore` file for OS/editor noise
- Install scripts for Windows (`PowerShell`) and macOS/Linux (`bash`)

## Repository Layout

```text
.
├─ config/
│  ├─ gitconfig
│  └─ gitignore_global
└─ scripts/
   ├─ install.ps1
   └─ install.sh
```

## Quick Start

### Windows (PowerShell)

```powershell
git clone <your-repo-url> "$HOME\\git-setup"
cd "$HOME\\git-setup"
.\scripts\install.ps1
```

### macOS / Linux

```bash
git clone <your-repo-url> "$HOME/git-setup"
cd "$HOME/git-setup"
chmod +x ./scripts/install.sh
./scripts/install.sh
```

## What the Installer Changes

- Adds `config/gitconfig` to your global Git config via `include.path`
- Sets `core.excludesfile` to `config/gitignore_global`
- Leaves your existing `~/.gitconfig` in place and only appends missing settings

## Verify

```bash
git config --global --get-all include.path
git config --global --get core.excludesfile
git config --global --list --show-origin
```

## Customize

- Update aliases and defaults in `config/gitconfig`
- Add or remove patterns in `config/gitignore_global`
- Keep personal identity local:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## Included Aliases

- `git st` -> short status
- `git lg` -> compact graph log
- `git last` -> last commit with file stats
- `git incoming` -> commits on upstream not in local branch
- `git outgoing` -> commits in local branch not on upstream
- `git conflicts` -> files currently in merge conflict
- `git whoami` -> current Git name and email

# This is my config

This config is for my personal machine using ubuntu.
I use the tools:
- nvim
- tmux
- opencode
- zed

Feel free to use it!

## Managing configs with GNU Stow

Configs are managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each app is a package under `dotfiles/` whose layout mirrors the target
directory (`~`):

```
dotfiles/
├── nvim/.config/nvim/...
├── tmux/.config/tmux/...
├── zed/.config/zed/settings.json
├── opencode/.config/opencode/...
└── local/.local/bin/plantuml.sh
```

The repo is the source of truth; targets (`~/.config/<app>`, `~/.local/bin`)
are symlinks back into `dotfiles/`.

### Commands

- `stow` to install: `stow -d dotfiles -t ~ <package>`
- Or use the helper: `./scripts/stow.sh {push|pull|delete}`
  - `push`   adopt live changes into the repo and stage them
  - `pull`   (re)create the symlinks
  - `delete` remove the symlinks

### Per-app install

`./install_ubuntu_package.sh <package>` also installs dependencies (snap/apt)
and stows the config. Available: brew, tmux, nvim, zed, latex, plantuml, go,
llamacpp, rust, opencode.

## NVIM

You can find details in [nvim.md](nvim.md).

## OPENCODE

Config lives in `dotfiles/opencode/.config/opencode/`; commands in
`dotfiles/opencode/.opencode/commands/`.

### Links

https://opencode.ai/config.json

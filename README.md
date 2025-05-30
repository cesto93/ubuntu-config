# This is my ubuntu config

Contains nvim and tmux.
Feel free to use it!
Inspired by theprimagen.

## Packet manager

Lazy packet manager

## Plugins used

- gp.nvim: gpt like calls
- mason: manage editor tools
- neotest: launching tests
- rosepine: fonts
- telescope: fuzzy finder
- treesitter: language syntax
- lspzero: lsp
- coverage: code coverage

## Manage plugin

For managing plugins use:

```
:Lazy Update

:Mason
```

## Remaps

- ![remaps](lua/remap.lua)
- ![coverage remaps](after/plugin/coverage.lua)
- ![lsp remaps](after/plugin/lsp.lua)
- ![test remaps](after/plugin/neotest.lua)
- ![telescope remaps](after/plugin/telescope.lua)
- ![gp remaps](after/plugin/gp.lua)

## Instructions
./install.sh

### Requirements

- nvim
- git
- node js

# Links

- https://github.com/folke/lazy.nvim
- https://github.com/Robitx/gp.nvim
- https://github.com/williamboman/mason.nvim
- https://github.com/andythigpen/nvim-coverage
- https://github.com/nvim-neotest/neotest
- https://github.com/nvim-treesitter/nvim-treesitter
- https://github.com/VonHeikemen/lsp-zero.nvim

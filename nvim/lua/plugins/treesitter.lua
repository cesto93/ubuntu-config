return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "vimdoc", "javascript", "go", "c", "lua", "rust", "bash" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "html", "dockerfile" },
                additional_vim_regex_highlighting = false,
            },
        })
    end
}
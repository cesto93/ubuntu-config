require("neotest").setup({
    -- your neotest config here
    adapters = {
        require("neotest-go"),
    }
})

vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
vim.keymap.set("n", "<leader>ta", function() require("neotest").run.run({ suite = true }) end)
vim.keymap.set("n", "<leader>tc", function() require("neotest").run.run({ suite = true, extra_args = {"-coverprofile='cover.out'"} }) end)

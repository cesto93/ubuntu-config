require("neotest").setup({
    -- your neotest config here
    adapters = {
        require("neotest-go"),
    }
})

vim.keymap.set("n", "<leader>tl", function() require("neotest").summary.toggle() end)
vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end)
vim.keymap.set("n", "<leader>tv", function() require("neotest").run.run({ extra_args = {"-v"} }) end)
vim.keymap.set("n", "<leader>ta", function() require("neotest").run.run({ suite = true }) end)
vim.keymap.set("n", "<leader>tc", function() require("neotest").run.run({ suite = true, extra_args = {"-coverprofile='cover.out'"} }) end)
vim.keymap.set("n", "<leader>td", function() require("neotest").diagnostic() end)
vim.keymap.set("n", "<leader>to", function() require("neotest").output_panel.toggle() end)


local gp = require("gp")


vim.keymap.set({'n', 'v'}, '<leader>gt', '<cmd>GpUnitTests<cr>', {})
vim.keymap.set({'n', 'v'}, '<leader>ge', '<cmd>GpExplain<cr>', {})

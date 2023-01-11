require('nvim_comment').setup({operator_mapping = '<C-_>', comment_empty = false})

vim.keymap.set("n", "<C-_>", vim.cmd.CommentToggle)

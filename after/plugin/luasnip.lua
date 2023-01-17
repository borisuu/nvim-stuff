local luasnip = require('luasnip')
-- Setup TAB to expand or jump
vim.keymap.set("i", "<Tab>",
    function() if luasnip.expand_or_jumpable() then return "<Plug>luasnip-expand-or-jump" else return "<Tab>" end end,
    { silent = true, expr = true })

-- Setup Tab and Shift Tab to move through the nodes, '1' - forwards, '-1' - backwards
vim.keymap.set("i", "<S-Tab>", function() luasnip.jump(-1) end, { noremap = true })
vim.keymap.set("s", "<Tab>", function() luasnip.jump(1) end, { silent = true })
vim.keymap.set("s", "<S-Tab>", function() luasnip.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>",
    function() if luasnip.choice_active() then return "<Plug>lausnip-next-choice" else return "<C-E>" end end,
    { silent = true, expr = true })

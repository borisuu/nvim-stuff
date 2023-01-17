require('Comment').setup({
    ignore = '^$',
    -- this is for NORMAL mode
    toggler = {
        line = '<C-_>'
    },
    -- this is for VISUAL mode
    opleader = {
        line = '<C-_>'
    }
})

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local unpack = unpack or table.unpack

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = '[G]o to [D]efinition', unpack(opts) })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = 'Hover', unpack(opts) })
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = '[W]orkspace [S]ymbol', unpack(opts) })
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = 'Open [d]iagnostic float', unpack(opts) })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = 'Go to next diagnostic', unpack(opts) })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = 'Go to prev diagnostic', unpack(opts) })
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', unpack(opts) })
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { desc = '[R]efe[r]ences', unpack(opts) })
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = '[R]e[n]ame', unpack(opts) })
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = 'Signature [h]elp', unpack(opts) })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

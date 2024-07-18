return {
    "hrsh7th/cmp-nvim-lsp",
    "SmiteshP/nvim-navic",
    "RRethy/vim-illuminate",
    icons = {
        Text = " ",
        Method = "m ",
        Function = " ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = "  ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
    },
    config = function()
        local M = {}
        
        local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not status_cmp_ok then
            return
        end
        
        local status_navic_ok, navic = pcall(require, "nvim-navic")
        if not status_navic_ok then
            return
        end
        
        navic.setup({
            icons = icons,
            separator = "  ",
            highlight = true,
            click = true,
        })
        
        M.capabilities = vim.lsp.protocol.make_client_capabilities()
        M.capabilities.textDocument.completion.completionItem.snippetSupport = true
        M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
        
        M.setup = function()
            local signs = {
                { name = "DiagnosticSignError", text = " " },
                { name = "DiagnosticSignWarn", text = " " },
                { name = "DiagnosticSignHint", text = " " },
                { name = "DiagnosticSignInfo", text = " " },
            }
        
            for _, sign in ipairs(signs) do
                vim.fn.sign_define(
                    sign.name,
                    { texthl = sign.name, text = sign.text, numhl = "" }
                )
            end
        
            local config = {
                virtual_text = false, -- disable virtual text
                signs = {
                    active = signs, -- show signs
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }
        
            vim.diagnostic.config(config)
        
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, {
                    border = "rounded",
                })
        
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = "rounded",
                })
        end
        
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]])
        local function lsp_keymaps(bufnr)
            local opts = { noremap = true, silent = true }
            local keymap = vim.api.nvim_buf_set_keymap
            keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
            keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
            keymap(bufnr, "n", "<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
            keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder<CR>", opts)
            keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder<CR>", opts)
            keymap(bufnr, "n", "<leader>wF", "<cmd>lua  vim.lsp.buf.formatting<CR>", opts)
        end
        
        local formatter_blacklist = {
            "tsserver",
        }
        
        M.on_attach = function(client, bufnr)
            for _, blacklist in ipairs(formatter_blacklist) do
                if client.name == blacklist then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end
            end
        
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
            end
        
            lsp_keymaps(bufnr)
            local status_ok, illuminate = pcall(require, "illuminate")
            if not status_ok then
                return
            end
            illuminate.on_attach(client, bufnr)
        end
        
        return M
        
    end,
}
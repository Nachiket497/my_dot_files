return {
    "neovim/nvim-lspconfig",
    "ray-x/lsp_signature.nvim", 
    config = function()
        local status_ok, _ = pcall(require, "lspconfig")
        if not status_ok then
            return
        end
        
        local lsp_signature_status_ok, lsp_signature = pcall(require, "lsp_signature")
        if not lsp_signature_status_ok then
            return
        end
        
        lsp_signature.setup({
            hint_prefix = " ",
        })
        require("usr.plugins.lsp.mason")
        require("usr.plugins.lsp.handlers")
        require("usr.plugins.lsp.null-ls")
    end,
}


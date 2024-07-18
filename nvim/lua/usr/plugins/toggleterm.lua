return{
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        toggleterm = require("toggleterm")
        toggleterm.setup({
            size = 20,
            open_mapping = [[<cmd>lua require"toggleterm".toggle()<CR>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
        vim.api.nvim_set_keymap('n', '<leader>`', '<cmd>lua require"toggleterm".toggle()<CR>', { noremap = true, silent = true })

        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<leader>`",'<cmd>lua require"toggleterm".toggle()<CR>', opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
        end
        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end
        local top = Terminal:new({ cmd = "top", hidden = true })
        function _TOP_TOGGLE()
            top:toggle()
        end
        local python = Terminal:new({ cmd = "python", hidden = true })
        function _PYTHON_TOGGLE()
            python:toggle()
        end
    end,
}
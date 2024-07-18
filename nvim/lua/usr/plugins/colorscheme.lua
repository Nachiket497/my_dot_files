-- return {
--   "catppuccin/nvim",
--   priority = 1000,
--   config = function()
--   require("catppuccin").setup({
--     integrations = {
--         aerial = true,
--         cmp = true,
--         gitsigns = true,
--         nvimtree = true,
--         hop = false,
--         treesitter = true,
--         treesitter_context = true,
--         which_key = false,
--         notify = true,
--         mason = true,
--         markdown = true,
--         mini = {
--             enabled = true,
--             indentscope_color = "",
--         },
--         symbols_outline = true,
--         native_lsp = {
--             enabled = true,
--             virtual_text = {
--                 errors = { "italic" },
--                 hints = { "italic" },
--                 warnings = { "italic" },
--                 information = { "italic" },
--             },
--             underlines = {
--                 errors = { "underline" },
--                 hints = { "underline" },
--                 warnings = { "underline" },
--                 information = { "underline" },
--             },
--             inlay_hints = {
--                 background = true,
--             },
--         },
--         navic = {
--             enabled = true,
--             custom_bg = "NONE", -- "lualine" will set background to mantle
--         },
--       },
--
--     })
--
--     vim.cmd.colorscheme("catppuccin")
--     vim.cmd([[highlight! Visual guibg=#505783 gui=nocombine]])
--   end
-- }
--
return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = function()
        if vim.fn.has("termguicolors") == 1 then
            vim.opt.termguicolors = true
        end
        -- Default options:
        require("gruvbox").setup({
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
              strings = true,
              emphasis = true,
              comments = true,
              operators = false,
              folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,
            contrast = "",
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        })

        vim.cmd("colorscheme gruvbox")
    end,

}

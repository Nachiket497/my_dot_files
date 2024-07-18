return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        -- import comment plugin safely
        local comment = require("Comment")

        local ts_context_commentstring =
            require("ts_context_commentstring.integrations.comment_nvim")

        comment.setup({
            pre_hook = function(ctx)
                local U = require("Comment.utils")

                local location = nil
                if ctx.ctype == U.ctype.blockwise then
                    location =
                        require("ts_context_commentstring.utils").get_cursor_location()
                elseif
                    ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V
                then
                    location =
                        require("ts_context_commentstring.utils").get_visual_start_location()
                end

                return require("ts_context_commentstring.internal").calculate_commentstring({
                    key = ctx.ctype == U.ctype.linewise and "__default"
                        or "__multiline",
                    location = location,
                })
            end,
        })
    end,
}

-- opts = {
--      config = {
--        cpp = "// %s",
--        verilog = "// %s",
--        systemverilog = "// %s",
--      },
--    },
--
--    -- enable comment
-- comment.setup({
--   -- for commenting tsx, jsx, svelte, html files
--   pre_hook = ts_context_commentstring.create_pre_hook(),
-- })

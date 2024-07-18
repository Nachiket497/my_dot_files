return {
   'petertriho/nvim-scrollbar',
    dependencies = { "kevinhwang91/nvim-hlslens" },
    event = { "BufReadPre", "BufNewFile" },
    -- require("scrollbar.handlers.search").setup({
    --     override_lens = function() end, -- don't add unnecessary virtual text and clutter
    -- }),

    config = function()
   require("scrollbar").setup({
       show_in_active_only = true,
       hide_if_all_visible = true, -- Hides everything if all lines are visible
       handle = {
           blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
       },
       marks = {
           Cursor = {
               text = "▮",
           },
           Search = {
               highlight = "@text.todo",
           },
           GitAdd = {
               text = "|",
           },
           GitChange = {
               text = "|",
           },
       },
       handlers = {
           gitsigns = true, -- Requires gitsigns
           search = true, -- Requires hlslens
       },
   })
   end,
}


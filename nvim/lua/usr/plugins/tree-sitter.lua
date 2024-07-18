return {
    "nvim-treesitter",
    "hiphish/rainbow-delimiters.nvim",
    "m-demare/hlargs.nvim",

    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = "all", -- one of "all" or a list of languages
            sync_install = false, -- install languages asynchronously
            auto_install = true, -- installs missing parsers on opening file
            ignore_install = {
                "wing",
                "scfg",
                "smali",
                "fusion",
                "blueprint",
                "t32",
                "jsonc",
                "ruby",
                "tlaplus",
            }, -- list of languages to ignore installing
            highlight = {
                enable = true, -- false disables whole extension
                disable = { "" }, -- list of languages to be disabled for highlight
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, disable = { "yaml" } },
        })
    end,
}

return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "honza/vim-snippets",
    },
    config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()

        local ls = require("luasnip")

        require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})

        -- Set up snippet configuration
        ls.config.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        })
    end
}

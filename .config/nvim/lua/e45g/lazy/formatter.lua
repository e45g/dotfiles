return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
            },
        })
        vim.keymap.set({ "n", "v" }, "<leader>F", function()
            conform.format()
        end, { desc = "Format file or range (in visual mode)" })
    end,
}

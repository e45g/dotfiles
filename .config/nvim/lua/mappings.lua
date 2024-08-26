require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("v", "<leader>sc", function ()
    require("nvim-silicon").clip()
end, { desc = "Snapshot Code"})

map("n", "<leader>rg", "<cmd>FzfLua live_grep <cr>", {desc = "Live grep"})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

require("config.set")
require("config.remap")
require("config.lazy_init")

vim.cmd.colorscheme("vim")

local autocmd = vim.api.nvim_create_autocmd

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 80,
        })
    end,
})

autocmd('BufWritePre', {
	pattern = "*",
	command = [[%s/\s\+$//e]]
})


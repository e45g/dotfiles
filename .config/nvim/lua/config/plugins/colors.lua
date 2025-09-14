function ColorMyPencils(color)
	color = color or "midnight"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "nikolvs/vim-sunbather",
    },
    {
        'lurst/austere.vim',
    },
    {
        "andreasvc/vim-256noir",
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "erikbackman/brightburn.vim",
    },
    {
        'dasupradyumna/midnight.nvim',
    },
    {
        "slugbyte/lackluster.nvim",
    },
    {
        "ficcdaf/ashen.nvim",
    },
    { 'projekt0n/github-nvim-theme', name = 'github-theme' }
}

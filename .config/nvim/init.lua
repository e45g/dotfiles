        -- Core
vim.g.mapleader = " "

require("caelus.init").colorscheme()
-- vim.cmd.colorscheme("quiet")

local o = vim.opt
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

        -- Options
        -- UI
o.guicursor = ""
o.number = true
o.relativenumber = true
o.scrolloff = 3
o.signcolumn = "yes"
o.colorcolumn = "100"
o.wrap = false

        -- Clipboard / undo
o.clipboard = "unnamedplus"
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

        -- Spelling
o.spell = true
o.spelllang = { "en_us", "cs" }

        -- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

        -- Indentation
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.cindent = true

        -- Files / completion
o.isfname:append("@-@")
o.completeopt = { "menuone", "noselect", "popup" }
o.autocomplete = true
o.complete:append("o")

        -- Diagnostics & LSP servers
vim.diagnostic.config({ virtual_text = true })

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--fallback-style=Microsoft"
  },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
})

vim.lsp.config("asm_lsp", {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "nasm", "vmasm" },
  root_markers = { ".asm-lsp.toml", ".git" },
})

vim.lsp.config("texlab", {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".latexmkrc", "main.tex", ".git" },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      chktex = { onOpenAndSave = true },
    },
  },
})

vim.lsp.config("pylsp", {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    pylsp = {
      plugins = {
        -- ruff handles these, so turn them off to avoid duplicate diagnostics
        pycodestyle = { enabled = false },
        pyflakes    = { enabled = false },
        mccabe      = { enabled = false },
        autopep8    = { enabled = false },
        yapf        = { enabled = false },
        -- jedi gives completion, hover, definition, references
        jedi_completion = { fuzzy = true },
      },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
})

vim.lsp.enable({ "clangd", "texlab", "asm_lsp", "pylsp", "ruff" })

vim.api.nvim_create_autocmd("TextYankPost", {
   pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 80,
        })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function(ev)
        if #vim.lsp.get_clients({ bufnr = ev.buf, method = "textDocument/formatting" }) > 0 then
            vim.lsp.buf.format({ bufnr = ev.buf, timeout_ms = 2000 })
        end

        local view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  group = augroup,
  callback = function(ev)
    if #vim.lsp.get_clients({ bufnr = ev.buf, method = "textDocument/completion" }) > 0 then
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
  end,
})

        -- Keymaps
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function pum_visible()
  return vim.fn.pumvisible() == 1
end

            -- GeneraL
map("n", "<leader>pv", ":Explore<CR>", { desc = "File explorer" })
map("n", "<leader>m", ":make<CR>", { desc = "Make" })
map("n", "<leader>r", ":!./%:r<CR>", { desc = "Run binary built from current file" })

            -- Completion menu
map("i", "<Tab>", function()
  if pum_visible() then
    return "<C-n>"
  end
  if vim.snippet.active({ direction = 1 }) then
    vim.schedule(function() vim.snippet.jump(1) end)
    return ""
  end
  return "<Tab>"
end, { expr = true, desc = "Next completion / snippet jump" })

map("i", "<S-Tab>", function()
  if pum_visible() then
    return "<C-p>"
  end
  if vim.snippet.active({ direction = -1 }) then
    vim.schedule(function() vim.snippet.jump(-1) end)
    return ""
  end
  return "<S-Tab>"
end, { expr = true, desc = "Prev completion / snippet jump" })

map("i", "<CR>", function()
  if pum_visible() and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true, desc = "Accept selected completion" })

            -- LSP (buffer-local, set when a server attaches)
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local function lsp_map(lhs, rhs, desc, mode)
      map(mode or "n", lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

                -- Navigation
    lsp_map("gd", vim.lsp.buf.definition, "Definition")
    lsp_map("gD", vim.lsp.buf.declaration, "Declaration")

                -- Actions
    lsp_map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
    lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")
    lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })

                -- Diagnostics
    lsp_map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
    lsp_map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
    lsp_map("<leader>e", vim.diagnostic.open_float, "Line diagnostics")
  end,
})

            -- LaTeX: buffer-local override of the global <leader>r
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "tex",
  callback = function(ev)
    map("n", "<leader>r", ":silent !zathura %:r.pdf &<CR>", {
      buffer = ev.buf,
      desc = "Open PDF in zathura",
    })
  end,
})

        -- Filetype settings
            -- C: no Makefile? compile the current file directly
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "c",
  callback = function()
    local has_makefile = vim.fn.filereadable("Makefile") == 1
      or vim.fn.filereadable("makefile") == 1
    if not has_makefile then
      vim.opt_local.makeprg = "gcc -Wall -Wextra -g % -o %:r"
    end
  end,
})

            -- LaTeX
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "tex",
  callback = function()
    local opt = vim.opt_local

                -- Build
    opt.makeprg = "latexmk -pdf -interaction=nonstopmode -file-line-error %"
    opt.errorformat = "%f:%l: %m"

                -- Prose-friendly display
    opt.wrap = true
    opt.linebreak = true
    opt.colorcolumn = ""

                -- Indentation (C-style indent mangles LaTeX)
    opt.cindent = false
    opt.smartindent = false
    opt.shiftwidth = 2
    opt.tabstop = 2
    opt.softtabstop = 2
  end,
})

        -- Quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "make",
  callback = function() vim.cmd("cwindow") end,
})

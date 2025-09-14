return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🛠️  Mason Setup
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        require('mason').setup({
            ui = {
                border = 'single',
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗'
                }
            }
        })

        require('mason-lspconfig').setup({
            ensure_installed = { 'clangd', 'lua_ls', 'texlab' },
            automatic_installation = true,
        })

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🎨 Diagnostics Configuration
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        local signs = {
            Error = ' ',
            Warn = ' ',
            Info = ' ',
            Hint = '󰌶 '
        }

        -- Modern way to define diagnostic signs
        for type, icon in pairs(signs) do
            local severity = vim.diagnostic.severity[type:upper()]
            vim.diagnostic.config({
                signs = {
                    text = {
                        [severity] = icon,
                    }
                }
            })
        end

        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',
                severity = { min = vim.diagnostic.severity.WARN },
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'single',
                source = 'always',
                header = '',
                prefix = '',
            },
        })

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🔧 LSP Handlers
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover, { border = 'single' }
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help, { border = 'single' }
        )

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- ⚙️  Completion Setup
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                -- TAB: completion OR jump inside snippet
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
                    end
                end, { 'i', 's' }),

                -- Shift-TAB: back in snippet or previous completion
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'luasnip', priority = 750 },
                { name = 'buffer', priority = 500 },
                { name = 'path', priority = 250 },
            }),
            formatting = {
                format = function(entry, vim_item)
                    -- Add source name
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snippet]',
                        buffer = '[Buffer]',
                        path = '[Path]',
                    })[entry.source.name]
                    return vim_item
                end
            },
        })

        -- Command line completion
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🎯 LSP Capabilities & Keymaps
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local function on_attach(client, bufnr)
            -- LSP attached, keybinds handled elsewhere
        end

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🚀 texlab (latex)
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        require('lspconfig').texlab.setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            on_attach = function(client, bufnr)
                -- Optional: keymaps handled by VimTeX
            end,
            settings = {
                texlab = {
                    build = {
                        executable = "pdflatex",  -- directly use pdflatex
                        args = { "-interaction=nonstopmode", "%f" },
                        onSave = false,           -- we don’t need auto-build; VimTeX handles it
                        forwardSearchAfter = true,
                    },
                    forwardSearch = {
                        executable = "zathura",
                        args = { "%p", "%f", "%l" },
                    },
                    lint = {
                        onEdit = true,
                        onSave = true,
                    },
                },
            },
            filetypes = { "tex" },
        })


        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🚀 asm_lsp
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        require('lspconfig').asm_lsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "asm", "nasm" },
            root_dir = require('lspconfig').util.root_pattern(".git", "."),
        })

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🚀 clangd (C/C++)
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        require('lspconfig').clangd.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- Disable clangd's built-in completion to prevent duplicates
                client.server_capabilities.completionProvider = false

                on_attach(client, bufnr)
            end,
            cmd = {
                'clangd',
                '--background-index',
                '--clang-tidy',
                '--header-insertion=iwyu',
                '--completion-style=detailed',
                '--function-arg-placeholders',
                '--fallback-style=llvm',
                '--cross-file-rename',
                '--pch-storage=memory',
                '--suggest-missing-includes',
                '--all-scopes-completion',
                '--log=verbose',
            },
            filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
            root_dir = require('lspconfig').util.root_pattern(
                'compile_commands.json',
                'compile_flags.txt',
                '.clangd',
                '.clang-tidy',
                '.clang-format',
                'Makefile',
                'configure.ac',
                'configure.in',
                'config.h.in',
                'meson.build',
                'meson_options.txt',
                'build.ninja',
                '.git'
            ),
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
            settings = {
                clangd = {
                    InlayHints = {
                        Designators = true,
                        Enabled = true,
                        ParameterNames = true,
                        DeducedTypes = true,
                    },
                    fallbackFlags = { '-std=c17' },
                },
            },
        })

        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- 🌙 lua_ls (For Neovim configuration)
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        require('lspconfig').lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = vim.split(package.path, ';'),
                    },
                    diagnostics = {
                        globals = { 'vim' },
                        disable = { 'missing-fields' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true,
                        },
                    },
                    telemetry = { enable = false },
                    format = { enable = false },
                },
            },
        })
    end,
}

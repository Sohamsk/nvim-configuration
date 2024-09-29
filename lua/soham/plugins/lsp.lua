return {
	"neovim/nvim-lspconfig",
	dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        -- Snippet shtick
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
	},
	config = function()
		require("mason").setup()
        local cmp_lsp = require("cmp_nvim_lsp")
		require("mason-lspconfig").setup {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
                "clangd"
			},
		}
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
		local handlers = {
			function (server_name)
				require("lspconfig")[server_name].setup {
                    capabilities = capabilities
                }
			end,
            ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            ["clangd"] = function ()
                local lspconfig = require("lspconfig")
                lspconfig.clangd.setup {
                    capabilities = capabilities,
                    cmd = { "clangd" }
                }
            end
        }

        require("mason-lspconfig").setup_handlers(handlers)
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
               -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                    { name = 'buffer' },
                })
        })
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })


        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
 --        cmp.setup.cmdline(':', {
 --            mapping = cmp.mapping.preset.cmdline(),
 --            sources = cmp.config.sources({
 --                { name = 'path' }
 --            }, {
 --                    { name = 'cmdline' }
 --                }),
 --            matching = { disallow_symbol_nonprefix_matching = false }
 --        })

    end
    }

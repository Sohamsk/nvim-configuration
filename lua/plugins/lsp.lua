return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			 "mason-org/mason.nvim",
			 "mason-org/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup({})
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = 'LuaJIT'
							},
							diagnostics = {
				                globals = { "vim" },
				            },
				            workspace = {
				                checkThirdParty = false,
				                library = vim.api.nvim_get_runtime_file("", true),
								            },
						}
					}
				},
				bashls = {
					cmd = { 'bash-language-server', 'start' },
  					filetypes = { 'bash', 'sh' }
				},
			}
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				auto_enable = true
			})

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
			end
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		},
		config = function()
			-- config
			local cmp = require "cmp"
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body) 
					end,
				},
				mapping = cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete({})
				},
				sources = cmp.config.sources({
					{ 
						name = "nvim_lsp" 
					}},
					{
						{ name = "buffer" },
						{ name = "path" },
				}),
			})
		end
	}
}

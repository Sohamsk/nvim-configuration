vim.keymap.set('n', '<leader>e', ':Ex<CR>', { silent = true })
vim.keymap.set('v', 'Y', '"+y', { desc = 'Copy to System Clipboard'})
vim.keymap.set('n', 'YY', '"+yy', { desc = 'Copy to System Clipboard'})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


vim.api.nvim_create_autocmd('LspAttach', {
	callback = function()
		vim.keymap.set('n', 'gd', builtin.lsp_definitions)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover)
		vim.keymap.set('n', 've', vim.diagnostic.open_float)
	end
})

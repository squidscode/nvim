require("sid")

-- Options:
vim.wo.relativenumber = true
vim.wo.number = true
vim.diagnostic.config({
	update_in_insert = true
})
vim.api.nvim_set_option('tabstop', 4)
vim.api.nvim_set_option('shiftwidth', 4)

-- Keymaps
vim.keymap.set('n', '<leader>1', [[1gt]])
vim.keymap.set('n', '<leader>2', [[2gt]])
vim.keymap.set('n', '<leader>3', [[3gt]])
vim.keymap.set('n', '<leader>4', [[4gt]])
vim.keymap.set('n', '<leader>5', [[5gt]])
vim.keymap.set('n', '<leader>6', [[6gt]])
vim.keymap.set('n', '<leader>7', [[7gt]])
vim.keymap.set('n', '<leader>8', [[8gt]])
vim.keymap.set('n', '<leader>9', [[9gt]])
vim.keymap.set('n', '<leader>w', [[<C-w>]])
vim.keymap.set('n', '<C-w>a', [[:res<Enter>]])
vim.keymap.set('n', '<C-w>A', [[:res<Enter>]])
vim.keymap.set('n', '<localleader>w', [[<C-w>ji]])
vim.keymap.set('n', '<leader>nw', [[<C-w>n<C-w>T]])
vim.keymap.set('n', '<leader>nt', [[<C-w>s:terminal<Enter><C-w>T]])
vim.keymap.set('n', '<leader>st', [[:sp<Enter><C-w>j:terminal<Enter><C-w><C-w>]])
vim.keymap.set('n', '[b', [[:bprev<Enter>]])
vim.keymap.set('n', ']b', [[:bnext<Enter>]])
vim.keymap.set('n', '[B', [[:bfirst<Enter>]])
vim.keymap.set('n', ']B', [[:blast<Enter>]])
vim.keymap.set('n', '<leader>l', [[:ls<Enter>]])
vim.keymap.set('n', '<leader>bd', [[:bd<Enter>]])
vim.keymap.set('n', '<leader>g', [[`]])
vim.keymap.set('n', '<leader>to', [[:tabonly]])
vim.keymap.set('n', '<C-q>', [[:Bdelete menu<Enter>]])


vim.keymap.set('t', '<localleader>1', [[<C-\><C-n>1gt]])
vim.keymap.set('t', '<localleader>2', [[<C-\><C-n>2gt]])
vim.keymap.set('t', '<localleader>3', [[<C-\><C-n>3gt]])
vim.keymap.set('t', '<localleader>4', [[<C-\><C-n>4gt]])
vim.keymap.set('t', '<localleader>5', [[<C-\><C-n>5gt]])
vim.keymap.set('t', '<localleader>6', [[<C-\><C-n>6gt]])
vim.keymap.set('t', '<localleader>7', [[<C-\><C-n>7gt]])
vim.keymap.set('t', '<localleader>8', [[<C-\><C-n>8gt]])
vim.keymap.set('t', '<localleader>9', [[<C-\><C-n>9gt]])
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<localleader>c', [[<C-\><C-n>]])
vim.keymap.set('t', '<localleader>w', [[<C-\><C-n><C-w><C-w>]])
vim.keymap.set('t', '<s-space>', [[<space>]])

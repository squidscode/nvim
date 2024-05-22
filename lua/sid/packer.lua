local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  -- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- use ({
--	  'rose-pine/neovim',
--	  as = 'rose-pine',
--	  config = function()
--	  vim.cmd('colorscheme rose-pine')
--	  end
  -- })

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use ('nvim-treesitter/playground')
  use ('theprimeagen/harpoon')
  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')

  use {
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  }

  use ('p00f/clangd_extensions.nvim')

  use {'neoclide/coc.nvim', branch = 'master', run = 'npm ci'}

  use { "catppuccin/nvim", as = "catppuccin" }

  use {"Asheq/close-buffers.vim"}

  use {
	"samjwill/nvim-unception",
    setup = function()
        -- Optional settings go here!
        -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
    end }

  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }


end)

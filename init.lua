vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- NvimTree shows up on right
require('nvim-tree').setup {
  view = {
    side = 'right'
  }
}

-- Set OCaml-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ocaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Ensure Neovim recognizes OCaml file extensions
-- vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
  -- pattern = "*.ml,*.mli",
  -- command = "set filetype=ocaml",
-- })

-- Forcing cmp back to default behavior
local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  }
})

-- Dune build
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ml", "*.mli" },
  callback = function()
    if vim.fn.glob("**/dune") ~= ""  then
          vim.fn.jobstart("dune build", {
          on_stdout = function(_, data)
            --if data then
              -- vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
            --end
          end,
          on_stderr = function(_, data)
            -- if data then
              -- vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
            -- end
          end,
          on_exit = function(_, code)
            if code == 0 then
              vim.notify("Dune build completed successfully.", vim.log.levels.INFO)
            -- else
              -- vim.notify("Dune build failed.", vim.log.levels.ERROR)
            end
          end,
        })
    else
      vim.notify("No dune file found, skipping build.", vim.log.levels.WARN)
    end
  end,
})

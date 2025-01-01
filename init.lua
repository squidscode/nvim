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

-- harpoon :: https://github.com/ThePrimeagen/harpoon/tree/harpoon2
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

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
          on_exit = function(_, code)
            if code == 0 then
              vim.notify("Dune build completed successfully.", vim.log.levels.INFO)
            end
          end,
        })
    else
      vim.notify("No dune file found, skipping build.", vim.log.levels.WARN)
    end
  end,
})

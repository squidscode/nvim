local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local util = require "lspconfig/util"

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

vim.tbl_deep_extend('keep', lspconfig, {
	lsp_name = {
		cmd = { 'racket -l racket-langserver' },
		filetypes = 'rkt',
		name = 'racket-langserver',
	}
})

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- rust
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  on_init = on_init,
  filetypes = {"rust"},
  capabilities = capabilities,
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      }
    }
  }
})

-- python
lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python", "py"}
})

-- go
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- clangd
lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"cpp", "c", "h", "hpp", "tpp"}
})

-- ocaml
lspconfig.ocamllsp.setup({
	on_attach = on_attach,
})

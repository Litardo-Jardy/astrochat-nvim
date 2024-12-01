
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Usar LuaSnip para snippets
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(), -- Navegar hacia abajo
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navegar hacia arriba
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar selección
    ["<C-Space>"] = cmp.mapping.complete(), -- Forzar autocompletado manual
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- Fuente: LSP
    { name = "luasnip" },  -- Fuente: Snippets
  }, {
    { name = "buffer" },   -- Fuente: Buffer actual
    { name = "path" },     -- Fuente: Rutas
  }),
})

-- Configuración de LSP con nvim-lspconfig
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ts_ls.setup({ capabilities = capabilities }) -- JavaScript/TypeScript

lspconfig.lua_ls.setup({ -- Lua
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }, -- Evitar errores con "vim"
    },
  },
})

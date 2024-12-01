return {
  {
    "williamboman/mason.nvim",              -- Plugin principal de Mason
    dependencies = {
      "williamboman/mason-lspconfig.nvim",   -- Conexión entre Mason y nvim-lspconfig
      "neovim/nvim-lspconfig",               -- Configuración base de LSP
    },
    config = function()
      -- Configuración inicial de Mason
      require("mason").setup()

      -- Configuración de mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright" },  -- Servidores LSP que deseas instalar
      })

      -- Configuración de nvim-lspconfig para servidores específicos
      local lspconfig = require("lspconfig")

      -- Configuración para el servidor de Lua (lua_ls)
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      -- Configuración para TypeScript (tsserver)
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Ir a definición
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Buscar referencias
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Renombrar
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Acciones de código
        end,
      })

      -- Configuración para Python (pyright)
      lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}

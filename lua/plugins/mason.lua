return {
  {
    "williamboman/mason.nvim",              -- plugin principal de mason
    dependencies = {
      "williamboman/mason-lspconfig.nvim",   -- conexión entre mason y nvim-lspconfig
      "neovim/nvim-lspconfig",               -- configuración base de lsp
      {
        "nvimtools/none-ls.nvim",
        name = "null-ls",
        dependencies = { "nvim-lua/plenary.nvim" },
      }
    },
    config = function()
      -- Configuración inicial de Mason
      require("mason").setup()

      -- Configuración de mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "eslint", "pyright", "cssls", "omnisharp" },  -- Servidores LSP que deseas instalar
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

      -- Configuración para Css (cssls)
      lspconfig.cssls.setup({
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })

      -- Configuracion para c#
     lspconfig.omnisharp.setup({
      cmd = { "omnisharp" },  -- Comando para ejecutar OmniSharp
      root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln"),  -- Determina el directorio raíz
      on_attach = function(client, bufnr)
         local opts = { noremap = true, silent = true, buffer = bufnr }
         -- Definir atajos de teclado útiles para C#
         vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)  -- Ir a definición
         vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)  -- Buscar referencias
         vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)  -- Renombrar
         vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- Acciones de código
      end,
     })


     local null_ls = require("null-ls")

     null_ls.setup({
       sources = {
         null_ls.builtins.formatting.prettier.with({
       prefer_local = "node_modules/.bin",
     }),
    },
      on_attach = function(client, bufnr)
        -- No formateo automático al guardar
      end,
    })
    vim.api.nvim_set_keymap(
     "n",
     "<leader>f",
     "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
    { noremap = true, silent = true })


    end,
  },
}

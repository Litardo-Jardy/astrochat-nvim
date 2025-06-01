
vim.g.mapleader = " " -- Leader;

-- Config to editor;
vim.wo.relativenumber = true
vim.o.completeopt = "menuone,noselect"
vim.o.signcolumn = "yes"

-- Change function tabs;
local b = { noremap = true, silent = true, }
vim.keymap.set('i', 'jj', '<Esc>', b)

-- Guardado sin formatear automaticamente
vim.keymap.set('i', '<C-s>', function()
  vim.api.nvim_command('stopinsert')
  vim.cmd('noautocmd w') 
end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-s>', ':noautocmd w<CR>', { noremap = true, silent = true })

-- Formateo de forma manual
vim.keymap.set('n', '<Leader>f', function()
  vim.lsp.buf.format({
    async = true,
    filter = function(client)
      return client.name == "null-ls"
    end,
  })
end, { noremap = true, silent = true, desc = "Format buffer with prettier" })

vim.keymap.set('n', 'ñ', '<cr>', b)

vim.keymap.set("n", "<Leader>gb", function()
  require("plugins.telescope.builtin").git_bcommits()
end, { noremap = true, silent = true, desc = "Git blame with Telescope" })

-- Open 
vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle Nvim Tree" })


-- Mostrar diagnósticos del espacio de trabajo
vim.keymap.set("n", "<leader>xw", function() vim.diagnostic.setloclist() end, { desc = "Workspace Diagnostics" })


--Diagnostico

local telescope_builtin = require("telescope.builtin")
-- Buscar diagnósticos de todo el proyecto
vim.keymap.set("n", "<leader>xd", telescope_builtin.diagnostics, { desc = "Project Diagnostics" })
local telescope_builtin = require("telescope.builtin")

-- Buscar diagnósticos solo en el archivo actual
vim.keymap.set("n", "<leader>xw", function()
  telescope_builtin.diagnostics({ bufnr = 0 })  -- Solo busca en el buffer actual
end, { desc = "Document Diagnostics" })

-- Open search with telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })

-- Codemiun 
vim.keymap.set("i", "<C-a>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

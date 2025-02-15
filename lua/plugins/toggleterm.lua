return {
	{
    "akinsho/toggleterm.nvim",
    version = "*",  -- Opcional: asegúrate de instalar la última versión
    config = function()
      require("toggleterm").setup({
        size = 20,                -- Tamaño de la terminal, puedes ajustarlo
        open_mapping = [[<c-t>]], -- Mapeo de tecla para abrir la terminal (Ctrl-\)
        direction = "float", -- La dirección de la terminal ("horizontal", "vertical", "float")
        shade_filetypes = {},     -- Lista de tipos de archivo donde no se debe aplicar sombra
        shade_terminals = true,   -- Aplica sombra a las terminales
        shading_factor = 2,       -- Cuánto se aplica la sombra (valor entre 1 y 10)
        start_in_insert = true,   -- Iniciar en modo insertar
        insert_mappings = true,   -- Habilitar atajos en modo insertar
        terminal_mappings = true, -- Habilitar atajos en la terminal
      })

      -- Si necesitas mapear teclas específicas para las terminales, puedes hacerlo aquí:
      -- Por ejemplo, mapear <C-t> para abrir y cerrar la terminal
      vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    end
  },}

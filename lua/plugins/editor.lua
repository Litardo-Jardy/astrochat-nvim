return { 
    {
    -- Plugin: git.nvim
    "dinhhuy258/git.nvim",
    event = "BufReadPre", -- Load the plugin before reading a buffer
    opts = {
      keymaps = {
        blame = "<Leader>gb", -- Keybinding to open blame window
        browse = "<Leader>go", -- Keybinding to open file/folder in git repository
          },
       },
    },
   
    {
    -- Plugin: telescope.nvim
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults = {
        path_display = { "smart" }, -- Display paths smartly
        file_ignore_patterns = {
          "node_modules",
          "package-lock.json",
          "yarn.lock",
          "bun.lockb",
        },
        prompt_prefix = "> ", -- Set the prompt to just ">"
        layout_strategy = "horizontal", -- Use horizontal layout
        sorting_strategy = "ascending", -- Sort results in ascending order
        winblend = 0, -- No transparency
        results_title = false, -- Remove the "Results" title
        borderchars = {
          prompt = { "─", " ", " ", " ", " ", " ", " ", " " }, -- Top border for the prompt only
          results = { " ", " ", " ", " ", " ", " ", " ", " " }, -- No borders for results
          preview = { "─", "│", " ", "│", "╭", "╮", "", "" }, -- Borders for the preview (top and sides)
        },
        mappings = {
          i = {
            ["<C-Down>"] = actions.cycle_history_next, -- Cycle to next history item
            ["<C-Up>"] = actions.cycle_history_prev, -- Cycle to previous history item
            ["<C-f>"] = actions.preview_scrolling_down, -- Scroll preview down
            ["<C-b>"] = actions.preview_scrolling_up, -- Scroll preview up
          },
          n = {
            ["q"] = actions.close, -- Close the telescope window
          },
        },
      }

      -- Load the fzf extension for fast searches
      require("telescope").load_extension("fzf")

      -- Add hidden files and no-ignore options to file search and live_grep
      opts.pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--no-ignore", "--iglob", "!.git/" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--no-ignore" }
          end,
        },
      }
      return opts
    end,

    dependencies = {
      {
        -- Plugin: telescope-live-grep-args.nvim
        -- URL: https://github.com/nvim-telescope/telescope-live-grep-args.nvim
        -- Description: Adds live grep arguments to Telescope.
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
        config = function()
          require("telescope").load_extension("live_grep_args")
        end,
      },
      {
        -- Plugin: telescope-fzf-native.nvim
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Build the plugin using make
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      -- Keybinding to open live grep with arguments
      --
      vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

    end,
  },

----Codeium dependencies


{
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- Si usas cmp
  },
  config = function()
    require("codeium").setup({
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        idle_delay = 75,
        key_bindings = {
          accept = "<c-a>",
          next = "<c-j>",
          prev = "<c-k>",
        },
      },
    })
  end,
  event = "InsertEnter",
},

{
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view = {
      side = "left",
      width = 30,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- Mapea "l" para abrir archivos o expandir
     vim.keymap.set("n", "a", api.fs.create, opts("Create"))
     vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
     vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
     vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
     vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
     vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))

     -- Navegación
     vim.keymap.set("n", "l", api.node.open.edit, opts("Open File or Folder"))
     vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Folder"))
     vim.keymap.set("n", "P", api.node.navigate.parent, opts("Go to Parent"))

     -- Otros
     vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
    end,
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle Nvim Tree" })
  end,
}
}


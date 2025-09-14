-- lua/plugins/core.lua
return {
    
  -- NeoVim Themes 
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  --Telescop: Easy navigation with nvim 
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup{}

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fb", builtin.buffers)
        vim.keymap.set("n", "<leader>lg", builtin.live_grep)

    end,
  },

  --Treesitter
  {
    "nvim-treesitter/nvim-treesitter", 
    branch = 'master', 
    lazy = false, build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "python" },
            highlight = {
                enable = true,      -- Activate syntax highlighting
                additional_vim_regex_highlighting = false, -- Avoid duplicate highlights
            },
        indent = { enable = true }, -- Optional: better indentation
        })
    end,
  },


    -- Mason: LSP/DAP/Linter installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- Mason-LSPConfig: bridge between mason and nvim-lspconfig
  {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = { "pyright" }, -- auto-install pyright
        })

        local lspconfig = require("lspconfig")
        lspconfig.pyright.setup({})
      end
  },

  -- LSPConfig: actual Neovim LSP client configs
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})

      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) 
    end
  },


}


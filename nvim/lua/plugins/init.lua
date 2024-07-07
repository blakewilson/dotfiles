return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

 {
   "neovim/nvim-lspconfig",
   config = function()
     require("nvchad.configs.lspconfig").defaults()
     require "configs.lspconfig"
   end,
 },

 {
 	"williamboman/mason.nvim",
 	opts = {
 		ensure_installed = {
 			"lua-language-server",
      "stylua",
 			"html-lsp",
      "css-lsp" ,
      "prettier",
      "typescript-language-server",
      "svelte-language-server",
      "tailwindcss-language-server",
      "markdownlint",
      "json-lsp",
      "html-lsp",
      "eslint-lsp",
      "codespell",
      "bash-language-server",
      "graphql-language-service-cli"
 		},
 	},
 },

{
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
        config = {
          week_header = {
            enable = true
          },
          shortcut = {
          },
        }
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
},

{
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
}

 -- require('telescope').setup{
 --   defaults = {
 --     file_ignore_patterns = {
 --       "node_modules",
 --       "dist"
 --     }
 --   }
 -- }

 -- {
 -- 	"nvim-treesitter/nvim-treesitter",
 -- 	opts = {
 -- 		ensure_installed = {
 -- 			"vim", "lua", "vimdoc",
 --      "html", "css"
 -- 		},
 -- 	},
 -- },
}

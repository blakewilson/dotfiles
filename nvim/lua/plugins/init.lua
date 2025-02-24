return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        -- Available servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
        ensure_installed = {
          "lua_ls", -- Lua
          "marksman", -- Markdown
          "bashls", -- Bash
          "cssls", -- CSS
          "tailwindcss", -- Tailwind
          "dockerls", -- Docker
          "graphql", -- GraphQL
          "html", -- HTML
          "eslint", -- ESLint
          "tsserver", -- TypeScript/JS
          "jsonls", -- JSON
          "intelephense", -- PHP
          "yamlls", -- YAML
        },
      }
      require "../configs/lspconfig"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "User FilePost" },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    -- opts = function()
    --   return require "nvchad.configs.cmp"
    -- end,
    opts = function()
      return {
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
        mapping = {
          ["<C-p>"] = require("cmp").mapping.select_prev_item(),
          ["<C-n>"] = require("cmp").mapping.select_next_item(),
          ["<C-d>"] = require("cmp").mapping.scroll_docs(-4),
          ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
          ["<C-Space>"] = require("cmp").mapping.complete(),
          ["<C-e>"] = require("cmp").mapping.close(),

          ["<CR>"] = require("cmp").mapping.confirm {
            behavior = require("cmp").ConfirmBehavior.Insert,
            select = true,
          },

          ["<Tab>"] = require("cmp").mapping(function(fallback)
            if require("cmp").visible() then
              require("cmp").select_next_item()
            -- elseif require("luasnip").expand_or_jumpable() then
            --   require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = require("cmp").mapping(function(fallback)
            if require("cmp").visible() then
              require("cmp").select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    keys = {
      {
        -- Format with <leader>f
        "<leader>f",
        function()
          require("conform").format { async = true, lsp_format = "fallback" }
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      return require "../configs.conform"
    end,
  },

  {
    "zapling/mason-conform.nvim",
    event = { "VeryLazy" },
    config = function()
      require("mason-conform").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            "dist",
          },
          theme = "tokyonight",
          initial_mode = "insert",
          mappings = {
            n = {
              ["d"] = require("telescope.actions").delete_buffer,
            },
          },
        },
      }
    end,
  },

  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.cmd.colorscheme "gruvbox-material"
  --   end,
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "../configs.nvimtree"
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    event = { "VeryLazy" },
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
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
  },

  {
    "almo7aya/openingh.nvim",
    config = function()
      require("openingh").setup()
    end,
    keys = {
      {
        "<leader>gf",
        ":OpenInGHFile<CR>",
        mode = "n",
        noremap = true,
        silent = true,
        desc = "Open file on Git Web",
      },
      {
        "<leader>gf",
        ":'<,'>OpenInGHFile<CR>",
        mode = "x",
        noremap = true,
        silent = true,
        desc = "Open file lines on Git Web",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "VimEnter" },
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = { "VimEnter" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "tokyonight",
        },
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          },
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup()
    end,
  },

  {
    "romgrk/barbar.nvim",
    lazy = false,
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
        NvimTree = true,
      },
    },
  },

  {
    "frankroeder/parrot.nvim",
    event = "VeryLazy",
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
    -- optionally include "rcarriga/nvim-notify" for beautiful notifications
    config = function()
      return require "../configs/parrot"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "../configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      provider = "claude", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
      -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
      -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
      -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
      auto_suggestions_provider = "claude",
      cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}

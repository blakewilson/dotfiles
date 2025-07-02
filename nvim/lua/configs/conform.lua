local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { { "biome" }, { "prettier" } },
    typescript = { { "biome" }, { "prettier" } },
    json = { { "biome" }, { "prettier" } },
    html = { { "biome" }, { "prettier" } },
    css = { { "biome" }, { "prettier" } },
    php = { "phpcbf", "phpcs" },
    markdown = { "markdownlint" },
    ["*"] = { "codespell" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

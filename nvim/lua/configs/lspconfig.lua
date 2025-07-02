local LSPHelpers = {}
local map = vim.keymap.set

-- export on_attach & capabilities
LSPHelpers.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
LSPHelpers.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

LSPHelpers.capabilities = vim.lsp.protocol.make_client_capabilities()

LSPHelpers.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local on_attach = LSPHelpers.on_attach
local on_init = LSPHelpers.on_init
local capabilities = LSPHelpers.capabilities

-- Configure LSP servers
local function setup_servers()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  
  -- Get all installed servers from mason-lspconfig
  local installed_servers = mason_lspconfig.get_installed_servers()
  
  -- Set up each server with the common config
  for _, server_name in ipairs(installed_servers) do
    lspconfig[server_name].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
  
  -- You can also set up servers with custom configurations
  -- For example:
  -- lspconfig.rust_analyzer.setup {
  --   on_attach = on_attach,
  --   on_init = on_init,
  --   capabilities = capabilities,
  --   -- Custom settings for rust_analyzer
  --   settings = { ... }
  -- }
 end

-- Initialize servers
setup_servers()

local map = vim.keymap.set

-- general
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "buffer close" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Cancel out of terminal mode", noremap = true })
map("n", '"+y', "<leader>y", { desc = "Copy to system clipboard" })
map("n", "<leader>dd", function()
  vim.diagnostic.open_float()
end, { desc = "toggles local errors/diagnostic" })

-- line numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- formatting
map("n", "<leader>s", "<cmd>noautocmd w<CR>", { desc = "Save without formatting" })
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "General Format file" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- diffview
local defaultGitBranch = vim.fn.system "git symbolic-ref refs/remotes/origin/HEAD --short" -- e.g. origin/main, origin/develop
map("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "open diffview" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "close diffview" })
map(
  "n",
  "<leader>pr",
  "<cmd>DiffviewOpen " .. defaultGitBranch .. "...HEAD<CR>",
  { desc = "See diff from main branch to current branch" }
)

-- telescope
map("n", "<leader>t", "<cmd>Telescope <CR>", { desc = "telescope" })
map("n", "<leader>b", "<cmd>Telescope buffers <CR>", { desc = "telescope" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- barbar
map("n", "<C-[>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<C-]>", "<Cmd>BufferNext<CR>", opts)

-- Pin/unpin buffer
-- map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
map("n", '"+y', "<leader>y")

map("n", "<leader>dd", function()
  vim.diagnostic.open_float()
end, { desc = "toggles local errors/diagnostic" })

map("n", "<leader>x", "<cmd>bd<CR>", { desc = "buffer close" })

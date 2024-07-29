require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
map("n", '"+y', "<leader>y")

vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.open_float()
end, { desc = "toggles local errors/diagnostic" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

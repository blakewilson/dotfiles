require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map('t', '<Esc>', [[<C-\><C-n>]],{noremap=true})
map('n', "\"+y", "<leader>y")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

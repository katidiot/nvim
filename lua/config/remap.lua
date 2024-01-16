-- Map 'leader' to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Open filemanager
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex)

-- Move highlighted line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append next line to current keeping cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll up/down and center view
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Center view when searching and open folds
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste replace visual selection without copying it
--vim.keymap.set("x", "<leader>p", [["_dP]])

-- Use system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["+d]])
vim.keymap.set({"n", "v"}, "<leader>D", [["+D]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

--vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Alternative to Esc key
vim.keymap.set("i", "<C-c>", "<Esc>")

--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace the word under the cursor globally
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- Change spell language
vim.keymap.set("n", "<leader>ss", ":setlocal spell! spelllang=en<cr>")
vim.keymap.set("n", "<leader>se", ":setlocal spell! spelllang=el<cr>")

-- Set paste
vim.keymap.set("n", "<leader>pp", ":setlocal paste!<cr>")

-- Quick save and exit
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>x", ":x<cr>")

-- Format document
vim.keymap.set("n", "<leader>gg", "gg=Gg;zz")

-- Change buffers
vim.keymap.set("n", "<m-l>", ":bn<cr>")
vim.keymap.set("n", "<m-h>", ":bp<cr>")
vim.keymap.set("n", "<m-j>", ":bp<bar>sp<bar>bn<bar>bd<cr>")

-- Go up/down on command mode (previous command)
vim.keymap.set("c", "<m-k>", "<Up>")
vim.keymap.set("c", "<m-j>", "<Down>")

-- Move around while in insert mode
vim.keymap.set("i", "<m-l>", "<Right>")
vim.keymap.set("i", "<m-h>", "<Left>")
vim.keymap.set("i", "<m-j>", "<Down>")
vim.keymap.set("i", "<m-k>", "<Up>")

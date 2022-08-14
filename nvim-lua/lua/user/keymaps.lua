M = {}

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
-- keymap("n", "<C-i>", "<C-i>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode --

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-tab>", "<c-6>", opts)

-- Tabs --
keymap("n", "<m-t>", ":tabnew %<cr>", opts)
keymap("n", "<m-y>", ":tabclose<cr>", opts)
keymap("n", "<m-\\>", ":tabonly<cr>", opts)
keymap("n", "<A-=>", "gt", opts)
keymap("n", "<A-->", "gT", opts)
keymap("n", "<A-1>", "1gt", opts)
keymap("n", "<A-2>", "2gt", opts)
keymap("n", "<A-3>", "3gt", opts)
keymap("n", "<A-4>", "4gt", opts)
keymap("n", "<A-5>", "5gt", opts)
keymap("n", "<A-6>", "6gt", opts)
keymap("n", "<A-7>", "7gt", opts)
keymap("n", "<A-8>", "8gt", opts)
keymap("n", "<A-9>", "9gt", opts)
keymap("n", "<A-0>", ":tablast<CR>", opts)

-- Resize with arrows
keymap("n", "<S-up>", ":resize -2<CR>", opts)
keymap("n", "<S-down>", ":resize +2<CR>", opts)
keymap("n", "<S-left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-right>", ":vertical resize +2<CR>", opts)

-- Y is supposed to be an alias for yy but for some reason it doesn't work as expected
keymap("n", "Y", "yy", opts)

-- Nvimtree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Map write commands
vim.cmd [[
  command! WQ wq
  command! Wq wq
  command! W w
  command! Q q
  command! Qa qa
]]

-- Navigate buffers
-- keymap("n", "<A-=>", ":bnext<CR>", opts)
-- keymap("n", "<A-->", ":bprevious<CR>", opts)
-- keymap("n", "<A-q>", ":bdelete<CR>", opts)

-- Move Lines and Blocks
keymap('n', '<A-j>', ":MoveLine(1)<CR>", opts)
keymap('n', '<A-k>', ":MoveLine(-1)<CR>", opts)
keymap('v', '<A-j>', ":MoveBlock(1)<CR>", opts)
keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", opts)
keymap('n', '<A-l>', ":MoveHChar(1)<CR>", opts)
keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", opts)
keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", opts)
keymap('v', '<A-h>', ":MoveHBlock(-1)<CR>", opts)

-- Telescope (Fuzzy Finder)
keymap(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  opts
)
keymap("n", "<C-s>", ":Telescope grep_string<CR>", opts)
keymap("n", "<C-f>", ":Telescope live_grep<CR>", opts)

-- Relative Number Toggle
keymap("n", "<F2>", ":set relativenumber!<CR>", opts)

-- Git
keymap("n", "<Leader>gb", ":GitBlameToggle<CR>", opts)
keymap("n", "<Leader>go", ":GitBlameOpenCommitURL<CR>", opts)

-- Insert Mode --

-- Disable arrow keys in Insert Mode
keymap("i", "<up>", "<nop>", opts)
keymap("i", "<down>", "<nop>", opts)
keymap("i", "<left>", "<nop>", opts)
keymap("i", "<right>", "<nop>", opts)

return M

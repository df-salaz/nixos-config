vim.g.mapleader = " "
local opts = { noremap = true, silent = true }
vim.keymap.set("", "<Space>", "<Nop>", opts)

-- General editing
vim.keymap.set("i", "<C-BS>", "<C-w>", opts);

-- Vim file manager
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex, opts)

-- Move text up and down
vim.keymap.set("n", "<A-j>", ":m +1<CR>", opts)
vim.keymap.set("n", "<A-k>", ":m -2<CR>", opts)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- System clipboard
vim.opt.clipboard = "unnamedplus"
-- Copy entire file
vim.keymap.set("n", "<C-S-y>", "gg0yG<C-o>", opts)

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.fillchars = {eob = " "}

-- Tabs and spacing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.textwidth = 80
vim.opt.formatoptions = "roqwnc"

-- Buffer switching
vim.keymap.set("n", "H", vim.cmd.bprevious, opts)
vim.keymap.set("n", "L", vim.cmd.bnext, opts)
vim.keymap.set("n", "<leader>t", ":bd<CR>", opts)
vim.keymap.set("n", "<leader>T", ":bd!<CR>", opts)

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Don't re-yank what I'm pasting over
vim.keymap.set("v", "p", '"*dP', opts)

vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.incsearch = true
vim.opt.ignorecase = true --finally free!

-- nvim-dap debugger
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<leader>d", ":lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<leader>i", ":lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<leader>n", ":lua require'dap'.step_over()<CR>", opts)

-- Neovide ✨
vim.o.guifont = "JetBrainsMono Nerd Font:h11"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0.04
vim.g.neovide_cursor_unfocused_outline_width = 0.08
vim.g.neovide_floating_shadow = true
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_transparency = 0.9


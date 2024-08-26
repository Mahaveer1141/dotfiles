vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.swapfile = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Yank to clipboard
vim.opt.clipboard = 'unnamed'

-- Enable break indent
vim.opt.breakindent = true

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- set the title of window
vim.opt.title = true

-- handle indentation of new line from current line
vim.opt.autoindent = true
vim.opt.smartindent = true

-- inserts blanks according to shiftwidth or tabstop
vim.opt.smarttab = true

vim.opt.backup = false

vim.opt.showcmd = true

vim.opt.cmdheight = 1

vim.opt.laststatus = 2

vim.opt.expandtab = true

vim.opt.shell = 'zsh'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }

vim.opt.inccommand = 'split'

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'java', 'python' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc', 'markdown', 'Dockerfile' },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- set file type on buffer creation and reading for slim
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.slim' },
  command = 'set ft=slim',
})

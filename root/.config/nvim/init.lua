vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true

--
-- Plugins 
--

vim.pack.add({
  { src = "https://github.com/tpope/vim-sleuth" },
  { src = "https://github.com/EdenEast/nightfox.nvim", },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/tpope/vim-abolish" },
  { src = "https://github.com/othree/eregex.vim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/f-person/git-blame.nvim" },
  { src = "https://github.com/notjedi/nvim-rooter.lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = 'https://github.com/echasnovski/mini.statusline' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
})

--
-- Theme
--

vim.cmd.colorscheme("carbonfox")

--
-- Keyboard shortcuts
--

local list_buffers = function()
  require("telescope.builtin").buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  })
end

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-a>", vim.cmd.NvimTreeFindFileToggle, {})
vim.keymap.set("n", "<leader>rg", require("telescope.builtin").live_grep, { desc = "[R]ip[G]rep" })
vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "" })
vim.keymap.set("n", ";;", list_buffers, { desc = "List buffers" })

--
-- Plugin setup
--

require("telescope").setup({
  defaults = {
    preview = false,
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
      theme = "ivy",
      layout_config = {
        height = 10,
      },
    },
    live_grep = {
      theme = "ivy",
      preview = true,
      hidden = true,
      layout_strategy = "vertical",
      layout_config = {
        width = { padding = 0 },
        height = 120,
      },
    },
    find_files = {
      theme = "ivy",
      hidden = true,
      layout_config = {
        height = 15,
      },
    },
    buffers = {
      theme = "ivy",
      layout_config = {
        height = 10,
      },
    },
  },
})

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
  },
  view = {
    width = 50,
  },
})

require("bufferline").setup()
require('mini.statusline').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require("fidget").setup()

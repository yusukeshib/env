vim.g.mapleader = ' '
vim.opt.nu = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
-- For NvimTree
vim.g.loaded_netrw = 1            -- disable netrw at the very start of your init.lua
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true      -- set termguicolors to enable highlight groups
vim.opt.clipboard = "unnamedplus" -- sync yank with mac's clipboard
vim.opt.cursorline = true         -- highlight current line
vim.opt.ignorecase = true
vim.opt.smartcase = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Lsp
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'VonHeikemen/lsp-zero.nvim', },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { 'simrat39/symbols-outline.nvim' },
  -- Todo
  { 'folke/todo-comments.nvim', },

  -- Debug
  { 'simrat39/rust-tools.nvim' },
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'folke/neodev.nvim', },
  { 'theHamsta/nvim-dap-virtual-text' },

  -- UI(status,tree,finder)
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "lua", "javascript", "typescript", "html", "rust" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- undo
  { 'mbbill/undotree' },
  -- theme
  { 'dracula/vim' },
  -- subvert
  { 'tpope/vim-abolish' },
  -- regex
  { 'othree/eregex.vim' },
  -- git
  { 'tpope/vim-fugitive' },
  -- { 'f-person/git-blame.nvim' },
  { 'lewis6991/gitsigns.nvim', },
  -- LSP progress indicator
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = {},
  },
})

-- ColorScheme
vim.cmd('colorscheme dracula')

-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)
require('lspconfig').lua_ls.setup({})
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})
-- Completion configuration
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  -- presetlect first item
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  -- enter to confirm
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  })
})

require('rust-tools').setup({
  server = {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = "clippy",
        },
        files = {
          excludeDirs = {
            "apps/content/node_modules",
          },
        },
      }
    },
    standalone = false
  }
})
require('dapui').setup()
require('neodev').setup({
  library = { plugins = { 'nvim-dap-ui' }, types = true },
})
require('nvim-tree').setup()
require('lualine').setup()
require('todo-comments').setup()
require('gitsigns').setup()
require('nvim-dap-virtual-text').setup()
require('symbols-outline').setup()

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

--
-- Keyboard shortcuts
--

-- Symbol outline
vim.keymap.set('n', '<leader>s', vim.cmd.SymbolsOutline, {})
-- Dap UI
vim.keymap.set('n', '<leader>d', require('dapui').toggle, {})
vim.keymap.set('n', '<F4>', vim.cmd.RustDebuggables, {})
vim.keymap.set('n', '<F5>', require('dap').continue, {})
vim.keymap.set('n', '<F9>', require('dap').toggle_breakpoint, {})
vim.keymap.set('n', '<F10>', require('dap').step_over, {})
vim.keymap.set('n', '<F11>', require('dap').step_into, {})
vim.keymap.set('n', '<F12>', require('dap').step_out, {})
-- Trouble
vim.keymap.set('n', '<leader>t', vim.cmd.TroubleToggle, {})
-- Undo tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {})
-- NvimTree
vim.keymap.set('n', '<C-a>', vim.cmd.NvimTreeFindFileToggle, {})
-- Telescope
require('telescope').load_extension('fzf')
vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').git_files(require('telescope.themes').get_ivy())
end, {})
vim.keymap.set('n', ';;', function()
  require('telescope.builtin').buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  });
end, {})

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
vim.opt.clipboard = "unnamedplus" -- sync yank with mac's clipboard
vim.opt.cursorline = true         -- highlight current line
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- For NvimTree
vim.g.loaded_netrw = 1       -- disable netrw at the very start of your init.lua
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

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

vim.g.coq_settings = { auto_start = true }

require('lazy').setup({
  -- Lsp
  { 'williamboman/mason.nvim',           config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },
  { 'neovim/nvim-lspconfig' },
  { 'L3MON4D3/LuaSnip' },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { 'simrat39/symbols-outline.nvim', config = true },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- Auto complete
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  {
    'github/copilot.vim',
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },
  { "zbirenbaum/copilot.lua", config = true },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "petertriho/cmp-git",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { 'lukas-reineke/cmp-rg' },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end
  },

  -- Todo
  { 'folke/todo-comments.nvim', config = true },

  -- Debug
  { 'simrat39/rust-tools.nvim', },
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui',     config = true },
  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup({
        library = { plugins = { 'nvim-dap-ui' }, types = true },
      })
    end
  },
  { 'theHamsta/nvim-dap-virtual-text', config = true },

  -- UI(status,tree,finder)
  { 'nvim-lualine/lualine.nvim',       config = true },
  { 'nvim-tree/nvim-tree.lua',         config = true },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true
  },
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
        ensure_installed = { "python", "lua", "typescript", "tsx", "html", "rust", "glsl" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- Light bulb
  {
    'kosayoda/nvim-lightbulb',
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
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
  { 'f-person/git-blame.nvim', config = true },
  { 'lewis6991/gitsigns.nvim', config = true },
  -- LSP progress indicator
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = {},
  },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = "op read op://Personal/openai/key --no-newline"
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
})


-- Set up nvim-cmp.
local luasnip = require("luasnip")
local cmp = require('cmp')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "git" },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "rg" },
    { name = "crates" },
    { name = "copilot", group_index = 2 },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require("cmp_git").setup()

-- ColorScheme
vim.cmd('colorscheme dracula')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').lua_ls.setup({
  capabilities = capabilities
})

require('rust-tools').setup({
  server = {
    capabilities = capabilities,
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

require("typescript-tools").setup({
  settings = {
    capabilities = capabilities,
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-auto-tag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    }
  },
})

-- Telescope
require('telescope').load_extension('fzf')

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

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
vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').git_files(require('telescope.themes').get_ivy())
end, {})
vim.keymap.set('n', ';;', function()
  require('telescope.builtin').buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  });
end, {})
-- Code action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

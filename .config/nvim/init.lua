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

-- For eregex
vim.g.eregex_default_enable = 0
vim.g.eregex_force_case = 1

local home = vim.fn.expand("$HOME")
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
  { 'williamboman/mason.nvim',          config = true },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
  },
  { 'neovim/nvim-lspconfig' },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
  },
  { 'simrat39/symbols-outline.nvim', config = true },

  { 'simrat39/rust-tools.nvim', },

  -- Auto complete
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'uga-rosa/cmp-dictionary',       config = true },
  -- { "zbirenbaum/copilot.lua",        config = true },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },
  {
    "petertriho/cmp-git",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "Dynge/gitmoji.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {},
    ft = "gitcommit",
    config = true
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

  -- Git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },

  -- Diff
  { 'sindrets/diffview.nvim' },

  -- Todo
  { 'folke/todo-comments.nvim', config = true },

  -- Debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { 'mfussenegger/nvim-dap', },
    config = true
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      'mfussenegger/nvim-dap',
      "nvim-neotest/nvim-nio",
    },
    config = true
  },
  {
    'ldelossa/nvim-dap-projects',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('nvim-dap-projects').search_project_config()
    end
  },
  { 'mfussenegger/nvim-dap', },

  -- UI(status,tree,finder)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
  { 'nvim-lualine/lualine.nvim', config = true },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        view = {
          width = 54
        },
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        filters = {
          git_ignored = false,
          dotfiles = false,
        },
      })
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    config = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    }
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup({
        defaults = {
          preview = false,
        },
        pickers = {
          buffers = {
            theme = "ivy",
          },
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })
    end
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
        ensure_installed = { "svelte", "python", "lua", "typescript", "tsx", "html", "rust", "glsl" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- rooter
  { 'notjedi/nvim-rooter.lua', config = true },
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

  -- KDL config file format
  { 'imsnif/kdl.vim' },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
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
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
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
    {
      name = "dictionary",
      keyword_length = 2,
    },
    { name = "rg" },
    { name = "crates" },
    -- { name = "copilot" },
  }, {
    { name = 'buffer' },
  }),
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' },
--     { name = 'gitmoji' },
--     {
--       name = "dictionary",
--       keyword_length = 2,
--     },
--     { name = "rg" },
--     { name = "copilot" },
--   }, {
--     { name = 'buffer' },
--   })
-- })
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "pylsp", "tsserver" }
})

require('lspconfig').tsserver.setup({
  capabilities = capabilities
})

require('lspconfig').lua_ls.setup({
  capabilities = capabilities
})

require('lspconfig').pylsp.setup({
  capabilities = capabilities,
  settings = {
    pylsp = {
      formatCommand = { "black" },
      plugins = {
        -- formatter
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = false },
      }
    }
  }
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
            "crates/mercury_web/node_modules",
          },
        },
      }
    },
    standalone = false
  }
})

-- Telescope
require('telescope').load_extension('fzf')

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

--
-- Keyboard shortcuts
--

-- Debugger
local dap = require('dap')
local ui = require('dapui');

vim.keymap.set('n', '<F5>', dap.continue);
vim.keymap.set('n', '<s-F5>', dap.stop);
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint);
vim.keymap.set('n', '<F10>', dap.step_over);  -- step over
vim.keymap.set('n', '<F11>', dap.step_into);  -- step into
vim.keymap.set('n', '<s-F11>', dap.step_out); -- step out
vim.keymap.set('n', '<F12>', ui.toggle);      -- step out

dap.listeners.before.launch.dapui_config = function()
  ui.open()
end

-- NvimTree
vim.keymap.set('n', '<C-a>', vim.cmd.NvimTreeFindFileToggle, {})
-- Telescope
vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files(require('telescope.themes').get_ivy())
end, {})
vim.keymap.set('n', ';;', function()
  require('telescope.builtin').buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  });
end, {})

-- Keymap
local wk = require('which-key')

wk.add({
  { "<leader>a", function() vim.lsp.buf.code_action() end, desc = "Code action" },
  { "<leader>u", function() vim.cmd.UndotreeToggle() end,  desc = "Undo tree" },
  { "<leader>s", function() vim.cmd.SymbolsOutline() end,  desc = "Symbol outline" },
})

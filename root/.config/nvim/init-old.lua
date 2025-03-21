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

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },

  -- Auto complete
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'uga-rosa/cmp-dictionary', config = true },
  {
    "petertriho/cmp-git",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { "zbirenbaum/copilot.lua", config = true },
  { "zbirenbaum/copilot-cmp", config = true },
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
  { -- Autoformat
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'eslint_d', 'prettier', stop_after_first = true },
          typescript = { 'eslint_d', 'prettier', stop_after_first = true },
          typescriptreact = { 'eslint_d', 'prettier', stop_after_first = true },
        },
        format_on_save = {
          timeout_ms = 3000,
          async = false,
          lsp_format = "fallback",
        },
      });
    end
  },

  -- Diff
  { 'sindrets/diffview.nvim' },

  -- Todo
  { 'folke/todo-comments.nvim', config = true },

  -- Lint
  { 'mfussenegger/nvim-lint' },

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
  {
    'Weissle/persistent-breakpoints.nvim',
    config = function()
      require('persistent-breakpoints').setup({
        load_breakpoints_event = { "BufReadPost" }
      })
    end
  },

  -- UI(status,tree,finder)
  { 'norcalli/nvim-colorizer.lua', config = true },
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
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        filters = {
          git_ignored = false,
          dotfiles = false,
        },
        view = {
          width = 50
        }
      })
    end
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
    build = 'make'
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

  -- UI
  { 'MunifTanjim/nui.nvim' },
  { 'stevearc/dressing.nvim',    opts = {}, },

  -- rooter
  { 'notjedi/nvim-rooter.lua',   config = true },
  -- undo
  -- { 'mbbill/undotree' },
  -- theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
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
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  -- LLM
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     -- add any opts here
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua",      -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }
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
    { name = "copilot" },
    { name = "git" },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    {
      name = "dictionary",
      keyword_length = 2,
    },
    { name = "rg" },
    { name = "crates" },
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
vim.cmd('colorscheme tokyonight-night')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = { "rust_analyzer", "lua_ls", "ts_ls", "cssmodules_ls" }
})

require('lspconfig').ts_ls.setup({
  capabilities = capabilities
})

require('lspconfig').lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    }
  }
})
require('lspconfig').cssmodules_ls.setup({
  capabilities = capabilities,
})

-- Telescope
require('telescope').load_extension('fzf')

-- Set filetype of vert and frag to be GLSL type
vim.cmd('au! BufRead,BufNewFile *.vert,*.frag set filetype=glsl')

--
-- Keyboard shortcuts
--

-- Debugger
local dap = require('dap')
local ui = require('dapui');

vim.keymap.set('n', '<f5>', dap.continue);
vim.keymap.set('n', '<s-f5>', dap.stop);
-- vim.keymap.set('n', '<f9>', dap.toggle_breakpoint);
vim.keymap.set('n', '<f9>', require('persistent-breakpoints.api').toggle_breakpoint);
vim.keymap.set('n', '<f10>', dap.step_over);  -- step over
vim.keymap.set('n', '<f11>', dap.step_into);  -- step into
vim.keymap.set('n', '<s-f11>', dap.step_out); -- step out
vim.keymap.set('n', '<f12>', ui.toggle);      -- step out

-- Customize icons
vim.fn.sign_define('DapBreakpoint',
  { text = '●', texthl = 'DiagnosticSignError', linehl = '', numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DapStopped',
  { text = '▶️', texthl = 'DiagnosticWarn', linehl = '', numhl = 'DiagnosticWarn' })

dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
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

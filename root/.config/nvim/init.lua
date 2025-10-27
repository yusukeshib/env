-- ============================================================================
-- GENERAL SETTINGS
-- ============================================================================

-- Set leader key to space for custom key bindings
vim.g.mapleader = " "

-- Display line numbers in the gutter
vim.opt.number = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Use system clipboard for yank/paste operations
vim.opt.clipboard = "unnamedplus"

-- Preserve indentation when wrapping lines
vim.opt.breakindent = true

-- Save undo history to file for persistence across sessions
vim.opt.undofile = true

-- Case-insensitive search by default
vim.opt.ignorecase = true

-- Override ignorecase if search contains uppercase letters
vim.opt.smartcase = true

-- Always show sign column (prevents layout shift for git/diagnostic signs)
vim.opt.signcolumn = "yes"

-- Open vertical splits to the right of current window
vim.opt.splitright = true

-- Open horizontal splits below current window
vim.opt.splitbelow = true

-- Display whitespace characters
vim.opt.list = true

-- Define how whitespace characters are displayed (tabs, trailing spaces, nbsp)
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Show live preview of substitute commands in split window
vim.opt.inccommand = "split"

-- Highlight the line containing the cursor
vim.opt.cursorline = true

-- Keep 3 lines visible above/below cursor when scrolling
vim.opt.scrolloff = 3

-- Faster update time for better UX (affects CursorHold, swap file writes)
vim.opt.updatetime = 250

-- Time to wait for mapped sequence to complete (milliseconds)
vim.opt.timeoutlen = 300

-- Enable 24-bit RGB colors in the terminal
vim.opt.termguicolors = true

-- Prevent LSP completion from auto-selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- ============================================================================
-- PLUGINS
-- ============================================================================

vim.pack.add({
  -- Editor behavior
  { src = "https://github.com/tpope/vim-sleuth" },        -- Auto-detect indentation (tabs/spaces)
  { src = "https://github.com/tpope/vim-abolish" },       -- Advanced search/replace with case variants
  { src = "https://github.com/othree/eregex.vim" },       -- POSIX-style regular expressions
  { src = "https://github.com/notjedi/nvim-rooter.lua" }, -- Auto-change working directory to project root

  -- Theme and UI
  { src = "https://github.com/EdenEast/nightfox.nvim" },    -- Color scheme
  { src = "https://github.com/akinsho/bufferline.nvim" },   -- Tab/buffer line at the top
  { src = "https://github.com/nvim-lualine/lualine.nvim" }, -- Status line at the bottom
  { src = "https://github.com/j-hui/fidget.nvim" },         -- LSP progress notifications
  { src = "https://github.com/folke/which-key.nvim" },      -- Show available key bindings in popup

  -- Syntax and language support
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Modern syntax highlighting

  -- Git integration
  { src = "https://github.com/tpope/vim-fugitive" },      -- Git commands within vim
  { src = "https://github.com/sindrets/diffview.nvim" },  -- Enhanced diff viewer
  { src = "https://github.com/f-person/git-blame.nvim" }, -- Show git blame as virtual text
  { src = "https://github.com/lewis6991/gitsigns.nvim" }, -- Git diff signs in gutter

  -- File navigation and search
  { src = "https://github.com/nvim-lua/plenary.nvim" },         -- Lua utility library (dependency)
  { src = "https://github.com/nvim-telescope/telescope.nvim" }, -- Fuzzy finder (files, text, buffers)
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },       -- File explorer tree view

  -- LSP (Language Server Protocol)
  { src = "https://github.com/neovim/nvim-lspconfig" },                  -- LSP configuration presets
  { src = "https://github.com/mason-org/mason.nvim" },                   -- Language server installer
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },         -- Bridge mason & lspconfig
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" }, -- Inline LSP diagnostics

  -- Code completion and AI
  { src = "https://github.com/Saghen/blink.cmp" },       -- Completion engine
  { src = "https://github.com/zbirenbaum/copilot.lua" }, -- GitHub Copilot integration
  { src = "https://github.com/folke/sidekick.nvim" },    -- AI assistant (Claude)

  -- Code formatting
  { src = "https://github.com/stevearc/conform.nvim" }, -- Format-on-save with multiple formatters

  -- Debugging
  { src = "https://github.com/mfussenegger/nvim-dap" }, -- Debug Adapter Protocol client
  { src = "https://github.com/rcarriga/nvim-dap-ui" },  -- UI for nvim-dap
  { src = "https://github.com/nvim-neotest/nvim-nio" }, -- Async I/O library (dependency)
})

-- ============================================================================
-- THEME
-- ============================================================================

-- Apply the carbonfox color scheme
vim.cmd.colorscheme("carbonfox")

-- ============================================================================
-- PLUGIN CONFIGURATION
-- ============================================================================

-- Telescope: Fuzzy finder for files, text, buffers, etc.
require("telescope").setup({
  defaults = {
    -- Disable preview by default for faster performance
    preview = false,
  },
  pickers = {
    -- Color scheme selector with preview enabled
    colorscheme = {
      enable_preview = true,
      theme = "ivy",
      layout_config = {
        height = 10,
      },
    },
    -- Live text search across project
    live_grep = {
      theme = "ivy",
      preview = true,
      hidden = true, -- Include hidden files in search
      layout_strategy = "vertical",
      layout_config = {
        width = { padding = 0 },
        height = 120,
      },
    },
    -- File finder
    find_files = {
      theme = "ivy",
      hidden = true, -- Include hidden files
      layout_config = {
        height = 15,
      },
    },
    -- Open buffer list
    buffers = {
      theme = "ivy",
      layout_config = {
        height = 10,
      },
    },
  },
})

-- NvimTree: File explorer
require("nvim-tree").setup({
  -- Sync tree root with current working directory
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    -- Auto-update tree root when changing files
    update_root = true,
  },
  filters = {
    -- Show git ignored files
    git_ignored = false,
    -- Show dotfiles
    dotfiles = false,
  },
  view = {
    width = 50,
  },
})

-- NvimRooter: Auto-change working directory to project root
require("nvim-rooter").setup()

-- Bufferline: Tab-like buffer list at top of window
require("bufferline").setup()

-- Lualine: Status line at bottom of window
require("lualine").setup({})

-- Fidget: LSP progress notifications
require("fidget").setup({
  notification = {
    window = {
      align = "top",
      border = "rounded",
    },
  },
})

require("tiny-inline-diagnostic").setup({
  preset = "minimal",
  options = {
    virt_texts = {
      priority = 10480
    }
  }
})
vim.diagnostic.config({ virtual_text = false })

-- ============================================================================
-- COPILOT & AI ASSISTANTS
-- ============================================================================

-- GitHub Copilot: AI code suggestions
require("copilot").setup({
  suggestion = {
    enabled = true,
    -- Automatically show suggestions while typing
    auto_trigger = true,
    -- Don't auto-accept suggestions (manual with Ctrl-\)
    accept = false,
  },
  panel = {
    -- Disable Copilot panel UI
    enabled = false,
  },
  -- Enable Copilot for all file types
  filetypes = {
    markdown = true,
    help = true,
    html = true,
    javascript = true,
    typescript = true,
    ["*"] = true,
  },
})

-- Sidekick: Claude AI assistant integration
require("sidekick").setup({
  -- Disable NES emulator feature
  nes = { enabled = false },
  cli = {
    -- Disable terminal multiplexer
    mux = { enabled = false }
  }
})

-- ============================================================================
-- LSP (LANGUAGE SERVER PROTOCOL)
-- ============================================================================

-- Configure Lua language server with nvim runtime path awareness
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        -- Make language server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

-- Mason: Install and manage language servers
require("mason").setup()

-- Mason-LSPConfig: Bridge between Mason and LSP
require("mason-lspconfig").setup({
  -- Automatically install these language servers
  ensure_installed = { "lua_ls", "pyright", "ts_ls" },
  -- Automatically enable LSP servers after installation
  automatic_enable = true,
})

-- ============================================================================
-- AUTO-COMPLETION
-- ============================================================================

-- Blink.cmp: Completion engine
require("blink.cmp").setup({
  completion = {
    accept = {
      -- Don't auto-insert brackets after accepting completion
      auto_brackets = { enabled = false }
    },
  },
  keymap = {
    preset = "default",
    -- Navigate completion menu with Tab/Shift-Tab
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    -- Accept completion with Enter
    ["<CR>"] = { "accept", "fallback" },
  },
  -- Use pure Lua fuzzy matching (faster)
  fuzzy = { implementation = "lua" },
})

-- ============================================================================
-- CODE FORMATTING
-- ============================================================================

-- Conform: Format code on save
require("conform").setup({
  -- Define formatters for each file type
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  },
  -- Automatically format on save
  format_on_save = {
    timeout_ms = 500,
    -- Use LSP formatter if conform formatter not available
    lsp_format = "fallback",
  },
})

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Show Telescope buffer list, sorted by most recently used
local list_buffers = function()
  require("telescope.builtin").buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  })
end

-- Reload Neovim configuration without restarting
local reload_configuration = function()
  local vim_rc = os.getenv("MYVIMRC")
  print("Reloading configuration from: " .. vim_rc)
  vim.cmd.luafile(vim_rc)
end

local sidekick_toggle = function()
  require("sidekick.cli").toggle({ filter = { installed = true } })
end

local sidekick_send = function()
  require("sidekick.cli").send({ msg = "{this}", filter = { installed = true } })
end

-- ============================================================================
-- NOTIFICATIONS
-- ============================================================================

-- Use Fidget for all vim notifications
vim.notify = require("fidget.notification").notify

-- ============================================================================
-- KEY MAPPINGS
-- ============================================================================

-- General editor shortcuts
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Unhighlight search word" })

-- Window navigation (Ctrl + hjkl)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- File and buffer navigation
vim.keymap.set("n", "<C-a>", vim.cmd.NvimTreeFindFileToggle, { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "Cmd+P" })
vim.keymap.set("n", ";;", list_buffers, { desc = "List buffers" })

-- Plugin management
vim.keymap.set("n", "<F5>", vim.pack.update, { desc = "Update plugins" })

-- AI assistants
vim.keymap.set("i", "<C-\\>", require("copilot.suggestion").accept, { desc = "Accept Copilot suggestion" })
vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", sidekick_toggle, { desc = "Sidekick toggle" })
vim.keymap.set({ "n", "t", "i", "x" }, "<c-/>", sidekick_send, { desc = "Sidekick send" })

-- Leader key shortcuts (Space + ...)
vim.keymap.set("n", "<leader>rg", require("telescope.builtin").live_grep, { desc = "[R]ip[G]rep" })
vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit, { desc = "[G]it [D]iff" })
vim.keymap.set("n", "<leader>rc", reload_configuration, { desc = "Reload configuration" })

-- ============================================================================
-- DEBUGGING (DAP - Debug Adapter Protocol)
-- ============================================================================

-- DAP UI: Visual debugger interface
require("dapui").setup()

local dap = require("dap")

-- Debug key mappings
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>?", function()
  -- Evaluate expression under cursor in debug mode
  require("dapui").eval(nil, { enter = true })
end)

-- Debug control (F1-F4)
vim.keymap.set("n", "<F1>", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Step Out" })

-- dap.adapters.python = {
--   type = 'executable',
--   command = 'python', -- or 'python3' / full path if needed
--   args = { '-m', 'debugpy.adapter' },
-- }
--
-- dap.configurations.python = {
--   {
--     type = 'python',
--     request = 'attach',
--     name = 'attach debugpy',
--     connect = {
--       host = '127.0.0.1', -- or the remote IP (e.g., '192.168.1.50')
--       port = 5678,
--     },
--     justMyCode = false, -- optional: include library code
--     pathMappings = {
--       {
--         localRoot = vim.fn.getcwd(),  -- your local project root
--         remoteRoot = vim.fn.getcwd(), -- path on the remote machine
--       },
--     },
--   },
-- }

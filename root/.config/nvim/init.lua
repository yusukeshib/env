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

  --
  -- Editor behavior
  --

  -- Auto-detect indentation (tabs/spaces)
  { src = "https://github.com/tpope/vim-sleuth" },
  -- Advanced search/replace with case variants
  { src = "https://github.com/tpope/vim-abolish" },
  -- Auto-change working directory to project root
  { src = "https://github.com/notjedi/nvim-rooter.lua" },

  --
  -- Theme and UI
  --

  -- GitHub-themed color schemes
  { src = "https://github.com/scottmckendry/cyberdream.nvim" },
  -- Tab/buffer line at the top
  { src = "https://github.com/akinsho/bufferline.nvim" },
  -- Status line at the bottom
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  -- Show available key bindings in popup
  { src = "https://github.com/folke/which-key.nvim" },

  --
  -- Syntax and language support
  --

  -- Modern syntax highlighting
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  --
  -- Git integration
  --

  -- Git commands within vim
  { src = "https://github.com/tpope/vim-fugitive" },
  -- Enhanced diff viewer
  { src = "https://github.com/sindrets/diffview.nvim" },
  -- Show git blame as virtual text
  { src = "https://github.com/f-person/git-blame.nvim" },
  -- Git diff signs in gutter
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  --
  -- File navigation and search
  --

  -- Lua utility library (dependency)
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  -- Fuzzy finder (files, text, buffers)
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  -- File explorer tree view
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },

  --
  -- LSP (Language Server Protocol)
  --

  -- LSP configuration presets
  { src = "https://github.com/neovim/nvim-lspconfig" },
  -- Language server installer
  { src = "https://github.com/mason-org/mason.nvim" },
  -- Bridge mason & lspconfig
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  -- Inline LSP diagnostics
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  -- Format-on-save with multiple formatters
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },

  --
  -- Code completion and AI
  --

  -- Completion engine
  { src = "https://github.com/Saghen/blink.cmp" },
  -- GitHub Copilot integration
  { src = "https://github.com/zbirenbaum/copilot.lua" },
  -- ClaudeCode integration
  { src = "https://github.com/folke/sidekick.nvim" },
})

-- ============================================================================
-- THEME
-- ============================================================================

-- Apply the carbonfox color scheme
vim.cmd("colorscheme cyberdream")

-- ============================================================================
-- PLUGIN CONFIGURATION
-- ============================================================================

-- Telescope: Fuzzy finder for files, text, buffers, etc.
require("telescope").setup({})

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
require("nvim-rooter").setup({})

-- Bufferline: Tab-like buffer list at top of window
require("bufferline").setup({})

-- Lualine: Status line at bottom of window
require("lualine").setup({})

require("fidget").setup({})

require('sidekick').setup({
  cli = {
    mux = {
      enabled = false,
    }
  }
})

require("tiny-inline-diagnostic").setup({
  preset = "minimal",
  options = {
    virt_texts = {
      priority = 10240,
    },
  },
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
  nes = {
    enabled = false
  },
  panel = {
    enabled = false,
  },
  filetypes = {
    ["*"] = true,
  },
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
require("mason").setup({})

-- Mason-LSPConfig: Bridge between Mason and LSP
require("mason-lspconfig").setup({
  -- Automatically install these language servers
  ensure_installed = { "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
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
      auto_brackets = { enabled = false },
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

-- Reload Neovim configuration without restarting
local reload_configuration = function()
  local vim_rc = os.getenv("MYVIMRC")
  print("Reloading configuration from: " .. vim_rc)
  vim.cmd.luafile(vim_rc)
end


local sidekick_send = function()
  require("sidekick.cli").send({ msg = "{this}", })
end

local sidekick_toggle = function()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end

local themes = require('telescope.themes')

local telescope_files = function()
  require("telescope.builtin").find_files(themes.get_ivy({
    preview = false,
    hidden = true,
    layout_config = {
      width = { padding = 0 },
      height = 10,
    },
  }))
end

local telescope_buffers = function()
  require("telescope.builtin").buffers(themes.get_ivy({
    preview = false,
    hidden = true,
    layout_config = {
      width = { padding = 0 },
      height = 10,
    },
    sort_lastused = true,
    ignore_current_buffer = true,
  }))
end

local telescope_rg = function()
  require("telescope.builtin").live_grep(themes.get_ivy({
    preview = false,
    hidden = true,
    layout_config = {
      width = { padding = 0 },
      height = 10,
    },
  }))
end

local telescope_lsp_refs = function()
  require('telescope.builtin').lsp_references(themes.get_ivy({
    preview = true,
    hidden = true,
    layout_strategy = "vertical",
    layout_config = {
      height = vim.o.lines,  -- maximally available lines
      width = vim.o.columns, -- maximally available columns
      prompt_position = "bottom",
      preview_height = 0.8
    },
  }))
end

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
vim.keymap.set("n", "<C-p>", telescope_files, { desc = "Cmd+P" })
vim.keymap.set("n", ";;", telescope_buffers, { desc = "List buffers" })

-- Plugin management
vim.keymap.set("n", "<F5>", vim.pack.update, { desc = "Update plugins" })

-- AI assistants
vim.keymap.set("i", "<C-\\>", require("copilot.suggestion").accept, { desc = "Accept Copilot suggestion" })

-- Leader key shortcuts (Space + ...)
vim.keymap.set("n", "<leader>rg", telescope_rg, { desc = "[R]ip[G]rep" })
vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit, { desc = "[G]it [D]iff" })
vim.keymap.set("n", "<leader>rc", reload_configuration, { desc = "Reload configuration" })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "List references" })
vim.keymap.set("n", "gr", telescope_lsp_refs, { noremap = true, silent = true, desc = "List references" })

-- sidekick
vim.keymap.set({ "i", "n", "t", "x" }, "<C-.>", sidekick_toggle, { desc = "Toggle Sidekick" })
vim.keymap.set({ "i", "n", "t", "x" }, "<C-/>", sidekick_send, { desc = "Send to Sidekick" })

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
require("fidget").setup()
require('mini.statusline').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
	ensure_installed = {
		"lua_ls",
	}
})

--
-- LSP
--

vim.lsp.enable('lua_ls')


--   {
--     "saghen/blink.cmp",
--     optional = true,
--     dependencies = {
--       "rafamadriz/friendly-snippets",
--       "giuxtaposition/blink-cmp-copilot",
--     },
--     -- use a release tag to download pre-built binaries
--     version = "*",
--     -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--     -- build = 'cargo build --release',
--     -- If you use nix, you can build from source using latest nightly rust with:
--     -- build = 'nix run .#build-plugin',
-- 
--     ---@module 'blink.cmp'
--     ---@type blink.cmp.Config
--     opts = {
--       enabled = function()
--         return vim.b.completion ~= false
--       end,
-- 
--       completion = {
--         keyword = { range = "full" },
--         -- Show documentation when selecting a completion item
--         documentation = {
--           auto_show = true,
--           auto_show_delay_ms = 100,
--         },
--         -- Display a preview of the selected item on the current line
--         ghost_text = {
--           enabled = true,
--           show_without_selection = true,
--         },
--       },
-- 
--       signature = { enabled = true },
-- 
--       -- See the full "keymap" documentation for information on defining your own keymap.
--       keymap = {
--         -- set to 'none' to disable the 'default' preset
--         preset = "default",
-- 
--         ["<Up>"] = { "select_prev", "fallback" },
--         ["<Down>"] = { "select_next", "fallback" },
--         ["<S-Tab>"] = { "select_prev", "fallback" },
--         ["<Tab>"] = { "select_next", "fallback" },
--         ["<Enter>"] = { "select_and_accept", "fallback" },
--         ["C-space"] = { "show", "show_documentation", "hide_documentation" },
--       },
-- 
--       appearance = {
--         -- Sets the fallback highlight groups to nvim-cmp's highlight groups
--         -- Useful for when your theme doesn't support blink.cmp
--         -- Will be removed in a future release
--         use_nvim_cmp_as_default = true,
--         -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--         -- Adjusts spacing to ensure icons are aligned
--         nerd_font_variant = "mono",
--       },
-- 
--       -- Default list of enabled providers defined so that you can extend it
--       -- elsewhere in your config, without redefining it, due to `opts_extend`
--       sources = {
--         default = { "lsp", "path", "snippets", "buffer" },
--         providers = {
--           copilot = {
--             name = "copilot",
--             module = "blink-cmp-copilot",
--             score_offset = 100,
--             async = true,
--           },
--         },
--       },
-- 
--       -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
--       -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
--       -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
--       --
--       -- See the fuzzy documentation for more information
--       fuzzy = { implementation = "prefer_rust_with_warning" },
--     },
--     opts_extend = { "sources.default" },
--   },
-- 
-- 
-- })


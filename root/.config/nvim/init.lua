vim.g.mapleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
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
vim.opt.scrolloff = 3
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true

-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }


--
-- Plugins
--

vim.pack.add({
  -- Respect editorconfig
  { src = "https://github.com/tpope/vim-sleuth" },
  -- Theme
  { src = "https://github.com/EdenEast/nightfox.nvim" },
  -- Syntax highlighting
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
  -- Lsp status
  { src = "https://github.com/j-hui/fidget.nvim" },
  -- Subvert
  { src = "https://github.com/tpope/vim-abolish" },
  -- POSIX regexp
  { src = "https://github.com/othree/eregex.vim" },
  --  Git
  { src = "https://github.com/tpope/vim-fugitive" },
  -- Diff
  { src = "https://github.com/sindrets/diffview.nvim" },
  -- Blame ghost
  { src = "https://github.com/f-person/git-blame.nvim" },
  -- Respect workspace root
  { src = "https://github.com/notjedi/nvim-rooter.lua" },
  -- Git sign column
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  -- Tab UI
  { src = "https://github.com/akinsho/bufferline.nvim" },
  -- UI lib
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  -- Telescope
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  -- Explorer
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  -- Status line UI
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  -- Provide default config for lsp.vim.config(...)
  { src = "https://github.com/neovim/nvim-lspconfig" },
  -- Install lua-language-server, pyright-langserver automatically
  { src = "https://github.com/mason-org/mason.nvim" },
  -- Automatically install using mason
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  -- Copilot ghost
  { src = "https://github.com/zbirenbaum/copilot.lua" },
  -- Autocomplete
  { src = "https://github.com/Saghen/blink.cmp" },
})

--
-- Theme
--

vim.cmd.colorscheme("carbonfox")

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
require("lualine").setup({})
require("fidget").setup({
  notification = {
    poll_rate = 1,
    filter = vim.log.levels.TRACE,
  },
  integration = {
    ["nvim-tree"] = {
      enable = true,
    },
  },
})

--
-- Copilot
--

require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    accept = false,
  },
  panel = {
    enabled = false
  },
  filetypes = {
    markdown = true,
    help = true,
    html = true,
    javascript = true,
    typescript = true,
    ["*"] = true
  },
})

--
-- LSP
--

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls" },
  -- vim.lsp.enable
  automatic_enable = true,
})


--
-- Auto complete
--

require("blink.cmp").setup({
  completion = {
    accept = { auto_brackets = { enabled = false }, },
  },
  keymap = {
    preset = "default",
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
  },
  fuzzy = { implementation = "lua" }
})

--
-- Format on save
--

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local fmt_group = vim.api.nvim_create_augroup("autoformat_cmds", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      group = fmt_group,
      desc = "Format current buffer",
      callback = function(e)
        vim.lsp.buf.format({
          bufnr = e.buf,
          async = false,
          timeout_ms = 10000,
        })
      end
    })
  end
})

--
-- Keyboard shortcuts
--

local list_buffers = function()
  require("telescope.builtin").buffers({
    sort_lastused = true,
    ignore_current_buffer = true,
  })
end

local reload_configuration = function()
  local vim_rc = os.getenv('MYVIMRC')
  print("Reloading configuration from: " .. vim_rc)
  vim.cmd.luafile(vim_rc)
end

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Unhighlight search word" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-a>", vim.cmd.NvimTreeFindFileToggle, { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>rg", require("telescope.builtin").live_grep, { desc = "[R]ip[G]rep" })
vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit, { desc = "[G]it [D]iff" })
vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "Cmd+P" })
vim.keymap.set("n", ";;", list_buffers, { desc = "List buffers" })
-- vim.keymap.set("n", "<F5>", reload_configuration, { desc = "Reload configuration" })
vim.keymap.set("n", "<F5>", vim.pack.update, { desc = "Update plugins" })
vim.keymap.set("i", "<C-]>", require("copilot.suggestion").accept, { desc = "Accept Copilot suggestion" })

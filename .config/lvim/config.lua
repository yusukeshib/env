-- Plugins
lvim.plugins = {
  { "dracula/vim" },
  -- subvert
  { "tpope/vim-abolish" },
  -- regex
  { "othree/eregex.vim" },
  -- git diff
  { "tpope/vim-fugitive" },
  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {},
  }
}

lvim.colorscheme = "dracula"
lvim.format_on_save = true

-- Key configuration
lvim.keys.normal_mode["<C-a>"] = "<Cmd>NvimTreeToggle<CR>"
lvim.keys.normal_mode["<C-p>"] = "<Cmd>Telescope git_files<CR>"
lvim.keys.normal_mode[";;"] = "<Cmd>Telescope buffers<CR>"
lvim.keys.normal_mode['[d'] = '<Cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>'
lvim.keys.normal_mode[']d'] = '<Cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>'

-- Telescope style
lvim.builtin.telescope.theme = "ivy";
lvim.builtin.telescope.defaults.path_display = { truncate = 3 }

-- rust-analyzer
require('lspconfig').rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      formatOnSave = true,
      checkOnSave = {
        command = "clippy",
      },
      files = {
        excludeDirs = {
          "apps/content/node_modules",
        },
      },
      -- cargo = {
      --   target = "wasm32-unknown-unknown"
      -- }
    }
  }
})

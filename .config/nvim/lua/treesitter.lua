require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust" ,"javascript", "typescript", "lua" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}
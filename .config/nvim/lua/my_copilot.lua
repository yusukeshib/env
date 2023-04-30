require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  formatters = {
    label = require("copilot_cmp.format").format_label_text,
    insert_text = require("copilot_cmp.format").format_insert_text,
    preview = require("copilot_cmp.format").deindent,
  },
})
-- Compilot integration for auto-complete
require("copilot_cmp").setup()


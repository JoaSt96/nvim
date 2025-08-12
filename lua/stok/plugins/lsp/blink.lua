return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    -- Custom keymap configuration
    keymap = {
      -- Trigger completion with Ctrl+Space
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- Accept with Enter
      ['<CR>'] = { 'accept', 'fallback' },
      -- Navigation only - no acceptance with Tab
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      -- Scroll documentation
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    enabled = function()
      -- Disable in command mode and prompts
      local disabled = {
        'prompt',
        'nofile',
        'help',
      }
      local buftype = vim.bo.buftype
      if vim.tbl_contains(disabled, buftype) then
        return false
      end
      return true
    end,
  },
  opts_extend = { "sources.default" },
}

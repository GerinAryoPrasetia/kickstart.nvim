return {
  'iamcco/markdown-preview.nvim',
  ft = { 'markdown' },
  build = ':call mkdp#util#install()',
  config = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
}

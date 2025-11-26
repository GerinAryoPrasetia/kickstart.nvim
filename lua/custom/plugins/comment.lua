return {
  'numToStr/Comment.nvim',
  opts = {
    toggler = {
      -- Normal mode toggle
      line = '<C-_>', -- Ctrl + /
      block = '<C-\\>', -- optional for block comments
    },
    opleader = {
      -- Visual/Operator mode toggle
      line = '<C-_>',
      block = '<C-\\>',
    },
  },
}

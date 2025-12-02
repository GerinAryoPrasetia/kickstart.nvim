return {
  name = 'floating-terminal',

  dir = vim.fn.stdpath 'config' .. '/lua/custom/floating-terminal',

  event = 'VeryLazy',

  config = function()
    require('custom.floating-terminal').setup()
  end,
}

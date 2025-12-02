-- lua/custom/neotermish/init.lua
local M = {}

local term_buf = nil
local term_win = nil

-- Size ratio of terminal
local width_ratio = 0.80
local height_ratio = 0.80

----------------------------------------------------
-- Create floating window
----------------------------------------------------
local function open_float_window()
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * width_ratio)
  local height = math.floor(ui.height * height_ratio)

  local col = math.floor((ui.width - width) / 2)
  local row = math.floor((ui.height - height) / 2)

  term_win = vim.api.nvim_open_win(term_buf, true, {
    relative = 'editor',
    style = 'minimal',
    border = 'rounded',
    width = width,
    height = height,
    col = col,
    row = row,
  })

  vim.cmd 'startinsert'
end

----------------------------------------------------
-- Create terminal buffer + process
----------------------------------------------------
local function create_terminal()
  -- Create an unlisted, scratch buffer
  term_buf = vim.api.nvim_create_buf(false, true)

  -- Open the floating window *before* starting termopen()
  open_float_window()

  -- Run shell directly inside that floating window buffer
  vim.fn.termopen(vim.o.shell)
end

----------------------------------------------------
-- Toggle terminal (like neoterm)
----------------------------------------------------
function M.toggle()
  -- Close only the floating window
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  -- If buffer died, create again
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    create_terminal()
    return
  end

  -- Otherwise reopen existing terminal session
  open_float_window()
end

----------------------------------------------------
-- Auto-setup keymaps
----------------------------------------------------
function M.setup()
  vim.keymap.set('n', '<leader>tt', M.toggle, {
    desc = 'Toggle floating terminal',
  })
end

return M
--

-- lua/custom/keymaps.lua

-- ==============================
-- Native comment toggle (C-/)
-- ==============================

local function toggle_comment_line()
  local cs = vim.bo.commentstring
  if cs == "" then return end

  local prefix = cs:match("^(.*)%%s")
  if not prefix then return end

  local line = vim.api.nvim_get_current_line()

  if line:find(prefix, 1, true) then
    line = line:gsub("^%s*" .. vim.pesc(prefix) .. "%s?", "")
  else
    line = prefix .. " " .. line
  end

  vim.api.nvim_set_current_line(line)
end

local function toggle_comment_visual()
  local cs = vim.bo.commentstring
  if cs == "" then return end

  local prefix = cs:match("^(.*)%%s")
  if not prefix then return end

  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  for i = start_line, end_line do
    local line = vim.fn.getline(i)

    if line:find(prefix, 1, true) then
      line = line:gsub("^%s*" .. vim.pesc(prefix) .. "%s?", "")
    else
      line = prefix .. " " .. line
    end

    vim.fn.setline(i, line)
  end
end

-- Ctrl + / (actually <C-_>)
vim.keymap.set("n", "<C-_>", toggle_comment_line, { desc = "Toggle comment line" })
vim.keymap.set("v", "<C-_>", toggle_comment_visual, { desc = "Toggle comment selection" })

-- fallback (some terminals)
vim.keymap.set("n", "<C-/>", toggle_comment_line)
vim.keymap.set("v", "<C-/>", toggle_comment_visual)

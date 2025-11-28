return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    --------------------------------------------------------------------
    -- Telescope integration
    --------------------------------------------------------------------
    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end

        return require('telescope.finders').new_table {
          results = paths,
        }
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = finder(),
          previewer = false,
          sorter = require('telescope.config').values.generic_sorter {},
          layout_config = {
            height = 0.4,
            width = 0.5,
            prompt_position = 'top',
            preview_cutoff = 120,
          },
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<C-d>', function()
              local state = require 'telescope.actions.state'
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_bufnr)

              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(finder())
            end)
            return true
          end,
        })
        :find()
    end
    --------------------------------------------------------------------
    -- Keymaps (Basic Setup + Telescope override for <C-e>)
    --------------------------------------------------------------------

    -- Add file
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
      vim.cmd 'echo "file added to harpoon"'
    end, { desc = 'Harpoon: Add file' })

    -- Use Telescope instead of quick_menu
    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon: Telescope menu' })

    -- Jump to slots
    -- vim.keymap.set('n', '<C-h>', function()
    --   harpoon:list():select(1)
    -- end)
    -- vim.keymap.set('n', '<C-t>', function()
    --   harpoon:list():select(2)
    -- end)
    -- vim.keymap.set('n', '<C-n>', function()
    --   harpoon:list():select(3)
    -- end)
    -- vim.keymap.set('n', '<C-s>', function()
    --   harpoon:list():select(4)
    -- end)

    -- Previous / next items
    vim.keymap.set('n', '<M-p>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<M-n>', function()
      harpoon:list():next()
    end)
  end,
}

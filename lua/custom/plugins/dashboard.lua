return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require('dashboard').setup {
      theme = 'doom',

      config = {
        -- Center everything vertically
        vertical_center = true,

        header = {
          "           __..--''``---....___   _..._    __",
          " /// //_.-'    .-/\";  `        ``<._  ``.'_ `. / // /",
          "///_.-' _..--.'_    \\                    `( ) ) // //",
          "/ (_..-' // (< _     ;_..__               ; `' / ///",
          " / // // //  `-._,_)' // / ``--...____..-' /// / //",
          ' ',
        },

        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'New File',
            desc_hl = 'String',
            key = 'n',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'enew',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Open File Explorer',
            desc_hl = 'String',
            key = 'e',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Oil', -- or Yazi / NvimTreeToggle
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope find_files',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Update Plugins',
            desc_hl = 'String',
            key = 'u',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Lazy update',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Quit',
            desc_hl = 'String',
            key = 'q',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'qa',
          },
        },

        footer = {
          'Have a Nice Day!',
        },
      },
    }
  end,
}

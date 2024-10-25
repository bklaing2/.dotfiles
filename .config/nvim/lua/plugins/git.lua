return {

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- git blame
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = true,
      message_template = ' <summary> • <date> • <author> • <<sha>>',
      date_format = '%m-%d-%Y %H:%M:%S',
      virtual_text_column = 1,
    },
    keys = {
      {
        '<leader>gbu',
        '<cmd>GitBlameToggle<cr>',
        desc = 'toggle git blame',
      },
      {
        '<leader>gbe',
        '<cmd>GitBlameEnable<cr>',
        desc = 'enable git blame',
      },
      {
        '<leader>gbd',
        '<cmd>GitBlameDisable<cr>',
        desc = 'disable git blame',
      },
      {
        '<leader>gbh',
        '<cmd>GitBlameCopySHA<cr>',
        desc = 'copy line commit SHA',
      },
      {
        '<leader>gbl',
        '<cmd>GitBlameCopyCommitURL<cr>',
        desc = 'copy line commit URL',
      },
      {
        '<leader>gbo',
        '<cmd>GitBlameOpenFileURL<cr>',
        desc = 'opens file in default browser',
      },
      {
        '<leader>gbc',
        '<cmd>GitBlameCopyFileURL<cr>',
        desc = 'copy file url to clipboard',
      },
    },
    {
      'folke/which-key.nvim',
      -- default show git blame when open git files
      opts = {
        defaults = {
          ['<leader>gb'] = { name = 'git blame+' },
        },
      },
    },
  },
}

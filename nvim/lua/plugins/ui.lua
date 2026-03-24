return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function() vim.cmd.colorscheme 'tokyonight-night' end
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup{
        options = {
          mode = "buffers",
          separator_style = "thin",
          indicator = { style = 'icon', icon = '▎' },
          show_buffer_close_icons = false,
          show_close_icon = false,
        }
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
      })
    end,
  },
  { 'folke/lsp-colors.nvim', event = "BufRead" },
}

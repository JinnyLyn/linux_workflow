return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'whoissethdaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
      {
        "folke/lazydev.nvim",
        ft = "lua", 
        opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
      },
    },
    config = function()
      require('mason').setup()

      require('mason-tool-installer').setup({
        ensure_installed = { 'black', 'isort', 'stylua', 'clangd', 'pyright', 'rust_analyzer', 'gopls', 'lua_ls' },
      })

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.offsetEncoding = { "utf-16" }
            local opts = { capabilities = capabilities }
            if server_name == "lua_ls" then opts.settings = { Lua = { diagnostics = { globals = { 'vim' } } } } end
            require('lspconfig')[server_name].setup(opts)
          end,
        }
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('gl', vim.diagnostic.open_float, 'Show Line Diagnostics') 
          map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        end,
      })
    end
  },
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>lf',
        function() require('conform').format { async = true, lsp_fallback = true } end,
        mode = '',
        desc = '[L]SP [F]ormat',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = { lua = { 'stylua' }, python = { 'isort', 'black' } },
    },
  },
}

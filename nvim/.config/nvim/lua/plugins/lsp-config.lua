return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  -- cmd = { 'LspInfo', 'Mason' },
  dependencies = {
    -- Mason for managing external tools
    { 'williamboman/mason.nvim', opts = {} },
    { 'williamboman/mason-lspconfig.nvim', opts = { automatic_enable = false } },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Completion capabilities
    'saghen/blink.cmp',
  },
  config = function()
    -- Diagnostic Configuration
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      -- Disable virtual text because tiny-inline-diagnostic will show them instead
      virtual_text = false,
      -- virtual_text = { source = 'if_many',
      --   spacing = 2,
      --   format = function(diagnostic)
      --     return diagnostic.message
      --   end,
      -- },
    }

    -- Define LSP server configurations
    vim.lsp.config['clangd'] = {
      cmd = { 'clangd', '--header-insertion=never' },
    }

    vim.lsp.config['rust_analyzer'] = {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = true,
          check = {
            command = 'clippy',
          },
        },
      },
    }

    vim.lsp.config['lua_ls'] = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    }

    vim.lsp.config['cssls'] = {
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = 'ignore',
          },
        },
      },
    }

    -- Enable the configured servers
    vim.lsp.enable {
      'clangd',
      'rust_analyzer',
      'lua_ls',
      'emmet_language_server',
      'ts_ls',
      'cssls',
      'html',
      'yamlls',
      'prismals',
      'dockerls',
    }

    -- Ensure tools are installed via mason-tool-installer
    local ensure_installed = {
      -- LSPs
      'rust-analyzer',
      'clangd',
      'css-lsp',
      'dockerfile-language-server',
      'emmet-language-server',
      'html-lsp',
      'lua-language-server',
      'prisma-language-server',
      'typescript-language-server',
      'yaml-language-server',
      -- formatters
      'beautysh',
      'clang-format',
      'prettier',
      'stylua',
      'tex-fmt',
      -- DAPs
      'codelldb',
    }
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Key mappings for LSP functions
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grr', require('snacks').picker.lsp_references, '[G]oto [R]eferences')
        map('gri', require('snacks').picker.lsp_implementations, '[G]oto [I]mplementation')
        map('grd', require('snacks').picker.lsp_definitions, '[G]oto [D]efinition')
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gO', require('snacks').picker.lsp_symbols, 'Open Document Symbols')
        map('gW', require('snacks').picker.lsp_workspace_symbols, 'Open Workspace Symbols')
        map('grt', require('snacks').picker.lsp_type_definitions, '[G]oto [T]ype Definition')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
      end,
    })
  end,
}

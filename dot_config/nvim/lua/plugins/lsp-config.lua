return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
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
        map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
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
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    vim.diagnostic.config {
      severity_sort = true,
      float = {
        title = 'Diagnostic',
        header = '',
        border = 'single',
        source = 'if_many',
        scope = 'line',
      },

      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},

      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    local lsp = {
      clangd = {
        languages = { 'c', 'cpp' },
        config = {
          cmd = { 'clangd', '--header-insertion=never' },
        },
      },

      lua_ls = {
        languages = { 'lua' },
        config = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      },

      rust_analyzer = {
        languages = { 'rust' },
        config = {
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = true,
              check = { command = 'clippy' },
            },
          },
        },
      },

      ts_ls = {
        languages = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
      },

      pyright = {
        languages = { 'python' },
      },

      gopls = {
        languages = { 'go' },
      },

      cssls = {
        languages = { 'css' },
        config = {
          settings = {
            css = { validate = true, lint = { unknownAtRules = 'ignore' } },
          },
        },
      },

      zls = {
        languages = { 'zig' },
      },
    }

    local augroup = vim.api.nvim_create_augroup('lsp', { clear = true })

    for server, entry in pairs(lsp) do
      -- register configs if present
      if entry.config then
        vim.lsp.config(server, entry.config)
      end

      -- autocmds for each language
      for _, ft in ipairs(entry.languages) do
        vim.api.nvim_create_autocmd('FileType', {
          group = augroup,
          pattern = ft,
          callback = function()
            vim.schedule(function() vim.lsp.enable { server } end)
          end,
        })
      end
    end
  end,
}

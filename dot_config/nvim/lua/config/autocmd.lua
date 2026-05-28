-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Notify about LspProgress
vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), 'info', {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif) notif.icon = ev.data.params.value.kind == 'end' and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1] end,
    })
  end,
})

-- Two space indent in specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'typescript',
    'html',
    'javascriptreact',
    'typescriptreact',
    'css',
    'lua',
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').lox = {
      install_info = {
        url = 'https://github.com/kaezrr/tree-sitter-lox',
        queries = 'queries',
      },
    }
  end,
})

vim.filetype.add {
  extension = {
    lox = 'lox',
    wgsl = 'wgsl',
  },
}

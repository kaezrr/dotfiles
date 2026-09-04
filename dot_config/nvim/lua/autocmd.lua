-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then vim.cmd 'normal! g`"zz' end
  end,
})

-- Start files picker when neovim is opened on an empty buffer with no args
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('FzfLuaOnStart', { clear = true }),
  nested = true,
  callback = function()
    if vim.fn.argc() ~= 0 then return end

    if vim.v.startreason == 'restart' then return end

    local buf = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_name(buf) ~= '' then return end
    if vim.bo[buf].buftype ~= '' then return end
    if vim.api.nvim_buf_line_count(buf) > 1 or vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= '' then
      return -- e.g. piped stdin content
    end

    FzfLua.files()
  end,
})

local json = require('json')
local vim = require('vim')

-- Get current cursor position
local line, col = unpack(vim.api.nvim_win_get_cursor(0))
local text = vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]

-- Parse JSON and pretty-print it
local parsed = json.parse(text)
local formatted = json.encode(parsed, {indent = 4})

-- Replace the original text with pretty-printed version
vim.api.nvim_buf_set_lines(0, line-1, line, false, {formatted})


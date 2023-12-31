require("zani.set")
require("zani.remap")
require("zani.plugins")

if (vim.fn.has("termguicolors")) then
 vim.g.termguicolors = true
end

local augroup = vim.api.nvim_create_augroup
local zani_group = augroup('zani', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = zani_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

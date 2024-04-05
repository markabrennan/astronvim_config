if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
vim.api.nvim_create_autocmd("FileType", {
pattern = "python",
callback = function()
  vim.keymap.set("n", "<F3>", ":call flake8#Flake8()<CR>", { buffer = true, noremap = true, silent = true })
end,
})    --
vim.g.netrw_list_hide = ''
vim.api.nvim_set_hl(0, "Visual", { bg = "DarkGrey", fg = "white" })
vim.opt.mouse = ""

-- require("copilot_cmp").setup()
require("oil").setup()
require('lualine').setup({
  options = { theme = 'modus-vivendi' }
})

require('telescope').setup({
defaults = {
  vimgrep_arguments = {
    'rg',
    '--color=never',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case',
    '--hidden',
    '-L',
  },
},
})


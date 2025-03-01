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

  -- ChatGPT helped me replace this:
  -- callback = function()
  --   vim.keymap.set("n", "<F3>", ":call flake8#Flake8()<CR>", { buffer = true, noremap = true, silent = true })
  -- end,

  -- with this:

  callback = function()
    vim.keymap.set("n", "<F3>", function()
      vim.api.nvim_command "call flake8#Flake8()"
      -- Delay briefly to ensure Flake8 window has time to open
      vim.defer_fn(function()
        -- Get the number of windows
        local windows = vim.api.nvim_tabpage_list_wins(0)
        if #windows > 1 then -- If more than one window, assume Flake8 window is open
          vim.cmd "wincmd j" -- Jump to the Flake8 window
          local buf_lines = vim.api.nvim_buf_line_count(0) -- Get line count of current buffer
          if buf_lines > 1 then -- If there are lines in the buffer (errors exist)
            vim.cmd "resize 20" -- Resize to appropriate size
          else -- If no errors, close the window
            vim.cmd "q"
          end
        end
      end, 50) -- Delay in milliseconds
    end, { buffer = true, noremap = true, silent = true })
  end,
}) --

vim.api.nvim_create_user_command("RuffDiff", function()
  local file = vim.fn.expand "%:p" -- Expand to full file path
  vim.cmd("vsplit | terminal ruff format --diff " .. vim.fn.shellescape(file))
end, { desc = "Preview Ruff Fixes in Diff Mode" })

vim.g.netrw_list_hide = ""
vim.api.nvim_set_hl(0, "Visual", { bg = "DarkGrey", fg = "white" })
vim.opt.mouse = ""

-- require("copilot_cmp").setup()
require("oil").setup()
require("lualine").setup {
  options = { theme = "modus-vivendi" },
}

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "-L",
    },
  },
}

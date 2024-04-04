return function()
  local highlights = {
    -- Add your highlight customizations here
    Visual = { bg = "white", fg = "DarkGrey" },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end


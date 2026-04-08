-- lua/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"

    config.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
    }

    return config
  end,
}

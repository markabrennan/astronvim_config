-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>o"] = { ":only<cr>" },
    ["<leader>l"] = { ":noh<cr>" },
    -- ["<leader>f"] = { "/<c-r><c-w><cr>" },
    vim.api.nvim_set_keymap('n', '<Leader>d', ':e %:p:h<CR>', { noremap = true, silent = true }),
    ["<leader>mt"] = { "<cmd>wincmd K<cr>", desc = "Move window to the top" },
    ["<leader>mb"] = { "<cmd>wincmd J<cr>", desc = "Move window to the bottom" },
    ["<leader>ml"] = { "<cmd>wincmd H<cr>", desc = "Move window to the left" },
    ["<leader>mr"] = { "<cmd>wincmd L<cr>", desc = "Move window to the right" },
    ["<leader>s"] = { "/<C-R><C-W><CR>", desc = "Search word under cursor" },
    vim.api.nvim_set_keymap('n', '-',': Oil<CR>', { noremap = true, silent = true }),



    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

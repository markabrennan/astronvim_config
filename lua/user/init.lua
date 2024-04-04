return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  plugins = {
    {
      "jlanzarotta/bufexplorer",
      keys = { "<leader>be" },
    },
    {
      "psf/black",
      cmd = "Black",
    },
    -- {
    --   "github/copilot.vim",
    --   cmd = "Copilot",
    -- },
    -- {
    --   "zbirenbaum/copilot-cmp",
    --   config = function()
    --       require("copilot_cmp").setup()
    --   end,
    -- },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          -- require("copilot").setup({})
          require('copilot').setup({
            panel = {
              enabled = true,
              auto_refresh = false,
              keymap = {
                jump_prev = "[[",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-CR>"
              },
              layout = {
                position = "bottom", -- | top | left | right
                ratio = 0.4
              },
            },
            suggestion = {
              enabled = true,
              auto_trigger = true,
              debounce = 75,
              keymap = {
                accept = "<C-l>",
                accept_word = false,
                accept_line = false,
                next = "<C-n>",
                prev = "<C-p>",
                dismiss = "<C-d>",
              },
            },
            filetypes = {
              yaml = false,
              markdown = false,
              help = false,
              gitcommit = false,
              gitrebase = false,
              hgcommit = false,
              svn = false,
              cvs = false,
              ["."] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 18.x
            server_opts_overrides = {},
          })
        end,
    },
    {
      "nvie/vim-flake8",
      ft = "python",
      config = function()
        -- Configuration options for vim-flake8, if any
      end,
    },
    {
      "tpope/vim-obsession",
      cmd = "Obsession",
        -- Configuration options for vim-flake8, if any
    },
    {
      "stevearc/oil.nvim",
      cmd = "Oil",
    },
    {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    -- Add more plugins here
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }    
      -- vim.g.neo_tree_remove_legacy_commands = 1
      -- require('neo-tree').setup({
      --   filesystem = {
      --     follow_current_file = true,
      --     hijack_netrw_behavior = "open_current",
      --     use_libuv_file_watcher = true,
      --     filtered_items = {
      --       visible = true,
      --       hide_dotfiles = false,
      --       hide_gitignored = true,
      --       hide_by_name = {
      --         ".DS_Store",
      --         "thumbs.db",
      --         "node_modules",
      --       },
      --       never_show = { ".git" },
      --     },
      --     -- commands = {
      --     --   show_hidden_items = function()
      --     --     require('neo-tree.sources.filesystem').show_hidden_items()
      --     --     vim.notify("Showing hidden items", "info", { title = "Neo-tree" })
      --     --   end,
      --     -- },
      --   },
      -- })


    --
    --
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

  end,
}

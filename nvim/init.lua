-- ~/.config/nvim/init.lua — Neovim configuration

-- =============================================================================
-- Bootstrap lazy.nvim (plugin manager)
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader must be set before lazy.setup so plugin keymaps resolve correctly.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Editor options
-- =============================================================================
vim.opt.number = true -- show absolute line numbers

-- =============================================================================
-- Plugins
-- =============================================================================
require("lazy").setup({
  -- Colorscheme. `priority = 1000` ensures it loads before any other plugin
  -- so highlights are applied from the first frame.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "macchiato", -- latte | frappe | macchiato | mocha
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- File/directory navigation (vinegar replacement).
  -- Press `-` to open the parent directory as a buffer. Edit filenames like
  -- text and `:w` to apply renames / creates / deletes. `-` again walks up.
  {
    "stevearc/oil.nvim",
    lazy = false, -- so `-` works on first launch and `nvim .` opens a dir
    opts = {
      view_options = { show_hidden = true },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },

  -- Fuzzy finder + ripgrep content search (fzf.vim replacement).
  -- Uses the `fzf` and `rg` binaries — both must be on $PATH.
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<C-p>",      function() require("fzf-lua").files() end,     desc = "Find files" },
      { "<leader>rg", function() require("fzf-lua").live_grep() end, desc = "Live grep (ripgrep)" },
      { "<leader>b",  function() require("fzf-lua").buffers() end,   desc = "Buffers" },
      { "<leader>h",  function() require("fzf-lua").oldfiles() end,  desc = "Recent files" },
    },
    opts = {},
  },
})

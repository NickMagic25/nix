# Neovim with LazyVim configuration
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Additional packages for LazyVim
  home.packages = with pkgs; [
    fd           # Better find alternative (used by telescope)
    lazygit      # Git TUI (integrates with LazyVim)
    tree-sitter  # Syntax highlighting
  ];

  # LazyVim configuration files
  home.file.".config/nvim/init.lua".text = ''
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    end
    vim.opt.rtp:prepend(lazypath)

    -- Setup lazy.nvim
    require("lazy").setup({
      spec = {
        -- Import LazyVim
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- Import any additional plugins here
        { import = "plugins" },
      },
      defaults = {
        lazy = false,
        version = false,
      },
      install = { colorscheme = { "tokyonight", "habamax" } },
      checker = { enabled = true },
      performance = {
        rtp = {
          disabled_plugins = {
            "gzip",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
    })

    vim.cmd.colorscheme("tokyonight")
  '';

  home.file.".config/nvim/lua/config/lazy.lua".text = ''
    -- LazyVim configuration
    return {
      -- Configure LazyVim to load the colorscheme
      colorscheme = "tokyonight",
    }
  '';

  home.file.".config/nvim/lua/config/options.lua".text = ''
    -- Options are automatically loaded before lazy.nvim startup
    -- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

    -- VS Code-like options
    vim.opt.number = true          -- Show line numbers
    vim.opt.relativenumber = true  -- Relative line numbers
    vim.opt.termguicolors = true   -- True color support
    vim.opt.splitbelow = true      -- Horizontal splits go below
    vim.opt.splitright = true      -- Vertical splits go right
  '';

  home.file.".config/nvim/lua/config/keymaps.lua".text = ''
    -- Keymaps are automatically loaded on the VeryLazy event
    -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

    -- VS Code-like keybindings
    -- Toggle file explorer (VS Code: Ctrl+B)
    vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

    -- Terminal navigation (Escape to exit terminal mode)
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

    -- Navigate between windows easily
    vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
    vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
  '';

  home.file.".config/nvim/lua/config/autocmds.lua".text = ''
    -- Autocmds are automatically loaded on the VeryLazy event
    -- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

    -- Auto-open neo-tree and terminal on startup (VS Code-like layout)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Only open if we're not opening a specific file or in a git commit
        if vim.fn.argc() == 0 and vim.bo.filetype ~= "gitcommit" then
          -- Small delay to ensure plugins are loaded
          vim.defer_fn(function()
            -- Open neo-tree
            vim.cmd("Neotree show left")

            -- Open terminal at the bottom using toggleterm
            vim.cmd("ToggleTerm direction=horizontal")

            -- Focus back to the main editor window
            vim.cmd("wincmd p")
          end, 100)
        end
      end,
    })
  '';

  # Custom plugin configurations for VS Code-like behavior
  home.file.".config/nvim/lua/plugins/neo-tree.lua".text = ''
    -- Neo-tree configuration for VS Code-like file explorer
    return {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        close_if_last_window = false,  -- Don't close if it's the last window
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
          position = "left",
          width = 30,
          mappings = {
            ["<space>"] = "none",  -- Disable space so it doesn't conflict with leader
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,  -- Find and focus the current file
          },
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      },
    }
  '';

  home.file.".config/nvim/lua/plugins/toggleterm.lua".text = ''
    -- Terminal configuration for VS Code-like integrated terminal
    return {
      "akinsho/toggleterm.nvim",
      opts = {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],  -- Ctrl+\ to toggle terminal (like VS Code Ctrl+`)
        hide_numbers = true,
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal",  -- Open at bottom like VS Code
        close_on_exit = true,
        shell = vim.o.shell,
      },
    }
  '';
}

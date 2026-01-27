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
    -- Add any additional options here
  '';

  home.file.".config/nvim/lua/config/keymaps.lua".text = ''
    -- Keymaps are automatically loaded on the VeryLazy event
    -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
    -- Add any additional keymaps here
  '';

  home.file.".config/nvim/lua/config/autocmds.lua".text = ''
    -- Autocmds are automatically loaded on the VeryLazy event
    -- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    -- Add any additional autocmds here
  '';

  home.file.".config/nvim/lua/plugins/.gitkeep".text = ''
    -- Add your custom plugins here
  '';
}

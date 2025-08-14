{ config, pkgs, lib, ... }:

{
  imports = [
    ./plugins.nix
    ./lsp.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Basic settings
    extraConfig = ''
      set number relativenumber
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set smartindent
      set wrap
      set ignorecase
      set smartcase
      set termguicolors
      set scrolloff=8
      set sidescrolloff=8
      set updatetime=50
      set clipboard=unnamedplus
      set signcolumn=yes
      set isfname+=@-@
      set cursorline
      set splitright
      set splitbelow
      set undofile
      set undodir=~/.vim/undodir
      set noswapfile
      set nobackup
      set incsearch
      set colorcolumn=100
      
      let mapleader = " "
      let maplocalleader = " "
    '';
    
    # Platform-agnostic packages
    extraPackages = with pkgs; [
      # Essential tools
      ripgrep
      fd
      fzf
      tree-sitter
      
      # Clipboard support
    ] ++ lib.optionals pkgs.stdenv.isDarwin [
      # macOS specific
      reattach-to-user-namespace
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux specific
      xclip
      wl-clipboard
    ];
    
    # Minimal Lua configuration  
    extraLuaConfig = ''
      -- Force true color support
      vim.opt.termguicolors = true
      
      -- Theme is loaded in plugins.nix
      
      -- Essential keymaps only
      
      -- Better escape
      vim.keymap.set("i", "jk", "<ESC>")
      
      -- Move between windows
      vim.keymap.set("n", "<C-h>", "<C-w>h")
      vim.keymap.set("n", "<C-j>", "<C-w>j")
      vim.keymap.set("n", "<C-k>", "<C-w>k")
      vim.keymap.set("n", "<C-l>", "<C-w>l")
      
      -- Quick save/quit
      vim.keymap.set("n", "<leader>w", ":w<CR>")
      vim.keymap.set("n", "<leader>q", ":q<CR>")
    '';
  };
}
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
      
      -- Navigation is handled by vim-tmux-navigator plugin
      -- The plugin automatically sets up Ctrl+hjkl for seamless navigation
      
      -- Window resize mode: Press <leader>r then use hjkl repeatedly
      -- Press Esc or any other key to exit resize mode
      -- Uses tmux-style directional resizing (h/l move vertical split, j/k move horizontal split)
      vim.keymap.set("n", "<leader>r", function()
        print("Resize mode: use hjkl to resize, Esc to exit")
        local key = vim.fn.getchar()
        while key ~= 27 do -- 27 is Esc
          if key == 104 then -- h (move vertical split left)
            if vim.fn.winnr() == vim.fn.winnr('l') then
              vim.cmd("vertical resize +3")
            else
              vim.cmd("vertical resize -3")
            end
          elseif key == 108 then -- l (move vertical split right)
            if vim.fn.winnr() == vim.fn.winnr('l') then
              vim.cmd("vertical resize -3")
            else
              vim.cmd("vertical resize +3")
            end
          elseif key == 106 then -- j (move horizontal split down)
            if vim.fn.winnr() == vim.fn.winnr('j') then
              vim.cmd("resize -3")
            else
              vim.cmd("resize +3")
            end
          elseif key == 107 then -- k (move horizontal split up)
            if vim.fn.winnr() == vim.fn.winnr('j') then
              vim.cmd("resize +3")
            else
              vim.cmd("resize -3")
            end
          else
            break
          end
          vim.cmd("redraw")
          key = vim.fn.getchar()
        end
        print("") -- Clear the message
      end, { desc = "Enter resize mode" })
      
      -- Quick save/quit
      vim.keymap.set("n", "<leader>w", ":w<CR>")
      vim.keymap.set("n", "<leader>q", ":q<CR>")
    '';
  };
}

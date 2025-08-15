{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Better terminal tools
    ripgrep       # Better grep
    fd            # Better find
    bat           # Better cat with syntax highlighting
    eza           # Better ls with icons
    zoxide        # Smarter cd
    fzf           # Fuzzy finder
    jq            # JSON processor
    yq            # YAML processor
    htop          # Better top
    btop          # Even better system monitor
    tldr          # Simplified man pages
    
    # Development tools
    nodejs_22     # Node.js (needed for claude and other tools)
    gh            # GitHub CLI
    lazygit       # Terminal UI for git
    httpie        # Better curl for APIs
    watchman      # File watching
    
    # Nix tools
    nix-tree      # Visualize nix dependencies
    nix-diff      # Compare nix derivations
    nixpkgs-fmt   # Format nix files
    
    # Container tools
    docker
    docker-compose
    
    # Network tools
    curl
    wget
    nmap
    
    # Archive tools
    unzip
    zip
  ];
  
  # Configure some of these tools
  programs = {
    # fzf configuration
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
      ];
    };
    
    # bat configuration
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        pager = "less -FR";
      };
    };
    
    # eza will be aliased in shell.nix to avoid conflicts
    
    # zoxide configuration
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"  # Replace cd command
      ];
    };
  };
}
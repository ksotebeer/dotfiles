{ config, pkgs, lib, ... }:

{
  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Migrate your existing aliases
    shellAliases = {
      # Your existing aliases
      c = "cd ..";
      vpnup = "sudo wg-quick up wg5";
      vpndown = "sudo wg-quick down wg5";
      claude = "/Users/keegansotebeer/.claude/local/claude";
      
      # Better ls with eza (no icons for now)
      ls = "eza";
      ll = "eza -l";  # Replaces old "ls -alF --color"
      la = "eza -la";
      lt = "eza --tree";
      
      # Git shortcuts (similar to oh-my-zsh git plugin)
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gp = "git push";
      gpull = "git pull";
      gl = "git log --oneline --graph";
      gd = "git diff";
      gb = "git branch";
      
      # Neovim
      v = "nvim";
      vim = "nvim";
    };
    
    # Keep your direnv plugin functionality
    initContent = ''
      # Better history (from oh-my-zsh)
      export HISTSIZE=10000
      export SAVEHIST=10000
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt SHARE_HISTORY
      
      # Better directory navigation (from oh-my-zsh)
      setopt AUTO_CD
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_MINUS
      
      # Load ssh passphrase from keychain (your existing config)
      ssh-add --apple-use-keychain 2>/dev/null
      
      # Set default editor to neovim
      export EDITOR='nvim'
      export VISUAL='nvim'
    '';
    
    # oh-my-zsh handled these, but we need them without it
    historySubstringSearch.enable = true;
  };
  
  # Starship prompt - Minimal Pure-inspired config
  programs.starship = {
    enable = true;
    settings = {
      # Clean, minimal format
      format = ''
        $directory$git_branch$git_status$nix_shell
        $character
      '';
      
      # Add a blank line between prompts for breathing room
      add_newline = true;
      
      # Directory - short and sweet
      directory = {
        style = "blue bold";
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style) ";
      };
      
      # Git branch - simple
      git_branch = {
        style = "bright-black";
        format = "[$branch]($style) ";
      };
      
      # Git status - only the essentials
      git_status = {
        style = "red";
        format = "[$modified$staged$untracked]($style)";
        modified = "✗";
        staged = "✓";
        untracked = "?";
        diverged = "";
        conflicted = "";
        ahead = "";
        behind = "";
        stashed = "";
        renamed = "";
        deleted = "";
      };
      
      # Character - simple prompt
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";  # For vim mode if you use it
      };
      
      # Only show nix-shell when active
      nix_shell = {
        symbol = "";
        style = "cyan";
        format = "[$symbol nix]($style) ";
      };
      
      # Language versions - only show when in relevant projects
      # They appear on the right side of the terminal
      right_format = "$cmd_duration$nodejs$python$rust";
      
      nodejs = {
        symbol = "";
        style = "green";
        format = "[$symbol $version]($style)";
        detect_extensions = ["js" "mjs" "cjs" "ts" "tsx"];
        detect_files = ["package.json"];
      };
      
      python = {
        symbol = "";
        style = "yellow";
        format = "[$symbol $version]($style)";
        detect_extensions = ["py"];
        detect_files = ["requirements.txt" "pyproject.toml" "Pipfile"];
      };
      
      rust = {
        symbol = "";
        style = "orange";
        format = "[$symbol $version]($style)";
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
      };
      
      # Show command duration for long commands
      cmd_duration = {
        min_time = 3000;  # Show after 3 seconds
        style = "yellow";
        format = "[$duration]($style) ";
      };
      
      # Disable modules we don't need
      aws = { disabled = true; };
      gcloud = { disabled = true; };
      package = { disabled = true; };
      time = { disabled = true; };
      battery = { disabled = true; };
      memory_usage = { disabled = true; };
      username = { disabled = true; };
      hostname = { disabled = true; };
    };
  };
  
  # Direnv (which you already use)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;  # Better nix-shell integration
    enableZshIntegration = true;
  };
}
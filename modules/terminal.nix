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
      
      # Better ls with eza
      ls = "eza";
      ll = "eza -l";
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

    # vi mode plugin for zsh
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    
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
    settings = lib.mkMerge [
      (builtins.fromTOML (builtins.readFile "${pkgs.starship}/share/starship/presets/pure-preset.toml")) {
        # Custom config here
        aws.disabled = true;
      }
    ];
  };
  
  # Direnv (which you already use)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;  # Better nix-shell integration
    enableZshIntegration = true;
  };
}


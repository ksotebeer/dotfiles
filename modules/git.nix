{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    
    # Your git identity
    userName = "Keegan Sotebeer";
    userEmail = "keegan.sotebeer@cobaltai.com";
    
    # Better diffs
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        side-by-side = false;
        line-numbers = true;
      };
    };
    
    # Essential git config
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      
      # Better merge conflict resolution
      merge.conflictstyle = "diff3";
      
      # Reuse recorded resolutions
      rerere.enabled = true;
      
      # Better colors
      color.ui = true;
      
      # Faster git
      core.fsmonitor = true;
      
      # Use native keychain for credentials on macOS
      credential.helper = lib.mkIf pkgs.stdenv.isDarwin "osxkeychain";
    };
    
    # Useful git aliases
    aliases = {
      # Shortcuts
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      
      # View abbreviated SHA, description, and history graph
      l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
      
      # View the current working tree status using the short format
      s = "status -s";
      
      # Show verbose output about tags, branches or remotes
      tags = "tag -l";
      branches = "branch --all";
      remotes = "remote --verbose";
      
      # Amend the currently staged files to the latest commit
      amend = "commit --amend --reuse-message=HEAD";
      
      # Interactive rebase with the given number of latest commits
      reb = "!r() { git rebase -i HEAD~$1; }; r";
      
      # Find branches containing commit
      fb = "!f() { git branch -a --contains $1; }; f";
      
      # Find commits by commit message
      fm = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f";
      
      # Remove branches that have already been merged with main
      dm = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d";
      
      # Undo last commit but keep changes
      undo = "reset HEAD~1 --mixed";
    };
    
    # Global gitignore
    ignores = [
      ".DS_Store"
      "*.swp"
      "*.swo"
      "*~"
      ".direnv"
      ".envrc"
      "result"  # Nix build output
      "result-*"
    ];
  };
}
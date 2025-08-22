{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Use backtick as prefix instead of C-b
    prefix = "`";
    
    # Enable mouse support
    mouse = true;
    
    # Use vi keybindings in copy mode
    keyMode = "vi";
    
    # Increase scrollback buffer
    historyLimit = 50000;
    
    # Don't rename windows automatically
    disableConfirmationPrompt = false;
    
    # Base configuration
    extraConfig = ''
      # Enable true colors and proper terminal support
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      
      # Don't rename windows automatically
      set-option -g allow-rename off
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Switch panes using vim navigation bindings
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

    '';
  };
}


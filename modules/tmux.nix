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

      # Smart pane switching with awareness of Vim splits
      # This works with vim-tmux-navigator plugin
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

      # Restore clear screen with prefix + C-l
      bind C-l send-keys 'C-l'

      # Resize with Option + hjkl
      bind-key -n M-h resize-pane -L 2
      bind-key -n M-j resize-pane -D 2
      bind-key -n M-k resize-pane -U 2
      bind-key -n M-l resize-pane -R 2
    '';
  };
}


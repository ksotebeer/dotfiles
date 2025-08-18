{ config, pkgs, lib, ... }:

{
  # Install Nerd Fonts for terminal icons
  home.packages = with pkgs; [
    # Popular Nerd Fonts with good icon support
    nerd-fonts.jetbrains-mono     # Excellent for programming
    nerd-fonts.fira-code          # Popular with ligatures
    nerd-fonts.meslo-lg           # Good for terminal/tmux
    nerd-fonts.hack               # Clean and readable
  ];
  
  # Font configuration for macOS
  fonts.fontconfig.enable = true;
}


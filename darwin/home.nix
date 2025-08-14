{ config, pkgs, lib, ... }:

{
  # Import shared modules
  imports = [
    ../modules/neovim
    ../modules/terminal.nix
    ../modules/git.nix
    ../modules/dev-tools.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "keegansotebeer";
  home.homeDirectory = "/Users/keegansotebeer";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This should match your nixpkgs version.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Packages
  home.packages = with pkgs; [
    home-manager  # Add home-manager command
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # macOS-only tools
    reattach-to-user-namespace
  ];
}
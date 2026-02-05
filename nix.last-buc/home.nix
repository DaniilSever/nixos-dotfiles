{ config, pkgs, ... }:

{
  home = {
    username = "denver";
    homeDirectory = "/home/denver";
    stateVersion = "25.05";
  };

  imports = [
    ./homepkgs/budgie.nix  # DE
    ./homepkgs/terminal.nix  # wezterm and zsh
    ./homepkgs/git.nix  # work
    
  ];
}
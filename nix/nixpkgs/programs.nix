{ config, pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    direnv.enable = true;
    git.enable = true;

    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };
}
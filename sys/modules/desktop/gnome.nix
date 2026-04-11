{ config, pkgs, ... }:

{
  services = {
    desktopManager.gnome.enable = true;
    displayManager = {
      enable = true;
      gdm = {
        enable = true;
        wayland = true;
      };

      defaultSession = "gnome";
    };

    gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    nautilus
  ];
}
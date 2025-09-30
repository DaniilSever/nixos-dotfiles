{ config, pkgs, ... }:

{
  services = {
    # --desctop enviroment--
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.budgie.enable = true;
      videoDrivers = ["amdgpu"];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    printing.enable = true;
    flatpak.enable = true;

    # --sound--
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
{ config, pkgs, ... }:

{
  services = {
    flatpak.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = ["amdgpu"];
    };
    
    displayManager = {

      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-mocha-mauve";  # имя темы из nixpkgs
      };

      autoLogin = {
        enable = true;
        user = "Denver";
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  programs = {
    zsh.enable = true;
    xfconf.enable = true;
    
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      
      # Для Proton
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };

  systemd.services.nix-daemon.environment = {
    ALL_PROXY = "http://127.0.0.1:10809";
    HTTP_PROXY = "http://127.0.0.1:10809";
    HTTPS_PROXY = "http://127.0.0.1:10809";

    NO_PROXY = "localhost,127.0.0.1";
  };
}

{ config, pkgs, ... }:

{
  services = {
    flatpak.enable = true;
    tailscale.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager = {
   	  autoLogin = {
   	  	enable = true;
   	  	user = "Denver";
   	  };
    };
  };

  programs = {
    zsh.enable = true;
    xfconf.enable = true;
    xwayland.enable = true;

    steam = {
      enable = true;
      package = pkgs.millennium-steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      
      # Для Proton
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };

    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: with pkgs; [
          libepoxy  # Явно добавляем недостающую библиотеку
          zstd
          libGL
          xorg.libX11
        ];
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    # Разрешить запуск без sudo (добавляет пользователя в группу docker)
    enableOnBoot = true;
    autoPrune.enable = true;  # Автоматическая очистка
  };

}

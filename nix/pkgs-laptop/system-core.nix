{ config, pkgs, ... }:

{
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
    dbus.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = false;

    xserver = {
      enable = true;
      xkb.layout = "us";
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


    

    # --- Tiger Lake Settings ---

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        INTEL_GPU_MIN_FREQ_ON_AC = "350";
        INTEL_GPU_MAX_FREQ_ON_AC = "1150";
        INTEL_GPU_MIN_FREQ_ON_BAT = "350";
        INTEL_GPU_MAX_FREQ_ON_BAT = "850";
      };
    };

    thermald.enable = true;
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

    gamemode = {
      enable = true;
      enableRenice = true;

      settings = {
        general = {
          renice = 10;
          softrealtime = "auto";
          desiredgov = "performance";
          inhibit_screensaver = 1;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          ignore_vendor = true;  # Игнорируем ошибку с Intel GPU
        };
      };
    };

    gamescope = {
      enable = true;
      args = [ "--rt" "--prefer-vk-device" "--adaptive-sync" ];
      capSysNice = true;
    };
  };

  system.activationScripts.gamemodeLibFix = ''
    mkdir -p /usr/lib
    ln -sf ${pkgs.gamemode.lib}/lib/libgamemodeauto.so /usr/lib/libgamemodeauto.so 2>/dev/null || true
  '';

  systemd.services.nix-daemon.environment = {
    ALL_PROXY = "http://127.0.0.1:10809";
    HTTP_PROXY = "http://127.0.0.1:10809";
    HTTPS_PROXY = "http://127.0.0.1:10809";

    NO_PROXY = "localhost,127.0.0.1";
  };
}

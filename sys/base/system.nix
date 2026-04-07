{ config, pkgs, ... }:

{
  services = {
    flatpak.enable = true;
    tailscale.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";

      excludePackages = with pkgs; [ xterm ];
    };

    desktopManager.gnome.enable = true;
    displayManager = {
      enable = true;
      gdm = {
        enable = true;
        wayland = true;
      };
      # sddm = {
      #   enable = true;
      # };
      
      
      defaultSession = "gnome";
    
   	  autoLogin = {
   	  	enable = true;
   	  	user = "Denver";
   	  };
    };

    gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      extraConfig.pipewire = {
        "context.modules" = [
          {
            name = "libpipewire-module-echo-cancel";
            args = {
              "capture.props" = {
                "node.name" = "capture.echo-cancel";
                "stream.dont-remix" = true;
                "node.passive" = true;
              };
              "playback.props" = {
                "node.name" = "playback.echo-cancel";
                "stream.dont-remix" = true;
                "node.passive" = true;
              };
            };
          }
        ];
      };

      wireplumber.configPackages = [
        (pkgs.writeTextDir "share/wireplumber/main.lua.d/51-disable-agc.lua" ''
          rule = {
            matches = {
              {
                { "node.name", "matches", "alsa_input.*" },
              },
            },
            apply_properties = {
              ["node.name"] = "disable-agc",
              ["audio.channels"] = 2,
              ["audio.format"] = "S16LE",
              ["audio.rate"] = 48000,
              ["api.alsa.soft-mixer"] = true,
              ["api.alsa.soft-vol"] = true,
              ["node.disabled"] = false,
            },
          }
          
          table.insert(alsa_monitor.rules, rule)
        '')
      ];
    };
  };

  # Устанавливаем pavucontrol для ручного управления
  environment.systemPackages = with pkgs; [
    pavucontrol
    alsa-utils
  ];

  programs = {
    zsh.enable = true;
    xfconf.enable = true;
    
    # hyprland = {
    #   enable = true;
    #   withUWSM = true;
    #   xwayland.enable = true;
    # };

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

  systemd.services.nix-daemon.environment = {
    ALL_PROXY = "http://127.0.0.1:10808";
    HTTP_PROXY = "http://127.0.0.1:10808";
    HTTPS_PROXY = "http://127.0.0.1:10808";
  };

  virtualisation.docker = {
    enable = true;
    # Разрешить запуск без sudo (добавляет пользователя в группу docker)
    enableOnBoot = true;
    autoPrune.enable = true;  # Автоматическая очистка
  };

}

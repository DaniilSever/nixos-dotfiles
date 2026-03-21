{ config, pkgs, ... }:

{
  services = {
    flatpak.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";

      desktopManager.xfce.enable = true;
      displayManager.lightdm.enable = true;
    };

    displayManager = {
      enable = true;
      
      # sddm = {
      #   enable = true;
      # };
      
      
      defaultSession = "xfce";
    
   	  autoLogin = {
   	  	enable = true;
   	  	user = "Denver";
   	  };
    };

    # pipewire = {
    #   enable = true;
    #   pulse.enable = true;
    #   alsa = {
    #     enable = true;
    #     support32Bit = true;
    #   };
    # };
  };

  # Включаем PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;  # обычно включен по умолчанию
  };

  # Добавляем конфигурацию через extraConfig
  services.pipewire.extraConfig.pipewire = {
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

  # Отключаем AGC через WirePlumber
  services.pipewire.wireplumber.configPackages = [
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

    NO_PROXY = "localhost,127.0.0.1";
  };
}

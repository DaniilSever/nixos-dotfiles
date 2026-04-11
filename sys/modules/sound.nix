{
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

  environment.systemPackages = with pkgs; [
    pavucontrol
    alsa-utils
  ];
}
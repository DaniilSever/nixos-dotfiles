{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # --sys package--
      btop
      wget
      iptables
      neofetch
      firefox
      pavucontrol
      home-manager
      zapret

      # --home package--
      nekoray
      vesktop
      vencord
      anydesk
      todoist
      komorebi
      keepassxc
      telegram-desktop
      teamspeak6-client

      # --work package--
      vscode
      obsidian
      dbeaver-bin
      docker-compose

      # -- --python--
      python313
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/denver/.steam/root/compatibilitytools.d";
    };
  };
}
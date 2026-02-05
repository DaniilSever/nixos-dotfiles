{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    rose-pine-cursor

    dconf-editor
  ];

  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    cursorTheme = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "menu:";
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    # Глобальные настройки Budgie
    "com/solus-project/budgie-panel" = {
      dark-theme = true;
      builtin-theme = false;
    };

    # Настройки панелейg
    "com/solus-project/budgie-panel/instance/raven" = {
      expand = true;
    };

    # Настройки рабочего стола
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "gruvbox-dark";
      icon-theme = "oomox-gruvbox-dark";
      cursor-theme = "BreezeX-RosePine-Linux";
      enable-hot-corners = false;
    };

    # Настройки окон
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      theme = "gruvbox-dark";
    };

    # Настройки шрифтов
    "org/gnome/desktop/interface" = {
      font-name = "Fira Code 10";
      document-font-name = "Fira Code 10";
      monospace-font-name = "Fira Code 10";
    };
  };

  home.activation.setupBudgie = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Убедимся, что темы доступны
    if [ ! -d "$HOME/.themes/Gruvbox-Dark" ]; then
      mkdir -p "$HOME/.themes"
      ln -sf ${pkgs.gruvbox-dark-gtk}/share/themes/Gruvbox-Dark "$HOME/.themes/"
    fi
    
    if [ ! -d "$HOME/.icons/Gruvbox-Dark" ]; then
      mkdir -p "$HOME/.icons"
      ln -sf ${pkgs.gruvbox-dark-icons-gtk}/share/icons/Gruvbox-Dark "$HOME/.icons/"
    fi
  '';
}
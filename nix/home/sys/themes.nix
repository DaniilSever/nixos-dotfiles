{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [

    (catppuccin-gtk.override {
      accents = [ "blue" ];
      variant = "mocha";
    })

    (catppuccin-papirus-folders.override {
      accent = "blue";
      flavor = "mocha";
    })
    
    # Курсоры Catppuccin
    catppuccin-cursors.mochaBlue
    
    gtk_engines
    gtk-engine-murrine
    libsForQt5.qtstyleplugins                                                                             
    adwaita-qt
  ];

  gtk = {
    enable = true;
    
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-dark";
      package = pkgs.catppuccin-gtk;
    };
    
    # ИСПРАВЛЕНО: используем Catppuccin иконки
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
    
    cursorTheme = {
      name = "Catppuccin-Mocha-Blue-Cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 24;
    };

    gtk2.extraConfig = ''
      gtk-theme-name="Catppuccin-Mocha-Standard-Blue-dark"
      gtk-icon-theme-name="Papirus-Dark"
      gtk-cursor-theme-name="Catppuccin-Mocha-Blue-Cursors"
      gtk-cursor-theme-size=24
      gtk-application-prefer-dark-theme=1
    '';
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-size = 24;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  
  # Настройка QT тем (для KDE, VLC, Telegram)
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  
  # Переменные окружения для тем (важно!)
  home.sessionVariables = lib.mkForce {
    # GTK тема
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-dark";

    # Курсоры
    XCURSOR_THEME = "Catppuccin-Mocha-Blue-Cursors";
    XCURSOR_SIZE = "24";
    
    # QT темы
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    
    # Electron приложения
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  
  # Копирование конфигов GTK2 (старые приложения)
  xdg.configFile."gtk-2.0/gtkrc".text = ''
    # Catppuccin Mocha Blue Dark Theme for GTK2
    gtk-theme-name="Catppuccin-Mocha-Standard-Blue-dark"
    gtk-icon-theme-name="Papirus-Dark"
    gtk-cursor-theme-name="Catppuccin-Mocha-Blue-Cursors"
    gtk-cursor-theme-size=24
    gtk-application-prefer-dark-theme=1
    
    # Дополнительные настройки
    gtk-font-name="Sans 10"
    gtk-enable-animations=1
    gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
    gtk-menu-images=1
    gtk-button-images=1
    gtk-primary-button-warps-slider=0
    gtk-dnd-drag-threshold=8
  '';

}

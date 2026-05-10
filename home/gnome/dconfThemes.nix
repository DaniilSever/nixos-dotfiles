{ pkgs, ...}:

{
  home.packages = with pkgs; [
    qogir-theme
    qogir-icon-theme
    volantes-cursors
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Qogir-Dark";     # Имя темы GTK
      icon-theme = "Qogir-Dark";           # Имя набора иконок
      cursor-theme = "Qogir-Dark"; # Имя темы курсора
      cursor-size = 20;
      color-scheme = "prefer-dark";          # Принудительно тёмная тема
      enable-hot-corners = false;
      clock-format = "12h";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Qogir-Dark";   # Имя темы оболочки
    };
  };
}
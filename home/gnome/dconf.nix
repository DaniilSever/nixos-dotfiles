{ pkgs, ...}:

{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator


    libappindicator-gtk3
    libdbusmenu-gtk3
  ];
  
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 4;
        button-layout = "appmenu:minimize,maximize,close";
      };
      
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "blur-my-shell@aunetx"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];

        favorite-apps = [
          "firefox.desktop"
          "vesktop.desktop"
          "spotify.desktop"
          "code.desktop"
          "steam.desktop"
          "org.wezfurlong.wezterm.desktop"
          "obsidian.desktop"
          "org.telegram.desktop.desktop"
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        # Включаем блюр для панели
        blur = true;
        # Используем динамический блюр (для адаптации под окна)
        # static-blur = false; # По умолчанию false, это и есть динамический режим
        
        # КЛЮЧЕВАЯ НАСТРОЙКА: отключаем блюр, когда окно находится рядом
        # Это и есть реализация вашего условия "приложение открыто в полный экран"
        unblur-on-window-close = true;
        
        # Настройка расстояния (в пикселях) от панели до окна,
        # при котором блюр отключается. Значение по умолчанию 0.
        # Для более плавного поведения, можно оставить 0, чтобы
        # блюр отключался только когда окно касается панели.
        unblur-distance = 0;
        
        # Дополнительные параметры внешнего вида
        brightness = 1.0;
        sigma = 30;           # Сила размытия
      };

      # Отключаем блюр для Dash (чтобы он использовал тему Shell)
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        # Главный выключатель: НЕ применяем блюр к доку
        blur = false;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        # Позиция и внешний вид
        dock-position = "BOTTOM";           # Панель снизу
        extend-height = false;              # Только под иконки, не на всю ширину
        icon-size = 32;                     # Компактный размер иконок

        # Использование системных тем
        apply-custom-theme = false;          # Использовать тему GNOME Shell
        custom-theme-shrink = true;         # Минимальные отступы

        transparency-mode = "FIXED";  # FIXED, DYNAMIC, DEFAULT
        background-opacity = 0.1;

        # Поведение
        intellihide = true;         
        click-action = "minimize-or-previews";  # Клик сворачивает или показывает окна
        show-apps-at-top = false;            # Кнопка "Приложения" сверху
        show-trash = false;                 # Не показывать корзину
        show-mounts = false;                # Не показывать диски
        isolate-workspaces = false;         # Показывать окна со всех рабочих столов
        isolate-monitors = false;           # Для нескольких мониторов

        disable-drag-over-dock = false;

        hot-keys = true;
        shortcut = "Super";          # Клавиша для вызова (Super = Windows)
      };
    };
  };
}
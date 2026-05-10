## Мой Flake NixOS conf

### Архитектура:
```
.
├── disko.nix  # общее описание разбитие дисков (settings.nix сюда тоже импортируется)
├── flake.nix  # общее описание системы
├── settings.nix  # .env что импортируется во все lib/ и core.nix
├── home
│   ├── hmCore.nix  # описание системы + imports
│   ├── applications 
│   │   ├── appPackage.nix  # установка приложений под пользователя
│   │   └── lib  # настройки отдельных приложений/утилит которые доступны в home-manager
│   │       └── git.nix
│   └── hyprland
│       ├── lib
│       │   ├── fileManager.nix
│       │   ├── fonts.nix
│       │   └── ruleWindow.nix
│       ├── styles
│       │   ├── css
│       │   │   └── waybar.css
│       │   ├── icons
│       │   │   └── nixos.svg
│       │   ├── themes.nix
│       │   └── wallpapers  # обои что можно поставить в settings.nix
│       │       ├── ...
│       │       └── walls.jpg
│       ├── hypr.nix  # обшие настройки + imports необходимых lib
│       ├── waybar.nix
│       ├── shell.nix
│       └── wlogout.nix
└── sys
    ├── laptopCore.nix # import либ + настройки ядра/запуска/...
	├── desktopCore.nix # import либ + настройки ядра/запуска/... 
    ├── base
    │   ├── account.nix
    │   ├── automount.nix
    │   ├── environment.nix  # общие приложения и утелиты
    │   └── system.nix
    ├── gaming
    │   ├── gameCore.nix  # общие настройки по играм + imports
    │   └── lib  # файлы настроек под конкретные игры (maincraft, gensh и прочее)
	├── services  # demons + vpn
    └── hardware
        ├── amdOptions.nix  # оптимизация и настройки/утилиты под amd графику
        ├── intelOptions.nix  # оптимизация и настройки/утилиты под intel графику
        └── lib  # default
            ├── desktop
            │   └── hardware-configuration.nix
            └── laptop
                └── hardware-configuration.nix
```

### Тестирование:
```
nix flake check  # Проверка синтаксиса

nixos-rebuild dry-build  # Покажет, что будет построено, но не собирать

nixos-rebuild dry-activate  # Покажет, какие изменения произойдут при активации

home-manager build     # Собрать в result, но не переключать
home-manager dry-run   # Показать что изменится
```
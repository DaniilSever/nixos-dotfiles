{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Игровые платформы
    steam
    lutris
    heroic
    bottles
    
    # Утилиты для мониторинга
    mangohud
    goverlay
    
    # Для Wine/Proton
    wine-staging
    winetricks
    protonup-qt
    
    # Утилиты
    gamescope
    gamemode
    gamemode.lib
    vkbasalt # Пост-обработка для Vulkan
    libadwaita
    gtk4
    adwaita-icon-theme

    
    # Драйвера и утилиты
    piper # Настройка мышей
    openrgb # Управление RGB
    
    # Для записи геймплея в Wayland
    wf-recorder
    obs-studio
    
    # PortProton зависимости
    libpng
    libjpeg
    freetype
    fontconfig
    openssl
  ];
  
  # Настройки для PortProton
  environment.sessionVariables = {
    # Для Intel Iris Xe
    MESA_LOADER_DRIVER_OVERRIDE = "iris";
    INTEL_DEBUG = "norbc";
    
    # Для игр в Wayland
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
  };
}
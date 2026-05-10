{ config, pkgs, ... }:

let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "sha256:1sph4kym2hzh27pdnff22za2vhqrbd64dmsy7q0hg6ra22b5a8w7"; # Временный хэш
  });
in
{
  imports = [
    aagl-gtk-on-nix.module
  ];

  environment.systemPackages = with pkgs; [
    # Игровые платформы
    lutris
    (lutris.override {
      extraLibraries = pkgs: with pkgs; [
        # Зависимости для honkers-railway-launcher
        bzip2
        cairo
        glib
        gtk4
        libadwaita
        pango
        wayland

        # Важные зависимости для графики и Vulkan
        vulkan-loader
        mesa
        libGL

        # Часто нужны и 32-битные версии библиотек для Wine-игр
        pkgsi686Linux.bzip2
        pkgsi686Linux.cairo
        pkgsi686Linux.glib
        pkgsi686Linux.gtk4
        pkgsi686Linux.libadwaita
        pkgsi686Linux.pango
        pkgsi686Linux.wayland
        pkgsi686Linux.vulkan-loader
        pkgsi686Linux.mesa
        pkgsi686Linux.libGL
      ];
    })

    bottles
    wineWowPackages.staging
    cabextract
    p7zip
    dxvk            # DirectX 9/10/11 на Vulkan
    vkd3d           # DirectX 12 на Vulkan  

    heroic
    
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
  
  programs.gamemode.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Графика и игры
      vulkan-loader
      vulkan-validation-layers  # на всякий случай
      libGL
      mesa
      libwebp
      
      # Lutris / Wine (32-битные тоже важны!)
      pkgsi686Linux.vulkan-loader
      pkgsi686Linux.libGL
      pkgsi686Linux.mesa
      
      # Для scrcpy (зависимости ffmpeg)
      ffmpeg
      
      # Аудио
      pipewire
      
      # Общие системные библиотеки, которые часто просит софт
      stdenv.cc.cc
      zlib
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXrandr
      xorg.libXi
      freetype
      fontconfig
      nss
      
      # Для Feral GameMode (чтобы не ругался)
      gamemode


      # hsr
      bzip2
      cairo
      glib
      gtk4
      libadwaita
      pango
      wayland
    ];
  };

  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
  aagl.enableNixpkgsReleaseBranchCheck = false;
  programs.honkers-railway-launcher.enable = true;
}
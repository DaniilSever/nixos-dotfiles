{ config, pkgs, lib, ... }:

{
  services = {
    flatpak.enable = true;
    tailscale.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager = {
   	  autoLogin = {
   	  	enable = true;
   	  	user = "Denver";
   	  };
    };
  };

  programs = {
    zsh.enable = true;
    xfconf.enable = true;
    xwayland.enable = true;

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

  virtualisation = {

    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };

    docker = {
      enable = true;
      # Разрешить запуск без sudo (добавляет пользователя в группу docker)
      enableOnBoot = true;
      autoPrune.enable = true;
    };  # Автоматическая очистка
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer       # SPICE клиент
    spice             # протокол удаленного доступа
    spice-gtk
    virtio-win        # ISO с драйверами VirtIO для Windows
    win-spice         # ISO с драйверами SPICE для Windows
    quickemu          # (опционально) альтернативный способ запуска ВМ
  ];
}

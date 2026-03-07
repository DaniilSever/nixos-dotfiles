{ config, pkgs, settings, ... }:

{
  #TODO: вынести в .env (settings.nix)
  imports = [
    ./hardware/lib/desktop/hardware-configuration.nix # disk default
    ./hardware/amdOptions.nix  # или ./hardware/intelOptions.nix
    
    ./base/system.nix # services + programs
    ./base/automount.nix
    ./base/account.nix
    ./base/environment.nix
       
    # ./gaming/gameCore.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" "exfat" "vfat" "ext4" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 3;  # count in system-boot
      };
    };
  };

  #TODO: вынести в .env (settings.nix)
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Novosibirsk";  #TODO: вынести в .env (settings.nix)
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
  };
  
  xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];	
	};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-36.9.5" ];
  };
  
  #TODO: autoupdate и autoclear можно подумать и сделать в .env (settings.nix) через проверку на true
  # --autoupdate--
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
  };

  # --autoclear system--
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-order-than 30d";
    };

    settings = {
      auto-optimise-store = true;
      keep-outputs = false;
      keep-derivations = false;
    };
  };

  system.stateVersion = "25.11";  #TODO: можно подумать как синхронизировать с flake.nix чтоб в 1 месте прописывать версию системы
}
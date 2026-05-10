{ config, pkgs, ... }:

{
  imports = [
    ./hardware/lib/desktop/hardware-configuration.nix # disk default
    ./hardware/amdOptions.nix  # или ./hardware/intelOptions.nix
    
    ./modules/system.nix # services + programs
    ./modules/desktop/gnome.nix
    ./modules/sound.nix
    # ./modules/automount.nix
    ./modules/account.nix
    ./modules/environment.nix
    # ./modules/local-proxy.nix
       
    ./modules/gaming/gameCore.nix
  ];

  boot = {
    supportedFilesystems = [ "ntfs" "exfat" "vfat" "ext4" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 5;  # count in system-boot
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Novosibirsk";
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

  system.stateVersion = "25.11";
}
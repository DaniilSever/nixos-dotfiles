{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # disk
    
    ./pkgs-pc/system-core.nix # services + programs
    
    # -- custom service --
    # ./pkgs/sysmd/xray-hys.nix
    # ./pkgs/sysmd/xray-trojan.nix
    ./pkgs-pc/sysmd/xray-vless.nix

    # -- users and sys.environment --
    ./pkgs-pc/user.nix
    ./pkgs-pc/enviroment.nix
    ./pkgs-pc/gaming.nix
  ];

  # ----- base settings -----
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" "exfat" "vfat" "ext4" ];

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 3;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Novosibirsk";

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

  # --driver--
  hardware = {
  	bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # ------- sys.info -------
  system.stateVersion = "25.05";
}

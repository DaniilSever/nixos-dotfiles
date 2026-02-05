{ config, pkgs, ... }:

{
  # --set boot--
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # --set network--
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # --set timezone--
  time.timeZone = "Asia/Novosibirsk";
  time.hardwareClockInLocalTime = true;

  # --internationalisation properties--
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
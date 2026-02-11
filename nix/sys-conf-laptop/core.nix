{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # disk
    
    ./pkgs-laptop/system-core.nix # services + programs
    
    # -- custom service --
    # ./pkgs/sysmd/xray-hys.nix
    # ./pkgs/sysmd/xray-trojan.nix
    ./pkgs-laptop/sysmd/xray-vless.nix

    # -- users and sys.environment --
    ./pkgs-laptop/user.nix
    ./pkgs-laptop/enviroment.nix
    ./pkgs-laptop/gaming.nix
  ];

  # ----- base settings -----
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    
    kernelParams = [
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "i915.enable_psr=1"
      "i915.enable_dc=2"
      "i915.fastboot=1"
    ];

    kernel.sysctl = {
      # Увеличиваем размеры буферов для сетевых игр
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
      "net.ipv4.tcp_rmem" = "4096 87380 134217728";
      "net.ipv4.tcp_wmem" = "4096 65536 134217728";
      
      # Для игр с большим количеством текстур
      "vm.max_map_count" = 2147483642;
      
      # Уменьшаем swap usage для игр
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
    };

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 3;
      efi.canTouchEfiVariables = true;
    };

    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "tun" ];
    supportedFilesystems = [ "ntfs" "exfat" "vfat" "ext4" ];
  };

  networking = {
    hostName = "nixos";
    # networkmanager.enable = true;

    wireless = {
      enable = true;
      interfaces = [ "wlo1" ];
      userControlled.enable = true;
      networks = {
        "WebStream-5" = {
          psk = "32183337";
        };
        "Denver" = {
          psk = "vosal,oga";
        };
        "PSUTI" = {
          auth = ''
            key_mgmt=WPA-EAP
            eap=PEAP
            identity="s2530145"
            password="n8g@9E8N"
            phase2="auth=MSCHAPV2"
          '';
        };
      };
    };

    firewall = {
      allowedTCPPorts = [ 
        27015 27036  # Steam
        3478 3479    # STUN
        3659         # Epic Games
        5222         # GOG Galaxy
      ];
      
      allowedUDPPortRanges = [
        { from = 27000; to = 27100; } # Steam
        { from = 4380; to = 4380; }   # Steam
        { from = 3478; to = 3479; }   # STUN
      ];
    };
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

      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        intel-vaapi-driver
        intel-gpu-tools
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers

        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs; [
        driversi686Linux.intel-vaapi-driver
      ];
    };
  };

  # ------- sys.info -------
  system.stateVersion = "25.05";
}

{ pkgs, ... }:

{
  boot = {
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

    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "tun" ];
  };

  networking = {
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
}
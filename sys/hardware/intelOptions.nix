{ pkgs, ... }:

{
  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "kvm-intel" ];

    kernelParams = [
      "i915.enable_guc=3"
      "i915.enable_psr=0"
    ];
  };

  services = {
    thermald.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "modesetting" ];
    };

    tlp = {
      enable = true;
      settings = {
        # Режимы CPU в зависимости от питания
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        
        # Политика энергопотребления
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        
        # Лимиты частоты (на Tiger Lake хорошо работают эти настройки)
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;  # Ограничиваем на батарее для экономии
        
        # Опционально: защита батареи (если ноутбук поддерживает)
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

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

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  hardware = {
  	bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        intel-media-driver          # VAAPI для кодека AV1
        intel-compute-runtime       # OpenCL
        libvdpau-va-gl              # VDPAU поверх VAAPI
        vaapiVdpau                  # Мост для обратной совместимости
      ];
    };
  };

  nix = {
    settings = {
      max-jobs = 4;
      cores = 2;
    };

    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };
}
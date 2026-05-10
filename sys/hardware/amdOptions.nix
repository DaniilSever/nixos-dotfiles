{ pkgs, ...}:

{
  
  boot = {
    kernelPackages = pkgs.linuxPackages_lqx;
    kernelModules = [ "kvm-amd" ];
    kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
      "amdgpu.tmz=0"           # Trusted Memory Zone — бажит на RDNA3
      "amdgpu.sg_display=0"    # Отключает scatter-gather для дисплея
      "amdgpu.dcdebugmask=0x10" # Отключает дебаг Display Core
      "iommu=soft"             # Программный IOMMU вместо аппаратного
      "amdgpu.gpu_recovery=1"  # Включает восстановление после зависаний
    ];
    
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };
  
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware = {
  	bluetooth.enable = true;
    enableRedistributableFirmware = true;
    firmware = [ pkgs.linux-firmware ];
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
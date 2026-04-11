{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware = {
  	bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
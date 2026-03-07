{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  hardware = {
  	opengl.enable = true;
  	bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
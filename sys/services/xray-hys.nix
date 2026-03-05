{ config, pkgs, lib, ... }:

{
  systemd.services.hysteria-test = {
    enable = true;
    description = "Hysteria2 Test";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart = "${pkgs.hysteria}/bin/hysteria client -c ${pkgs.writeText "test.yaml" ''
        server: 148.253.212.56:6874
        auth: "main:epBfp0qkf2TtCvWPPUqlG5GJd2bCgjBP"
        tls:
          sni: ya.ru
          insecure: true
        socks5:
          listen: 127.0.0.1:10809
      ''}";
      Restart = "no";
    };
  };

  environment.systemPackages = with pkgs; [ hysteria ];
}
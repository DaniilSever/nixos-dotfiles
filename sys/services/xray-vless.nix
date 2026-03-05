{ config, pkgs, lib, ... }:

{
  # 1. Создаем конфигурационный файл для Xray
  systemd.services.xray-proxy = {
    enable = true;
    description = "Xray Hysteria Proxy";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "nobody";  # Безопасный пользователь без привилегий
      Group = "nogroup";
      ExecStart = "${pkgs.xray}/bin/xray -config /etc/xray/config.json";
      Restart = "on-failure";
      RestartSec = "5s";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = "/var/log/xray";
    };
  };

  # 2. Создаем конфигурационный файл для Xray с Hysteria
  environment.etc."xray/config.json".text = builtins.toJSON {
    log = {
      loglevel = "warning";
      access = "/var/log/xray/access.log";
      error = "/var/log/xray/error.log";
    };

    inbounds = [
      {
        port = 10808;
        listen = "127.0.0.1";
        protocol = "socks";
        settings = {
          auth = "noauth";
          udp = true;
        };
        sniffing = {
          enabled = true;
          destOverride = [ "http" "tls" ];
        };
      }
      {
        port = 10809;
        listen = "127.0.0.1";
        protocol = "http";
        settings = {
          allowTransparent = false;
        };
      }
    ];

    outbounds = [
      {
        protocol = "vless";
        tag = "proxy";
        settings = {
          vnext = [
            {
              address = "x-ui.sagegrid.su";
              port = 53842;
              users = [
                {
                  id = "7401a8a7-4c34-475b-917c-3a1d755887e4";
                  encryption = "none";
                  flow = "";
                }
              ];
            }
          ];
        };
        
        streamSettings = {
          network = "grpc";
          security = "reality";

          realitySettings = {
            publicKey = "yreaScwtN92KUsUQ2fInrUNEXTLNW5xfJHI3eFS1AxE";
            shortId = "ba5b";
            serverName = "google.com";
            fingerpront = "chrome";
            spiderX = "/";
          };

          grpcSettings = {
            serviceName = "";
            authority = "";
          };
        };
      }

      {
        protocol = "freedom";
        tag = "direct";
        settings = {};
      }
    ];

    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        {
          type = "field";
          ip = [ "geoip:private" "geoip:cn" ];
          outboundTag = "direct";
        }
        {
          type = "field";
          domain = [ "geosite:cn" ];
          outboundTag = "direct";
        }
        {
          type = "field";
          protocol = [ "bittorrent" ];
          outboundTag = "direct";
        }
        {
          type = "field";
          port = "123";  # NTP
          outboundTag = "direct";
        }
        {
          type = "field";
          network = "tcp,udp";
          outboundTag = "proxy";
        }
      ];
    };

    policy = {
      levels = {
        "0" = {
          handshake = 4;
          connIdle = 300;
          uplinkOnly = 0;
          downlinkOnly = 0;
          bufferSize = 10240;
        };
      };
    };
  };

  # 3. Создаем директории для логов
  systemd.tmpfiles.rules = [
    "d /var/log/xray 0755 nobody nogroup -"
  ];

  # 4. Включаем xray в системных пакетах
  environment.systemPackages = with pkgs; [ xray ];
}

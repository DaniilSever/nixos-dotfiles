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
          tcp = true;
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
        protocol = "hysteria";
        tag = "proxy";
        settings = {
          address = "148.253.212.56";
          port = 6874;
          users = [
            {
              id = "main";  # Ваш id (можно любое имя)
              encryption = "none";
              flow = "";
            }
          ];
          obfs = "salamander";
          obfsPassword = "9RjRfz6vD9BHTVE61uH5Ith2nLbHI5";
          sni = "ya.ru";
          insecure = true;
          pinSHA256 = "11:E3:42:8D:83:E6:50:70:FD:B2:AB:4E:EA:69:F4:90:87:C0:9C:E1:AC:CA:28:0C:19:2C:10:82:79:F8:68:B9";
        };
        streamSettings = {
          network = "tcp";
        };
        mux = {
          enabled = false;
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
          network = "tcp";
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

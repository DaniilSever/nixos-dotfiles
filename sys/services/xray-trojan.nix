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

  # 2. Создаем конфигурационный файл для Xray с Reality
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
        protocol = "trojan";
        tag = "proxy";
        settings = {
          servers = [
            {
              address = "x-ui.sagegrid.su";
              port = 43986;
              password = "fqV2jWxxFb";
            }
          ];
        };
        
        streamSettings = {
          network = "grpc";
          security = "reality";

          realitySettings = {
            publicKey = "GcI_chrfEV0PVMjJ4eNARcaxTEtFj18TYPGck_dXCCE";
            shortId = "6c";
            serverName = "ya.ru";
            fingerprint = "firefox";
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
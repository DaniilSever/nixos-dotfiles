{
  systemd.services.nix-daemon.environment = {
    ALL_PROXY = "http://127.0.0.1:10808";
    HTTP_PROXY = "http://127.0.0.1:10808";
    HTTPS_PROXY = "http://127.0.0.1:10808";
  };

  environment.sessionVariables = {
    ALL_PROXY = "http://127.0.0.1:10808";
    HTTP_PROXY = "http://127.0.0.1:10808";
    HTTPS_PROXY = "http://127.0.0.1:10808";

    http_proxy = "http://127.0.0.1:10808";
    https_proxy = "http://127.0.0.1:10808";
    socks_proxy = "socks5://127.0.0.1:10808";

    NO_PROXY = "localhost, 127.0.0.1, *.mail.ru,*.psuti.ru,*.spotify.com";
  };
}
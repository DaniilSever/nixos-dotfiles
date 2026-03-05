{ config, pkgs, ... }:

{
  environment = {
		
		systemPackages = with pkgs; [
			home-manager
			neofetch
			direnv
			libsForQt5.qt5.qtgraphicaleffects
			qt6.qtwayland
			xray
			sing-box
			throne

			(pkgs.catppuccin-sddm.override {
				flavor = "mocha";
				accent = "mauve";
			})

			python313
			python313Packages.pip

			git
			docker
			btop
			micro
			wget
			firefox
			wezterm
			appimage-run
			bcompare
			onlyoffice-desktopeditors
		];

		variables = {
			QT_STYLE_OVERRIDE = "Fusion";
			QT_QPA_PLATFORM = "wayland";
		};

		sessionVariables = {
			MOZ_ENABLE_WAYLAND = "1";
			NIXOS_OZONE_WL = "1";
			XKB_DEFAULT_LAYOUT = "us, ru";
			XKB_DEFAULT_OPTIONS = "grp:win_space_toggle";

			ALL_PROXY = "http://127.0.0.1:10808";
			HTTP_PROXY = "http://127.0.0.1:10808";
			HTTPS_PROXY = "http://127.0.0.1:10808";

			http_proxy = "http://127.0.0.1:10808";
			https_proxy = "http://127.0.0.1:10808";
			socks_proxy = "socks5://127.0.0.1:10808";

			NO_PROXY = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,::1,*.mail.ru,*.psuti.ru,*.deepseek.com,*.spotify.com";
		};
	};
}

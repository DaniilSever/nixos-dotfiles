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
			v2rayn
			androidenv.androidPkgs.platform-tools
			gnome-tweaks
			nautilus

			go

			python313
			python313Packages.pip
			
			javaPackages.compiler.temurin-bin.jre-21
			javaPackages.compiler.temurin-bin.jre-25

			git
			_7zz
			docker
			btop
			micro
			wget
			firefox
			google-chrome
			wezterm
			appimage-run
			bcompare
			scrcpy
			onlyoffice-desktopeditors
		];

		variables = {
			QT_STYLE_OVERRIDE = "Fusion";
			QT_QPA_PLATFORM = "xcb";
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

			NO_PROXY = "*.mail.ru,*.psuti.ru,*.spotify.com";
		};
	};
}

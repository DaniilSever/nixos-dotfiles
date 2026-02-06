{ config, pkgs, ... }:

{
  environment = {
		
		systemPackages = with pkgs; [
			home-manager
			neofetch
			amdgpu
			direnv
			libsForQt5.qt5.qtgraphicaleffects
			qt6.qtwayland

			(pkgs.catppuccin-sddm.override {
				flavor = "mocha";
				accent = "mauve";
			})

			git
			docker
			btop
			micro
			wget
			firefox
			wezterm
			appimage-run
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

			ALL_PROXY = "http://127.0.0.1:10809";
			HTTP_PROXY = "http://127.0.0.1:10809";
			HTTPS_PROXY = "http://127.0.0.1:10809";

			http_proxy = "http://127.0.0.1:10809";
			https_proxy = "http://127.0.0.1:10809";
			socks_proxy = "socks5://127.0.0.1:10808";

			NO_PROXY = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,::1,*.mail.ru,*.psuti.ru,*.deepseek.com";
		};
	};
}
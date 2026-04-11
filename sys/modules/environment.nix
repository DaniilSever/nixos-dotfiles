{ config, pkgs, ... }:

{
  environment = {
		
		systemPackages = with pkgs; [
			# ------- sys_pkgs -------
			home-manager
			neofetch
			direnv
			libsForQt5.qt5.qtgraphicaleffects
			qt6.qtwayland

			# ------- vpn_pkgs -------
			xray
			sing-box
			v2rayn

			# ------- dev_pkgs -------
			go

			python313
			python313Packages.pip
			
			javaPackages.compiler.temurin-bin.jre-21
			javaPackages.compiler.temurin-bin.jre-25

			# ------- general_pkgs -------
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

		sessionVariables = {
			MOZ_ENABLE_WAYLAND = "1";
			NIXOS_OZONE_WL = "1";
			QT_STYLE_OVERRIDE = "Fusion";
			QT_QPA_PLATFORM = "wayland";
			SDL_VIDEODRIVER = "wayland";
			XKB_DEFAULT_LAYOUT = "us, ru";
			PROTON_ENABLE_WAYLAND = "1";
			XKB_DEFAULT_OPTIONS = "grp:win_space_toggle";
		};
	};
}

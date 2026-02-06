{config, pkgs, ... }:

{
	wayland.windowManager.hyprland = {

		enable = true;
		systemd.enable = false;

		package = pkgs.hyprland;

		xwayland.enable = true;

		settings = {
			monitor = ", 1920x1080@60, 0x0, 1";
			# monitor = "DP1, 1920x1080@100, 0x0, 1";
			# monitor = "DP2, 1920x1080@100, 1920x0, 2";

			input = {
				kb_layout = "us, ru";
				kb_options = "grp:win_space_toggle";
				follow_mouse = 1;
				sensitivity = -0.5;
			};
			
			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};

			windowrulev2 = [
				# Float (поверх всех) для типичных всплывающих окон
				"float, class:^(popup)$"
				"float, class:^(dialog)$"
				"float, class:^(notification)$"
				"float, class:^(toolbar)$"
				"float, title:^(Open File)$"
				"float, title:^(Save As)$"
				"float, title:^(Select.*)$"
				"float, title:^(Preferences)$"
				
				# Центрирование всплывающих окон
				"center, class:^(popup)$"
				"center, class:^(dialog)$"
				
				# Размер для всплывающих окон (опционально)
				"size 800 600, class:^(dialog)$"
				"size 600 400, class:^(popup)$"
				
				# Без рамок для всплывающих
				"noborder, class:^(popup)$"
			];


			general = {
				resize_on_border = true;
				border_size = 2;
				"col.active_border" = "rgb(cba6f7) rgb(89b4fa) 45deg";
				"col.inactive_border" = "rgb(313244)";
			};

			decoration = {
        rounding = 8;

				blur = {
					enabled = true;
					size = 8;
					passes = 2;
					ignore_opacity = true;
					new_optimizations = true;
				};
      };
      

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };


			device = {
				name = "elan1200:00-04f3:30f7-touchpad";
				enabled = false;
				sensitivity = 0.1;
			};

			layerrule = [
				"noanim, ^(steam|gamescope|.*game.*)$"
				"noanim, class:^(steam_app_.*)$"
				"noanim, title:^(.*game.*)$"
			];

			env = [
				"WLR_DRM_NO_ATOMIC,1"
				"WLR_NO_HARDWARE_CURSORS,1"
				"__GL_SHADER_DISK_CACHE,1"
				"__GL_SHADER_DISK_CACHE_PATH,${config.home.homeDirectory}/.cache/nvidia"
			];

	
			"$mod" = "SUPER";
			"$mod_shift" = "SUPER SHIFT";
			"$mod_alt" = "SUPER ALT";
	
			bindm = [
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizeactive"
			];

			bind = [
				# system
				"$mod, L, exec, swaylock"
				"$mod, ESCAPE, exec, wlogout"

				# screenshots
				", PRINT, exec, grimblast copy area"
				"SHIFT, PRINT, exec, grimblast copy screen"
				"CTRL, PRINT, exec, grimblast copy active"
			
				# bind application
				"$mod, RETURN, exec, wezterm"
				"$mod, D, exec, rofi -show drun"
				"$mod, W, exec, firefox"
				"$mod, E, exec, nemo"

				# mouse
				"$mod_shift, SPACE, togglefloating"

				# window
				"$mod, Q, killactive"
				"$mod, F, fullscreen, 1"

				# focus
				"$mod, left, movefocus, l"
				"$mod, right, movefocus, r"
				"$mod, up, movefocus, u"
				"$mod, down, movefocus, d"

				# move window
				"$mod_shift, left, movewindow, l"
				"$mod_shift, right, movewindow, r"
				"$mod_shift, up, movewindow, u"
				"$mod_shift, down, movewindow, d"

				
				# workspace
				"$mod, 1, workspace, 1"
				"$mod, 2, workspace, 2"
				"$mod, 3, workspace, 3"
				"$mod, 4, workspace, 4"

				"$mod_shift, 1, movetoworkspace, 1"
				"$mod_shift, 2, movetoworkspace, 2"
				"$mod_shift, 3, movetoworkspace, 3"
				"$mod_shift, 4, movetoworkspace, 4"

				"$mod, mouse_down, workspace, e+1"
				"$mod, mouse_up, workspace, e-1"
			];

			workspace = [
				"1, persistent:true"
				"2, persistent:true"
				"3, persistent:true"
				"4, persistent:true"
			];

			exec-once = [
				"waybar"
				"swaybg -i ~/.config/wallpapers/a_screenshot_of_a_computer.jpg"
			];
		};
	};

	# ------ packages ------
	home.packages = with pkgs; [
		wlogout
		brightnessctl
		swaylock-effects
		swaybg
		xdg-utils

		grimblast
		wl-clipboard
		
		rofi
		pavucontrol	
	];

	home.sessionVariables = {
		ALL_PROXY = "socks5://127.0.0.1:10808";
		HTTP_PROXY = "http://127.0.0.1:10809";
		HTTPS_PROXY = "http://127.0.0.1:10809";

		http_proxy = "http://127.0.0.1:10809";
		https_proxy = "http://127.0.0.1:10809";
		socks_proxy = "socks5://127.0.0.1:10808";

		NO_PROXY = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,::1,*.mail.ru,*.psuti.ru,*.deepseek.com";
	};
}

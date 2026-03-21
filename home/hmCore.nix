{ config, pkgs, ... }:

{
	home = {
		username = "denver";
		homeDirectory = "/home/denver";
		stateVersion = "25.11";
	};

	imports = [
		# ----- System Components -----
    # ./hyprland/hypr.nix
    # ./hyprland/waybar.nix
    ./hyprland/shell.nix
		# ./hyprland/wlogout.nix

		# ----- Applications -----
		./applications/appPackage.nix
	];
}

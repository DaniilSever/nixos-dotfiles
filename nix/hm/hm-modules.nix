{ config, pkgs, ... }:

{
	home = {
		username = "denver";
		homeDirectory = "/home/denver";
		stateVersion = "25.11";
	};

	imports = [
		# ----- System Components -----
		./home/sys/hypr.nix
		./home/sys/waybar.nix
		./home/sys/fonts.nix
		./home/sys/file-manager.nix
		./home/sys/themes.nix
		./home/sys/window-rule.nix

		# ----- Shell -----
		./home/shell/zsh.nix

		# ----- Applications -----
		./home/app/applications.nix
		./home/app/git.nix
	];
}

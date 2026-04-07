{ config, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;
	
	home.packages = with pkgs; [
		dbeaver-bin
		obsidian
		vscode
		vlc
		telegram-desktop
		vesktop
		keepassxc
		prismlauncher
		spotify
		qbittorrent
	];

	imports = [
		./lib/git.nix
	];
}

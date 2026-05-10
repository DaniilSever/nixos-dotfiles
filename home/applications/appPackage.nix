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
		discord
		keepassxc
		spotify
		qbittorrent
		bitwarden-desktop
	];

	imports = [
		./lib/git.nix
	];
}

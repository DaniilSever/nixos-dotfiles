{ config, pkgs, ... }:

{
	programs.zsh = {
		enable = true;

		oh-my-zsh = {
			enable = true;
			theme = "fino";

			plugins = [
				"git"	
			];
		};
		
		shellAliases = {
			update = "sudo nixos-rebuild switch --flake";
			hm-update = "home-manager switch --flake";
		};
	};
}

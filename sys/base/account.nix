{ pkgs, ... }:

{
	users.users.denver = {
		isNormalUser = true;
		description = "Denver";
		shell = pkgs.zsh;
		extraGroups = [ "networkmanager" "wheel" "storage" "dick" ];
	};
}

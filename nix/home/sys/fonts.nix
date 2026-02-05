{ pkgs, ... }:

{
	fonts = {
		fontconfig.enable = true;
	};

	home.packages = with pkgs; [
		nerd-fonts.fira-code
		noto-fonts
		noto-fonts-color-emoji
		font-awesome	
	];
}

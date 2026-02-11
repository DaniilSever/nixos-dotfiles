{
	description = "DS&SW system v.1";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";	
		};
	};

	outputs = { nixpkgs, home-manager, disko, ... }:

	let
		system = "x86_64-linux";
	in
	{
		nixosConfigurations = {
			pc = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [ 
					disko.nixosModules.disko
					./disko.nix
					./sys-conf-pc/core.nix
				];
			};

			laptop = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [ ./sys-conf-laptop/core.nix ];
			};
		};

		homeConfigurations.denver = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [ ./hm/hm-modules.nix ];	
		};
	};
}

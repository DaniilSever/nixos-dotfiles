{
	description = "DS&SW system v.2";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";	
		};
	};

	outputs = { nixpkgs, home-manager, disko, ... }@inputs:

	let
		system = "x86_64-linux";

		settings = import ./settings.nix;
		hostName = "nixos";
		userName = "denver";
	in
	{
		nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
				inherit system;
				
				specialArgs = {
					inherit settings;
				};

				modules = [ 
					disko.nixosModules.disko
					./disko.nix
					./sys/defaultCore.nix
				];
			};

		homeConfigurations.${userName} = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};

			extraSpecialArgs = {
				inherit settings;
			};

			modules = [ ./home/hmCore.nix ];	
		};
	};
}

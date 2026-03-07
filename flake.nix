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
		settings = imports ./settings.nix;
		activeSystemConfig = settings.systems.${settings.activeSystem}
	in
	{
		nixosConfigurations.${activeSystemConfig.hostName} = nixpkgs.lib.nixosSystem {
				inherit system;
				
				specialArgs = {
					inherit settings;
					deviceConfig = activeSystemConfig;
				};

				modules = [ 
					disko.nixosModules.disko
					./disko.nix
					./sys/desktopCore.nix
				];
			};

		homeConfigurations.${settings.user.username} = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};

			extraSpecialArgs = {
				inherit settings
			};

			modules = [ ./home/hmCore.nix ];	
		};
	};
}

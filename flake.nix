{
	description = "DS&SW system v.2";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
		millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";	
		};
	};

	outputs = { nixpkgs, home-manager, disko, millennium, ... }@inputs:

	let
		system = "x86_64-linux";

		hostName = "nixos";
		userName = "denver";
	in
	{
		nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
				inherit system;

				modules = [ 
					disko.nixosModules.disko
					./disko.nix
					./sys/defaultCore.nix
					{ nixpkgs.overlays = [ millennium.overlays.default ]; }
				];
			};

		homeConfigurations.${userName} = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};

			modules = [ ./home/hmCore.nix ];	
		};
	};
}

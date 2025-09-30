{ config, pkgs, ... }:

{  
  imports = [ 
    # -- base imports system --
    ./hardware-configuration.nix  # TODO: switch on disko
    
    # -- my imports system --
    ./nixpkgs/system.nix
    ./nixpkgs/user.nix
    ./nixpkgs/enviroment.nix
    ./nixpkgs/services.nix
    ./nixpkgs/programs.nix
    ./nixpkgs/automount.nix
    # -- home manager --
  ];

  # -- init packages --
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nixpkgs.config.allowUnfree = true;
  security.rtkit.enable = true;

  # --------------------------------
  system.stateVersion = "25.05";
}

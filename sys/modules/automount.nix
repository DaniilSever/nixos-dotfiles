{ config, pkgs, ... }:

{
  services.udisks2.enable = true;

  fileSystems."/home/denver/games" = {
    device = "/dev/disk/by-uuid/f6348656-ee82-46d1-bf67-0af23ca24649";
    fsType = "btrfs";
    options = [
      "defaults"
      "compress=zstd"
      "noatime"
      "space_cache=v2"
      "autodefrag"
      "nofail"
    ];
  };
}
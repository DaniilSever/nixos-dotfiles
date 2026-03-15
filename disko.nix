{ lib, ... }:

let
  disk-id = "/dev/disk/by-id/nvme-KINGSTON_SNV2S250G_50026B768685D05C";
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = disk-id;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            swap = {
              size = "8G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
{ lib, ... }:

let
  lap-disk-id = "/dev/disk/by-id/nvme-INTEL_SSDPEKNW512G8_PHNH052500S3512A";
  pc-disk-id = "/dev/disk/by-id/nvme-KINGSTON_SNV2S250G_50026B768685D05C";
  game-disk-id = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B77857B5634";
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = pc-disk-id;
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

      games = {
        type = "disk";
        device = game-disk-id;
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/games";
              };
            };
          };
        };
      };
    };
  };
}
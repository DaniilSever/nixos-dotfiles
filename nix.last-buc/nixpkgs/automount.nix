{ config, pkgs, ... }:

{
  services.udisks2.enable = true;

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/BC3256783256381A";
    fsType = "ntfs-3g";
    options = [
      "rw"           # чтение и запись
      "uid=1000"
      "gid=100"
      "umask=022"    # права доступа
      "nofail"       # не прерывать загрузку если диск отсутствует
      "windows_names"
    ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/1E0C2AC00C2A9337";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=022"
      "nofail"
      "windows_names"
    ];
  };
}
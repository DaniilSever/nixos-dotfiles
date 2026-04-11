{ config, pkgs, ... }:
let
  win-disk = "/dev/disk/by-uuid/7A28D93228D8EDDF";
  game-disk = "/dev/disk/by-uuid/1E0C2AC00C2A9337";
in
{
  services.udisks2.enable = true;

  fileSystems."/home/denver/win/sys" = {
    device = win-disk;
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

  fileSystems."/home/denver/win/game" = {
    device = game-disk;
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
}
{ config, pkgs, ... }:

{
  services.udisks2.enable = true;

  fileSystems."/home/denver/win" = {
    device = "/dev/disk/by-uuid/7A28D93228D8EDDF";
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
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nemo
    nemo-fileroller
    nemo-seahorse
    nemo-python

    file-roller
    sushi
    eog
    glib-networking
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nemo.desktop" ];
      "application/zip" = [ "file-roller.desktop" ];
      "application/x-tar" = [ "file-roller.desktop" ];
    };
  };

  dconf.settings = {
    "org/nemo/preferences" = {
      show-open-in-terminal-toolbar = true;
      show-edit-icon-toolbar = true;
      date-format = "iso";
      show-hidden-files = false;
      show-new-folder-toolbar = true;
      default-folder-viewer = "list-view";
    };

    "org/nemo/list-view" = {
      default-zoom-level = "small";
    };
  };

  systemd.user.services = {
    gvfs-daemon = {
      Unit = {
        Description = "Virtual filesystem service";
        Requires = [ "dbus.service" ];
        After = [ "dbus.service" ];
      };
      Service = {
        ExecStart = "${pkgs.gvfs}/libexec/gvfsd";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
{ pkgs, lib, ...}:

let
  weztermCfg = import ./terminal/wezterm.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [
    # Терминал
    wezterm
    zsh

    # Шрифты
    nerd-fonts.fira-code
  ];

  home.file.".config/wezterm/wezterm.lua".text = weztermCfg.weztermConfig;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "crunch";
      plugins = [ "git" "docker" "sudo" ];
    };
  };
}
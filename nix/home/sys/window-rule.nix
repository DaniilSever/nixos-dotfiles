# window-rules.nix
{ config, pkgs, ... }:

let
  # Список приложений для плавающего режима
  floatApps = [
    # [ класс, размер, позиция, дополнительные опции ]
    
    [ "org.telegram.desktop" "1140 742" "center" "" ]
    [ "org.pulseaudio.pavucontrol" "600 400" "center" "" ]
    [ "org.keepassxc.KeePassXC" "900 600" "center" "pin" ]
    [ "DBeaver" "1200 800" "center" "" ]
    [ "vlc" "800 500" "50% 50%" "" ]
    [ "nemo" "900 600" "center" "" ]
    [ "PortProton" "" "" "" ]
    [ "portproton" "" "" "" ]
  ];
  
  # Генерация правил из списка
  generateRules = apps: builtins.concatLists (map (app: 
    let
      className = builtins.elemAt app 0;
      size = builtins.elemAt app 1;
      position = builtins.elemAt app 2;
      extra = builtins.elemAt app 3;
    in
      [
        "float, class:^(${className})$"
      ] ++
      (if size != "" then [ "size ${size}, class:^(${className})$" ] else []) ++
      (if position != "" then [ "move ${position}, class:^(${className})$" ] else []) ++
      (if extra != "" then [ "${extra}, class:^(${className})$" ] else [])
  ) apps);
  
in
{
  wayland.windowManager.hyprland.settings.windowrulev2 = 
    (generateRules floatApps) ++ [
      # Общие правила для всех плавающих окон
      "noborder, floating:1"
      "rounding 12, floating:1"
      "opacity 0.97 0.90, floating:1"
    ];
}
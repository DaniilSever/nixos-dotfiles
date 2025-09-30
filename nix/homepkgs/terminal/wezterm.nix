{ pkgs }:

let
  weztermConfig = ''
    local wezterm = require "wezterm"

    return {
      -- Цвет (Тема)
      color_scheme = 'Gruvbox Dark (Gogh)';

      -- Шрифт
      font = wezterm.font("FiraCode Nerd Font");
      font_size = 11.0;
      line_height = 1.0;

      -- Вкладки
      tab_bar_at_bottom = true;

      -- Окно по умолчанию
      initial_cols = 80;
      initial_rows = 24;

      -- Отступы окна
      window_padding = {
        left = 2;
        right = 2;
        top = 2;
        bottom = 2;
      };
    }
  '';
in {
  inherit weztermConfig;
}
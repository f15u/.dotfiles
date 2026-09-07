{...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "IoskeleyMonoTerm Nerd Font Mono";
      size = 13;
    };

    # GitHub Dark Default (github-vscode-theme).
    settings = {
      background = "#0d1117";
      foreground = "#e6edf3";
      selection_background = "#264f78";
      selection_foreground = "#e6edf3";
      url_color = "#39c5cf";
      cursor = "#e6edf3";
      cursor_text_color = "#0d1117";

      active_tab_background = "#58a6ff";
      active_tab_foreground = "#0d1117";
      inactive_tab_background = "#161b22";
      inactive_tab_foreground = "#6e7681";

      active_border_color = "#58a6ff";
      inactive_border_color = "#161b22";

      # Security: disable remote control and network listener.
      allow_remote_control = "no";
      listen_on = "none";

      color0 = "#484f58";
      color1 = "#ff7b72";
      color2 = "#3fb950";
      color3 = "#d29922";
      color4 = "#58a6ff";
      color5 = "#bc8cff";
      color6 = "#39c5cf";
      color7 = "#b1bac4";

      color8 = "#6e7681";
      color9 = "#ffa198";
      color10 = "#56d364";
      color11 = "#e3b341";
      color12 = "#79c0ff";
      color13 = "#d2a8ff";
      color14 = "#56d4dd";
      color15 = "#f0f6fc";
    };

    # Slashed zero. `font_features` keys on the PostScript name, per style.
    extraConfig = ''
      font_features IoskeleyMonoTermNFM +zero
      font_features IoskeleyMonoTermNFM-Bold +zero
      font_features IoskeleyMonoTermNFM-Italic +zero
      font_features IoskeleyMonoTermNFM-BoldItalic +zero
    '';
  };
}

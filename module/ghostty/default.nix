{...}: {
  programs.ghostty = {
    enable = true;

    settings = {
      font-family = "IoskeleyMonoTerm Nerd Font Mono";
      font-size = 14;

      # Slashed zero.
      font-feature = "zero";

      # GitHub Dark Default (github-vscode-theme).
      background = "#0d1117";
      foreground = "#e6edf3";
      selection-background = "#264f78";
      selection-foreground = "#e6edf3";
      cursor-color = "#e6edf3";
      cursor-text = "#0d1117";

      palette = [
        "0=#484f58"
        "1=#ff7b72"
        "2=#3fb950"
        "3=#d29922"
        "4=#58a6ff"
        "5=#bc8cff"
        "6=#39c5cf"
        "7=#b1bac4"
        "8=#6e7681"
        "9=#ffa198"
        "10=#56d364"
        "11=#e3b341"
        "12=#79c0ff"
        "13=#d2a8ff"
        "14=#56d4dd"
        "15=#f0f6fc"
      ];
    };
  };
}

{
  pkgs,
  lib,
  ...
}: {
  environment.cinnamon.excludePackages = [
    pkgs.celluloid
  ];

  services.gnome.gnome-online-accounts.enable = true;

  # ── Multi-monitor taskbar: per-monitor windows ──────────────────────
  #
  # Cinnamon's Grouped Window List applet supports showing only
  # windows from the current monitor OUT OF THE BOX.  No patching,
  # no third-party applets needed.
  #
  # Quick interactive setup (1 min):
  #   1. Right-click panel → "Panel Settings" → "Add new panel"
  #      Pick the second monitor; a new empty panel appears.
  #   2. Right-click the new panel → "Add applets" →
  #      add "Grouped Window List".
  #   3. Right-click any app icon in the grouped window list →
  #      "Applet preferences" → "Show windows from other monitors"
  #      → "Only from monitors without a window list"  ← DEFAULT
  #
  # That's it.  Each monitor's taskbar now shows only windows on
  # that monitor.  Windows moved to the other monitor disappear
  # from the first monitor's taskbar automatically.
  #
  # Declarative equivalent (dconf) – see home.nix.
  #
  # ── Alt-Tab per-monitor (bonus) ─────────────────────────────────────
  # Cinnamon Settings → Windows → Alt-Tab → enable
  # "Show windows from current monitor" for per-monitor alt-tab.
  #
}


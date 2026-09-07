{
  config,
  ...
}: let
  # Out-of-store symlink -> repo working tree (same pattern as ai-skills).
  # Cinnamon/Muffin reads ~/.config/cinnamon-monitors.xml through the link,
  # so the pinned layout stays git-tracked.
  #
  # Layout:
  #   DP-0  3440x1440  TOP     at 0,0
  #   DP-2  1920x1080  PRIMARY, BOTTOM at 760,1440   # 760 = (3440-1920)/2
  #
  # Read path is reliable. GUI display changes write with a backup rename,
  # which replaces the symlink with a plain file (edits go to ~/.config,
  # not the repo); rerun `switch` to restore the link.
  repoDir = "${config.home.homeDirectory}/.dotfiles/module/cinnamon";
in {
  xdg.configFile."cinnamon-monitors.xml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/cinnamon-monitors.xml";
    force = true;
  };
}

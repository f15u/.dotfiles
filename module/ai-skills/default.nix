{
  config,
  pkgs,
  lib,
  ...
}: let
  # Vendored content lives in the repo working tree. Deployed as out-of-store
  # symlinks so edits (e.g. `pnpm skills add`) write straight back into the
  # repo (then `git add` + `switch`). One home dir maps 1:1 to one vendored dir.
  repoDir = "${config.home.homeDirectory}/.dotfiles/module/ai-skills";
  linkRepo = rel: config.lib.file.mkOutOfStoreSymlink "${repoDir}/${rel}";
  linkSkills = sub: linkRepo "skills/${sub}";
in {
  # Writable symlinks -> repo working tree.
  home.file = {
    ".agents/skills".source = linkSkills "agents";
    ".claude/skills".source = linkSkills "claude";
    ".claude/output-styles".source = linkRepo "output-styles";
    # User-global CLAUDE.md at the default path Claude Code reads.
    ".claude/CLAUDE.md" = {
      source = linkRepo "CLAUDE.md";
      force = true;
    };
    # rtk instructions (referenced via @RTK.md in CLAUDE.md).
    # ".claude/RTK.md" = {
    #   source = linkRepo "RTK.md";
    #   force = true;
    # };
  };

  # settings.json is rewritten atomically by Claude Code (write tmp + rename).
  # A home.file symlink resolves one hop into the read-only store dir, so the
  # tmp write fails EROFS. Emit a direct single-hop symlink to the repo file
  # instead: the resolved parent is the writable repo dir, so atomic writes
  # succeed and land back in the working tree (commit-back preserved).
  home.activation.claudeSettingsLink = lib.hm.dag.entryAfter ["linkGeneration"] ''
    run ln -sfn "${repoDir}/claude-settings.json" "${config.home.homeDirectory}/.claude/settings.json"
  '';

  xdg.configFile."opencode/skills".source = linkSkills "agents";

  home.packages = [pkgs.pnpm];
}

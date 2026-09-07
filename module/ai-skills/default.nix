{
  config,
  pkgs,
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
    # User-global CLAUDE.md at the default path Claude Code reads.
    ".claude/CLAUDE.md" = {
      source = linkRepo "CLAUDE.md";
      force = true;
    };
  };

  xdg.configFile."opencode/skills".source = linkSkills "agents";

  home.packages = [pkgs.pnpm];
}

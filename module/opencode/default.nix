{ config, pkgs, inputs, ... }:
let
  # Out-of-store symlink so opencode's runtime writes (e.g. sidebar state) land
  # back in the repo working tree. `git add` + `switch` when you want to keep them.
  repoDir = "${config.home.homeDirectory}/.dotfiles/module/opencode";
  link = rel: config.lib.file.mkOutOfStoreSymlink "${repoDir}/${rel}";

  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  # Alias opencode2 as `opencode`.
  opencode = pkgs.symlinkJoin {
    name = "opencode";
    paths = [ agents.opencode2 ];
    postBuild = "ln -s $out/bin/opencode2 $out/bin/opencode";
  };
in
{
  home.packages = [
    agents.herdr
    agents.pi
    opencode
  ];

  xdg.configFile."caveman/config.json".source =
    (pkgs.formats.json { }).generate "caveman-config.json"
      { defaultMode = "ultra"; };

  xdg.configFile."opencode/cli.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/cli.json";
    force = true;
  };

  xdg.configFile."opencode/opencode.json".source =
    (pkgs.formats.json { }).generate "opencode-config.json" {
      "$schema" = "https://opencode.ai/config.json";
      autoupdate = false;
      disabled_providers = [ "openai" "copilot" ];
      plugins = [ "./plugins/caveman" ];
    };

  # caveman opencode integration. Official payload lives in the repo working
  # tree (installed via `node bin/install.js --only opencode` with
  # XDG_CONFIG_HOME pointed here); these out-of-store symlinks expose it to
  # opencode and keep both the payload and runtime writes git-tracked.
  # `skills` is owned by the ai-skills module, so it is not symlinked here.
  xdg.configFile."opencode/plugins".source = link "plugins";
  xdg.configFile."opencode/commands".source = link "commands";
  xdg.configFile."opencode/agents".source = link "agents";
  xdg.configFile."opencode/AGENTS.md".source = link "AGENTS.md";
}

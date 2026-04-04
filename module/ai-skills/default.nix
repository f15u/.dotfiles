{
  pkgs,
  lib,
  inputs,
  ...
}: let
  aiSkillsRepo = inputs.ai-skills;
  claudeProjectDir = "/home/f15u/.claude/projects/-home-f15u-OpenSource-f15u-ai-skills";

  # Files that should be managed by Nix and made immutable
  managedFiles = {
    "CLAUDE.md" = {
      source = "${aiSkillsRepo}/CLAUDE.md";
      target = "${claudeProjectDir}/CLAUDE.md";
    };
  };

  # Create a script to set immutable attributes on managed files
  makeImmutableScript = pkgs.writeShellScript "make-ai-skills-immutable" ''
    # Set immutable attribute on managed files
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: attrs: ''
        if [ -f "${attrs.target}" ]; then
          echo "Setting immutable flag on ${attrs.target}"
          sudo chattr +i "${attrs.target}"
        fi
      '')
      managedFiles)}
  '';
in {
  # Deploy managed files from the repository
  home.file =
    lib.mapAttrs' (name: attrs: {
      name = attrs.target;
      value = {
        source = attrs.source;
        onChange = ''
          # Remove immutable flag temporarily to allow file update
          if [ -f "${attrs.target}" ]; then
            sudo chattr -i "${attrs.target}" 2>/dev/null || true
          fi

          # Set immutable flag after update
          sudo chattr +i "${attrs.target}" 2>/dev/null || true
        '';
      };
    })
    managedFiles
    // {
      # Ensure the target directory exists and is writable
      "${claudeProjectDir}/.keep".text = "";
    };

  # Add a script to manually restore immutable attributes
  home.packages = [
    (pkgs.writeShellScriptBin "restore-ai-skills-immutable" ''
      echo "Restoring immutable attributes to managed ai-skills files..."
      ${makeImmutableScript}
    '')
  ];

  # Ensure the local project directory has proper permissions
  systemd.user.services.ai-skills-permissions = {
    Unit = {
      Description = "Set proper permissions for ai-skills project directory";
      After = ["home-manager-path.service"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'chmod 755 ${claudeProjectDir} && chown f15u:users ${claudeProjectDir}'";
    };
  };
}

# /etc is the only place Claude reads managed settings but never writes them.
# A read-only ~/.claude/settings.json hits data-loss bug claude-code#88307, and
# home-manager cannot own /etc, so this is NixOS, not the HM module (./default.nix).
{...}: {
  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    disableRemoteControl = true;
    includeCoAuthoredBy = false;

    # "" hides the commit/PR attribution; sessionUrl drops the session link.
    attribution = {
      commit = "";
      pr = "";
      sessionUrl = false;
    };

    # Stable policy. Claude never writes /etc, so these survive the atomic-write
    # bug that read-only ~/.claude/settings.json triggers. Volatile/UI-mutated
    # keys (model, effortLevel, theme, plugins) stay in the writable user file.
    skipAutoPermissionPrompt = true;
    spinnerTipsEnabled = false;
    promptSuggestionEnabled = false;
    awaySummaryEnabled = false;
    preferredNotifChannel = "notifications_disabled";
    fileCheckpointingEnabled = false;
    terminalProgressBarEnabled = false;
    autoConnectIde = false;
    worktree.baseRef = "fresh";

    permissions = let
      mutating = [
        "create" "edit" "comment" "merge" "close" "reopen" "review" "delete" "ready"
        "lock" "unlock" "transfer" "rename" "archive" "unarchive" "fork" "sync"
        "set" "add" "remove" "run" "rerun" "cancel" "enable" "disable" "develop"
        "update-branch" "install" "upgrade" "login" "logout" "refresh" "import"
      ];
      apiWriteFlags = ["-X" "--method" "-f" "-F" "--field" "--raw-field" "--input"];
    in {
      allow = [
        "Bash(gh * view*)" "Bash(gh * list*)" "Bash(gh * status*)" "Bash(gh * diff*)"
        "Bash(gh * checks*)" "Bash(gh search:*)" "Bash(gh api:*)"
      ];
      # ask beats allow, so mutating gh calls always prompt.
      ask =
        map (v: "Bash(gh * ${v}*)") mutating
        ++ map (f: "Bash(gh api* ${f}*)") apiWriteFlags;
    };

    hooks = {
      SessionStart = [
        {
          matcher = "*";
          hooks = [
            {
              type = "command";
              command = "bash '/home/f15u/.claude/hooks/herdr-agent-state.sh' session";
              timeout = 10;
            }
          ];
        }
      ];
    };

    env = {
      CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      DISABLE_TELEMETRY = "1";
      DO_NOT_TRACK = "1";
      DISABLE_GROWTHBOOK = "1";
      DISABLE_ERROR_REPORTING = "1";
      DISABLE_AUTOUPDATER = "1";
      DISABLE_FEEDBACK_COMMAND = "1";
      CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY = "1";
      CLAUDE_CODE_DISABLE_OFFICIAL_MARKETPLACE_AUTOINSTALL = "1";
      DISABLE_BUG_COMMAND = "1";
      DISABLE_NON_ESSENTIAL_MODEL_CALLS = "1";
    };
  };
}

# /etc is the only place Claude reads managed settings but never writes them.
# A read-only ~/.claude/settings.json hits data-loss bug claude-code#88307, and
# home-manager cannot own /etc, so this is NixOS, not the HM module (./default.nix).
{...}: {
  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    disableRemoteControl = true;

    # "" hides the commit/PR attribution; sessionUrl drops the session link.
    attribution = {
      commit = "";
      pr = "";
      sessionUrl = false;
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

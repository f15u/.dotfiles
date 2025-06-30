{
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["f15u"];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        librewolf
      '';
      mode = "0755";
    };
  };
}

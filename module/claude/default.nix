{
  pkgs,
  inputs,
  ...
}: {
  home.packages =
    (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-code
    ])
    ++ (with pkgs; [
      nodejs_24 # Needed for caveman claude's skill
    ]);
}

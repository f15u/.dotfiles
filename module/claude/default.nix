{pkgs, inputs, ...}: {
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    claude-code
  ];

  home.file.".claude/skills".source = "${inputs.ai-skills}/.claude/skills";
}

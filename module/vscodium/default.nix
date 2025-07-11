{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      # https://gist.github.com/danielroe/5ea82608dc680fe6c0179240803437ab
      userSettings = {
        "[svelte]" = {
          "editor.defaultFormatter" = "svelte.svelte-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };

        "editor.inlayHints.maximumLength" = 0;
        "editor.fontFamily" = "'Fragment Mono', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        "editor.lineHeight" = 1.75;
        "editor.minimap.scale" = 1;
        "editor.minimap.renderCharacters" = false;
        "editor.minimap.size" = "fit";
        "editor.minimap.showSlider" = "always";
        "editor.pasteAs.enabled" = false;
        "editor.renderWhitespace" = "boundary";
        "editor.rulers" = [
          {
            "column" = 80;
            "color" = "#191919";
          }
          {
            "column" = 100;
            "color" = "#333";
          }
        ];
        "editor.stickyScroll.enabled" = false;
        "editor.snippetSuggestions" = "none";
        "editor.suggest.showWords" = false;
        "editor.suggestSelection" = "first";
        "editor.tabSize" = 2;
        "editor.wordWrap" = "bounded";
        "editor.wordWrapColumn" = 100;

        "explorer.fileNesting.patterns" = {
          "*.ts" = "\${capture}.test.ts, \${capture}.test-d.ts, \${capture}.spec.ts, \${capture}.bench.ts, \${capture}.js, \${capture}.typegen.ts, \${capture}.bru";
          "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
          "*.jsx" = "\${capture}.js";
          "*.tsx" = "\${capture}.ts, \${capture}.typegen.ts";
          "tsconfig.json" = "tsconfig.*.json";
          "package.json" = "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb";
          "pnpm-lock.yaml" = "pnpm-workspace.yaml";
        };

        "files.autoSave" = "onFocusChange";
        "files.hotExit" = "onExitAndWindowClose";

        "git.autofetch" = true;
        "git.fetchOnPull" = true;
        "git.pruneOnFetch" = true;

        "scm.defaultViewMode" = "tree";

        "search.defaultViewMode" = "tree";

        "terminal.integrated.allowChords" = false;
        "terminal.integrated.fontLigatures" = true;
        "terminal.integrated.gpuAcceleration" = "on";
        "terminal.integrated.showExitAlert" = false;
        "terminal.integrated.sendKeybindingsToShell" = false;

        "update.mode" = "none";

        "window.commandCenter" = false;

        "workbench.colorTheme" = "Default Dark Modern";
        "workbench.editor.languageDetection" = false;
        "workbench.editor.customLabels.patterns" = {
          "**/+*" = "\${dirname} (\${filename}.\${extname})";
        };
        "workbench.iconTheme" = "vs-minimal";
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.editor.showIcons" = false;
        "workbench.editor.tabSizing" = "shrink";
        "workbench.sideBar.location" = "right";

        # Extensions
        "biome.suggestInstallingGlobally" = false;

        "svelte.enable-ts-plugin" = true;

        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "alejandra";
        "nix.serverSettings"."nil"."formatting"."command" = [
          "alejandra"
        ];
      };

      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        biomejs.biome
        dbaeumer.vscode-eslint
        svelte.svelte-vscode
        orta.vscode-twoslash-queries
        mk12.better-git-line-blame
      ];
    };
  };
}

{ pkgs, ... }: {
  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      userSettings = {
        "chat.disableAIFeatures" = true;

        "editor.acceptSuggestionOnCommitCharacter" = false;
        "editor.experimentalGpuAcceleration" = "off";
        "editor.experimental.asyncTokenization" = true;
        # "editor.inlayHints.maximumLength" = 0;
        # Term variant: arrows/box glyphs stay inside their cell (Mono overflows).
        "editor.fontFamily" = "'IoskeleyMonoTerm Nerd Font Mono', monospace";
        "editor.fontSize" = 18;
        # Ioskeley builds with noCvSs → no ss/cv features. Only calt + zero.
        "editor.fontLigatures" = "'calt', 'zero'";
        "editor.inlayHints.enabled" = "offUnlessPressed";
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
        "editor.snippetSuggestions" = "none";
        "editor.smartSelect.selectSubwords" = true;
        "editor.smoothScrolling" = true;
        "editor.stickyScroll.enabled" = false;
        "editor.suggest.showWords" = false;
        "editor.suggestSelection" = "first";
        "editor.tabSize" = 2;
        "editor.wordWrap" = "bounded";
        "editor.wordWrapColumn" = 100;

        "explorer.fileNesting.enabled" = true;
        "explorer.fileNesting.patterns" = {
          "*.ts" =
            "\${capture}.test.ts, \${capture}.test-d.ts, \${capture}.spec.ts, \${capture}.spec-d.ts, \${capture}.bench.ts, \${capture}.js, \${capture}.typegen.ts";
          "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
          "*.jsx" = "\${capture}.js";
          "*.tsx" = "\${capture}.ts, \${capture}.typegen.ts";
          "tsconfig.json" = "tsconfig.*.json";
          "package.json" = "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb";
          "pnpm-lock.yaml" = "pnpm-workspace.yaml";
        };

        "emmet.showExpandedAbbreviation" = "never";

        "extensions.autoCheckUpdates" = false;
        "extensions.ignoreRecommendations" = true;

        "files.autoSave" = "onFocusChange";
        "files.hotExit" = "onExitAndWindowClose";

        "git.autofetch" = true;
        "git.fetchOnPull" = true;
        "git.pruneOnFetch" = true;

        "json.schemaDownload.trustedDomains" = {
          "https://www.schemastore.org/" = true;
        };

        "npm.fetchOnlinePackageInfo" = false;

        "scm.defaultViewMode" = "tree";

        "search.defaultViewMode" = "tree";

        "terminal.integrated.initialHint" = false;
        "terminal.integrated.allowChords" = false;
        "terminal.integrated.gpuAcceleration" = "on";
        "terminal.integrated.fontFamily" = "'IoskeleyMonoTerm Nerd Font Mono', monospace";
        "terminal.integrated.fontLigatures.enabled" = false;
        # "terminal.integrated.fontLigatures.featureSettings" = "'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'cv02', 'cv03', 'cv06', 'cv07', 'cv09', 'cv11'";
        "terminal.integrated.fontSize" = 16;
        "terminal.integrated.showExitAlert" = false;
        "terminal.integrated.stickyScroll.enabled" = false;
        "terminal.integrated.suggest.enabled" = false;

        "telemetry.telemetryLevel" = "off";
        # "telemetry.enableCrashReporter" = false;
        # "telemetry.enableTelemetry" = false;
        "telemetry.feedback.enabled" = false;

        "typescript.enablePromptUseWorkspaceTsdk" = true;
        "typescript.disableAutomaticTypeAcquisition" = true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "typescript.inlayHints.parameterNames.enabled" = "literals";
        "typescript.inlayHints.parameterTypes.enabled" = true;
        "typescript.inlayHints.variableTypes.enabled" = true;
        "typescript.preferences.importModuleSpecifier" = "relative";

        # "update.enableWindowsBackgroundUpdates" = false;
        "update.mode" = "none";

        "window.commandCenter" = false;
        "window.menuBarVisibility" = "toggle";
        "window.titleBarStyle" = "native";

        "workbench.colorTheme" = "GitHub Dark Colorblind (Beta)";
        "workbench.editor.customLabels.patterns" = {
          "**/+*" = "\${dirname} (\${filename}.\${extname})";
        };
        "workbench.editor.empty.hint" = "hidden";
        "workbench.editor.enablePreview" = false;
        "workbench.editor.languageDetection" = false;
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.editor.showIcons" = false;
        "workbench.editor.tabSizing" = "shrink";
        "workbench.editor.untitled.labelFormat" = "name";
        "workbench.enableExperiments" = false;
        "workbench.iconTheme" = "vs-minimal";
        "workbench.layoutControl.enabled" = false;
        "workbench.secondarySideBar.defaultVisibility" = "hidden";
        "workbench.settings.enableNaturalLanguageSearch" = false;
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
        "workbench.tree.enableStickyScroll" = false;

        # Languages
        # "[svelte]" = {
        #   "editor.defaultFormatter" = "svelte.svelte-vscode";
        # };

        # Extensions
        "biome.suggestInstallingGlobally" = false;
        "biome.requireConfiguration" = true;

        "direnv.watchForChanges" = false;

        # "files.associations" = {
        #   "*.css" = "css";
        # };

        "nix.enableLanguageServer" = true;

        "orta.vscode-twoslash-queries.maxLength" = 9999;

        "svelte.enable-ts-plugin" = true;
      };

      extensions =
        with pkgs.open-vsx;
        [
          antfu.unocss
          astro-build.astro-vscode
          # bmewburn.vscode-intelephense-client
          # bradlc.vscode-tailwindcss
          # dbaeumer.vscode-eslint
          # denoland.vscode-deno
          # dprint.dprint
          esbenp.prettier-vscode
          github.github-vscode-theme
          jnoortheen.nix-ide
          matthewpi.caddyfile-support
          # matiasolivera.universe
          mk12.better-git-line-blame
          mkhl.direnv
          # monotykamary.vscode-aql
          # nefrob.vscode-just-syntax
          oxc.oxc-vscode
          pflannery.vscode-versionlens
          # runem.lit-plugin
          # svelte.svelte-vscode
          # thebearingedge.vscode-sql-lit
          unifiedjs.vscode-mdx
        ]
        ++ (with pkgs.vscode-marketplace; [
          atoolz.htmx-vscode-toolkit # open-vsx missing
          orta.vscode-twoslash-queries # open-vsx behind
        ])
      # ++ [
      #   # nightly — nix-vscode-extensions cache stale, old VSIX purged from CDN
      #   # manually pinned to current version; update hash periodically
      #   (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      #     mktplcRef = {
      #       name = "native-preview";
      #       publisher = "TypeScriptTeam";
      #       version = "0.20260708.2";
      #       sha256 = "sha256-oDt296OEoPd/gerUzpkjMLrrAM0LQ9+W/5KJWx3tBmY=";
      #     };
      #     meta = {
      #       description = "TypeScript and JavaScript language support powered by the native TypeScript language server";
      #       license = pkgs.lib.licenses.mit;
      #     };
      #   })
      # ]
      ;
    };
  };
}

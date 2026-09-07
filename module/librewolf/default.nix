{
  pkgs,
  config,
  ...
}:
{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-bin;

    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
        Install = [
          # TODO: use `mkcert -CAROOT`
          "${config.home.homeDirectory}/.local/share/mkcert/rootCA.pem"
        ];
      };

      "3rdparty" = {
        Extensions = {
          "CanvasBlocker@kkapsner.de" = {
            blockMode = "fake";
            showNotifications = false;
          };
        };
      };

      Permissions = {
        Autoplay = {
          Default = "block-audio-video";
          Locked = true;
        };
      };

      Preferences = {
        "privacy.fingerprintingProtection" = {
          Value = false;
          Status = "locked";
        };
      };
    };

    profiles.default = {
      settings = {
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "browser.contentblocking.category" = "strict";
        "browser.chrome.guess_favicon" = false;
        "browser.discovery.containers.enabled" = false;
        "browser.fixup.alternate.enabled" = false;
        "browser.laterrun.bookkeeping.sessionCount" = 1;
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.ml.linkPreview.longPress" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.policies.runOncePerModification.removeSearchEngines" = builtins.toJSON [
          "Amazon.com"
          "Bing"
          "DuckDuckGo"
          "DuckDuckGo Lite"
          "eBay"
          "Google"
          "SearXNG - searx.be"
          "Startpage"
          "Twitter"
        ];
        "browser.startup.page" = 3; # Restore previous session
        "browser.startup.couldRestoreSession.count" = 2;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.tabs.inTitlebar" = 0;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.enable" = false;
        "browser.translations.panelShown" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.topsites.contile.cachedTiles" = "[]";
        "browser.uidensity" = 0;
        "browser.uiCustomization.horizontalTabstrip" = builtins.toJSON [
          # "tabbrowser-tabs"
          "new-tab-button"
          # "alltabs-button"
        ];
        "browser.uiCustomization.navBarWhenVerticalTabs" = builtins.toJSON [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "home-button"
          "customizableui-special-spring1"
          "vertical-spacer"
          "urlbar-container"
          "customizableui-special-spring2"
          "downloads-button"
          "fxa-toolbar-menu-button"
          "unified-extensions-button"
          "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
          "sidebar-button"
        ];
        "browser.urlbar.autoFill" = true;
        "browser.urlbar.autoFill.adaptiveHistory.enabled" = true;
        "browser.urlbar.oneOffSearches" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.scotchBonnet.enableOverride" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.topsites" = false;

        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;

        "datareporting.healthreport.uploadEnabled" = false;

        "devtools.accessibility.enabled" = false;

        "dom.ipc.processCount" = 16;
        "dom.security.https_only_mode" = true;
        "dom.w3c_touch_events.enabled" = 0;
        "dom.webnotifications.enabled" = false;
        "dom.webnotifications.serviceworker.enabled" = false;
        "dom.push.connection.enabled" = false;
        "dom.push.enabled" = false;
        "dom.reporting.enabled" = false;

        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "extensions.autoDisableScopes" = 0;
        "extensions.colorway-builtin-themes-cleanup" = 1;
        "extensions.pocket.enabled" = false;
        "extensions.update.enabled" = false;

        "full-screen-api.warning.timeout" = 1;

        "geo.enabled" = false;

        "gfx.webrender.all" = true;
        "gfx.webrender.compositor" = true;
        "gfx.webrender.compositor.force-enabled" = true;
        "gfx.webrender.enabled" = true;
        "gfx.webrender.max-filter-ops-per-subpass" = 128;
        "gfx.webrender.precise-shader-matching" = true;

        "gfx.canvas.accelerated" = true;
        "gfx.canvas.accelerated.cache-items" = 4096;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.azure.backends" = "skia";
        "gfx.content.azure.skia-use-ctx-locks" = true;

        "identity.fedcm.enabled" = false;
        "identity.fxaccounts.enabled" = false;

        "intl.locale.requested" = "en-GB,en-US";

        "keyword.enabled" = false;

        "image.decode-immediately.enabled" = true;

        "layers.acceleration.force-enabled" = true;

        "media.autoplay.default" = 5;
        "media.autoplay.blocking_policy" = 2;
        "media.hardwaremediakeys.enabled" = false;
        "media.hardware-video-decoding.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.peerconnection.enabled" = false;

        "middlemouse.paste" = false;

        "messaging-system.rsexperimentloader.enabled" = false;

        "network.cookie.CHIPS.enabled" = true;
        "network.cookie.cookieBehavior.optInPartitioning" = true;
        "network.http.altsvc.enabled" = true;
        "network.http.altsvc.oe" = true;
        "network.http.http3.enabled" = true;
        "network.trr.custom_uri" = "https://dns.nextdns.io/cccfa6";
        "network.trr.mode" = 3; # STRICT = 3; DEFAULT = 5
        "network.trr.uri" = "https://dns.nextdns.io/cccfa6";

        "permissions.default.geo" = 2; # UNKNOWN = 0; ALLOW = 1; DENY = 2; PROMPT = 3;
        "permissions.default.canvas" = 2; # DENY = 2
        "permissions.default.persistent-storage" = 2; # DENY = 2, no prompt
        "privacy.fingerprintingProtection.overrides" =
          "+AllTargets,-CanvasImageExtractionPrompt,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate";

        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearHistory.cookiesAndStorage" = false;
        "privacy.clearSiteData.cookiesAndStorage" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.userContext.enabled" = false;

        "security.csp.reporting.enabled" = false;
        # Route passkey (WebAuthn) handling to password-manager extensions
        # (Bitwarden/1Password/Proton Pass) instead of the browser UI.
        # No native platform authenticator exists on Linux; the "native ask"
        # comes from the hardware-token dialog and the conditional-mediation
        # autofill, both disabled here so only extensions can answer.
        "security.webauth.webauthn_enable_usbtoken" = false;
        "security.webauthn.enable_conditional_mediation" = false;

        "sidebar.verticalTabs" = true;
        "signon.rememberSignons" = false;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.pioneer-new-studies-available" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;

        "view_source.wrap_long_lines" = true;

        "webgl.disabled" = false;
        "webgl.enable-webgl2" = true;

        "widget.use-xdg-desktop-portal" = true;
        "widget.gtk.native-emoji-dialog" = false;
        "widget.wayland-dmabuf-vaapi.enabled" = true;
      };

      # https://gist.github.com/abelcheung/0229ee3ab896feac8126f40eb1405996
      # https://css-tricks.com/messing-with-firefoxs-view-source-css-file/
      # https://support.mozilla.org/si/questions/1276606
      userChrome = builtins.readFile ./configuration/userChrome.css;

      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          canvasblocker
          consent-o-matic
          github-issue-link-status
          # knockoff-amazon-brand-filter
          onepassword-password-manager
          react-devtools
          refined-github
          proton-pass
          sponsorblock
        ];
      };
    };
  };
}

{
  pkgs,
  config,
  ...
}: {
  # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.extensions.packages
  #https://git.sr.ht/~rycee/configurations/tree/5b6582462725ef5938d9ae44b03e8c378d7a129f/item/user/firefox.nix?__goaway_challenge=meta-refresh&__goaway_id=11a59c125149b26ff81cacd4fb48770a&__goaway_referer=https%3A%2F%2Fwww.reddit.com%2F
  # https://git.sr.ht/~johnhamelink/nix/tree/master/item/home/modules/librewolf/default.nix
  programs.librewolf = {
    enable = true;

    # ls ~/.librewolf/native-messaging-hosts
    # package = pkgs.librewolf.override {
    #   # https://github.com/nix-community/home-manager/pull/5684
    #   # https://github.com/nix-community/home-manager/issues/5190
    #   # https://librewolf.net/docs/faq/#how-do-i-get-native-messaging-to-work-1
    #   nativeMessagingHosts = with pkgs; [
    #     _1password-gui
    #   ];
    # };

    nativeMessagingHosts = with pkgs; [
      _1password-gui
    ];

    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
        Install = [
          # TODO: use `mkcert -CAROOT`
          "${config.home.homeDirectory}/.local/share/mkcert/rootCA.pem"
        ];
      };
    };

    profiles.default = {
      settings = {
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "browser.contentblocking.category" = "strict";
        "browser.discovery.containers.enabled" = false;
        "browser.laterrun.bookkeeping.sessionCount" = 1;
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
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
        "browser.startup.couldRestoreSession.count" = 2;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.enable" = false;
        "browser.translations.panelShown" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.topsites.contile.cachedTiles" = "[]";
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
          # "save-to-pocket-button"
          "downloads-button"
          "fxa-toolbar-menu-button"
          "unified-extensions-button"
          # "ublock0_raymondhill_net-browser-action"
          "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
          # "alltabs-button"
          "sidebar-button"
        ];
        # "browser.uiCustomization.state" = builtins.readFile ./toolbar.json;
        "browser.urlbar.oneOffSearches" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.scotchBonnet.enableOverride" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.topsites" = false;

        "datareporting.healthreport.uploadEnabled" = false;

        "devtools.accessibility.enabled" = false;

        "dom.ipc.processCount" = 8;
        "dom.security.https_only_mode" = true;
        "dom.w3c_touch_events.enabled" = 0;

        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;

        "full-screen-api.warning.timeout" = 1;

        "gfx.webrender.software" = true;

        "identity.fxaccounts.enabled" = false;

        "intl.locale.requested" = "en-GB,en-US,it-IT";

        "layers.acceleration.disabled" = true;

        "media.hardwaremediakeys.enabled" = false;
        "media.hardware-video-decoding.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.peerconnection.enabled" = false;

        "middlemouse.paste" = false;

        "messaging-system.rsexperimentloader.enabled" = false;

        "network.trr.custom_uri" = "https://dns.nextdns.io/cccfa6";
        "network.trr.mode" = 3; # Strict
        "network.trr.uri" = "https://dns.nextdns.io/cccfa6";

        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearHistory.cookiesAndStorage" = false;
        "privacy.clearSiteData.cookiesAndStorage" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC"; # https://bitwilli.com/enable-dark-theme-in-librewolf
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.userContext.enabled" = false;

        "sidebar.verticalTabs" = true;
        "signon.rememberSignons" = false;

        "toolkit.telemetry.pioneer-new-studies-available" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;

        "view_source.wrap_long_lines" = true;

        "webgl.disabled" = true;
      };

      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          refined-github
          onepassword-password-manager
          # github-issue-link-status
        ];
      };
    };
  };
}

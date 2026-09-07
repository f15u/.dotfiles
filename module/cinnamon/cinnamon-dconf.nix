# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/cinnamon" = {
      alttab-switcher-delay = 100;
      desklet-snap-interval = 25;
      desktop-effects-workspace = false;
      enabled-applets = [ "panel1:left:0:menu@cinnamon.org:0" "panel1:left:1:separator@cinnamon.org:1" "panel1:left:2:grouped-window-list@cinnamon.org:2" "panel1:right:0:systray@cinnamon.org:3" "panel1:right:1:xapp-status@cinnamon.org:4" "panel1:right:2:notifications@cinnamon.org:5" "panel1:right:4:removable-drives@cinnamon.org:7" "panel1:right:5:keyboard@cinnamon.org:8" "panel1:right:6:favorites@cinnamon.org:9" "panel1:right:7:network@cinnamon.org:10" "panel1:right:8:sound@cinnamon.org:11" "panel1:right:9:power@cinnamon.org:12" "panel1:right:10:calendar@cinnamon.org:13" "panel1:right:11:cornerbar@cinnamon.org:14" ];
      enabled-desklets = [];
      hotcorner-layout = [ "expo:false:0" "scale:false:0" "scale:false:0" "desktop:false:0" ];
      next-applet-id = 15;
      panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";
      panels-enabled = [ "1:0:bottom" ];
      panels-height = [ "1:40" ];
      window-effect-speed = 1;
      workspace-osd-visible = false;
    };

    "org/cinnamon/cinnamon-session" = {
      quit-time-delay = 60;
    };

    "org/cinnamon/desktop/applications/calculator" = {
      exec = "gnome-calculator";
    };

    "org/cinnamon/desktop/applications/terminal" = {
      exec = "gnome-terminal";
      exec-arg = "--";
    };

    "org/cinnamon/desktop/background/slideshow" = {
      delay = 15;
      image-source = "directory:///home/f15u/Pictures";
    };

    "org/cinnamon/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "it" ]) ];
    };

    "org/cinnamon/desktop/interface" = {
      clock-show-date = false;
      clock-show-seconds = false;
      cursor-theme = "Bibata-Modern-Classic";
      font-name = "Ubuntu 12";
      gtk-theme = "Mint-Y-Dark-Blue";
      icon-theme = "Mint-Y-Blue";
      text-scaling-factor = 1.0;
    };

    "org/cinnamon/desktop/media-handling" = {
      autorun-never = false;
    };

    "org/cinnamon/desktop/notifications" = {
      bottom-notifications = true;
      fullscreen-notifications = true;
      notification-duration = 5;
      remove-old = true;
    };

    "org/cinnamon/desktop/screensaver" = {
      layout-group = 0;
    };

    "org/cinnamon/desktop/sound" = {
      event-sounds = false;
    };

    "org/cinnamon/desktop/wm/preferences" = {
      min-window-opacity = 30;
      mouse-button-modifier = "";
      titlebar-font = "Ubuntu Medium 11";
    };

    "org/cinnamon/gestures" = {
      pinch-percent-threshold = mkUint32 40;
      swipe-down-2 = "PUSH_TILE_DOWN::end";
      swipe-down-3 = "TOGGLE_OVERVIEW::end";
      swipe-down-4 = "VOLUME_DOWN::end";
      swipe-left-2 = "PUSH_TILE_LEFT::end";
      swipe-left-3 = "WORKSPACE_NEXT::end";
      swipe-left-4 = "WINDOW_WORKSPACE_PREVIOUS::end";
      swipe-percent-threshold = mkUint32 60;
      swipe-right-2 = "PUSH_TILE_RIGHT::end";
      swipe-right-3 = "WORKSPACE_PREVIOUS::end";
      swipe-right-4 = "WINDOW_WORKSPACE_NEXT::end";
      swipe-up-2 = "PUSH_TILE_UP::end";
      swipe-up-3 = "TOGGLE_EXPO::end";
      swipe-up-4 = "VOLUME_UP::end";
      tap-3 = "MEDIA_PLAY_PAUSE::end";
    };

    "org/cinnamon/launcher" = {
      check-frequency = 300;
      memory-limit = 2048;
      memory-limit-enabled = false;
    };

    "org/cinnamon/muffin" = {
      draggable-border-width = 10;
      tile-maximize = true;
      unredirect-fullscreen-windows = true;
    };

    "org/cinnamon/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinates = mkTuple [ 41.9 12.483333 ];
      night-light-temperature = mkUint32 2700;
    };

    "org/cinnamon/settings-daemon/plugins/xsettings" = {
      hinting = "medium";
    };

    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Blue";
    };

  };
}

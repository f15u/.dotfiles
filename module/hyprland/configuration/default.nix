{
  # Hyprland user configuration
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Monitor configuration for vertical stacking
      # 40" on top, 24" below (centered horizontally)
      monitor = [
        "DP-1,3440x1440@60,0x0,1" # 40" monitor on top
        "DP-2,1920x1080@60,760x1440,1" # 24" monitor below (centered: (3440-1920)/2 = 760)
      ];

      # Workspace assignment
      workspace = [
        "1,monitor:DP-2" # Workspace 1 on lower monitor (24")
        "2,monitor:DP-1" # Workspace 2 on upper monitor (40")
      ];

      # Keyboard configuration for Italian layout
      input = {
        kb_layout = "it";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
      };

      # Keybindings
      bind = [
        # Switch workspaces with Super + [0-9]
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        # Move active window to a workspace with Super + Shift + [0-9]
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        # Common keybindings
        "SUPER, Space, exec, wofi --show drun"
        "SUPER, F, togglefloating,"
        "SUPER, J, togglesplit," # dwindle
        "SUPER, M, exit,"
        "SUPER, P, pseudo," # dwindle
        "SUPER, Q, killactive,"
        "SUPER, T, exec, kitty"

        # Move focus with Super + arrow keys
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        # Move windows with Super + Shift + arrow keys
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        # Media keys
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };
}

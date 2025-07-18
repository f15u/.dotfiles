{
  programs.waybar = {
    enable = true;
    settings = {
      lowerBar = {
        layer = "top";
        position = "top";
        output = ["DP-2"];
        height = 32;
        spacing = 4;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["cpu" "temperature" "memory"];
        modules-right = ["tray" "pulseaudio" "clock"];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
          };
          persistent-workspaces = {
            "DP-2" = [1 2 3 4];
          };
        };

        clock = {
          format = "{:%H:%M %d %b %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "{usage}%";
          tooltip = false;
        };

        memory = {
          format = "{used:0.1f}G/{total:0.1f}G";
          tooltip = false;
        };

        tray = {
          spacing = 8;
          icon-size = 20;
        };

        pulseaudio = {
          format = "{volume}%";
          format-muted = "0%";
          on-click = "pavucontrol";
          tooltip = false;
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = "{temperatureC}°C";
          tooltip = false;
        };
      };

      upperBar = {
        layer = "top";
        position = "top";
        output = ["DP-1"];
        height = 32;
        spacing = 4;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = [];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
          };
          persistent-workspaces = {
            "DP-1" = [5 6 7 8];
          };
        };

        clock = {
          format = "{:%H:%M %d/%m/%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "{usage}%";
          tooltip = false;
        };

        memory = {
          format = "{used:0.1f}G/{total:0.1f}G";
          tooltip = false;
        };

        tray = {
          spacing = 8;
          icon-size = 20;
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}

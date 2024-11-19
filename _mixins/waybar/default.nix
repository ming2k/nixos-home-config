{
  programs.waybar = {
    enable = true;
    style = ''
      * {
          border: none;
          font-family: "Noto Sans", "Symbols Nerd Font", "JetBrainsMono Nerd Font Propo";
          font-size: 14px;
          min-height: 14px;
      }
      /* Tokyo Night Colors - matched with Sway config */
      @define-color bg #1a1b26;            
      @define-color bg-dark #20222c;       
      @define-color surface-bright #292c3c;
      @define-color fg-dark #7f849c;       
      @define-color fg #a9b1d6;            
      @define-color fg-bright #c0caf5;     
      @define-color blue #7aa2f7;          
      @define-color cyan #7dcfff;          
      @define-color red #f7768e;           
      @define-color purple #bb9af7;        
      @define-color green #9ece6a;         

      window#waybar {
          background: transparent;
      }

      window#waybar.empty #window {
          opacity: 0;
      }

      /* Original workspace style */
      #workspaces button {
          padding: 0px;
          min-width: 40px;
          color: @fg-dark;
          background: transparent;
          transition: all 0.2s ease;
      }

      #workspaces button.focused {
          padding: 0px;
          min-height: 12px;
          color: @blue;
          background: alpha(@surface-bright, 0.2);
          border-bottom: 2px solid @blue;
      }

      #workspaces button.empty {
          padding: 0px;
          min-height: 12px;
          color: @fg-dark;
          opacity: 0.5;
      }

      #workspaces button.empty.focused {
          color: @blue;
          opacity: 0.7;
          border-bottom: 2px solid @blue;
      }

      #workspaces button.urgent {
          padding: 0px;
          min-height: 12px;
          color: @red;
          background: alpha(@red, 0.2);
          border-bottom: 2px solid @red;
      }

      #clock {
          margin-right: 0;
          font-family: 'Rubik';
          color: @fg;
      }

      /* Framework style */
      #workspaces,
      #mode,
      #window,
      #clock,
      #tray,
      #backlight,
      #wireplumber,
      #bluetooth,
      #network,
      #battery,
      #idle_inhibitor {
          border-radius: 8px;
          background: alpha(@bg, 0.85);
          padding-left: 10px;
          padding-right: 10px;
          margin-right: 15px;
          font-size: 16px;
          min-height: 32px;
          min-width: 22px;
          color: @fg;
      }

      /* Keep the broken-right compose look for all modules */
      #wireplumber,
      #bluetooth,
      #network,
      #battery {
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
          padding-left: 5px;
      }

      #backlight,
      #wireplumber,
      #bluetooth,
      #network {
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          padding-right: 5px;
          margin-right: 0;
      }

      /* Edge elements */
      #workspaces {
          margin-left: 2px;
      }

      #idle_inhibitor {
          margin-right: 2px;
      }
    '';
    settings = [{
      layer = "top";
      position = "top";
      margin-top = 2;
      modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "tray" "backlight" "wireplumber" "bluetooth" "network" "battery" "idle_inhibitor" ];

      "sway/workspaces" = {
        format = "<span font_size='10pt'>{icon}</span>";
        tooltip = false;
        all-outputs = false;
        format-icons = {
          "1" = "壹";
          "2" = "貳";
          "3" = "叁";
          "4" = "肆";
          "5" = "伍";
          "6" = "陸";
          "7" = "柒";
          "8" = "捌";
          "9" = "玖";
          "0" = "零";
        };
      };

      "sway/mode" = {
        format = "<span color='#7aa2f7'>󰭩</span> <span font_size='10pt'>{}</span>";
        tooltip = false;
      };

      "sway/window" = {
        format = "<span font_size='10pt'>{}</span>";
        icon = true;
        icon-size = 16;
        max-length = 24;
        rewrite = {};
      };

      "clock" = {
        interval = 1;
        format = "<span font_size='11pt'>{:%H:%M:%S}</span>";
        tooltip-format = "{:%A, %B %d, %Y}";
      };

      "idle_inhibitor" = {
        format = "<span color='#7aa2f7'>{icon}</span>";
        format-icons = {
          activated = "󰅶";
          deactivated = "󰾫";
        };
        tooltip = false;
      };

      "tray" = {
        icon-size = 15;
        spacing = 8;
        reverse-direction = true;
      };

      "backlight" = {
        device = "intel_backlight";
        format = "<span color='#7aa2f7'>󰖨</span> <span font_size='10pt'>{percent}%</span>";
        scroll-step = 1;
        tooltip = false;
      };

      "wireplumber" = {
        format = "<span color='#7aa2f7'>󰕾</span> <span font_size='10pt'>{volume}%</span>";
        format-muted = "<span color='#7aa2f7'>󰖁</span>";
        scroll-step = 1;
        on-click = "~/.config/waybar/scripts/toggle_mute_master.sh";
        tooltip-format = "{node_name}";
      };

      "bluetooth" = {
        format = "<span color='#7aa2f7'></span> <span font_size='10pt'>{status}</span>";
        format-connected = "<span color='#7aa2f7'>󰂱</span>";
        format-connected-battery = "<span color='#7aa2f7'>󰥉</span> <span font_size='10pt'>{device_battery_percentage}%</span>";
        tooltip-format = "{controller_alias}\t{controller_address}";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\tBatt.{device_battery_percentage}%";
      };

      "network" = {
        interface = "wlan0";
        max-length = 20;
        format = "<span color='#7aa2f7'>󰛵</span> <span font_size='10pt'>{ifname}</span>";
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-wifi = "<span color='#7aa2f7'>󰖩</span> <span font_size='10pt'>{essid}</span>";
        format-ethernet = "<span color='#7aa2f7'>󰌘</span> <span font_size='10pt'>{ipaddr}/{cidr}</span>";
        format-disconnected = "<span color='#7aa2f7'>󰌙</span> <span font_size='10pt'>Disconnected</span>";
        tooltip-format = "{ifname}";
        tooltip-format-wifi = "{essid} ({signaldBm} dBm)\t{ipaddr}/{cidr}";
        tooltip-format-disconnected = "Disconnected";
      };

      "battery" = {
        interval = 1;
        format = "<span color='#7aa2f7'>{icon}</span> <span font_size='10pt'>{capacity}%</span>";
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        format-plugged = "<span color='#7aa2f7'>󰚥</span> <span font_size='10pt'>{capacity}%</span>";
        format-charging = "<span color='#7aa2f7'></span> <span font_size='10pt'>{capacity}%</span>";
        tooltip = false;
      };
    }];
  };

  # Make sure the script is available
  xdg.configFile."waybar/scripts/toggle_mute_master.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    '';
  };

}
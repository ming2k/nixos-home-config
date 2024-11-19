{ config, pkgs, lib, ... }:
let
  wallpaper = pkgs.copyPathToStore ./wallpaper.jpg;
in
{
  imports = [
    ./alacritty.nix
    ./tmux.nix
  ];
  home = {
    file.".config/sway/wallpaper.jpg".source = ./wallpaper.jpg;
  };
  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      # Input Method
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
      # QT Variables
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_QPA_PLATFORM=wayland
      export QT_QPA_PLATFORMTHEME=qt6ct
      # Wayland specific
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_WEBRENDER=1
      export SDL_VIDEODRIVER=wayland
      export GDK_BACKEND=wayland
      export ELECTRON_OZONE_PLATFORM_HINT=wayland
      # Theming
      export GTK_THEME=Adwaita:dark
      export XCURSOR_THEME=Adwaita
      export XCURSOR_SIZE=24
      # XDG Specifications
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/home/ming/.local/share/flatpak/exports/share
      export XDG_SESSION_TYPE=wayland
      export XDG_CONFIG_HOME=$HOME/.config
      export XDG_DATA_HOME=$HOME/.local/share
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
    '';
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "wofi -I --show drun -i -m";
      bars = [
        {
          command = "waybar";
        }
      ];

      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          repeat_delay = "300";
          repeat_rate = "80";
          xkb_numlock = "enabled";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      output = {
        "*" = {
          adaptive_sync = "on";
          subpixel = "rgb";
          background = "${wallpaper} fill";
        };
        "eDP-1" = {
          resolution = "3072x1920@120Hz";
          scale = "2";
        };
      };
      fonts = {
        names = [ "Noto Sans" ];
        size = 10.0;
      };

      gaps = {
        inner = 2;
        outer = 2;
        smartGaps = false;
        smartBorders = "off";
      };

      window = {
        border = 2;
        titlebar = false;
        commands = [
          {
            criteria = { class = ".*"; };
            command = "title_align center";
          }
          {
            criteria = { app_id = "java"; title = "(?i).*DBeaver.*"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "org.prismlauncher.PrismLauncher"; };
            command = "floating enable";
          }
          {
            criteria = { title = "Minecraft.*"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "com.github.johnfactotum.Foliate"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "org.keepassxc.KeePassXC"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "virt-manager"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "org.musicbrainz.Picard"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "org.qbittorrent.qBittorrent"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "localsend"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "com.obsproject.Studio"; };
            command = "floating enable";
          }
          {
            criteria = { title = "Picture-in-Picture"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "xdg-desktop-portal-gtk"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "imv"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "mpv"; };
            command = "floating enable";
          }
          {
            criteria = { app_id = "kitty"; };
            command = "floating disable";
          }
          {
            criteria = { app_id = "Alacritty"; };
            command = "floating disable";
          }
          {
            criteria = { app_id = "firefox"; };
            command = "floating disable";
          }
          {
            criteria = { app_id = "google-chrome"; };
            command = "floating disable";
          }
        ];
      };

      colors = {
        focused = {
          border = "#7aa2f7";
          background = "#1a1b26";
          text = "#c0caf5";
          indicator = "#7dcfff";
          childBorder = "#7aa2f7";
        };
        focusedInactive = {
          border = "#20222c";
          background = "#1a1b26";
          text = "#a9b1d6";
          indicator = "#20222c";
          childBorder = "#20222c";
        };
        unfocused = {
          border = "#20222c";
          background = "#1a1b26";
          text = "#7f849c";
          indicator = "#20222c";
          childBorder = "#20222c";
        };
        urgent = {
          border = "#f7768e";
          background = "#f7768e";
          text = "#1a1b26";
          indicator = "#f7768e";
          childBorder = "#f7768e";
        };
        placeholder = {
          border = "#1a1b26";
          background = "#1a1b26";
          text = "#a9b1d6";
          indicator = "#1a1b26";
          childBorder = "#1a1b26";
        };
        background = "#1a1b26";
      };

      seat = {
        "*" = {
          xcursor_theme = "Adwaita 24";
        };
      };

      floating = {
        modifier = "Mod4";
      };

      focus = {
        followMouse = false;
        newWindow = "smart";
      };

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
        "${modifier}+a" = "exec ${config.wayland.windowManager.sway.config.menu}";
        "${modifier}+Shift+a" = "exec ~/.config/sway/scripts/app_switcher.sh";
        "${modifier}+w" = "kill";
        
        # Navigation
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+p" = "focus parent";
        "${modifier}+c" = "focus child";
        "${modifier}+Tab" = "focus next";
        "${modifier}+Shift+Tab" = "focus prev";
        
        # Layout
        "${modifier}+d" = "split toggle";
        "${modifier}+Shift+d" = "split none";
        "${modifier}+f" = "floating toggle";
        "${modifier}+s" = "layout toggle split";
        "${modifier}+Shift+f" = "fullscreen toggle";
        "${modifier}+Shift+t" = "layout toggle tabbed split";
        "${modifier}+Shift+s" = "layout toggle stacking split";
        
        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        
        "${modifier}+Shift+1" = "move container to workspace number 1; workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2; workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3; workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4; workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5; workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6; workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7; workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8; workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9; workspace number 9";
        
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";
        "${modifier}+Prior" = "workspace prev";
        "${modifier}+Next" = "workspace next";
        "${modifier}+grave" = "workspace back_and_forth";
        
        # Screenshots
        "Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy";
        "Ctrl+Print" = "exec grim -g \"$(slurp -d)\" \"$HOME/Pictures/Screenshots/$(date \"+%Y-%m-%d %T\").png\"";
        "Shift+Print" = "exec ~/.config/sway/scripts/ocr.sh";
        
        # Media keys
        "XF86AudioPlay" = "exec playerctl play-pause";
        "--locked XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "--locked XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "--locked XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "--locked XF86AudioPrev" = "exec playerctl previous";
        
        # System
        "${modifier}+Ctrl+q" = "exit";
        "${modifier}+Ctrl+r" = "reload";
        "${modifier}+Ctrl+l" = "exec swaylock";
        "${modifier}+r" = "mode resize";
      };

      modes.resize = {
        "Left" = "resize shrink width 2px";
        "Down" = "resize shrink height 2px";
        "Up" = "resize grow height 2px";
        "Right" = "resize grow width 2px";
        "Return" = "mode default";
        "Escape" = "mode default";
        "${config.wayland.windowManager.sway.config.modifier}+r" = "mode default";
      };

      assigns = {
        "1" = [
          { app_id = "kitty"; }
          { app_id = "Alacritty"; }
          { app_id = "code-url-handler"; }
          { app_id = "jetbrains-idea"; }
          { app_id = "jetbrains-goland"; }
          { app_id = "jetbrains-studio"; }
          { app_id = "DBeaver"; }
          { app_id = "bruno"; }
        ];
        "2" = [
          { app_id = "firefox"; }
          { app_id = "google-chrome"; }
        ];
        "3" = [
          { app_id = "org.telegram.desktop"; }
          { app_id = "org.mozilla.Thunderbird"; }
          { app_id = "^libreoffice.*"; }
          { app_id = "org.kde.kdenlive"; }
          { app_id = "org.inkscape.Inkscape"; }
          { app_id = "AppFlowy"; }
          { app_id = "org.prismlauncher.PrismLauncher"; }
          { title = "Minecraft.*"; }
        ];
        "4" = [
          { app_id = "com.github.johnfactotum.Foliate"; }
        ];
        "5" = [
          { app_id = "org.keepassxc.KeePassXC"; }
          { app_id = "virt-manager"; }
          { app_id = "org.musicbrainz.Picard"; }
          { app_id = "org.qbittorrent.qBittorrent"; }
          { app_id = "localsend"; }
          { app_id = "com.obsproject.Studio"; }
        ];
      };
      startup = [
        { command = "swaymsg workspace 1"; always = true; }
        { command = "~/.config/sway/scripts/idle.sh"; }
      ];
    };

    extraConfig = '''';
  };

  # Make sure the script is available
  xdg.configFile = {
    "sway/scripts/ocr.sh" = {
      executable = true;
      text = ''
        #!/bin/sh

        # Prerequisites: grim, slurp, tesseract, wl-clipboard

        # Create a temporary directory
        TMPDIR=$(mktemp -d)

        # Take a screenshot of a selected area using grim and slurp, save it as screenshot.png in the temporary directory
        grim -g "$(slurp)" $TMPDIR/screenshot.png

        # Process the screenshot with Tesseract and save the result to a text file in the temporary directory
        # tesseract $TMPDIR/screenshot.png $TMPDIR/output
        tesseract $TMPDIR/screenshot.png $TMPDIR/output\
          -l chi_sim+eng \
          --oem 1 \
          --psm 6

        # Copy the result to the clipboard (Wayland)
        # Ignore all non-ASCII characters
        cat $TMPDIR/output.txt |
            tr -cd '\11\12\15\40-\176' | grep . | perl -pe 'chomp if eof' |
            wl-copy

        # Optionally, remove the temporary directory when done
        rm -r $TMPDIR
      '';
    };
    "sway/scripts/idle.sh" = {
      executable = true;
      text = ''
        #!/bin/bash
        swayidle -w \
            timeout 600 'swaylock -f' \
            timeout 900 'swaymsg "output * dpms off"' \
                resume 'swaymsg "output * dpms on"' \
            lock 'swaylock -f' \
            before-sleep 'swaylock -f'
      '';
    };
  };

  home.packages = with pkgs; [
    # desktop bus
    dbus
    # Window Manager
    wofi
    alacritty
    mako
    grim
    slurp
    wl-clipboard
    swaylock
    playerctl
    tesseract # OCR
    # Theme
    adwaita-icon-theme
    # Desktop Utils
    mpv
    imv
    firefox
    vscode
  ];
}

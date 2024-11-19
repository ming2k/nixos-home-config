{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "tmux";
        args = ["new-session" "-A" "-s" "main"];
      };
      
      window = {
        opacity = 0.72;
        padding = {
          x = 0;
          y = 0;
        };
      };
      
      colors = {
        primary = {
          background = "#1b1d22";
          foreground = "#e6e8ee";
        };
        cursor = {
          text = "#1b1d22";
          cursor = "#f6f6ec";
        };
        selection = {
          text = "#1b1d22";
          background = "#2e353d";
        };
        normal = {
          black = "#002731";
          red = "#d01b24";
          green = "#6bbe6c";
          yellow = "#a57705";
          blue = "#2075c7";
          magenta = "#8b57b5";
          cyan = "#259185";
          white = "#e9e2cb";
        };
        bright = {
          black = "#006388";
          red = "#f4153b";
          green = "#50ee84";
          yellow = "#b17e28";
          blue = "#178dc7";
          magenta = "#AF8FE9";
          cyan = "#00b29e";
          white = "#fcf4dc";
        };
      };
      
      font = {
        size = 11;
      };
      
      keyboard.bindings = [
        {
          key = "F";
          mods = "Control|Shift";
          action = "None";
        }
      ];
    };
  };
}
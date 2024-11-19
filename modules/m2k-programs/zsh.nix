{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.m2k-programs.zsh;
in {
  options.m2k-programs.zsh = {
    enable = mkEnableOption "ZSH configuration module";
    
    auto-start-sway = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to automatically start Sway on TTY1";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      history = {
        size = 100000;
        save = 100000;
        ignoreDups = true;
        ignoreSpace = true;
        ignorePatterns = ["ls" "bg" "fg" "exit"];
        share = true;
      };

      initExtra = ''
        # If not running interactively, don't do anything
        [[ $- != *i* ]] && return
        # Enable cd spell correction
        setopt correct_all
        # Prompt settings
        PS1="%F{green}%n@%m%f:%F{blue}%1~%f\$ "
        # Terminal title
        precmd() {
          print -Pn "\e]0;%n@%M:%1~\a"
        }
      '';

      profileExtra = mkIf cfg.auto-start-sway ''
        if [ "$(tty)" = "/dev/tty1" ]; then
          sway
        fi
      '';

      shellAliases = {
        cn = "sudo -i && cd /etc/nixos";
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        fars = "curl -F \"c=@-\" \"http://fars.ee/\"";
      };
    };

    home.sessionVariables = {
      LC_COLLATE = "C.UTF-8";
      LANG = "en_US.UTF-8";
    };

    home.sessionPath = [
      "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
      "$HOME/.local/bin"
      "$HOME/development/flutter/bin"
      "$HOME/.cargo/bin"
    ];
  };
}
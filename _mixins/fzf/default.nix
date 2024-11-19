{ config, pkgs, ... }:

{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--inline-info"
        "--color=dark"
        "--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f"
        "--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
      ];
      fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidgetOptions = [
        "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      ];
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
      changeDirWidgetOptions = [
        "--preview 'tree -C {} | head -200'"
      ];
    };

    # Optional: Install related tools
    bat.enable = true;
    fd.enable = true;
  };
}
{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      # Basic settings
      set -g allow-passthrough on
      set -g set-titles on
      set -g set-titles-string "#I:#T"
      set -g repeat-time 400
      
      # Status bar styling
      set -g status on
      set -g status-position bottom
      set -g status-style "bg=#1a1b26,fg=#c0caf5"
      set -g status-left "#[fg=#1a1b26,bg=#bb9af7,bold] #S #[fg=#bb9af7,bg=#1a1b26]"
      set -g status-left-length 40
      setw -g window-status-format "#[fg=#c0caf5,bg=#1a1b26] #I #W "
      setw -g window-status-current-format "#[fg=#1a1b26,bg=#7aa2f7,bold] #I #W #[fg=#7aa2f7,bg=#1a1b26]"
      set -g status-right "#[fg=#7aa2f7,bg=#1a1b26]#[fg=#1a1b26,bg=#7aa2f7,bold] %Y-%m-%d %H:%M "
      set -g status-right-length 40
      
      # Window management
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind -n MouseDrag1Border resize-pane -M
      bind C-t new-window
      bind C-w kill-window
      bind x kill-pane
      bind C-s next-layout
      bind C-PageUp previous-window
      bind C-PageDown next-window
      
      # Vi mode bindings
      bind -T copy-mode-vi MouseDrag1Pane send -X begin-selection
      bind -T copy-mode-vi MouseDragEnd1Pane send -X
      bind -T copy-mode-vi MouseDown1Pane select-pane \; send-keys -X clear-selection
      bind -T copy-mode-vi DoubleClick1Pane select-pane \; send-keys -X select-word
      bind -T copy-mode-vi TripleClick1Pane select-pane \; send-keys -X select-line
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X copy-selection-no-clear
    '';
  };
}
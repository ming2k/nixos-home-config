{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = ["ignoreboth" "erasedups"];
    historyIgnore = ["ls" "bg" "fg" "exit"];
    historySize = 100000;
    historyFileSize = 100000;
    shellOptions = [
      "histappend"
      "cdspell"
    ];
    initExtra = ''
      # If not running interactively, don't do anything
      [[ $- != *i* ]] && return
      
      # Prompt settings
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
      
      # Terminal title and cursor settings
      function prompt_command {
        echo -ne "\033]0;$USER@$(uname -n):$(basename "$PWD")\007\033[ q";
      }
      PROMPT_COMMAND=prompt_command
    '';
    shellAliases = {
      cn = "sudo -i bash -c \"cd /etc/nixos && bash\"";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      fars = "curl -F \"c=@-\" \"http://fars.ee/\"";
    };
  };

  programs.readline = {
    enable = true;
    extraConfig = ''
      set completion-ignore-case on
      set show-all-if-ambiguous on
      
      # Ctrl + Left/Right Arrow
      "\e[1;5D": backward-word
      "\e[1;5C": forward-word
      
      # Disable Alt + Left/Right
      "\e[1;3D": ""
      "\e[1;3C": ""
      
      # Unbind Ctrl-A and Ctrl-E
      "\C-a": ""
      "\C-e": ""
      
      # Ctrl+Backspace to delete word
      "\C-\b": backward-kill-word
    '';
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
}
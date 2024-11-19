{
  programs.neovim.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    file = {
      ".config/nvim" = {
        source = ./config;  # Your nvim config directory relative to home.nix
        recursive = true;  # Include all subdirectories
      };
    };
  };
}

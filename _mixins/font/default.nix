{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Basic fonts
    noto-fonts
    noto-fonts-emoji
    
    # CJK fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-sans
    
    noto-fonts-extra  # Extended language support
    
    # Coding fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans</family>
          <family>Source Han Sans SC</family>
          <family>Noto Emoji</family>
        </prefer>
      </alias>
      <alias>
        <family>serif</family>
        <prefer>
          <family>Noto Serif</family>
          <family>Noto Serif CJK SC</family>
          <family>Noto Emoji</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>JetBrainsMono Nerd Font Propo</family>
          <family>Noto Emoji</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
}
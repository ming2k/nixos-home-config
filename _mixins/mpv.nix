{
  programs.mpv = {
    enable = true;
    config = {
      geometry = "50%";
      "sub-auto" = "all";
      "slang" = "chi,en,eng";
      "alang" = "chi,en,eng";
      "audio-file-auto" = "fuzzy";
      "audio-pitch-correction" = "yes";
      "sub-font-size" = 40;
      "force-window" = "yes";
      "save-position-on-quit" = "yes";
    };

    bindings = {
      RIGHT = "seek 3";
      LEFT = "seek -3";
    };
  };

  xdg.configFile = {
    "mpv/scripts/load-subs.lua".text = ''
      mp.add_hook('on_load', 10, function()
          local sub_paths = { 'Subs', 'subtitles', 'subs', 'sub' }
          sub_paths[#sub_paths + 1] = 'Subs/' .. mp.get_property('filename/no-ext')
          mp.set_property_native('sub-file-paths', sub_paths)
      end)
    '';
  };
}
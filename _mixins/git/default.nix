{
  programs.git = {
    enable = true;
    
    # Basic user settings
    userName = "Nathaniel Anderson";
    userEmail = "mingmillennium@gmail.com";
    
    # Default settings
    extraConfig = {
      init.defaultBranch = "main";
    };  
  };
  
  home.file.".gitmessage".text = ''
    # <type>: <subject>
    # |<--------------------(Max 50 chars)------------------>|
    # Types:
    #   feat     : new feature
    #   fix      : bug fix
    #   docs     : documentation
    #   style    : formatting
    #   refactor : code restructure
    #   test     : tests
    #   chore    : maintenance
    #   perf     : performance

    # Body (if needed):
    # |<--------------------------------(Max 72 chars)-------------------------------->|
    #
    # Helpful Formats:
    # Breaking Changes:
    # - BREAKING CHANGE: [details]
    #
    # Issue Tracking:
    # GitHub:
    # - Closes #123
    # - Fixes #123
    # - Resolves #123
    # GitLab:
    # - Closes #123, !456
    # - Fixes #123, !456
    # - Closes group/project#123
    # - Related to #123
    #
    # Contributors:
    # - Co-authored-by: name <email>
    # - Reviewed-by: name <email>
  '';

}

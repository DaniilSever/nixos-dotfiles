{
  programs.git = {
    enable = true;
    userName = "";
    userEmail = "";

    extraConfig = {
      # --base settings--
      init.defaultBranch = "develop";
      pull.rebase = false;

      # --color--
      color.ui = true;
      color.status = "auto";
      color.branch = "auto";
      color.diff = "auto";
  
      # --profiles--
      alias = {
        apply-profile-github = "!f() { git config user.name \\\"DaniilSever\\\" && git config user.email \\\"jhisjfiohig14@mail.ru\\\"; }; f";
        apply-profile-gitlab = "!f() { git config user.name \\\"Denver\\\" && git config user.email \\\"jhisjfiohig14@mail.ru\\\"; }; f";
      };
    };
  };
}
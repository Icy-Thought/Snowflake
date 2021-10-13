{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.git;
in {
  options.modules.shell.git = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      gitAndTools.gh
      gitAndTools.git-open
      gitAndTools.diff-so-fancy
      git-filter-repo
      (mkIf config.modules.shell.gnupg.enable gitAndTools.git-crypt)
      act
    ];

    homeManager.programs.git = {
      enable = true;
      package = pkgs.gitFull;

      aliases = {
        amend = "commit --amend -m";
        fixup =
          "!f(){ git reset --soft HEAD~\${1} && git commit --amend -C HEAD; };f";
        br = "branch";
        co = "checkout";
        st = "status";
        ls = ''
          log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'';
        ll = ''
          log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';
        cm = "commit -m";
        ca = "commit -am";
        dc = "diff --cached";
      };

      ignores = [
        "*.bloop"
        "*.bsp"
        "*.metals"
        "*.metals.sbt"
        "*metals.sbt"
        "*.direnv"
        "*.envrc"
        "*hie.yaml"
        "*.mill-version"
        "*.jvmopts"
      ];

      signing.signByDefault = true;
      signing.key = "22CF239720AAD89B";

      userName = "Icy-Thought";
      userEmail = "gilganyx@pm.me";

      extraConfig = {
        core.editor = "emacsclient -t";
        core.pager = "diff-so-fancy | less --tabs=4 -RFX";

        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
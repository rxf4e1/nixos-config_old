{ pkgs, ... }:

let
  # Fix any corruptions in the local copy.
  myGitFix = pkgs.writeShellScriptBin "git-fix" ''
    if [ -d .git/objects/ ]; then
      find .git/objects/ -type f -empty | xargs rm -f
      git fetch -p
      git fsck --full
    fi
    exit 1
  '';
  
in {
  home.packages = [ myGitFix ];
  
  programs.git = {
    enable = true;
    userName = "rxf4el";
    userEmail = "rxf4e1@tuta.io";
    signing = {
      key = "17F4D020C55E2A22";
      signByDefault = true;
    };
  };
}

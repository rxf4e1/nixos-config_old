{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    initExtraFirst = ''
      export PATH="$XDG_BIN_HOME:$PATH"
    '';
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.4";
          sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
        };
      }

      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
        };
      }
      
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ../../../../config/p10k-config;
        file = "p10k.zsh";
      }
    ];

#     initExtra = ''
#       # check existence of a given cmd
#       cmd_exist() {
#         command -v "$1" /dev/null
#         return $?
#       }
# 
#       # ls alias ----------
#       cmd_exist "exa"
#       if [ "$?" -eq 0 ]; then
#         alias ls="exa -lh --git --group-directories-first --sort=type --classify -s extension --icons"
#         alias l="ls -lF --time-style=long-iso --grid --icons"
#       else
#         alias ls="ls --group-directories-first --color=auto -plh"
#       fi
# 
#       # cat alias ----------
#       cmd_exist "bat"
#       if [ "$?" -eq 0 ]; then
#         alias cat="bat -pp"
#         alias less="bat --paging=always"
#         export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#     '';

    shellAliases = {
      ga   = "git add";
      gc   = "git commit";
      gcm  = "git commit -m";
      gs   = "git status";
      gsb  = "git status -sb";
      ls   = "exa -lh --git --group-directories-first --sort=type --classify -s extension --icons";
      l    = "ls -lF --time-style=long-iso --grid --icons";
      la   = "ls -lha";
      sl   = "ls";
      tree = "ls --tree";
      cdd  = "cd /media/data";
      cdf  = "cd /media/data/00-09-configs/01-NixOS/01.10-flakes";
      x    = "sway";
    };
  };      
}

{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    keyMode = "emacs";
    prefix = "C-Space";

    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    extraConfig = ''
			set-option -s -g escape-time 0
			set-option -g base-index 1
			set-option -w -g pane-base-index 1
			set-option -g renumber-windows
			set-option -g mouse on
			set-option -s set-clipboard on

			# Bindings ─────────────────────────────────────────────────────────────────────
			
			# Enter command mode
			bind-key Enter command-prompt
    '';
  };
}

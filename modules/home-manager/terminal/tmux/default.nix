{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    keyMode = "emacs";
    prefix = "C-Space";

    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    extraConfig = ''
			set-option -g status off
			set-option -w -g status-position top
      set-option -g status-bg default
      set-option -g status-fg colour240
			set-option -s -g escape-time 0
			set-option -g base-index 1
			set-option -w -g pane-base-index 1
			set-option -g renumber-windows
			set-option -g mouse on
			set-option -s set-clipboard on

			# Bindings ─────────────────────────────────────────────────────────────────────
			
			# Enter command mode
			bind-key Enter command-prompt
      # bind-key C-s set-option -g status
    '';
  };
}

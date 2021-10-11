{ config, pkgs, ... }:
{
  programs.kakoune = {
    enable = true;

    plugins = with pkgs; [
      kakounePlugins.kak-fzf
      kakounePlugins.auto-pairs-kak
      kakounePlugins.connect-kak
      kak-lsp
      # kakounePlugins.powerline-kak
    ];

    config = {
      colorScheme = "gruvbox";
      autoReload = "ask";
      
      alignWithTabs = true;
      tabStop = 2;
      indentWidth = 2;

			showMatching = true;
			
      scrollOff.lines = 8;
      scrollOff.columns = 4;

      numberLines = {
        enable = true;
        relative = false;
        # separator = "|";
      };

      ui = {
        enableMouse = true;
        assistant = "none";
        statusLine = "bottom";
      };
      
      wrapLines = {
        enable = false;
        indent = true;
        marker = "⏎";
      };

      # keyMappings = {};
    };

    extraConfig = ''
      set-option global makecmd 'make -j 8'
      set-option global grepcmd 'rg --column'
      
      # Enable <tab>/<s-tab> for insert completion selection
      # ──────────────────────────────────────────────────────
      hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
      hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }
      
      eval %sh{kak-lsp --kakoune -s $kak_session}
      hook global WinSetOption filetype=(sh|javascript|typescript|nix) %{
        lsp-enable-window
      }
    '';
  };
}

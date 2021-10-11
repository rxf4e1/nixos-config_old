{ config, pkgs, ... }:
{
  programs.kakoune = {
    enable = true;

    plugins = with pkgs; [
      kak-lsp
      kakounePlugins.prelude-kak
      kakounePlugins.connect-kak
      kakounePlugins.kakoune-vertical-selection
    ];

    config = {
      colorScheme = "gruvbox";
      autoReload = "ask";
      
      alignWithTabs = true;
      tabStop = 2;
      indentWidth = 2;

      showMatching = true;

      scrollOff.lines = 5;
      scrollOff.columns = 1;

      numberLines = {
        enable = true;
        relative = false;
        # separator = "|";
      };

      ui = {
        enableMouse = true;
        statusLine = "bottom";
      };
      
      wrapLines = {
        enable = false;
        indent = true;
        marker = "⏎";
      };

      hooks = [
        # kak-lsp
        {
          name = "WinSetOption";
          option = "filetype=(sh|javascript|typescript|nix)";
          commands = "lsp-enable-window";
        }
      ];
    };

		extraConfig = ''
		  # Plugin Manager
		  # ────────────────────────────────────────────────────
		  source "%val{config}/plugins/plug.kak/rc/plug.kak"
		  plug "andreyorst/plug.kak" noload

      # Load Modules
      # ────────────────────────────────────────────────────
      require-module prelude
      require-module connect

      # Windowing
      # ────────────────────────────────────────────────────
      # alacritty-integration-enable

      # Clipboard
      # ────────────────────────────────────────────────────
      # synchronize-clipboard
      # synchronize-buffer-directory-name-with-register d

      # Options
      # ────────────────────────────────────────────────────
      set-option global makecmd 'make -j 8'
      set-option global grepcmd 'rg --column'

      set-option global ui_options terminal_assistant=none

      # LSP server
      # ────────────────────────────────────────────────────
     	eval %sh{kak-lsp --kakoune -s $kak_session}

     	# Enable <tab>/<s-tab> for insert completion selection
      # ────────────────────────────────────────────────────
      hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
      hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

      # Leader Map
      # ────────────────────────────────────────────────────
      unmap global normal ,
      map global normal <space> ': enter-user-mode user<ret>' -docstring 'Leader Key'

      # Plugins
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "alexherbo2/lib.kak" config %{
        enable-detect-indent
        enable-auto-indent
        set global disabled_hooks '(?!auto)(?!detect)\K(.+)-(trim-indent|insert|indent)'
        make-directory-on-save
      }
     
      # Auto-pairing of characters
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "alexherbo2/auto-pairs.kak" config %{
        enable-auto-pairs
      }
      # Fuzzy-Finder
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "andreyorst/fzf.kak" config %{
        map global normal <c-p> ': fzf-mode<ret>'
      }
      
      # Vertical-Selection
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      map global user v     ': vertical-selection-down<ret>'        -docstring 'select 🡓'
      map global user <a-v> ': vertical-selection-up<ret>'          -docstring 'select 🡑'
      map global user V     ': vertical-selection-up-and-down<ret>' -docstring 'select 🡑🡓'
      
      # Snippets
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "occivink/kakoune-snippets"

      # Emmet
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "JJK96/kakoune-emmet" config %{
        map global insert <a-e> "<esc>x: emmet<ret>"
      }

    '';
  };
}

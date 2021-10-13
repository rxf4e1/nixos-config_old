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
      
      alignWithTabs = false;
      tabStop = 2;
      indentWidth = 2;

      showMatching = true;
      # showWhitespace.enable = true;
      
      scrollOff.lines = 5;
      scrollOff.columns = 1;

      numberLines = {
        enable = true;
        relative = false;
        # separator = "|";
      };

      ui = {
        enableMouse = true;
        # assistant = "none";
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
          option = "filetype=(sh|javascript|typescript|lua|nix)";
          commands = "lsp-enable-window";
        }
      ];
    };

    extraConfig = ''
      # Plugin Manager
      # ────────────────────────────────────────────────────
      source "%val{config}/plugins/plug.kak/rc/plug.kak"
      plug "andreyorst/plug.kak" noload

      # Loads & Sources
      # ────────────────────────────────────────────────────
      require-module prelude
      require-module connect

      source "%val{config}/kakrc.local"

      # Default Options
      # ────────────────────────────────────────────────────
      set-option global makecmd 'make -j 8'
      set-option global grepcmd 'rg --column'
      set-option global ui_options terminal_assistant=none

      # LSP Server
      # ────────────────────────────────────────────────────
      eval %sh{kak-lsp --kakoune -s $kak_session}

      # Plugins
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "alexherbo2/alacritty.kak" config %{
        alacritty-integration-enable
      }
      plug "alexherbo2/lib.kak" config %{
        enable-detect-indent
        enable-auto-indent
        set global disabled_hooks '(?!auto)(?!detect)\K(.+)-(trim-indent|insert|indent)'
        make-directory-on-save
      }

      # Powerline
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "andreyorst/powerline.kak" defer powerline_gruvbox %{
            powerline-theme gruvbox
      } config %{
          powerline-start
      }

      # Auto-Pairing
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "alexherbo2/auto-pairs.kak" config %{
        enable-auto-pairs
      }

      # KakTreeFM
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "andreyorst/kaktree" defer kaktree %{
        set-option global kaktree_double_click_duration '0.5'
        set-option global kaktree_indentation 1
        set-option global kaktree_dir_icon_open  '▾ 🗁 '
        set-option global kaktree_dir_icon_close '▸ 🗀 '
        set-option global kaktree_file_icon      '⠀⠀🖺'
      } config %{
        hook global WinSetOption filetype=kaktree %{
          remove-highlighter buffer/numbers
          remove-highlighter buffer/matching
          remove-highlighter buffer/wrap
          remove-highlighter buffer/show-whitespaces
        }
        kaktree-enable
      }

      # Fuzzy-Finder
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "andreyorst/smarttab.kak" defer smarttab %{
        # when `backspace' is pressed, 2 spaces are deleted at once
        set-option global softtabstop 2
      } config %{
        # these languages will use `expandtab' behavior
        hook global WinSetOption filetype=(lua|markdown|kak|lisp|scheme|sh|perl) expandtab
        # these languages will use `noexpandtab' behavior
        hook global WinSetOption filetype=(makefile|gas) noexpandtab
        # these languages will use `smarttab' behavior
        hook global WinSetOption filetype=(c|cpp) smarttab
      }
     
      # Fuzzy-Finder
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "andreyorst/fzf.kak" config %{
        map global normal <c-p> ': fzf-mode<ret>'
      }
      
      # Vertical-Selection
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      map global user v ': vertical-selection-down<ret>' -docstring 'select 🡓'
      map global user <a-v> ': vertical-selection-up<ret>' -docstring 'select 🡑'
      map global user V ': vertical-selection-up-and-down<ret>' -docstring 'select 🡑🡓'
      
      # Snippets
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "occivink/kakoune-snippets" config %{
        # set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
      }
      # plug "andreyorst/kakoune-snippet-collection"

      # Emmet
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "JJK96/kakoune-emmet" config %{
        map global insert <a-e> "<esc>x: emmet<ret>"
      }

    '';
  };
}
